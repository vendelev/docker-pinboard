FROM datravel/php-fpm:5.6

ENV PATH=/bin:/usr/bin:/sbin:/usr/sbin

RUN mkdir /tmp/files && \
 mkdir -p /var/www/pinboard

ADD . /tmp/files
WORKDIR /var/www/pinboard

RUN apt-get update \
 && apt-get install -y cron git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone git://github.com/intaro/pinboard.git --branch=v1.5.2 /var/www/pinboard

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin \
 && mv /usr/bin/composer.phar /usr/bin/composer

RUN cd /var/www/pinboard && \
 composer install --no-interaction && \
 composer update kurl/silex-doctrine-migrations-provider doctrine/migrations

CMD ./console migrations:migrate --no-interaction && \
 ./console register-crontab --no-interaction && \
 exec /usr/sbin/php5-fpm -F
