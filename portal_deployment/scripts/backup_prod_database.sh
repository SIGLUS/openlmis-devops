#!/bin/bash

set -e
DATE=`date +%Y-%m-%d-%H-%M`
pg_dump -U $DBUSER -Fc -f openlmis-backup-$DATE $DBNAME -h 172.31.4.20 -p $DBPASSWORD
