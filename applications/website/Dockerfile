FROM php:fpm
MAINTAINER Axel Venet <kern046@gmail.com>

ENV TIMEZONE=Europe/Paris

COPY docker-entrypoint.sh /entrypoint.sh

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget zip unzip git \

    &&  usermod -u 1000 www-data \

    && docker-php-ext-install pdo pdo_mysql \

    && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \

    && wget https://phar.phpunit.de/phpunit-6.1.phar \
    && chmod +x phpunit-6.1.phar \
    && mv phpunit-6.1.phar /usr/bin/phpunit \

    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
    && php -r "unlink('composer-setup.php');" \

    && chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

WORKDIR /srv/apps/official-website
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
