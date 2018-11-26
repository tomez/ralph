#!/bin/bash
set -e

# wait for db init
sleep 15

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

./upgrade.sh

# pass the error (ex. when user already exist);
# by muting the error, this script could be use to upgrade data container too
$RALPH_EXEC createsuperuser --noinput --username ralph --email ralph@allegro.pl || true
python3 $RALPH_DIR/docker_ng/createsuperuser.py

set -e
cd $RALPH_DIR

make docs

$RALPH_EXEC migrate --noinput

make menu
