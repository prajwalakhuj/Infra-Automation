
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
sudo npm install npm@latest -g
sudo npm install pm2@latest -g
sudo npm install --save dotenv
