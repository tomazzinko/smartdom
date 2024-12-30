#!/bin/bash
set -e

# Create a new user if it doesn't exist
if ! id -u $SMARTDOM_USER > /dev/null 2>&1; then
    echo "Creating user $SMARTDOM_USER"
    sudo useradd -m $SMARTDOM_USER
fi

sudo usermod $SMARTDOM_USER -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio,docker