#!/bin/bash
set -e

# copy docker-compose.yml to the home
cp $SMARTDOM_OPT/docker-compose.yaml $SMARTDOM_HOME/docker-compose.yaml

# own the docker-compose.yml
chown $SMARTDOM_USER:$SMARTDOM_USER $SMARTDOM_HOME/docker-compose.yaml

sudo su - ${SMARTDOM_USER} << EOF
    cd $SMARTDOM_HOME
    set +e
    docker-compose stop
    docker-compose up -d pihole
    set -e
EOF