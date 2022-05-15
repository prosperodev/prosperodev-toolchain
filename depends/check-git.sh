#!/bin/sh
# check-git.sh by Franciso Javier Trujillo Mata (fjtrujy@gmail.com)

## Check for git.
git --version > /dev/null || { echo "ERROR: Install Git before continuing."; exit 1; }
