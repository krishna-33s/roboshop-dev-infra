#!/bin/bash

module=$1
env=$2
app_version=$3
dnf install ansible -y
cd /home/ec2-user
rm -rf ansible-roles-terraform
git clone https://github.com/krishna-33s/ansible-roles-terraform.git

cd ansible-roles-terraform
ansible-playbook -e module=$module -e env=$env -e app_version=$app_version roboshop.yml
