FROM debian:latest

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-zip \
    tar \
    curl \
    && rm -rf /var/lib/apt/lists/*


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

# RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz

# RUN tar -xf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
# 	&& rm -f /tmp/wordpress.tar.gz

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' \
    /etc/php/8.4/fpm/pool.d/www.conf

COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh


ENTRYPOINT ["/setup.sh"]
