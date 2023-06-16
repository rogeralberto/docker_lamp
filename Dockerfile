FROM ubuntu:22.04
LABEL maintainer=rogerolivares@gmail.com

##Update repository and upgrade the system
RUN apt-get update
RUN apt-get check
RUN apt-get dist-upgrade -y

##Install Apache server
RUN apt-get install -y apache2

##Install php7 and some librarys
RUN apt-get install -y php-curl \
&& apt-get install -y php-gd \
&& apt-get install -y libapache2-mod-php \ 
&& apt-get install -y wget \
&& apt-get install -y unzip \
&& apt-get install -y php-xml \ 
&& apt-get install -y php-common \
&& apt-get install -y php-gd \
&& apt-get install -y php-tcpdf \
&& apt-get install -y php-xmlrpc \
&& apt-get install -y php7.0 \
&& apt-get install -y php7.0-intl \ 
&& apt-get install -y php7.0-mbstring \ 
&& apt-get install -y php7.0-mcrypt \
&& apt-get install -y php7.0-mysql \
&& apt-get install -y php7.0-common \ 
&& apt-get install -y php7.0-bcmath \ 
&& apt-get install -y php7.0-cli \
&& apt-get install -y php7.0-curl \
&& apt-get install -y php7.0-gd \
&& apt-get install -y php7.0-json \ 
&& apt-get install -y php7.0-opcache \ 
&& apt-get install -y php7.0-readline \
&& apt-get install -y php7.0-soap \
&& apt-get install -y php7.0-xmlrpc     

##Enable handle to pretty url
RUN a2enmod rewrite

##Apache configuration
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

##Add apache2.conf to the container
ADD apache2.conf /etc/apache2/apache2.conf
ADD docker-default.conf /etc/apache2/sites-available/docker-default.conf

#Sites enable
RUN a2ensite docker-default.conf

##Restart apache2
RUN service apache2 restart

##Install composer
RUN wget https://getcomposer.org/download/1.8.3/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod -R 777 /usr/local/bin/composer

WORKDIR /var/www/html

ENTRYPOINT ["/usr/sbin/apache2"]

CMD ["-D", "FOREGROUND"]
