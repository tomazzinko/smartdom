#!/bin/bash
set -e

sudo su - ${SMARTDOM_USER} << EOF
    set +e

    cd /tmp
    wget https://github.com/AlexxIT/SonoffLAN/archive/refs/tags/v3.8.1.tar.gz
    tar -xvf v3.8.1.tar.gz

    mkdir -p $SMARTDOM_OPT/custom_components

    cp -r SonoffLAN-3.8.1/custom_components/sonoff $SMARTDOM_OPT/custom_components/sonoff

    set -e
EOF