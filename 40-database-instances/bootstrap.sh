#!/bin/bash

module=$1
dnf install ansible -y
cd /home/ec2-user
rm -rf ansible-roles-terraform
git clone https://github.com/krishna-33s/ansible-roles-terraform.git

cd ansible-roles-terraform
ansible-playbook -e module=$module roboshop.yml