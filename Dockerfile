FROM ubuntu:22.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 80

RUN apt-get update -y && \
    apt-get install -y software-properties-common --no-install-recommends && \
    add-apt-repository multiverse && \
    apt-get update && \
    apt-get upgrade -yy && \
    apt-get install -y git apache2 default-jre php php-mysql \ 
                       php-all-dev php-zip php-gd php-curl clamav libreoffice-common \ 
                       unoconv p7zip-full imagemagick ffmpeg tesseract-ocr \ 
                       meshlab dia pandoc poppler-utils zip unzip wget rar unrar --no-install-recommends && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR && \
    mkdir -p $APACHE_LOCK_DIR && \
    mkdir -p $APACHE_LOG_DIR


COPY uploads.ini /etc/php/8.1/apache2/conf.d/uploads.ini
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

RUN mkdir /var/www/html/HRProprietary && \
    mkdir /home/converter && \
    chmod -R 0755 /home/converter && \
    chown -R www-data /home/converter && \
    chgrp -R www-data /home/converter

RUN git clone https://github.com/zelon88/HRConvert2.git /var/www/html/HRProprietary/HRConvert2 && \
    rm -rf /var/www/html/HRProprietary/HRConvert2/.git

COPY index.html /var/www/html/index.html

RUN chmod -R 0755 /var/www/html && \
    chown -R www-data /var/www/html && \
    chgrp -R www-data /var/www/html

COPY config.php /var/www/html/HRProprietary/HRConvert2/config.php

RUN mv /var/www/html/HRProprietary/HRConvert2/rc.local /etc/rc.local && \
    chmod +x /etc/rc.local

RUN /usr/bin/soffice --headless --accept="socket,host=127.0.0.1,port=$soffice_port;urp;" --nofirststartwizard &
