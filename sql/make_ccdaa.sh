#!/bin/bash

# note where this script resides
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Dump only database structure and Sprocs
mysqldump --skip-add-locks --skip-comments \
    --routines --events --no-data \
    ccdaa \
    > $DIR/ccdaa.sql
