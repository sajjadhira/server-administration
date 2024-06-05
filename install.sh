#!/bin/bash

# Update package index
sudo apt update

# Install wget, zip, and unzip
sudo apt install -y wget zip unzip

# Install Apache web server
sudo apt install -y apache2

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Install MySQL server
sudo apt install -y mysql-server

# Prompt for MySQL root password
read -sp 'Enter MySQL root password: ' MYSQL_PASSWORD
echo

# Install PHP and necessary modules
sudo apt install -y php libapache2-mod-php php-mysql php-imap

# Configure Apache directory index
sudo bash -c "echo -e '<IfModule mod_dir.c>\n    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>' > /etc/apache2/mods-enabled/dir.conf"

# Install phpMyAdmin
sudo apt install -y phpmyadmin

# Configure Apache to include phpMyAdmin configuration
sudo bash -c "echo -e 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/conf-available/phpmyadmin.conf"
sudo ln -s /etc/apache2/conf-available/phpmyadmin.conf /etc/apache2/conf-enabled/

# Restart Apache
sudo systemctl restart apache2

# Set MySQL root password
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_PASSWORD'"

# Install and configure UFW
sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 25/tcp
sudo ufw allow 80/tcp
sudo ufw allow 143/tcp
sudo ufw allow 465/tcp
sudo ufw allow 993/tcp
sudo ufw enable

# Set permissions for web directory
sudo chmod -R a+rw /var/www/html/

# Reboot the system
sudo reboot
