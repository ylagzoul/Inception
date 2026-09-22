FROM debian:latest

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN rm -rf /var/lib/apt/lists/*

COPY tools/setup.sh  /setup.sh

RUN chmod 755 /setup.sh


ENTRYPOINT ["/setup.sh"]