#!/bin/bash

#
# This script installs dependencies
# It is intended to be run to set up the dotfiles
# And adds to .bashrc to source the load.sh script 
#

BASE_DIR=$(dirname "$0")
BASE_DIR=$(cd $BASE_DIR; pwd)

echo "dotfiles/install.sh - starting... (DEV_CONTAINER=$DEV_CONTAINER)"