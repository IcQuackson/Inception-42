# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

# Install MariaDB
RUN apt-get update && apt upgrade && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Expose MariaDB port
EXPOSE 3306

# Copy configurations
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/

COPY tools/create_user.sh /

RUN chmod 777 /create_user.sh

ENTRYPOINT ["/create_user.sh"]
# Start MariaDB
CMD ["mysqld"]
