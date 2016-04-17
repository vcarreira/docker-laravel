#!/bin/sh
source ./docker-laravel-aliases.sh
mkdir -p project
dc-composer create-project laravel/laravel /var/www --prefer-dist
cp project/.env .
echo "APP_NAME=laravel" > project/.env
echo "MYSQL_ROOT_PASSWORD=default-sql-pass" >> project/.env
cat .env >> project/.env
rm .env
ln -s project/.env .env
sed -i -e 's/DB_HOST=127.0.0.1/DB_HOST=laravel-db/g' .env
sed -i -e 's/REDIS_HOST=127.0.0.1/REDIS_HOST=laravel-redis/g' .env
