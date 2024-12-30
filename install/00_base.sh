#!/bin/bash
set -e

mkdir -p /etc/smartdom

export SMARTDOM_CONFIG_FILE=/etc/smartdom/config.yaml
export SMARTDOM_SECRET_FILE=/etc/smartdom/secret.yaml

if [ ! -f $SMARTDOM_SECRET_FILE ]; then
    touch $SMARTDOM_SECRET_FILE
fi
