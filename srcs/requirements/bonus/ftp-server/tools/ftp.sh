#!/bin/bash

# FTP

echo -e "listen=YES\n\
anonymous_enable=YES\n\
local_enable=YES\n\
write_enable=YES\n\
local_umask=022\n\
dirmessage_enable=YES\n\
use_localtime=YES\n\
xferlog_enable=YES\n\
connect_from_port_20=YES\n\
pasv_enable=YES\n\
pasv_min_port=1024\n\
pasv_max_port=1048\n\
pasv_address=0.0.0.0\n\
anon_root=/srv/ftp\n\
anon_upload_enable=YES\n\
anon_mkdir_write_enable=YES\n\
anon_other_write_enable=YES\n\
log_ftp_protocol=YES" > /etc/vsftpd.conf

mkdir -p /var/run/vsftpd/empty
# chmod a+w /srv/ftp

adduser --disabled-password --gecos "" ftpuser
echo "ftpuser:123" | chpasswd 

chown ftpuser:ftpuser /srv/ftp

mkdir -p /var/run/vsftpd/empty

vsftpd /etc/vsftpd.conf
