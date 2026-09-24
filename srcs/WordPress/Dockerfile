FROM debian:latest

RUN apt-get update && apt-get install -y php.fpm php.mysql

COPY tools/setup.sh /setup.sh

ENTRYPOINT ["sleep","10000000000"]
