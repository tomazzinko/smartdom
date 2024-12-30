#!/bin/bash
set -e

# read Z2M_SERIAL_PORT from .env
DEVICE=$SMARTDOM_ZIGBEE2MQTT_SERIAL_PORT

# Identify device attributes
idVendor=$(udevadm info -a -n $DEVICE | grep -m 1 '{idVendor}' | awk -F'==' '{print $2}' | tr -d '"')
echo ${idVendor}
idProduct=$(udevadm info -a -n $DEVICE | grep -m 1 '{idProduct}' | awk -F'==' '{print $2}' | tr -d '"')
echo ${idProgram}
serial=$(udevadm info -a -n $DEVICE | grep -m 1 '{serial}' | awk -F'==' '{print $2}' | tr -d '"')
echo ${serial}


# Create udev rule
RULE_FILE="/etc/udev/rules.d/99-zigbee.rules"

echo "Creating udev rule at $RULE_FILE..."

# Add rule to udev file
echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$idVendor\", ATTRS{idProduct}==\"$idProduct\", ATTRS{serial}==\"$serial\", SYMLINK+=\"zigbeeHUB\" OWNER=\"$DEPLOY_USER\"" | sudo tee $RULE_FILE > /dev/null

# Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "udev rule created and reloaded successfully."