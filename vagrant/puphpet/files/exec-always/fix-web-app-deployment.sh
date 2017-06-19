#!/bin/sh
# make the api logs directory

# Note the directory to make and the permissions to fix
APPROOT=/var/www/ccdaa/
NEWDIR=/var/www/ccdaa/api/v1/logs

# Make sure the directory exists
if [ -d $NEWDIR ]; then
    echo "$NEWDIR already exists"
else
    echo "Making $NEWDIR"
    mkdir -p $NEWDIR
fi

# fix ownership from APPROOT down
chown -R www-data:www-data $APPROOT

# fix permissions in api/v1 directory
find $APPROOT/api/v1/ -type d | xargs -i chmod 775 {}

# Symlink adminer into the ccdaa doc root
ln -s /var/www/html/adminer $APPROOT/
