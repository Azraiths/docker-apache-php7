FROM ubuntu:16.04
MAINTAINER Alexander Schenkel <alex@alexi.ch>

VOLUME ["/var/www"]

ENV OS_LOCALE="en_US.UTF-8"
RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive

RUN   \
      BUILD_DEPS='software-properties-common' \
    && dpkg-reconfigure locales \
      && apt-get install --no-install-recommends -y $BUILD_DEPS \
      && add-apt-repository -y ppa:ondrej/php \
      && add-apt-repository -y ppa:ondrej/apache2 \
      && apt-get update \
    && apt-get install -y \ 
    curl \
    apache2 \
    libapache2-mod-php7.3 \
    php7.3-cli \
    php7.3-readline \
    php7.3-mbstring \
    php7.3-zip \
    php7.3-intl \
    php7.3-xml \
    php7.3-json \
    php7.3-curl \
    php7.3-gd \
    php7.3-pgsql \
    php7.3-mysql \
    php-pear \
    composer

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]
