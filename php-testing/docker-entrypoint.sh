#!/bin/sh
#
# Entry Point
#

# is work directory set?
if [ -z "$WORK_DIR" ] 
then
    export WORK_DIR=/srv/app
fi

cd $WORK_DIR
make -f /php-testing/Makefile "$@"

# Can be used to code check tests
#export FOLDER_APP=${WORK_DIR}/tests
#export PSALM_FOLDER=tests
#make -f /php-testing/Makefile "$@"
