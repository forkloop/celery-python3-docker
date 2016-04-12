#!/usr/bin/env bash

set -e

export LOGLEVEL=${LOGLEVEL:=INFO}
export CELERYTYPE=${CELERYTYPE:=worker}
export RABBIT=${RABBIT:=false}

if [ $CELERYTYPE = 'beat' ]; then
    cp /home/celery/celery_beat.conf /etc/supervisor/conf.d
else
    cp /home/celery/celery_worker.conf /etc/supervisor/conf.d
fi

if [ $RABBIT = true ]; then
    cp /home/celery/rabbitmq.conf /etc/supervisor/conf.d
fi

exec "$@"

