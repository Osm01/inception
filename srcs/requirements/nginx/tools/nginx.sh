#!/bin/bash
sleep 6
openssl req -x509 -nodes -days 365 \
-keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt \
-subj "/C=MR/ST=RHAMNA/L=BENGUERIR/O=1337/CN=ouidriss.1337.ma"

nginx -g 'daemon off;'