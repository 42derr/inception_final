FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    php-fpm php-mysql php-cli curl unzip mariadb-client less procps wget \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/listen = .*/listen = 0.0.0.0:9000/" /etc/php/*/fpm/pool.d/www.conf

RUN mkdir -p /var/www/html
WORKDIR /var/www

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress/* html/ \
    && rm -rf wordpress latest.tar.gz

RUN apt-get update && apt-get install -y \
    php-gd php-imagick \
    && rm -rf /var/lib/apt/lists/*

COPY wp-config.php /var/www/html/wp-config.php
RUN chmod 644 /var/www/html/wp-config.php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY wordpress-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-init.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["wordpress-init.sh"]
