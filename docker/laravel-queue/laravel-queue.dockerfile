FROM vcarreira/php5

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor /var/www

COPY laravel-queue-supervisor.conf /etc/supervisor/conf.d/laravel-queue.conf

VOLUME ["/var/log/supervisor", "/var/www"]

CMD ["/usr/bin/supervisord"]
