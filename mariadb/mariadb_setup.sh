#!/bin/sh

set -e
echo "starting mysql"
/etc/rc.d/rc.mysqld start &
sleep 10
echo "creating user and adding privileges"
mysql -e "CREATE USER 'developer'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
sleep 10
echo "stoping mysql"
killall mysqld
