#
# slackware64-current
# - nginx

# base image
FROM vbatts/slackware:current
MAINTAINER josemrb <work@josemrb.com>

# update slackpg
RUN slackpkg update

# install dependencies
RUN \
	slackpkg -batch=on -default_answer=y install sasl rsync-* glibc-* perl && \
	slackpkg -batch=on -default_answer=y install autoconf automake binutils gettext-tools intltool kernel-headers libtool m4 make libmpc gcc-[0-9] gcc-g[+] && \
	slackpkg -batch=on -default_answer=y install pcre zlib libxslt libxml2 shadow

# update sbopkg and build
RUN \
	mkdir -p /tmp/install && cd /tmp/install && \
	wget -c http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz && \
	installpkg sbopkg-0.37.0-noarch-1_cng.tgz && \
	mkdir -p /var/lib/sbopkg/SBo/14.1 && \
	mkdir -p /var/lib/sbopkg/queues && \
	mkdir -p /var/cache/sbopkg && \
	mkdir -p /var/log/sbopkg && \
	mkdir -p /tmp/SBo && \
	sbopkg -r && \
	sbopkg -B -i sbotools && \
	sbosnap fetch && \
	sboinstall -r GeoIP && \
	groupadd -g 8080 www-data && \
	useradd -g 8080 -u 8080 -M -s /bin/false www-data && \
	USE_GEOIP=yes NGINXUSER=www-data NGINXGROUP=www-data sboinstall -r nginx && \
	chown -R www-data:www-data /var/lib/nginx

# update script | add exec | run in foreground 
RUN \
	chmod +x /etc/rc.d/rc.nginx

# copy config file
COPY ./nginx.conf /etc/nginx/nginx.conf

# define mountable directories
VOLUME ["/etc/nginx", "/etc/nginx/conf.d", "/var/lib/nginx"]

# set port
EXPOSE 80

# start server
ENTRYPOINT /etc/rc.d/rc.nginx start
