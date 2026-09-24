FROM debian:latest

RUN apt-get update \
	&& apt-get install -y mariadb-server\
	&& rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh  /setup.sh

RUN chmod 755 /setup.sh


ENTRYPOINT ["/setup.sh","sleep","1000000000000"]
