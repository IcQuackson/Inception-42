// print all envs
print all env


cd /var/www/wordpress

wp core config --dbhost=DB_HOST \
			   --dbname=DB_NAME \
			   --dbuser=DB_USER \
			   --dbpass=DB_PASSWORD --allow-root

wp core install \
    --url=$WP_SITE_URL \
    --title="$WP_SITE_TITLE" \
    --admin_user=$ \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --path=/var/www/html

wp user create $WP_USER $WP_USER_EMAIL \
	--role=author \
	--user_pass=$WP_USER_PASSWORD \
	--path=/var/www/html

echo "Wordpress installed successfully"