FROM php:7.2-apache

RUN apt-get update && \
    apt-get install net-tools && \
    apt-get install -y vim && \
    apt-get install nano

COPY web1/public_html /var/www/html/web1/public_html
COPY web1/web1.com.conf /etc/apache2/sites-available

RUN a2ensite web1.com.conf

RUN mkdir -p /etc/apache2/tls/certs && mkdir /etc/apache2/tls/private

COPY web1/tls/certs/web1.crt /etc/apache2/tls/certs
COPY web1/tls/private/web1.csr /etc/apache2/tls/private
COPY web1/tls/private/web1.key /etc/apache2/tls/private

RUN a2enmod ssl

EXPOSE 80 443
