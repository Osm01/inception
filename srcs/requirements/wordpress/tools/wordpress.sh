#!/bin/bash
sleep 6

#installing wordpress if not installed
if [ ! -d "/var/www/html/wordpress" ]; then
    wget https://wordpress.org/latest.tar.gz && tar -xvf latest.tar.gz && rm latest.tar.gz
    mv wordpress /var/www/html
    chown -R www-data:www-data /var/www/html/wordpress
    mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wordpress/wp-config.php    
    sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wordpress/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wordpress/wp-config.php
    sed -i "s/localhost/$MYSQL_HOST/" /var/www/html/wordpress/wp-config.php
   
fi

# handling error of commication between php and webserver (nginx)
if [ ! -d "/run/php/" ]; then
    mkdir /run/php/
    chown -R www-data:www-data /run/php/
fi

#installing wp-cli to automate wordpress installation
if [ ! -d "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
fi

# installing wordpress if not installed and creating admin user and user
if [ -z "$(wp user get $WP_ADMIN --field=user_login --allow-root --path=$PATH_TO_WP)" ]; then
    wp core install --url=$URL --title="$TITLE" \
    --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL \
    --path=$PATH_TO_WP --allow-root
    wp role create $WP_USER "$WP_DISPLAY_NAME" --clone="subscriber" --allow-root \
    --path=$PATH_TO_WP
    wp user create $WP_USER $WP_USER_EMAIL --role=$WP_USER --user_pass=$WP_USER_PASSWORD \
    --path=$PATH_TO_WP --allow-root
fi

#changing from unix socket to tcp socket to connect to nginx
sed -i "s;/run/php/php7.4-fpm.sock;0.0.0.0:9000;" /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F