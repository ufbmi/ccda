#!/bin/bash
# rewrite ./api/v1/config.php based on the example file

# note what we are making form what and where we can find them
DIRROOT=/var/www/ccdaa/api/v1
EXAMPLE=config.php.example
TARGETFILE=config.php

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
    NAME=$mysql_databases_mysqlnd_qri5yd3zfa6w_name
fi

# Make sure the directory exists
if [ -d $DIRROOT ]; then
    if [ -e $DIRROOT/$EXAMPLE ]; then
        cp -af $DIRROOT/$EXAMPLE $DIRROOT/$TARGETFILE
    else
        echo "Example file $DIRROOT/$EXAMPLE does not exist"
        exit 2
    fi
else
    echo "Directory $DIRROOT does not exist"
    exit 1
fi

# Stream edit the lines that require it
sed -e "s/'base_url' => .*/'base_url' => '\/api\/v1',/" -i $DIRROOT/$TARGETFILE
sed -e "s/'base_path' => .*/'base_path' => '\/var\/www\/ccdaa\/api\/v1',/" -i $DIRROOT/$TARGETFILE
sed -e "s/'name' => .*/'name' => '$NAME',/" -i $DIRROOT/$TARGETFILE
sed -e "s/'username' => .*/'username' => '$USERNAME',/" -i $DIRROOT/$TARGETFILE
sed -e "s/'password' => .*/'password' => '$PASSWORD',/" -i $DIRROOT/$TARGETFILE
