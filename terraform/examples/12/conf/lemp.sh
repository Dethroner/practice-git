#!/bin/bash
##################################################
# Install LEMP                                   #
# Author by Dethroner, 2020                      #
##################################################

##################################################
### Vars
VERP=5.0.2                    # Version phpmyadmin
BD="https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb"
DBROOTPASS=P@ssw0rd
DBNAME=hybrisDB
DBUSER=adb
DBPASS=123

##################################################
### mkdirs
sudo mkdir -p /var/www

##################################################
### PreInstall
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget unzip curl gnupg2 ca-certificates lsb-release

##################################################
### Download
cd /tmp
wget $BD

##################################################
### Install package
sudo apt install -y build-essential binutils \
			   libpcre3 libpcre3-dev libssl-dev zlib1g-dev libpcrecpp0v5 \
			   php7.4 php7.4-common php7.4-fpm php7.4-mysql php7.4-cgi php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-gd php7.4-imap php7.4-curl php7.4-zip php7.4-xml php7.4-bz2 php7.4-intl php7.4-gmp\
			   php-imagick php-phpseclib

sudo systemctl start php7.4-fpm
sudo systemctl enable php7.4-fpm

##################################################
### Install NGINX
echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt update && sudo apt install -y nginx
sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl start nginx


#sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
#sudo ufw allow http

##################################################
### Info about php
cat <<EOF | sudo tee /var/www/index.php
<?php
echo '
<div class="center">
 <table>
  <td width="934px" hieght="73px" bgcolor="#99F">
   <a href="http://$(exec wget http://ipinfo.io/ip -qO -)/phpmyadmin">
    <h1 style="font-family: sans-serif; color: #222; line-height: 64px";>Go to phpMyAdmin Version 5.0.2
    <img src="phpmyadmin/themes/original/img/logo_right.png" height="64px"></h1>
   </a>
  </td>
 </table>
</div>
';
phpinfo();
?>
EOF

##################################################
#### Include nginx snippets
sudo sh -c "sed -i "2s/nginx/www-data/" /etc/nginx/nginx.conf"
sudo mv /tmp/default.conf /etc/nginx/conf.d/
sudo chown -R www-data:www-data /var/www
sudo service nginx reload

##################################################
### Install MySQL
sudo DEBIAN_FRONTEND=noninteractive apt install -y ./mysql-apt-config*.deb
sudo apt update
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $DBROOTPASS"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $DBROOTPASS"
sudo debconf-set-selections <<< "mysql-community-server mysql-server/default-auth-override select Use Strong Passwoord Encryption (RECOMMENDED)"
sudo DEBIAN_FRONTEND=noninteractive apt -y install mysql-server
sudo sh -c "echo "bind-address    = 0.0.0.0" >> /etc/mysql/mysql.conf.d/mysqld.cnf"
sudo service mysqld start
sudo service mysqld status

##################################################
### Install phpmyadmin
cd /tmp
wget https://files.phpmyadmin.net/phpMyAdmin/$VERP/phpMyAdmin-$VERP-all-languages.zip
sudo unzip phpMyAdmin-$VERP-all-languages.zip
sudo mv phpMyAdmin-$VERP-all-languages /var/www/phpmyadmin
sudo chown -R www-data:www-data /var/www/phpmyadmin
sudo rm -r /var/www/phpmyadmin/setup
sudo cp -a /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.inc.php
sudo sh -c "sed -i "18s/= '';/= '12345678900987654321123456789009';/" /var/www/phpmyadmin/config.inc.php" # random number of 32 bits
sudo mysql -uroot -p$DBROOTPASS -e "CREATE DATABASE phpmyadmin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
sudo mysql -uroot -p$DBROOTPASS phpmyadmin < /var/www/phpmyadmin/sql/create_tables.sql

##################################################
### Tuning MySQL
#### Create DBUSER
sudo  -uroot -p$DBROOTPASS -e "CREATE USER '$DBUSER'@'%' IDENTIFIED BY '$DBPASS'"
#### Allow password's access
sudo mysql -uroot -p$DBROOTPASS -e "ALTER USER '$DBUSER'@'%' IDENTIFIED WITH mysql_native_password BY '$DBPASS';"
sudo mysql -uroot -p$DBROOTPASS -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$DBROOTPASS';"
#### Create DBNAME & select privilege for DBUSER
sudo mysql -uroot -p$DBROOTPASS -e "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_bin"
sudo mysql -uroot -p$DBROOTPASS -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' WITH GRANT OPTION"
sudo mysql -uroot -p$DBROOTPASS -e "FLUSH PRIVILEGES"
sudo mysql -uroot -p$DBROOTPASS -e 'SHOW DATABASES;'
