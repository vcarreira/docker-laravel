# Laravel docker container

This is a [Docker](http://www.docker.com) multi-container for the [Laravel PHP Framework](http://laravel.com/).
The Compose file provides the following services:

  - Nginx + PHP5 + FPM container [vcarreira/nginx-php5-fpm](https://registry.hub.docker.com/u/vcarreira/nginx-php5-fpm)
  - Redis container [vcarreira/redis](https://registry.hub.docker.com/u/vcarreira/redis)
  - Official MySQL container
  - Built-in MySQL backup container
  - Built-in Adminer container
  - Built-in queue:listen daemon

The following one-off containers are provided for the common Laravel tasks:

  - Artisan one-off container [vcarreira/artisan](https://registry.hub.docker.com/u/vcarreira/composer)
  - Composer one-off container [vcarreira/composer](https://registry.hub.docker.com/u/vcarreira/composer)
  - PHPUnit one-off container [vcarreira/phpunit](https://registry.hub.docker.com/u/vcarreira/phpunit)
  - PHPSpec one-off container [vcarreira/phpspec](https://registry.hub.docker.com/u/vcarreira/phpspec)
  - NodeJS one-off container to execute gulp, bower, npm and general node commands [vcarreira/node](https://registry.hub.docker.com/u/vcarreira/node)

## Setup
Before proceeding make sure you have ```docker```, ```docker-compose``` **version 1.7+** installed. Next:

 - Clone this repo: ```git clone https://github.com/vcarreira/docker-laravel.git```
 - Add the ```docker-laravel-alias.sh``` to your shell or for the current terminal type: ```source docker-laravel-alias.sh```
 - Setup a Laravel project by typing ```sh setup-project.sh```. This script will:
    - create a new Laravel project inside folder ```./project```
    - add two entries (```APP_NAME``` and ```MYSQL_ROOT_PASSWORD```) to Laravel's ```.env``` file
    - point the Compose ```.env``` file to the one provided by Laravel
 - Open ```.env``` file and update the ```APP_NAME```, ```MYSQL_ROOT_PASSWORD``` and other settings related with the services provided by this docker container

**Important notes:**

  - Version 1.7 or greater of ```docker-compose``` is required because the Compose file reads environment variables from the .env file
  - All containers assume that ```./project``` folder is the root folder of the Laravel project
  - The nginx container loads the site(s) definition(s) from folder ```./docker/nginx/sites```. A sample site is provided
  - The nginx container stores all logs on folder ```./docker/nginx/logs```
  - The redis container is configured with persistence enabled. Redis databases are stored on folder ```./docker/redis```
  - Due to file permissions issues on OSX, the mysql container maps the ```/var/lib/mysql``` folder to the ```/docker-server/${APP_NAME}-db``` on the docker machine. Because database data can be lost if the docker machine is restarted or deleted, a container called ```mysql-backup``` is provided to backup the database each 15m. Every 15m the ```mysql-backup``` container creates a backup of the database and places it inside the folder ```./docker/db-backups```

## Launching the containers
To launch the service containers just type:

```
dc-up
```

To stop and remove all containers type:

```
dc-down
```

## Daily usage

To run common tasks use the following aliases:

 - ```dc-art``` or ```dc-artisan``` - to run artisan (e.g. ```dc-art migrate```)
 - ```dc-composer``` - to run composer (e.g. ```dc-composer dumpautoload```)
 - ```dc-phpunit``` - to run phpunit (e.g. ```dc-phpunit tests```)
 - ```dc-phpspec``` - to run phpspec
 - ```dc-node``` - to run a generic node command
 - ```dc-gulp``` - to run gulp (e.g. ```dc-gulp watch```)
 - ```dc-npm``` - to run npm (e.g ```dc-npm install```)
 - ```dc-bower``` - to run (e.g. ```dc-bower install desandro/masonry```) bower


 The following aliases are provided to launch the extra-containers:

 - ```dc-backup``` - to launch the MySQL backup container
 - ```dc-adminer``` - to launch the adminer container
 - ```dc-queue``` - to launch the queue:listen daemon container

## Configuration environment variables
Hostnames are based on the ```APP_NAME``` variable (defaults to laravel). If you change the ```APP_NAME``` to another value, you must change the ```DB_HOST``` and ```DB_REDIS``` accordingly.

### Required configuration for MySQL
The following variables are required to configure/access the MySQL service container:

 - ```MYSQL_ROOT_PASSWORD``` - sets the root password for MySQL
 - ```DB_HOST``` - should follow the form of ```$APP_NAME-db``` (defaults to laravel-db)
 - ```DB_PORT``` - MySQL listening port (defaults to 3306)
 - ```DB_DATABASE``` - database to create (defaults to homestead)
 - ```DB_USERNAME``` - database username (defaults to homestead)
 - ```DB_PASSWORD``` - database password (defaults to secret)

Example:

```
APP_NAME=my-app
DB_HOST=my-app-db
DB_PORT=3306
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```

### MySql inside the docker-machine
When docker is running inside a vm like the one provided by docker machine, in OSX there are some file permission issues that prevent the MySQL data volume being mounted to a host folder. For that particular case you can launch a container that will create a backup of the database every 15 minutes and place the dump inside folder ```./docker/db-backups```.

To run such container type:
```
dc-backup
```

### Adminer container
The Composer file provides a container to run [Adminer](https://www.adminer.org/). To launch the Adminer container just type:

```
dc-adminer
```

Adminer endpoint is exposed at *port 81*.

### Required configuration for Redis
The following variables are required to configure/access the Redis service container:

 - ```REDIS_HOST``` - should follow the form of ```$APP_NAME-redis``` (defaults to laravel-redis)
 - ```REDIS_PORT``` - Redis listening port (defaults to 6379)
 - ```REDIS_PASSWORD``` - redis password (defaults to null)

Example:

```
APP_NAME=my-app
REDIS_HOST=my-app-redis
REDIS_PORT=6379
REDIS_PASSWORD=null
```

Before using the redis container you must install the predis package:

```
dc-composer require predis/predis
```

Because the image contains the PECL redis driver, in Laravel 5.2 you must change the redis namespace to avoid conflicts. Change ```/config/app.php```, and replace:

```
'Redis'     => Illuminate\Support\Facades\Redis::class,
```

with

```
'RedisL5'     => Illuminate\Support\Facades\Redis::class,
```

Use it like this:

```
$redis = RedisL5::connection();
$value = $redis->get('somekey');
```

### Queue daemon container
The Composer file provides a container to run the ```queue:listen``` artisan command monitor by the supervisor process. To launch the  ```queue:listen``` daemon type:

```
dc-queue
```


## Size

To provide consistency all images (except the official ones) are based on debian:jessie. All PHP related containers are based on the same [PHP 5 container](https://registry.hub.docker.com/u/vcarreira/php5). The rational behind this is to guarantee that the development and test environment are the same as the one used for the Nginx container.

Size of each image:
```
dockerlaravel_adminer      520.6 MB
vcarreira/nginx-php5-fpm   520.6 MB
vcarreira/redis            177.6 MB
```

Size of each container after ```dc-up``` command:
```
NAMES               SIZE
laravel-adminer     965 B (virtual 520.6 MB)
laravel-httpd       965 B (virtual 520.6 MB)
laravel-redis       0 B (virtual 177.6 MB)
laravel-db          4 B (virtual 374.1 MB)
```

## Related images

  - [vcarreira/nginx-php5-fpm](https://registry.hub.docker.com/u/vcarreira/nginx-php5-fpm)
  - [vcarreira/redis](https://registry.hub.docker.com/u/vcarreira/redis)
  - [vcarreira/composer](https://registry.hub.docker.com/u/vcarreira/composer)
  - [vcarreira/artisan](https://registry.hub.docker.com/u/vcarreira/artisan)
  - [vcarreira/node](https://registry.hub.docker.com/u/vcarreira/node)
  - [vcarreira/phpspec](https://registry.hub.docker.com/u/vcarreira/phpspec)
  - [vcarreira/phpunit](https://registry.hub.docker.com/u/vcarreira/phpunit)


## Credits
Must of this work is based on:
* [SpiralOut](https://github.com/SpiralOutDotEu)

---

:ok_hand: Happy Coding.

If you have any feedback or questions, feel free to contact me on Twitter with [@vcarreira](https://twitter.com/vcarreira) or email with [vitor.carreira@gmail.com](mailto:vitor.carreira@gmail.com).
