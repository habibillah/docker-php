FROM php:7.2-apache
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxml2-dev \
        zlib1g-dev libicu-dev g++ \
    && docker-php-ext-install -j$(nproc) pdo_mysql mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure xmlrpc \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && a2enmod rewrite
    


