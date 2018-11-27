#!bin/bash
set -a
source ${RALPH_CONF_DIR}/ralph.conf
source ${RALPH_CONF_DIR}/conf.d/database.conf
source ${RALPH_CONF_DIR}/conf.d/redis.conf

ralph migrate --noinput

python3 ${RALPH_LOCAL_DIR}/createsuperuser.py

ralph sitetree_resync_apps

