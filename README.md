# Laravel docker container

This is a [Docker](http://www.docker.com) multi-container for the [Laravel PHP Framework](http://laravel.com/).
The Compose file provides the following services:

  - Nginx + PHP7 + FPM container [vcarreira/nginx-php7-fpm](https://registry.hub.docker.com/u/vcarreira/nginx-php5-fpm)
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

To simplify the process of dockerizing a Laravel webapp you can use the [yeoman docker-laravel generator](https://github.com/vcarreira/generator-docker-laravel) based on this repo. The Git repository has detailed instructions on how to run the generator and a series of 5 videos that show each container working.


**Important notes:**

  - Version 1.7 or greater of ```docker-compose``` is required because the Compose file reads environment variables from the .env file
  - On Windows or OSX you must use the native Docker app (Docker for Windows or Docker for Mac)

## Size

To provide consistency all images (except the official ones) are based on debian:jessie. All PHP related containers are based on the same [PHP 7 container](https://registry.hub.docker.com/u/vcarreira/php7). The rational behind this is to guarantee that the development and test environment are the same as the one used for the Nginx container.

Size of each image:
```
vcarreira/nginx-php7-fpm   599 MB
vcarreira/redis            183 MB
```


## Related images

  - [vcarreira/nginx-php7-fpm](https://registry.hub.docker.com/u/vcarreira/nginx-php7-fpm)
  - [vcarreira/redis](https://registry.hub.docker.com/u/vcarreira/redis)
  - [vcarreira/composer](https://registry.hub.docker.com/u/vcarreira/composer)
  - [vcarreira/artisan](https://registry.hub.docker.com/u/vcarreira/artisan)
  - [vcarreira/phpspec](https://registry.hub.docker.com/u/vcarreira/phpspec)
  - [vcarreira/phpunit](https://registry.hub.docker.com/u/vcarreira/phpunit)


## Credits
Must of this work is based on:
* [SpiralOut](https://github.com/SpiralOutDotEu)

---

:ok_hand: Happy Coding.

If you have any feedback or questions, feel free to contact me on Twitter with [@vcarreira](https://twitter.com/vcarreira) or email with [vitor.carreira@gmail.com](mailto:vitor.carreira@gmail.com).
