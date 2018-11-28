#!bin/bash
ralph migrate --noinput

python3 ${RALPH_LOCAL_DIR}/createsuperuser.py

ralph sitetree_resync_apps
