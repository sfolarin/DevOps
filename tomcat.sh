#!/bin/bash
# Update package list and install necessary packages
sudo apt update
sudo apt install openjdk-11-jdk git maven wget rsync ufw -y

# Set the Tomcat URL
TOMURL="https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz"

# Download and extract Tomcat
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz
EXTOUT=$(tar xzvf tomcatbin.tar.gz)
TOMDIR=$(echo $EXTOUT | cut -d '/' -f1)

# Create a tomcat user
sudo useradd --shell /sbin/nologin tomcat

# Copy Tomcat files to the installation directory
sudo rsync -avzh /tmp/$TOMDIR/ /usr/local/tomcat/
sudo chown -R tomcat:tomcat /usr/local/tomcat

# Create the systemd service file for Tomcat
sudo rm -rf /etc/systemd/system/tomcat.service

cat <<EOT | sudo tee /etc/systemd/system/tomcat.service > /dev/null
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat
WorkingDirectory=/usr/local/tomcat

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_PID=/var/tomcat/%i/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat

ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd, start and enable Tomcat service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

# Clone the vprofile project and build it using Maven
git clone https://github.com/sfolarin/testrepo.git
cd testrepo
mvn install

# Deploy the WAR file to Tomcat
sudo systemctl stop tomcat
sleep 60
sudo rm -rf /usr/local/tomcat/webapps/ROOT*
sudo cp target/RegistrationApp-1.3.war /usr/local/tomcat/webapps/ROOT.war
sudo systemctl start tomcat

# Configure firewall
# Enable and configure the firewall
sudo ufw enable
sudo ufw allow 8080/tcp
sudo ufw reload
sudo systemctl restart tomcat

