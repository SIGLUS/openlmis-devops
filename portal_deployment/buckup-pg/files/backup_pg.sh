#!/bin/bash

#/pgdata/backup_pg.sh >> /tmp/backup_pg.log

now=$(date +%Y%m%d_%H%M%S)

pg_dump open_lmis -U openlmis > /pgdata/backup/openlmis-$now.sql 

cd /pgdata/backup
tar czf  openlmis-$now.sql.tar.gz openlmis-$now.sql 
rm openlmis-$now.sql

cd /pgdata/backup
ls -lt | awk '{if(NR>=6){print $9}}' | xargs rm -f
