#!/bin/bash

# note where this script resides
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Ignore authorization, sessions, and responses tables in the dump
mysqldump --skip-add-locks --skip-comments \
    --skip-extended-insert --no-create-db --no-create-info \
    --ignore-table=ccdaa.sessions \
    --ignore-table=ccdaa.authorization \
    --ignore-table=ccdaa.responses \
    ccdaa \
    > $DIR/ccdaa_sample_data.sql

