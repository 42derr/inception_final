FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.33.3/portainer-2.33.3-linux-arm64.tar.gz -o /tmp/portainer.tar.gz && \
    tar -xzvf /tmp/portainer.tar.gz -C /tmp && \
    mv /tmp/portainer /usr/local/bin/ && \
    rm -rf /tmp/portainer.tar.gz && \
    chmod +x /usr/local/bin/portainer/portainer

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/portainer/portainer"]

CMD ["--host", "unix:///var/run/docker.sock"]
