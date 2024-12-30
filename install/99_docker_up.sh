#!/bin/bash
set -e

sudo su - ${SMARTDOM_USER} << EOF
    cd $SMARTDOM_HOME
    docker-compose up -d
EOF