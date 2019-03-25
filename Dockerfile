FROM ubuntu:18.04

MAINTAINER Dylan Leahy <dylan@adr3nalin3.net>

ENV TZ Australia/Perth
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 80

RUN echo "deb http://ftp.iinet.net.au/pub/ubuntu/ubuntu bionic main universe" > /etc/apt/sources.list
RUN echo "deb http://ftp.iinet.net.au/pub/ubuntu/ubuntu/ bionic-security main universe" >> /etc/apt/sources.list
RUN echo "deb http://ftp.iinet.net.au/pub/ubuntu/ubuntu/ bionic-updates main universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y apache2 default-jre php php-mysql php-all-dev php-zip php-gd php-curl clamav libreoffice-common unoconv p7zip-full imagemagick unrar-free ffmpeg tesseract-ocr meshlab dia pandoc poppler-utils zip unzip wget && apt-get clean && rm -rf /var/lib/apt/lists/*
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
RUN mkdir -p $APACHE_RUN_DIR
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR
COPY uploads.ini /etc/php/7.2/apache2/conf.d/uploads.ini
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

RUN mkdir /var/www/html/HRProprietary
RUN mkdir /var/www/html/HRProprietary/HRConvert2
RUN mkdir /home/converter
RUN chmod -R 0755 /home/converter
RUN chown -R www-data /home/converter
run chgrp -R www-data /home/converter

RUN wget https://github.com/zelon88/HRConvert2/archive/v2.4.zip -O /tmp/2.4.zip
RUN unzip /tmp/2.4.zip -d /tmp/
RUN mv /tmp/HRConvert2-2.4/* /var/www/html/HRProprietary/HRConvert2
RUN rm -rf /var/www/html/index.html
COPY index.html /var/www/html/index.html

RUN chmod -R 0755 /var/www/html
RUN chown -R www-data /var/www/html
RUN chgrp -R www-data /var/www/html

RUN rm -rf /var/www/html/HRProprietary/HRConvert2/config.php
COPY config.php /var/www/html/HRProprietary/HRConvert2/config.php

RUN wget https://raw.githubusercontent.com/zelon88/HRConvert2/master/rc.local -O /etc/rc.local
RUN chmod +x /etc/rc.local
RUN /usr/bin/soffice --headless --accept="socket,host=127.0.0.1,port=$soffice_port;urp;" --nofirststartwizard &

