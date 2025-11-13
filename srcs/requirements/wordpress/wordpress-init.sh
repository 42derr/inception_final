#!/bin/bash
set -e

if [ -n "$MYSQL_PASSWORD_FILE" ]; then
  export MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
fi

if [ -n "$WP_ADMIN_PASSWORD_FILE" ]; then
  export WP_ADMIN_PASSWORD=$(cat "$WP_ADMIN_PASSWORD_FILE")
fi

if [ -n "$WP_USER_PASSWORD_FILE" ]; then
  export WP_USER_PASSWORD=$(cat "$WP_USER_PASSWORD_FILE")
fi

WP_CONFIG=/var/www/html/wp-config.php

if [ -f "$WP_CONFIG" ]; then
    sed -i -e "s/define( 'DB_NAME', .* );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/" \
           -e "s/define( 'DB_USER', .* );/define( 'DB_USER', '${MYSQL_USER}' );/" \
           -e "s/define( 'DB_PASSWORD', .* );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/" \
           -e "s/define( 'DB_HOST', .* );/define( 'DB_HOST', '${WORDPRESS_DB_HOST}:${WORDPRESS_DB_PORT}' );/" \
           -e "s/define( 'DB_CHARSET', .* );/define( 'DB_CHARSET', 'utf8' );/" \
           "$WP_CONFIG"
fi

echo "Waiting for MariaDB at ${WORDPRESS_DB_HOST}:${WORDPRESS_DB_PORT} ..."

echo "Waiting for database..."
for i in {1..60}; do
    mysql -h "$WORDPRESS_DB_HOST" -P "$WORDPRESS_DB_PORT" \
          -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" &>/dev/null && break
    echo "Waiting for database... ($i/60)"
    sleep 3
done

echo "Database reachable, continuing..."

TABLES=$(mysql -h "$WORDPRESS_DB_HOST" -P "$WORDPRESS_DB_PORT" \
               -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" \
               -D "$MYSQL_DATABASE" -e "SHOW TABLES LIKE 'wp_%';" | wc -l)

if [ "$TABLES" -eq 0 ]; then
    echo "Installing WordPress..."
    wp core install \
        --url="$DOMAIN" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --role="$WP_USER_ROLE" \
    --user_pass="$WP_USER_PASSWORD" \
    --allow-root

    wp theme install generatepress --activate --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root

    wp redis enable --allow-root

    echo "WordPress setup complete!"
else
    echo "WordPress already installed."
fi

chown -R www-data:www-data /var/www/html/wp-content
chmod -R 775 /var/www/html/wp-content

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
