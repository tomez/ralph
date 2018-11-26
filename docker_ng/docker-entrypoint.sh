#!/bin/bash
set -e

db_env_variables=(
    DATABASE_NAME
    DATABASE_USER
    DATABASE_PASSWORD
    DATABASE_HOST
    DATABASE_PORT
    DATABASE_ENGINE
)
db_conf_path="/etc/ralph/conf.d/database.conf"
db_conf_path="/tmp/docker_ng/database.conf"

redis_env_variables=(
    REDIS_HOST
    REDIS_PORT
    REDIS_DB
    REDIS_PASSWORD
)
redis_conf_path="/etc/ralph/conf.d/redis.conf"
redis_conf_path="/tmp/docker_ng/redis.conf"

function push_env_vars_to_config() {
    local conf_path=$1
    shift
    local env_variables=("$@")
    for env_var in "${env_variables[@]}"
    do
        if [[ ! -z "${!env_var}" ]]; then
            sed -ri "s/(${env_var} ?= ?).*/\1${!env_var}/" ${conf_path}
        fi
    done
}

push_env_vars_to_config "$db_conf_path" "${db_env_variables[@]}"

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



