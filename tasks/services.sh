#/usr/bin/env bash

echo "Enable and start nginx"
systemctl enable nginx
systemctl start nginx

echo "Enable and start MariaDB"
systemctl enable mysqld
systemctl start mysqld

echo "Enable and start php-fpm"
systemctl enable php-fpm
systemctl start php-fpm

