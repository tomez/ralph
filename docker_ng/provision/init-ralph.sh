#!bin/bash
set -e

${RALPH_LOCAL_DIR}/wait-for-it.sh $DATABASE_HOST:$DATABASE_PORT --timeout=15 --strict -- echo "Database is up"

ralph migrate --noinput

python3 ${RALPH_LOCAL_DIR}/createsuperuser.py

ralph sitetree_resync_apps
