#!/bin/bash
set -e

# Create a virtual environment if it doesn't exist
if [ ! -d "./venv" ]; then
  python3 -m venv ./venv
fi

# Activate the virtual environment
. ./venv/bin/activate

pip install jinja2 PyYAML

source <(python3 ./scripts/config.py "$SMARTDOM_CONFIG_FILE")

# Deactivate the virtual environment
deactivate 
