#!/bin/bash
# rewrite ~/my.cnf based on the example file

# note what we are making form what and where we can find them
EXAMPLE=/sql/my.cnf.example
TARGETFILE=.my.cnf
TARGETDIR=/home/vagrant

# Set values for variables we will edit here
PASSWORD=123
USERNAME=ccdaa
NAME=ccdaa

# load libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

# read variables from the config-custom yaml file
MYTEMP=`mktemp`
parse_yaml /vagrant/puphpet/config-custom.yaml > $MYTEMP
. <(sed '/^export/!s/^/export /' $MYTEMP)

if [ -n "$mysql_users_mysqlnu_l0ux1btcldlz_name" ]; then
    USERNAME=$mysql_users_mysqlnu_l0ux1btcldlz_name
fi

if [ -n "$mysql_users_mysqlnu_l0ux1btcldlz_password" ]; then
    PASSWORD=$mysql_users_mysqlnu_l0ux1btcldlz_password
fi

if [ -n "$mysql_databases_mysqlnd_qri5yd3zfa6w_name" ]; then
    DATABASE=$mysql_databases_mysqlnd_qri5yd3zfa6w_name
fi

if [ -n "$vagrantfile_ssh_username" ]; then
    TARGETDIR=/home/$vagrantfile_ssh_username
fi

TARGET=$TARGETDIR/$TARGETFILE
echo "Full path to TARGET file is $TARGET"

# Make sure the directory exists and source file exists before copying
if [ -d $TARGETDIR ]; then
    if [ -e $EXAMPLE ]; then
        echo "Copying from $EXAMPLE to $TARGET"
        cp -af $EXAMPLE $TARGET
    else
        echo "Example file $EXAMPLE does not exist"
        exit 2
    fi
else
    echo "Directory $TARGETDIR does not exist."
fi

# Stream edit the lines that require it
echo "Stream editing $TARGET"
sed -e "s/database=.*/database=$DATABASE/" -i $TARGET
sed -e "s/user=.*/user=$USERNAME/" -i $TARGET
sed -e "s/password=.*/password='$PASSWORD'/" -i $TARGET
