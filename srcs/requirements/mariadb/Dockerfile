# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

EXPOSE 3306

# Install MariaDB
RUN apt-get update && \
    apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/config.sh /tmp/config.sh

RUN chmod 777 /tmp/config.sh


ENTRYPOINT ["/tmp/config.sh"]

# TODO: Tentar especificar o port 3306
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]
