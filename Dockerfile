FROM php:7.3

ENV PATH /php-testing/vendor/bin:${PATH}

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY php-testing /php-testing

WORKDIR /php-testing

RUN apt-get update && \
    apt-get install -y libzip-dev zlib1g-dev curl make zip unzip procps && \
	chmod 777 /php-testing/docker-entrypoint.sh && \
	mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini && \
    pecl install xdebug-2.8.0 && docker-php-ext-enable xdebug && \
    docker-php-ext-install json sockets zip && \
	env COMPOSER_HOME="/php-testing" && \
    composer install
	
COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENTRYPOINT ["/php-testing/docker-entrypoint.sh"]
CMD ["tests"]
