#!/bin/bash

# Where is my settings file?
# If you need a sample
MYSQL_RC_FILE=~/.my.cnf

usage() { echo "Usage: $0" 1>&2;echo "$MYSQL_RC_FILE must exist and have a valid username, password, and database name." 1>&2; echo "Copy my.cnf.example to make a new $MYSQL_RC_FILE" 1>&2; exit 1; }

if [ -z "${MYSQL_RC_FILE}" ] || [ ! -e "${MYSQL_RC_FILE}" ] ; then
    usage
fi

echo "Redeploying database using credentials in $MYSQL_RC_FILE"

# Overwrite the decision aids database
cat /sql/ccdaa_all.sql | mysql

# Initialize the authorization system
echo "INSERT INTO authorization VALUES (1,1,NULL,NULL,NULL,'ccdaa_login_auth','Key used by new sessions for CCDAA',0,'','7b02422a35016bf1499be3442b0311f8',now(),'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00');" | mysql

# Generate 5000 subject records
echo "CALL setupNewInstance('5000', '10000');" | mysql
