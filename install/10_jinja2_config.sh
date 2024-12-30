#!/bin/bash
set -e

# Create a virtual environment if it doesn't exist
if [ ! -d "./venv" ]; then
  python3 -m venv ./venv
fi

# Activate the virtual environment
source ./venv/bin/activate

pip install jinja2 PyYAML

python3 ./scripts/render-jinja2.py $SMARTDOM_CONFIG_FILE $SMARTDOM_SECRET_FILE ./config_template $SMARTDOM_HOME/.config

# Deactivate the virtual environment
deactivate 

