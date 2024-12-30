#!/bin/bash
set -e

# Check if the VLAN interface already exists
if ip link show | grep -q "$SMARTDOM_NETWORK_ADAPTER.$SMARTDOM_NETWORK_VLAN_ID"; then
    echo "VLAN interface $SMARTDOM_NETWORK_ADAPTER.$SMARTDOM_NETWORK_VLAN_ID already exists."
else
    # Create the VLAN interface
    ip link add link "$SMARTDOM_NETWORK_ADAPTER" name "$SMARTDOM_NETWORK_ADAPTER.$SMARTDOM_NETWORK_VLAN_ID" type vlan id "$SMARTDOM_NETWORK_VLAN_ID"
    
    # Bring the VLAN interface up
    ip link set dev "$SMARTDOM_NETWORK_ADAPTER.$SMARTDOM_NETWORK_VLAN_ID" up
    
    echo "VLAN interface $SMARTDOM_NETWORK_ADAPTER.$SMARTDOM_NETWORK_VLAN_ID created and brought up."
fi
