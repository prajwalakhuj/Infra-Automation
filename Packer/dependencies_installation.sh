
#################################################################################################################################
# Unified Cloudwatch Agent Installation and nginx installation
#################################################################################################################################

#!/bin/bash
sleep 30
sudo apt update
sudo apt install nginx -y
sudo wget https://s3.us-east-2.amazonaws.com/amazoncloudwatch-agent-us-east-2/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
#sudo aws configure --profile AmazonCloudWatchAgent
#sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:configuration-file-path

#################################################################################################################################
# Code deploy agent installation
#################################################################################################################################

#!/bin/bash
sudo apt update
sudo apt install ruby-full -y
sudo apt install wget
cd $HOME
# wget https://bucket-name.s3.region-identifier.amazonaws.com/latest/install
# above is a sample set of your url. You can create a url as per your region.
# Reference : https://docs.aws.amazon.com/codedeploy/latest/userguide/resource-kit.html#resource-kit-bucket-names
# Find & replace region values from above reference link & ready your own link.
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
# To verify installation execute below command
# sudo service codedeploy-agent status

#################################################################################################################################
# Packer installation
#################################################################################################################################
cat <<EOF > packer_install.sh
#!/bin/bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer
EOF
# Verifying the Installation
# packer

#################################################################################################################################
# Ansible installation
#################################################################################################################################
cat <<EOF > ansible_install.sh
#!/bin/bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
EOF

#################################################################################################################################
# Nodejs Installation
#################################################################################################################################
cat <<EOF > nodejs_install.sh
#!/bin/bash
cd ~
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
cat /etc/apt/sources.list.d/nodesource.list
sudo apt -y install nodejs
node -v
EOF

#################################################################################################################################
# MongoDB Installation
#################################################################################################################################
cat <<EOF > mongodb_install.sh
#!/bin/bash
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
apt-key list
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update 
sudo apt install mongodb-org -y
EOF


#################################################################################################################################
# Docker Installation
#################################################################################################################################
cat <<EOF > docker_install.sh
sudo apt-get remove docker docker.io -y
sudo apt-get remoce docker-engine
sudo apt-get update -y
sudo apt install docker.io -y
sudo snap install docker
EOF

#################################################################################################################################
# Post Docker Installation
#################################################################################################################################
cat <<EOF > postdocker_install.sh
sudo systemctl stop docker.service
sudo systemctl disable docker.service
sudo systemctl enable docker.service
sudo systemctl start docker.service
# sudo docker run hello-world # to list demo images & container 
# sudo docker images
# sudo docker ps -a # sudo docker ps
EOF

#################################################################################################################################
# AWS cli Installation
#################################################################################################################################
cat <<EOF > awscli_install.sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install zip -y
unzip awscliv2.zip
sudo ./aws/install
# aws --version
EOF

#################################################################################################################################
# Docker Compose Installation
#################################################################################################################################
cat <<EOF > dockercompose_install.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# docker-compose --version
EOF

#################################################################################################################################
# Install Node Js
#################################################################################################################################
sudo apt update
cd ~
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
cat /etc/apt/sources.list.d/nodesource.list
sudo apt install nodejs -y
# node -v
sudo apt install npm -y

#################################################################################################################################
# Install Angular
#################################################################################################################################
sudo apt install ng-common
