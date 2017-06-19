#!/bin/bash

FILES=$1'/*.sql'
UPDATE_FILE=$1'/upgrade.sql'

if [ -f $UPDATE_FILE ]; then
    echo -e "Upgrade file exists, would you like to overwrite? [y/N] \c"
    read overwrite
    if [ "$overwrite" = "y" ]
    then
      echo "Removing old upgrade.sql in $1"
      rm $UPDATE_FILE
    else
      echo "Exiting..."
      exit
    fi
fi

for f in $FILES
do
  if [ "$f" != $UPDATE_FILE ]
  then
    echo "Processing $f..."
    echo "--" >> $UPDATE_FILE
    echo "-- Contents of $f" >> $UPDATE_FILE
    echo "--" >> $UPDATE_FILE
    cat $f >> $UPDATE_FILE
    echo "" >> $UPDATE_FILE
  fi
done