FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

COPY tools/mariadb_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_setup.sh

CMD ["mariadb_setup.sh"]