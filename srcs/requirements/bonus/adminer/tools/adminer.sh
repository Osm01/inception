#!/bin/bash

if [ ! -f "/var/www/html/adminer.php" ] ; then
    mv /adminer.php /var/www/html/wordpress/
fi

php -S 0.0.0.0:8080 -t /var/www/html