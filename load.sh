#
# This script is intended to be sourced from .bashrc
# It is added to .bashrc by install.sh
#

if [[ -z $REMOTE_CONTAINERS ]];then
    TZ='Europe/London'; export TZ

    # Always start docker if it's not running
    if [[ ! -f /var/run/docker.pid ]]; then
        { echo "🐳 Starting Docker..."; start-docker; };
    fi
fi

