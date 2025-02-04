#!/bin/bash

ROOT_PASSWORD="YourPassword"

sudo apt update && sudo apt upgrade -y
sudo apt install -y mariadb-server expect

sudo systemctl start mariadb
sudo systemctl enable mariadb

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn sudo mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"\r\"

expect \"Set root password?\"
send \"y\r\"

expect \"New password: \"
send \"$ROOT_PASSWORD\r\"

expect \"Re-enter new password: \"
send \"$ROOT_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo "$SECURE_MYSQL"

# MariaDB-Version anzeigen
echo "Installation completed. MariaDB-Version:"
mariadb --version
