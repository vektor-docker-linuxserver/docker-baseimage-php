FROM vektory79/i386-baseimage-apache
MAINTAINER Vektory79 <vektory79@gmail.com>

# Set correct environment variables
ENV BASE_APTLIST="$BASE_APTLIST libapache2-mod-php php php-cli php-curl php-fpm php-cgi"

# install main packages
RUN apt-get update -q && \
apt-get install $BASE_APTLIST -qy && \

# cleanup 
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files 
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

sed -i "s/www-data/abc/g" /etc/php/7.0/fpm/pool.d/www.conf && \
mkdir /run/php && \
chmod 0777 /run/php

# expose ports
EXPOSE 80 443

# set volumes
VOLUME /config
