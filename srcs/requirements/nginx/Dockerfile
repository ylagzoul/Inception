FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl

COPY tools/server.crt /etc/nginx/ssl/server.crt

COPY tools/server.key /etc/nginx/ssl/server.key

ENTRYPOINT ["nginx", "-g", "daemon off;"]
