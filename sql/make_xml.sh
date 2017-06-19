#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
mkdir -p $MYDIR/xml

if [ "$1" = "" ]
then
  CCDAA_PASSWORD="123"
  TABLES=(answers authorization forms lu_icons lu_languages lu_options lu_styles lu_types preferences_icons preferences_languages preferences_options preferences_styles preferences_text preferences_types projects questions responses sections sessions sites)
  for i in "${TABLES[@]}"
  do
    mysql -u ccdaa -p$CCDAA_PASSWORD --database ccdaa --xml -e "SELECT * FROM $i;" > $MYDIR/xml/ccdaa.$i.xml 2>/dev/null
  done
else
  mysql -u ccdaa -p$CCDAA_PASSWORD --database ccdaa --xml -e "SELECT * FROM $1;" > $MYDIR/xml/ccdaa.$1.xml 2>/dev/null
fi
