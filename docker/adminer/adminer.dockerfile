FROM vcarreira/nginx-php5-fpm

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

COPY entry-point.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
