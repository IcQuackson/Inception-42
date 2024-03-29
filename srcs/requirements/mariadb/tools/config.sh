#!/bin/bash

echo "Configuring MariaDB..."

if [ -d "/var/lib/mysql/$DB_NAME" ];

then
	echo "Database already exists"

else
	service mariadb start

	sleep 1

	mysql_secure_installation <<-END

	Y
	$DB_ROOT_PASSWORD
	$DB_ROOT_PASSWORD
	Y
	Y
	Y
	Y
	END
	echo "MariaDB configured"
	echo "Creating Database..."

	mysql -u root <<-EOF
		CREATE DATABASE IF NOT EXISTS $DB_NAME;
		CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
		GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
		FLUSH PRIVILEGES;
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
		FLUSH PRIVILEGES;
	EOF

 	mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

fi

echo "Database created"
echo "Starting MariaDB..."

exec "$@"
