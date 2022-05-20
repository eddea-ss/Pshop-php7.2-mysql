FROM php:7.2-apache
#Apache con PHP 7.2
#https://dev.to/fuenrob/usar-prestashop-1-7-con-docker-compose-34fi

RUN pecl install -f xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini;

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip
#RUN install-php-extensions intl bcmath imagick memcached
#Instacion e habilitacion de extension php int encontrada en:
#https://stackoverflow.com/questions/48674297/php-intl-extension-in-docker-container
RUN apt-get -y update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN a2enmod rewrite