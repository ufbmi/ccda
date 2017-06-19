#!/bin/bash

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm -f $MYDIR/ccdaa_all.sql
cp $MYDIR/ccdaa.sql $MYDIR/ccdaa_all.sql
echo "SET FOREIGN_KEY_CHECKS = 0;" >> $MYDIR/ccdaa_all.sql
cat $MYDIR/ccdaa_sample_data.sql >> $MYDIR/ccdaa_all.sql
echo "SET FOREIGN_KEY_CHECKS = 1;" >> $MYDIR/ccdaa_all.sql
