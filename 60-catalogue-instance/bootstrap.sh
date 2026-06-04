# #!/bin/bash

# module=$1
# env=$2
# dnf install ansible -y
# cd /home/ec2-user
# rm -rf ansible-roles-terraform
# git clone https://github.com/krishna-33s/ansible-roles-terraform.git

# cd ansible-roles-terraform
# ansible-playbook -e module=$module -e env=$env roboshop.yml

#!/bin/bash

module=$1
env=$2
dnf install ansible -y

cd /home/ec2-user
git clone https://github.com/daws-88s/ansible-roles-terraform.git

cd ansible-roles-terraform
git pull
ansible-playbook -e module=$module -e env=$env  roboshop.yaml