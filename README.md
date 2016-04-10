### how to use

default to run as celery worker

```
docker run --rm --name celery celery-python3
```

run as celery beat with rabbitmq

```
docker run -e "RABBIT=true" -e "CELERYTYPE=beat" --rm --name celery celery-python3
```

run as celery worker in `INFO` level with rabbitmq

```
docker run -e "RABBIT=true" -e "CELERYTYPE=worker" -e "LOGLEVEL=INFO" --rm --name celery celery-python3
```

