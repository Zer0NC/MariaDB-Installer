# MariaDB Installation Script for Ubuntu 24.04.1 LTS

This script automates the installation and basic security configuration of MariaDB on Ubuntu 24.04.1 LTS.

## Features
- Installs MariaDB server and necessary dependencies
- Configures MariaDB with a secure root password
- Enables and starts the MariaDB service
- Runs `mysql_secure_installation` automatically using `expect`
- Displays the installed MariaDB version

## Prerequisites
- A fresh Ubuntu 24.04.1 LTS installation
- Sudo privileges

## Installation

1. Clone this repository or download the script:
   ```sh
   git clone https://github.com/Zer0NC/MariaDB
   ```

2. Make the script executable:
   ```sh
   chmod +x mariadb.sh
   ```

3. Run the script:
   ```sh
   sudo ./install_mariadb.sh
   ```

## Script Content
```bash
#!/bin/bash

# Define the root password for MariaDB
ROOT_PASSWORD="YourPassword"

# Update package lists and upgrade existing packages
sudo apt update && sudo apt upgrade -y

# Install MariaDB server and expect (to automate mysql_secure_installation)
sudo apt install -y mariadb-server expect

# Start and enable MariaDB service to run at boot
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Automate secure MariaDB setup using expect
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

# Output the secure installation process result
echo "$SECURE_MYSQL"

# Display installed MariaDB version
echo "Installation completed. MariaDB version:"
mariadb --version
```

## Notes
- Change the `ROOT_PASSWORD` variable before running the script.
- Ensure that `expect` is installed; the script will automatically install it if missing.

## License
This script is provided under the MIT License. Feel free to modify and distribute it as needed.

