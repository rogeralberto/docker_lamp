FROM ubuntu:16.04
LABEL maintainer=rogerolivares@gmail.com


##Update repository and upgrade the system
RUN apt-get update
RUN apt-get check
RUN apt-get dist-upgrade -y

##Install Apache server
RUN apt-get install -y apache2

##Install php7 and some librarys
RUN apt-get install -y php7.0 && apt-get install -y php7.0-intl && apt-get install -y php7.0-mbstring && apt-get install -y php7.0-mcrypt && apt-get install -y php7.0-mysql && apt-get install -y libapache2-mod-php && apt-get install -y wget

##Enable handle to pretty url
RUN a2enmod rewrite

##Apache configuration
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

##Add apache2.conf to the container
ADD apache2.conf /etc/apache2/apache2.conf

##Restart apache2
RUN service apache2 restart


##Install composer
RUN wget https://getcomposer.org/download/1.8.3/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod -R 777 /usr/local/bin/composer

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
