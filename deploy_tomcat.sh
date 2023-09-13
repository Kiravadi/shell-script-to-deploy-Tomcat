#!/bin/bash

# Update the package list
sudo apt update

# Install Java (OpenJDK)
sudo apt install default-jdk

# Create a Tomcat user
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Download and extract Tomcat 9




TOMCAT_VERSION="9.0.80" # Update to the latest version if needed
TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"

wget "$TOMCAT_URL" -P /tmp


sudo tar -xzvf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt


cd /opt
ls
echo "Current path is $PWD"

sudo mv apache-tomcat-${TOMCAT_VERSION} tomcat

# Adjust Tomcat permissions
sudo chown -R tomcat:tomcat /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'
# Configure Tomcat to run as a systemd service
cat <<EOF | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

"deploy2.sh" 80L, 1882B                                                                35,42         Top
#!/bin/bash

# Update the package list
sudo apt update

# Install Java (OpenJDK)
sudo apt install default-jdk

# Create a Tomcat user
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Download and extract Tomcat 9




TOMCAT_VERSION="9.0.80" # Update to the latest version if needed
TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"

wget "$TOMCAT_URL" -P /tmp


sudo tar -xzvf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt


cd /opt
ls
echo "Current path is $PWD"

sudo mv apache-tomcat-${TOMCAT_VERSION} tomcat

# Adjust Tomcat permissions
sudo chown -R tomcat:tomcat /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'
# Configure Tomcat to run as a systemd service
cat <<EOF | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

"deploy2.sh" 80L, 1882B                                                                1,11          Top
