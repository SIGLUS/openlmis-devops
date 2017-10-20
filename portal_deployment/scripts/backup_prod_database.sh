#!/bin/bash

set -e
DATE=`date +%Y-%m-%d-%H-%M`
docker run --rm --volumes-from $HOSTNAME -w /godata/pipelines/portal_deployment/portal_deployment/scripts/ siglus/taskrunner:0.0.2 sh -c "mkdir -p backups && PGPASSWORD=$DBPASSWORD pg_dump -h 172.31.4.20-U $DBUSER -w -Fc -f backups/openlmis-backup-$DATE $DBNAME"
