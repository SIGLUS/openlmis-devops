#!/bin/bash

set -e
DATE=`date +%Y-%m-%d-%H-%M`
docker run --rm --volumes-from $HOSTNAME -w /godata/pipelines/portal_deployment/portal_deployment/scripts/ siglus/taskrunner:0.0.2 sh -c "mkdir -p backups && PGPASSWORD=$DBPASSWORD pg_dump -h 54.251.142.73 -U $DBUSER -f backups/openlmis-backup-$DATE.sql open_lmis && cd backups && tar -czvf openlmis-backup-$DATE.sql.gz openlmis-backup-$DATE.sql && rm openlmis-backup-$DATE.sql"
