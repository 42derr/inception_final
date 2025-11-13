#!/bin/bash
set -e 

if [ -n "$MYSQL_ROOT_PASSWORD_FILE" ]; then
  export MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
fi

if [ -n "$MYSQL_PASSWORD_FILE" ]; then
  export MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
fi

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

echo "Waiting for MariaDB to start..."
for i in {1..60}; do
    mariadb -u root -e "SELECT 1;" &>/dev/null && break
    sleep 1
done
echo "MariaDB is ready!"

mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

kill $(cat /var/run/mysqld/mysqld.pid)

exec /usr/sbin/mysqld --user=mysql --bind-address=0.0.0.0
