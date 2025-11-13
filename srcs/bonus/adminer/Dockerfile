FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php-cli \
    php-mysql \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer
WORKDIR /var/www/adminer

RUN wget "https://www.adminer.org/latest.php" -O index.php

RUN chown -R www-data:www-data /var/www/adminer \
    && chmod 755 /var/www/adminer/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
