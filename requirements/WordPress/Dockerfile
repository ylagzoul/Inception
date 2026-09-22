FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html \
    && rm latest.tar.gz


COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]