#!/bin/bash
echo "Decoding ssh key..."
python file_decoder.py $SSH_KEY decoded_openlmis.pem
echo "Deploying artifacts..."
docker run --rm --volumes-from $HOSTNAME \
           -e HOSTS_VERIFICATION=$HOSTS_VERIFICATION -e DBUSER=$DBUSER \
           -e DBPASSWORD=$DBPASSWORD \
           -e MAILPASSWORD=$MAILPASSWORD \
           -e OPENLMIS_VERSION=$OPENLMIS_VERSION \
           -w /godata/pipelines/portal_deployment/portal_deployment/ \
           siglus/taskrunner:0.0.2 \
           sh -c "python scripts/file_decoder.py $HOSTS_VERIFICATION known_hosts && mkdir -m 700 -p /home/go/.ssh && mv known_hosts /home/go/.ssh/ && ansible-playbook deploy_to_prod_playbook.yml -i inventory --private-key=scripts/decoded_openlmis.pem --extra-vars \"dbuser=${DBUSER} dbpassword=${DBPASSWORD} mailpassword=${MAILPASSWORD} openlmis_version=${OPENLMIS_VERSION}\""
echo "Deleting ssh key..."
rm decoded_openlmis.pem
