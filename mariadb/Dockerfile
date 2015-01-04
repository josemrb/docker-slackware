#
# slackware64-current
# - mariadb

# base image
FROM vbatts/slackware:current
MAINTAINER josemrb <work@josemrb.com>

# update slackpg
RUN slackpkg update

# install dependencies and mariadb
RUN \
	slackpkg -batch=on -default_answer=y install cyrus-sasl-2.1 git-1.8 rsync-* glibc-* gcc-[0-9] gcc-g[+] && \
	slackpkg -batch=on -default_answer=y install libaio-* mariadb-*

# install mysql tables
RUN \
	mysql_install_db --user=mysql && \
	chown -R mysql:mysql /var/lib/mysql

# update script | enable networking | add exec | run in foreground 
RUN \
	sed -i 's/^SKIP.*/#&/g' /etc/rc.d/rc.mysqld && \
	sed -i 's/\/usr\/bin\/mysqld_safe.*\&$/exec &/g' /etc/rc.d/rc.mysqld && \
	sed -i 's/\&$//g' /etc/rc.d/rc.mysqld && \
	chmod +x /etc/rc.d/rc.mysqld

# add scripts
ADD ./mariadb_setup.sh /tmp/mariadb_setup.sh

# run scripts
RUN chmod +x /tmp/mariadb_setup.sh && /tmp/mariadb_setup.sh

# define mountable directories
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# set port
EXPOSE 3306

# start server
ENTRYPOINT /etc/rc.d/rc.mysqld start
