FROM ubuntu:16.04
MAINTAINER Alexander Schenkel <alex@alexi.ch>

VOLUME ["/var/www"]

RUN apt-get update
RUN apt-get install -y language-pack-en-base
RUN apt-get install -y software-properties-common
RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
      apache2 \
      php7.2 \
      php7.2-cli \
      libapache2-mod-php7.2 \
      php-apcu \
      php-xdebug \
      php7.2-gd \
      php7.2-json \
      php7.2-mbstring \
      php7.2-mysql \
      php7.2-xml \
      php7.2-zip \
      php7.2-opcache \
      libargon2-0 \
      libsodium23 \
      libssl1.1 \
      php7.2-common \
      php7.2-readline \
      composer

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]
