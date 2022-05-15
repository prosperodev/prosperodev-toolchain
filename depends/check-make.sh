#!/bin/sh
# check-make.sh by Franciso Javier Trujillo Mata (fjtrujy@gmail.com)

## Check for make.
make -v 1> /dev/null || { echo "ERROR: Install make before continuing."; exit 1; }
