#!/bin/bash

# exec mysqld_safe &

service mariadb start
# sudo chown mysql:mysql /run/mysqld/mysqld.sock
# sudo chmod 777 /run/mysqld/mysqld.sock
# netstat -tuln | grep 3306


mariadb -h localhost -u root -v -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -h localhost -u root -v -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -h localhost -u root -v -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -h localhost -u root -v -e "FLUSH PRIVILEGES;"
mariadb -h localhost -u root -v -e "SHOW DATABASES;"
service mariadb stop

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
exec mysqld_safe