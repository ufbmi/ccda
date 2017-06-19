# Deploying to Amazon Web Services

## Introduction

Vagrant can be used to deploy a fully functional instance of the Decision Aids App to Amazon Web Services. The task requires a few modifications to some default configuration files.

## Configuring for AWS Deployment

To deploy to AWS, follow these steps:

### Copy the example Puphpet AWS YAML file to the active location:

    cd vagrant/puphpet
    cp config-custom-aws-example.yaml config-custom.yaml

### Edit config-custom.yaml AWS section as needed

Edit config-custom.yaml to set the parameters needed for your AWS EC2 environment.  This is relevant section from the example file:

    aws:
        access_key_id: 'EC2 Access Key ID'
        secret_access_key: 'EC2 Secret Access Key'
        keypair_name: 'EC2 keypair name'
        ami: ami-4b124a22
        region: us-east-1
        instance_type: m1.small
        security_groups:
            - 'security group ID. e.g., sg-a1b2c3d4'
        tags:
            Source: Puphpet
        elastic_ip: 'elastic IP address valid'
        associate_public_ip: 'true'
        subnet_id: 'subnet ID.  e.g. subnet-abcd1234'

These parameters _must_ be set:

    access_key_id
    secret_access_key
    keypair_name
    security_groups
    elastic_ip
    subnet_id

If you change the `region`, you will also need to change the `ami` as this ami is homed in the *us-east-1* region.


### Edit config-custom.yaml MySQL section as needed

Revise settings as needed in the mysql block of config-custom.yaml.  That section of the YAML file is shown here.

    mysql:
        install: '1'
        settings:
            version: '5.6'
            root_password: 'SET THIS PASSWORD FOR USER ROOT'
            override_options: {  }
        adminer: '1'
        users:
            mysqlnu_l0ux1btcldlz:
                name: ccdaa
                password: 'SET THIS PASSWORD FOR USER CCDAA'
        databases:
            mysqlnd_qri5yd3zfa6w:
                name: ccdaa
                sql: /sql/ccdaa_all.sql
        grants:
            mysqlng_aggegor2u1yt:
                user: ccdaa
                table: '*.*'
                privileges:
                    - ALL

At a minimum, `root_password` and `password` must be set.

The `sql` parameter also needs to be revised in any production instance.  The authorization table needs to be loaded with an appropriate list of PassIDs for the deployment.  One PassID must be created for each survey participant.

The settings in the MySQL section are used by Puphpet manifestes to construct the database and by provision scripts to rewrite the application backend's configuration file.  The script ./vagrant/puphpet/files/exec-always/edit-config-php.sh does the rewrite.


### Edit config-custom.yaml DAA section as needed

The front end application needs to know the URL of the backend.  A provisioning script in this Vagrant configuration (./vagrant/puphpet/files/exec-always/edit-config-js.sh) will read the needed values from ./vagrant/puphpet/config-custom.yaml and rewrite the configuraiton for the front end.

This section of config-custom.yaml controls the URL used by the front end to find the backend.

    daa:
        url: http://crcdaa.org/api/v1/

Adjust the `URL` key as needed. It must match the URL where the API will deploy.


### Add custom ssh public keys

If you need multiple people to have access to the default vagrant account on the VM, you can provide a collection of public key files to be added to the authorized_keys file in the default vagrant account in AWS deployments.  To do this, create a local folder of ssh public key files, one key per file with a naming pattern of *.pub.  Create a synced_folder in config-custom.yaml to synchronize it to AWS.  Also in config-custom.yaml, set two SSH custom parameters, to tell the deployment script, vagrant/puphpet/files/exec-always/copy-ssh-keys.sh, where to find the keys and where to append them. Those config-custom.yaml settings will look something like these values.

vagrantfile:
    vm:
        synced_folder:
            f8390ff9390f90f0fg0f:
                source: ../../sshkeys/
                target: /sshkeys
    ssh:
        custom:
            sshpubkeysdirectory: /sshkeys
            authorizedkeysfile: /home/admin/.ssh/authorized_keys


### Tell Vagrant to build the VM

When the configuration files are edited. Start the VM:

    vagrant up

Ordinarily a `vagrant up` should build the VM fine at this pojnt, but a bug in the adminer manifest has been causing problems.  If you get an error about "/var/www/html/adminer", use this command to build the VM:

    vagrant ssh -c 'sudo mkdir -p  /var/www/html/adminer'  && vagrant provision

The first fully scripted build took 17 minutes.

When the VM is built, access it http://your_domain_name/web/
