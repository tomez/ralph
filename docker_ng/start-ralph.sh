#!/bin/bash

/opt/ralph/ralph-core/bin/gunicorn -c "${RALPH_LOCAL_DIR}/gunicorn.ini" ralph.wsgi
