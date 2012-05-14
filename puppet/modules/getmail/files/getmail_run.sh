#!/bin/sh

WORKDIR=$HOME/.getmail
date=`date "+%d-%m-%Y_%H:%M"`

if [ ! -f $WORKDIR/gmail-backup.mbox ]
then
   touch $WORKDIR/gmail-backup.mbox
fi

getmail --quiet > $WORKDIR/getmail.log
OUT=$?
if [ $OUT -eq 0 ]
then
   mkdir -p $WORKDIR/backups/ && { mv $WORKDIR/gmail-backup.mbox $WORKDIR/backups/gmail-backup_$date.mbox ;}
else [ $OUT -eq 1 ]
   exit 1
fi

# Cleanup older than 3 days backups and oldmail-*
find $WORKDIR/backups/* -mtime +3 -exec rm {} \;
cd $WORKDIR && { rm -rf oldmail-* ;}
