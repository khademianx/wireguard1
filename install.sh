#!/bin/bash

docker info > /dev/null 2>&1

# Ensure that Docker is running...
if [ $? -ne 0 ]; then
    echo "Docker is not running."

    curl -fsSL https://get.docker.com | sh
fi

mkdir /opt/wireguard && \
    cd /opt/wireguard && \
    curl -o ./docker-compose.yml https://raw.githubusercontent.com/khademianx/wireguard1/refs/heads/main/docker-compose.yml && \
    curl -o ./.env https://raw.githubusercontent.com/khademianx/wireguard1/refs/heads/main/.env.example

docker run --rm --entrypoint="" -v /opt/wireguard/.env:/app/.env ahmadrezaei/wireguard-panel sh -c "php artisan key:generate"

docker run --rm -it --entrypoint="" -v /opt/wireguard/.env:/app/.env ahmadrezaei/wireguard-panel:develop sh -c "php artisan setup"

cd /opt/wireguard && docker compose up -d
