# Database Deployment and Maintenance

This document provides some guidance for deploying, upgrading and maintaining the database for CCDAA application.

## Refreshing the database from source

Create a ~/.my.cnf file from ./sql/my.cnf.example.  Adjust the password and othwer database credentials as needed.  The credentials in my.cnf.example match those in ./api/v1/config.php.example

To refresh the database from source code, execute this mysql command:

    cat /sql/ccdaa_all.sql | mysql


## Refreshing the site keys

The database is initialized with no authorization data in the authorization table.  You must populate the authorization table with the root entry and make enough subject records for this survey before you can use the application.  In this example 5000 keys are created.

    echo "INSERT INTO authorization VALUES (1,1,NULL,NULL,NULL,'ccdaa_login_auth','Key used by new sessions for CCDAA',0,'','7b02422a35016bf1499be3442b0311f8',now(),'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00');" | mysql

    echo "CALL setupNewInstance('5000', '10000');" | mysql
