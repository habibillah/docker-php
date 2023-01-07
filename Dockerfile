FROM php:7.4-apache

ENV APACHE_DOCUMENT_ROOT /var/www/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


COPY config/php.ini /usr/local/etc/php/php.ini

RUN mkdir -p /var/webapp/public \
    && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxml2-dev \
        zlib1g-dev libicu-dev g++ \
        libzip-dev \
    && docker-php-ext-install -j$(nproc) pdo_mysql mysqli \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure xmlrpc \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && pecl install xdebug-2.8.1 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && a2enmod rewrite
    
RUN service apache2 restart    
    



