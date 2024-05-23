FROM centos:7

# Install required packages
RUN yum install -y centos-release-scl && \
    yum install -y httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml mariadb-server mariadb && \
    yum clean all

# Enable and start services
RUN systemctl enable mariadb && \
    systemctl enable httpd24-httpd.service && \
    systemctl start mariadb && \
    systemctl start httpd24-httpd.service

# Install MediaWiki
RUN cd /var/www && \
    wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz && \
    wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz.sig && \
    gpg --verify mediawiki-1.41.1.tar.gz.sig mediawiki-1.41.1.tar.gz && \
    tar -zxf mediawiki-1.41.1.tar.gz && \
    ln -s mediawiki-1.41.1/ mediawiki && \
    chown -R apache:apache /var/www/mediawiki-1.41.1

# Configure Apache
RUN sed -i 's|DocumentRoot "/var/www"|DocumentRoot "/var/www/mediawiki"|g' /etc/httpd/conf/httpd.conf && \
    sed -i 's|<Directory "/var/www">|<Directory "/var/www/mediawiki">|g' /etc/httpd/conf/httpd.conf && \
    sed -i 's|DirectoryIndex index.html index.html.var index.php|DirectoryIndex index.php|g' /etc/httpd/conf/httpd.conf && \
    chown -R apache:apache /var/www/mediawiki && \
    echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/httpd/conf.d/rewrite.conf

# Configure MediaWiki
RUN echo "<?php $wgScriptPath = \"/\"; ?>" > /var/www/mediawiki/LocalSettings.php

# COPY ./config/mediawiki /var/www/mediawiki

# Firewall configuration
RUN firewall-cmd --permanent --zone=public --add-service=http && \
    firewall-cmd --permanent --zone=public --add-service=https && \
    systemctl restart firewalld

# Security configuration
RUN setenforce 0

# Expose ports
EXPOSE 80 443

# Start Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
