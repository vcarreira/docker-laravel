FROM mysql

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    cron \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mysql-backups

VOLUME /mysql-backups

COPY crontab /etc/crontab

COPY entry-point.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
