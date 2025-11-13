FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty && chown root:root /var/run/vsftpd/empty

COPY vsftpd-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/vsftpd-init.sh

COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 21 30000-30009

CMD ["/usr/local/bin/vsftpd-init.sh"]
