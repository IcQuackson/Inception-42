#!/bin/bash
echo "maria db running"

service mariadb start

sleep 4

echo "Maria db started"

export DB_ROOT_PASSWORD="mysql"

mysql_secure_installation << END

Y
$DB_ROOT_PASSWORD
$DB_ROOT_PASSWORD
Y
Y
Y
Y
END


sleep 1

echo "Creating user..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

echo "CREATE"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"

echo "GRANT"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';"

echo "FLUSH"
mysql -u root -e "FLUSH PRIVILEGES;"

echo "ALTER"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';"

echo "FLUSH"
mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

echo "SHUTDOWN"
mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown

echo "DONE"

exec "$@"