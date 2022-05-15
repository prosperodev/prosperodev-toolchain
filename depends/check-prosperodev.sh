#!/bin/sh
# check-prosperodev.sh by Franciso Javier Trujillo Mata (fjtrujy@gmail.com)

## Check if $PROSPERODEV is set.
if test ! $PROSPERODEV; then { echo "ERROR: Set \$PROSPERODEV before continuing."; exit 1; } fi

## Check for the $PROSPERODEV directory.
ls -ld $PROSPERODEV 1> /dev/null || mkdir -p $PROSPERODEV 1> /dev/null || { echo "ERROR: Create $PROSPERODEV before continuing."; exit 1; }

## Check for $PROSPERODEV write permission.
touch $PROSPERODEV/test.tmp 1> /dev/null || { echo "ERROR: Grant write permissions for $PROSPERODEV before continuing."; exit 1; }

## Check for $PROSPERODEV/bin in the path.
echo $PATH | grep $PROSPERODEV/bin 1> /dev/null || { echo "ERROR: Add $PROSPERODEV/bin to your path before continuing."; exit 1; }
