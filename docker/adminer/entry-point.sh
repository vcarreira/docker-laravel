#!/bin/bash

if [ ! -f /var/www/index.php ]; then
    wget https://www.adminer.org/static/download/4.2.4/adminer-4.2.4.php -O /var/www/index.php
fi
/usr/bin/supervisord
