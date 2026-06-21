#!/bin/bash


growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol 
xfs_growfs /home

#install terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# creating databases
cd /home/ec2-user
git clone https://github.com/krishna-33s/roboshop-dev-infra.git
chown ec2-user:ec2-user -R roboshop-dev-infra
cd roboshop-infra-dev/40-database-instances
terraform init
terraform apply -auto-approve

# creating components
cd /home/ec2-user
git clone https://github.com/krishna-33s/roboshop-dev-infra.git
chown ec2-user:ec2-user -R roboshop-dev-infra
cd roboshop-infra-dev/90-components
terraform init
terraform apply -auto-approve