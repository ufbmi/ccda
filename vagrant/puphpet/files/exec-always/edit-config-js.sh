#!/bin/bash
# rewrite ./web/app/config.js based on the example file

# note what we are making from what and where we can find them
DIRROOT=/var/www/ccdaa/web/app
EXAMPLE=config.js.example
TARGETFILE=config.js

# Set values for variables we will edit here
URI_TO_API="http://crcdaa.org/api/v1/"

# load libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/functions.sh

# read variables from the config-custom yaml file
MYTEMP=`mktemp`
parse_yaml /vagrant/puphpet/config-custom.yaml > $MYTEMP
. <(sed '/^export/!s/^/export /' $MYTEMP)


# load configuration from YAML file
if [ -n "$daa_url" ]; then
    URI_TO_API=$daa_url
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
sed -e "sX\"api_url\": .*X\"api_url\": \"$URI_TO_API\",X;" -i $DIRROOT/$TARGETFILE

# Do not use the fixed json file for form content if we are deployed at AWS.
if [ -n "$vagrantfile_target" ]; then
    if [ "$vagrantfile_target" = "aws" ]; then
        sed -e "sX\"use_fixed_file\": .*X\"use_fixed_file\": false,X;" -i $DIRROOT/$TARGETFILE
    fi
fi


