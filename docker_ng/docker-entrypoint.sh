#!/bin/bash
set -eux

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
#cd $DIR

export DEBIAN_FRONTEND=noninteractive

# pass the error (ex. when user already exist);
# by muting the error, this script could be use to upgrade data container too
$RALPH_EXEC createsuperuser --noinput --username ralph --email ralph@allegro.pl || true
python3 $RALPH_DIR/docker_ng/createsuperuser.py

#cd $RALPH_DIR

$RALPH_EXEC migrate --noinput
$RALPH_EXEC collectstatic --noinput
$RALPH_EXEC sitetree_resync_apps



