#!/bin/bash
set -e

function step {
  echo -e "---- \e[1;32m$1\e[0m $2 -----------------------------------------"
}

# read all files in folder install ending in .sh
for f in ./install/*.sh; do
  echo step "Running" $f
  . $f
  echo step "Completed" $f
done