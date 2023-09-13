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

Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Start Tomcat service
sudo systemctl start tomcat

# Enable Tomcat service to start on boot
sudo systemctl enable tomcat

# Firewall rules (allow Tomcat ports)
sudo ufw allow 8080/tcp
sudo ufw reload

# Cleanup
rm /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz



#installing maven

sudo apt install maven

mvn --version

cd /home/ubuntu

git clone https://github.com/shashirajraja/Train-Ticket-Reservation-System.git

git clone https://github.com/shashirajraja/onlinebookstore.git

cd /home/ubuntu/onlinebookstore

mvn clean install package

cd /home/ubuntu/onlinebookstore/target

sudo mv onlinebookstore.war /opt/tomcat/webapps/
sudo mv onlinebookstore /opt/tomcat/webapps/
