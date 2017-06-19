#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
mkdir -p $MYDIR/json

if [ "$1" = "" ]
then
  CCDAA_PASSWORD="123"
  TABLES=(answers authorization forms lu_icons lu_languages lu_options lu_styles lu_types preferences_icons preferences_languages preferences_options preferences_styles preferences_text preferences_types projects questions responses sections sessions sites)
  for i in "${TABLES[@]}"
  do
    echo "$CCDAA_PASSWORD" | php make_json.php $i >/dev/null
  done
else
  php make_json.php $1
fi
