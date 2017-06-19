#!/bin/bash
# Copy SSH keys for the support team to the AWS server

# load libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

# read variables from the config-custom yaml file
MYTEMP=`mktemp`
parse_yaml /vagrant/puphpet/config-custom.yaml > $MYTEMP
. <(sed '/^export/!s/^/export /' $MYTEMP)
rm $MYTEMP

AUTHORIZED_KEYS_FILE=~/.ssh/authorized_keys
# read the target file from YAML file
if [ -n "$vagrantfile_ssh_custom_authorizedkeysfile" ]; then
    AUTHORIZED_KEYS_FILE=$vagrantfile_ssh_custom_authorizedkeysfile
fi

# Read keys directory from YAML file and use it if we can
if [ -n "$vagrantfile_ssh_custom_sshpubkeysdirectory" ]; then
    KEYDIR=$vagrantfile_ssh_custom_sshpubkeysdirectory
    if [ -d $KEYDIR ]; then
        echo "Copy ssh keys from $KEYDIR into $AUTHORIZED_KEYS_FILE"
        copy_ssh_keys $KEYDIR $AUTHORIZED_KEYS_FILE
    else
        echo "Warning: Directory of ssh keys, $KEYDIR, does not exist"
    fi
else
    echo "Info: No directory of SSH public keys was specified."
fi
