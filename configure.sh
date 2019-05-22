#!/bin/bash
instance="instance ansible_host=$(grep -w 'public_ip' terraform.tfstate | sed 's/"//g' | awk '{print $2}' | sed 's/,//g')"
echo $instance > inventory.ini

rds_host="login_host: $(grep rds terraform.tfstate | grep address | sed 's/"//g' | awk '{print $2}' | sed 's/,//g')" 
echo $rds_host > group_vars/all.yml

rds_user="login_user: $(grep username -A 2 variables.tf | grep default | sed 's/"//g' | awk '{print $3}')"
echo $rds_user >> group_vars/all.yml

rds_password="login_password: $(grep password -A 2 variables.tf | grep default | sed 's/"//g' | awk '{print $3}')"
echo $rds_password >> group_vars/all.yml

rds_db="db_name: $(grep db_name -A 2 variables.tf | grep default | sed 's/"//g' | awk '{print $3}')"
echo $rds_db >> group_vars/all.yml

ip_instance=$(grep -w 'public_ip' terraform.tfstate | sed 's/"//g' | awk '{print $2}' | sed 's/,//g')
database_host=$(grep rds terraform.tfstate | grep address | sed 's/"//g' | awk '{print $2}' | sed 's/,//g')

ansible-playbook main.yml --diff --user ubuntu -i inventory.ini &&
echo "aws_instance IP is $ip_instance . For connect to it, use - ssh -i path/to/key/id_rsa ubuntu@$ip_instance . Check http://$ip_instance , its apache docker inside instance. Index.php shows if connection to postgress is successful . Database host is $database_host , which accessible only in internal AWS network . Enjoy!"
