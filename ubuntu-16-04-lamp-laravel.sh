#!/bin/bash

# How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu 16.04
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04

# PHP My Admin Secure
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-16-04

# How to install PHPMyAdmin
# https://help.ubuntu.com/lts/serverguide/phpmyadmin.html

# =================================================
# At many places it will ask for your inputs for using disk space
# or for configurations
# =================================================

# Update
sudo apt-get update

# Install cURL & ZIP/UNZIP
sudo apt-get install -y curl
sudo apt-get install -y zip unzip

# Install Apache
sudo apt-get install -y apache2
# Y to allow to use disk space
echo "Apache Installed Successfully!"

# Check Firewall Configurations
echo "Your firewall configuration is."
sudo ufw app list
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443

echo "You can check whether the apache is installed properly by accessing public URL/server IP address."
# If you can see the page then Apache installation is successful.

# To Remove Existing MySQL Server
#sudo apt-get remove --purge mysql-server mysql-client mysql-common
#sudo apt-get remove --purge mysql-*
#sudo apt-get autoremove
#sudo apt-get autoclean
# Other Important Commands
# sudo dpkg --configure mysql-server-5.5


# Install MySQL Server
sudo apt-get install -y mysql-server
# Y to allow to use disk space
# Enter password for MySQL Root User, Please remeber the password. (Sample ROOT Password: T1umoN23X8W9tPAlQS9)

sudo mysql_secure_installation
# This asks you if you want to enable secured password for your server.
# Press y|Y, if you want to allow VALIDATE PASSWORD PLUGIN to be used.
# If you select Yes, then it will ask you for password strength
# And to reset password if required (Sample Secure Password : Haksfuh@sfeGa23VhP3)

echo "MySQL Server Installed Successfully!"

# Install PHP7.1
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo service apache2 stop
sudo apt-get install -y php7.2 php7.2-common
#Install PHP Extension
sudo apt-get install -y php7.2-curl php7.2-xml php7.2-zip php7.2-gd php7.2-mysql php7.2-mbstring php7.2-bcmath

# Y to allow to use disk space

# Inform Apache to prefer php files over html files
# sudo nano /etc/apache2/mods-enabled/dir.conf
# Move the index.php at first place

# Install PHP Required Extensions
# sudo apt-get install -y php-cli php-mbstring php-gettext php-curl
# sudo phpenmod mcrypt
# sudo phpenmod mbstring
# sudo phpenmod curl
echo "php-cli, curl, mcrypt, mbstring Installed Successfully!"

sudo a2enmod rewrite
sudo a2enmod ssl



# Restart Apache Server
sudo systemctl restart apache2
# To See Apache Status
# sudo systemctl status apache2

echo "Your Home Directory is /var/www/html/. You can start using that Home Directory."

# PHPMyAdmin & Other Extensions
echo "Installing PHPMyAdmin for DB Access & Other Extensions."
sudo apt-get install -y phpmyadmin

# For the server selection, choose apache2.
# Select yes when asked whether to use dbconfig-common to set up the database
# You will be prompted for your database administrator's password
# You will then be asked to choose and confirm a password for the phpMyAdmin application itself


# Config PHPMyAdmin
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf
sudo systemctl reload apache2.service

# =================================================
# Installing Laravel Specific and other required things
	# such as Git, Composer, Redis for easy PHP Development
# =================================================

# Install GIT
sudo apt-get install -y git
echo "Git Installed Successfully!"
git config --global user.name "Your Git's Name "
git config --global user.email "Your Email"

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo "Composer Installed Successfully!"

# Change owner of disk
sudo chown -R root:root /var/www/
#Change permission
sudo chmod -R 777 /var/www/
#Restart apache
sudo systemctl restart apache2

