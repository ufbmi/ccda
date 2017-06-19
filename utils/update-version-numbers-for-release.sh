#!/bin/bash
# Update version numbers for release

NEWTAG=$2
LASTTAG=$1

usage() { echo "Usage: $0 -p previous_release_tag -n new_release_tag" 1>&2; exit 1; }

# Parse our arguments
while getopts ":p:n:" opt; do
  case $opt in
    p)
        LASTTAG=$OPTARG
        ;;
    n)
        NEWTAG=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        usage
        ;;
  esac
done

if [ -z "${LASTTAG}" ] || [ -z "${NEWTAG}" ]; then
    usage
fi

echo "Replacing $LASTTAG with $NEWTAG in ..."

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
REPOROOT=$MYDIR/../

FILE=$REPOROOT/./sql/*.sql
echo "  $FILE"
sed -e "s/,'$LASTTAG'/,'$NEWTAG'/;" -i $FILE
git add $FILE

FILE=$REPOROOT/./web/app/config.js.example
echo "  $FILE"
sed -e "s/$LASTTAG/$NEWTAG/;" -i $FILE
git add $FILE

FILE=$REPOROOT/./api/v1/config.php.example
echo "  $FILE"
sed -e "s/'app_version' => '.*'/'app_version' => '$NEWTAG'/;" -i $FILE
git add $FILE

# make the sql upgrades folder for this release
SQL_UPGRADE_DIR=$REPOROOT/./sql/$NEWTAG
if [ ! -e $SQL_UPGRADE_DIR ] ; then
    echo "Making $SQL_UPGRADE_DIR"
    mkdir $SQL_UPGRADE_DIR
fi

# move each .sql file in NEXT_RELEASE_DIR to SQL_UPGRADE_DIR
NEXT_RELEASE_DIR=$REPOROOT/./sql/next_release
if [ -e $NEXT_RELEASE_DIR ] ; then
    echo "Moving *.sql files in $NEXT_RELEASE_DIR to $SQL_UPGRADE_DIR"
    for UPGRADEFILE in $NEXT_RELEASE_DIR/*.sql; do
        git mv $UPGRADEFILE $SQL_UPGRADE_DIR
    done
fi

# make a sql file to bump the version number
FILE=$SQL_UPGRADE_DIR/99_bump_version_number.sql
echo "update forms set version='$NEWTAG' where 1=1;" > $FILE
git add $FILE

# Regenerate the upgrade.sql file for this release
echo "Regenerate the upgrade.sql file for this release"
rm -f $SQL_UPGRADE_DIR/upgrade.sql
$REPOROOT/./sql/make_upgrade_sql_file.sh $SQL_UPGRADE_DIR
git add $SQL_UPGRADE_DIR/upgrade.sql
