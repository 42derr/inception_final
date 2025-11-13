FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y mariadb-server && rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY mariadb-init.sh /mariadb-init.sh
RUN chmod +x /mariadb-init.sh

EXPOSE 3306

CMD ["/mariadb-init.sh"]
