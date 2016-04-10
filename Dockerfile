FROM python:3.4.3
MAINTAINER forkloop@gmail.com

RUN groupadd celery && useradd --create-home --home-dir /home/celery -g celery celery

WORKDIR /home/celery

RUN apt-get update && \
    apt-get install -y rabbitmq-server && \
    apt-get install -y --force-yes supervisor

ENV CELERY_VERSION 3.1.23

RUN pip install -U pip && \
    pip install celery=="$CELERY_VERSION"

RUN mkdir -p /etc/supervisor/conf.d

COPY conf/supervisord.conf /etc/supervisor

COPY conf/conf.d .

COPY run.sh /usr/local/bin/run.sh

RUN chown celery:celery /var/log/supervisor

RUN { \
    echo 'import os'; \
    echo "BROKER_URL = os.environ.get('CELERY_BROKER_URL', 'amqp://')"; \
} > celeryconfig.py

#USER celery
ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

