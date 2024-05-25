#!/bin/bash

sleep 15
mkdir -p /var/www/html/wordpress

if [ ! -f "/var/www/html/wordpress/adminer.php" ] ; then
    mv /adminer.php /var/www/html/wordpress/
fi

php -S 0.0.0.0:8080 -t /var/www/html