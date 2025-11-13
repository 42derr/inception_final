FROM debian:bookworm

RUN apt update && apt install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN npm init -y && npm install express -y

COPY www ./www

COPY server.js .

EXPOSE 2222

CMD ["node", "server.js"]
