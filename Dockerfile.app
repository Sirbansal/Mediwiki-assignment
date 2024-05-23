FROM httpd:2.4

RUN yum -y install mariadb-devel php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,xml,fpm,intl,json,apcu} && yum clean all

COPY . /var/www/html

RUN chown -R apache:apache /var/www/html

CMD ["httpd", "-D", "FOREGROUND"]
