#!/bin/bash
# Update the OS hostname

# load libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

# read variables from the config-custom yaml file
MYTEMP=`mktemp`
parse_yaml /vagrant/puphpet/config-custom.yaml > $MYTEMP
. <(sed '/^export/!s/^/export /' $MYTEMP)
rm $MYTEMP

# get the IP address for this node
MYIP=`hostname -I`

# Read hostanme and domain directory from YAML file and use it if we can
if [ -n "$vagrantfile_vm_hostname" ]; then
    MYHOSTNAME=$vagrantfile_vm_hostname

    # Create a new /etc/hosts file
    cat /etc/hosts | grep -v 127.0.1.1 | grep -v 127.0.0.1 | grep -v $MYIP > /tmp/h.txt
    if [ -n "$vagrantfile_vm_domain" ]; then
        MYDOMAIN=$vagrantfile_vm_domain
        MYFQDN=$MYHOSTNAME.$MYDOMAIN
        echo $MYIP $MYFQDN $MYHOSTNAME >> /tmp/h.txt
    else
        echo "Info: domain not specified.  Skipping FQDN."
        echo $MYIP $MYHOSTNAME >> /tmp/h.txt
    fi
    echo 127.0.0.1 localhost.localdomain localhost >> /tmp/h.txt
    chmod 544 /tmp/h.txt
    mv -f /tmp/h.txt /etc/hosts

    # Create a new /etc/hostname file
    hostname $MYHOSTNAME
    echo $MYHOSTNAME > /etc/hostname

    # Restart networking
    ifdown eth0 && ifup eth0

else
    echo "Warning: No hostname specified. Hostname cannot be changed."
fi
