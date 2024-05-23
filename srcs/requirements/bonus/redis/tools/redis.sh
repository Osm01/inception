#!/bin/bash

# chown redis:redis /var/log/redis/redis-server.log
# service redis-server start

sed -i 's/daemonize yes/daemonize no/' /etc/redis/redis.conf
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis/redis.conf
sed -i 's/protected-mode yes/protected-mode no/' /etc/redis/redis.conf

# echo 'vm.overcommit_memory = 1' | tee -a /etc/sysctl.conf
# sysctl -p
# sysctl vm.overcommit_memory=1

redis-server /etc/redis/redis.conf