#!/bin/bash

#reason of this script is that dockerfile only execute one command at the time but we need sometimes at the moment we create 
#the docker image to run more that one software for expecified configuration like when you need mysql running to chnage or create
#database for the container ...

  wget http://downloads.sourceforge.net/project/rackmonkey/rackmonkey/1.2.5/rackmonkey-1.2.5-1.tar.gz
  tar -xvf rackmonkey-1.2.5-1.tar.gz
  rm rackmonkey-1.2.5-1.tar.gz
  mkdir -p /var/www/rackmonkey
  cp rackmonkey-1.2.5-1/perl/rackmonkey.pl /var/www/rackmonkey
  cp -r rackmonkey-1.2.5-1/perl/RackMonkey /var/www/rackmonkey
  chmod 750 /var/www/rackmonkey/rackmonkey.pl
  cp -r rackmonkey-1.2.5-1/www/* /var/www/rackmonkey
  mkdir -p mkdir /var/lib/rackmonkey
  chown www-data:www-data /var/lib/rackmonkey
  cp -r rackmonkey-1.2.5-1/tmpl /var/lib/rackmonkey
  mkdir -p /etc/apache2/conf.d
  cp rackmonkey-1.2.5-1/conf/httpd-rackmonkey.conf /etc/apache2/conf.d/
  ln -s /etc/apache2/conf.d/httpd-rackmonkey.conf /etc/apache2/conf-enabled/httpd-rackmonkey.conf
  cp rackmonkey-1.2.5-1/conf/rackmonkey.conf-default /etc/rackmonkey.conf
  sed -i 's/dbconnect =/dbconnect = dbi\:SQLite\:dbname=\/var\/lib\/rackmonkey\/rackmonkey.db/' /etc/rackmonkey.conf
  sed  -i 's/tmplpath =/tmplpath = \/var\/lib\/rackmonkey\/tmpl/' /etc/rackmonkey.conf
  sed  -i 's/wwwpath =/wwwpath = \/rackmonkey/' /etc/rackmonkey.conf
  sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/schema/schema.sqlite.sql
  sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/data/default_data.sql
  sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/data/sample_data.sql
  chown www-data:www-data /var/lib/rackmonkey/rackmonkey.db
  cp rackmonkey-1.2.5-1/perl/rack2xls.pl /var/www/rackmonkey
  cp rackmonkey-1.2.5-1/perl/rackdns.pl /var/www/rackmonkey
  chmod 750 /var/www/rackmonkey/rack2xls.pl
  chmod 750 /var/www/rackmonkey/rackdns.pl
  a2enmod cgi
  sed -i '14 i\ DirectoryIndex \/rackmonkey\/rackmonkey.pl' /etc/apache2/sites-available/000-default.conf
  sed -i 's/^\s*#\s*plugin_xls/plugin_xls/' /etc/rackmonkey.conf
  sed -i 's/^\s*#\s*plugin_dns/plugin_dns/' /etc/rackmonkey.conf
  rm -R /var/www/html
  sed  -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www/' /etc/apache2/sites-available/000-default.conf
  rm -R rackmonkey-1.2.5-1
  chown -R www-data:www-data /var/www/

