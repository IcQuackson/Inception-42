#!/bin/bash
echo "maria db running"

if [ -d "/var/lib/mysql/$DB_NAME" ];

then
	echo "Database already exist"
	echo "Database already exist2312"

else
	service mariadb start

	sleep 1

	echo "Configuring MariaDB..."
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

	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

	mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"

	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';"

	mysql -u root -e "FLUSH PRIVILEGES;"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';"

	mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

	mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

fi

echo "DONE"
echo "Starting MariaDB..."

exec "$@"