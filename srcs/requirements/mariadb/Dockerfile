# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

# Install MariaDB
RUN apt-get update && apt upgrade && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Expose MariaDB port
EXPOSE 3306

COPY tools/config.sh /

RUN chmod 777 /config.sh

RUN mysql_install_db

ENTRYPOINT ["/config.sh"]
# Start MariaDB
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]
