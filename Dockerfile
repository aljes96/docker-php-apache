#
# Construída a partir da imagem oficial do Docker para PHP com a finalidade de
# facilitar o desenvolvimento de projetos web em geral.
#

ARG PHP_VERSION
FROM php:${PHP_VERSION}-apache

ARG XDEBUG_VERSION

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        nodejs \
        yarn \
        imagemagick \    
        zlib1g-dev \        
        libzip-dev \
        zip \
        unzip \
        # GD
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        # Soap
        libxml2-dev \
        && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
        && docker-php-ext-configure bcmath --enable-bcmath \
        && docker-php-ext-configure intl --enable-intl \
        && docker-php-ext-configure mysqli --with-mysqli \
        && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
        && docker-php-ext-configure soap --enable-soap \
        && docker-php-ext-install -j$(nproc) \
            gd \
            bcmath \
            intl \
            mysqli \
            pdo_mysql \
            soap \
            zip \
            exif \            
            opcache \    
        && docker-php-source delete \
    ; \
    pecl install xdebug-${XDEBUG_VERSION} \
        && docker-php-ext-enable xdebug \
        && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && echo "xdebug.remote_autostart = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && echo "xdebug.connect_back = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    ; \
    apt-get -q autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "ServerName localhost" > /etc/apache2/conf-available/ServerName.conf; \
    /usr/sbin/a2enconf ServerName; \
    /usr/sbin/a2enmod rewrite headers expires
