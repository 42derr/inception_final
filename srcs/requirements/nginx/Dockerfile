FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    nginx openssl bash \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/nginx /etc/ssl/private /var/www/html

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -subj "/CN=localhost" \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/private/nginx.crt \
    && chown -R www-data:www-data /etc/ssl/private

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
