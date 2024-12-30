#!/bin/bash
set -e

# read variable from first arg
if [ -z "$1" ]; then
    echo "Please provide the SSH_HOST SSH_PORT. Usage: ./deploy.sh user@host 22"
    exit 1
fi

SSH_HOST=$1
SSH_PORT=$2

export OPT="/opt"
export PROJECT_DIR="$OPT/smartdom"

echo "Copying SSH ID to $SSH_HOST"
ssh-copy-id -p $SSH_PORT $SSH_HOST

echo "Copying files to $SSH_HOST"
scp -r -P $SSH_PORT ../smartdom $SSH_HOST:/tmp

# Run install.sh on the remote host
echo "Running install.sh on $SSH_HOST"
ssh -p $SSH_PORT $SSH_HOST << EOF
  set -e

  sudo su -
  rm -rf $OPT/smartdom
  mv /tmp/smartdom $OPT

  cd $PROJECT_DIR
  chmod +x install.sh
  sudo ./install.sh
EOF


echo "Script execution completed."
