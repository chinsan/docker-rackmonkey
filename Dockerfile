# rackmonkey container
# VERSION               0.1.1
FROM angelrr7702/docker-ubuntu-14.04-sshd
MAINTAINER Angel Rodriguez  "angelrr7702@gmail.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe" >> /etc/apt/sources.list
RUN (DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -q )
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q apache2 sqlite3 libdbi-perl libdbd-sqlite3-perl libhtml-template-perl libhtml-parser-perl supervisor libspreadsheet-writeexcel-perl libnet-dns-perl libapache2-mod-perl2 wget
ADD foreground.sh /etc/apache2/foreground.sh
ADD start.sh /start.sh
RUN wget http://downloads.sourceforge.net/project/rackmonkey/rackmonkey/1.2.5/rackmonkey-1.2.5-1.tar.gz
RUN (tar -xvf rackmonkey-1.2.5-1.tar.gz &&  mkdir -p /var/www/rackmonkey)
RUN (cp rackmonkey-1.2.5-1/perl/rackmonkey.pl /var/www/rackmonkey &&  cp -r rackmonkey-1.2.5-1/perl/RackMonkey /var/www/rackmonkey)
RUN (chmod 755 /var/www/rackmonkey/rackmonkey.pl &&  cp -r rackmonkey-1.2.5-1/www/* /var/www/rackmonkey)
RUN (mkdir -p mkdir /var/lib/rackmonkey &&  chown www-data:www-data /var/lib/rackmonkey)
RUN (cp -r rackmonkey-1.2.5-1/tmpl /var/lib/rackmonkey &&  mkdir -p /etc/apache2/conf.d && cp rackmonkey-1.2.5-1/conf/httpd-rackmonkey.conf /etc/apache2/conf.d/)
RUN (ln -s /etc/apache2/conf.d/httpd-rackmonkey.conf /etc/apache2/conf-enabled/httpd-rackmonkey.conf && cp rackmonkey-1.2.5-1/conf/rackmonkey.conf-default /etc/rackmonkey.conf)
RUN (sed -i 's/dbconnect =/dbconnect = dbi\:SQLite\:dbname=\/var\/lib\/rackmonkey\/rackmonkey.db/' /etc/rackmonkey.conf &&  sed  -i 's/tmplpath =/tmplpath = \/var\/lib\/rackmonkey\/tmpl/' /etc/rackmonkey.conf)
RUN (sed  -i 's/wwwpath =/wwwpath = \/rackmonkey/' /etc/rackmonkey.conf &&  sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/schema/schema.sqlite.sql)
RUN (sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/data/default_data.sql &&  sqlite3 /var/lib/rackmonkey/rackmonkey.db < rackmonkey-1.2.5-1/sql/data/sample_data.sql)
RUN (chown www-data:www-data /var/lib/rackmonkey/rackmonkey.db &&  cp rackmonkey-1.2.5-1/perl/rack2xls.pl /var/www/rackmonkey)
RUN (cp rackmonkey-1.2.5-1/perl/rackdns.pl /var/www/rackmonkey &&  chmod 755 /var/www/rackmonkey/rack2xls.pl)
RUN (chmod 755 /var/www/rackmonkey/rackdns.pl && a2enmod cgi && sed -i '14 i\ DirectoryIndex \/rackmonkey\/rackmonkey.pl' /etc/apache2/sites-available/000-default.conf)
RUN (sed -i 's/^\s*#\s*plugin_xls/plugin_xls/' /etc/rackmonkey.conf && sed -i 's/^\s*#\s*plugin_dns/plugin_dns/' /etc/rackmonkey.conf &&  mkdir -p /var/log/supervisor)
RUN (chown -R www-data:www-data /var/www/ &&  chmod 755 /start.sh && chmod 755 /etc/apache2/foreground.sh)
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80 22
VOLUME ["/var/log/supervisor"]
CMD ["/bin/bash", "/start.sh"]
