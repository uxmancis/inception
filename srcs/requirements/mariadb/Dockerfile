FROM debian:bookworm

# Installs DB
RUN apt-get update && apt-get install -y mariadb-server

# Script (mariadb_setup.sh) runs when container starts
COPY mariadb_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_setup.sh

CMD ["mariadb_setup.sh"]