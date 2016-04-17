#!/bin/sh
source ./docker-laravel-aliases.sh
mkdir -p project
dc-composer create-project laravel/laravel /var/www --prefer-dist

echo "APP_NAME=laravel" > .env
echo "MYSQL_ROOT_PASSWORD=default-sql-pass" >> .env
sed -e 's/DB_HOST=127.0.0.1/DB_HOST=laravel-db/g' project/.env | sed -e 's/REDIS_HOST=127.0.0.1/REDIS_HOST=laravel-redis/g' | sed -e 's/REDIS_PASSWORD=null/REDIS_PASSWORD=redis-pass/g'>> .env
cp .env project/.env
rm .env
ln -s project/.env .env
dc-art key:generate
