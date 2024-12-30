#!/bin/bash
set -e

# get uuid of /dev/sda1
#uuid=$(ls -l /dev/disk/by-uuid/ | grep sda1 | awk '{print $9}')
#echo "UUID of /dev/sda1: $uuid"
#
# read first 3 lines of /etc/fstab
#head -n 3 /etc/fstab > /tmp/fstab
#echo "UUID=$uuid /mnt/disk1 ext4 defaults 0 2" >> /tmp/fstab
## /var/lib/docker is a symlink to /mnt/disk1/docker
#mkdir -p /mnt/disk1/var/lib/docker
#echo "/mnt/disk1/var/lib/docker /var/lib/docker none bind 0 0" >> /tmp/fstab
## /var/log is a symlink to /mnt/disk1/log
#mkdir -p /mnt/disk1/var/log
#echo "/mnt/disk1/var/log /var/log none bind 0 0" >> /tmp/fstab
## /var/cache is a symlink to /mnt/disk1/cache
#mkdir -p /mnt/disk1/var/cache
#echo "/mnt/disk1/var/cache /var/cache none bind 0 0" >> /tmp/fstab
#
#mount -a --fake -T /tmp/fstab
#
## replace /etc/fstab with /tmp/fstab
#rm -f /etc/fstab
#mv /tmp/fstab /etc/fstab
#
#mount -a