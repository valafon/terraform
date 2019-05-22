# Description
Creating AWS hosts and deploying software divided on two parts - terraform and using ansible-playbook. It's testeted on eu-central-1 AWS region.

# Software
I have tested it on ubuntu 16.04, with ansible version 2.8 (you may need to install most fresh repositories to get this version). 
Pip version 19.1.1
All pip modules I have used declared in requirements.txt
Python version 2.7.12
Terraform version v0.11.14

# How to use

1. First of all clone git repository https://github.com/valafon/terraform.git to one of your directories, than move inside it. All config files wrote with relative paths, so every actions should be made inside cloned directory of git repository.

2. Fill variables in file variables.tf . Most importat is to fill access_key and secret_key, of iam user inside AWS console (it is tested on eu-central-1), who have rights to create instances, vpc, keys and other stuff. Easier to check it with full admin rights. Optionally you can define db_instance variables such as db_name, username and password. Further they would be used to test connectivity from docker container inside main aws instance to connect postgresql via php_psql module. 

3. Launch "terraform init". Wait when it will be executed. Then launch "terraform plan" to check, if it starts without errors. If everything is fine, launch "terraform apply". When terraform asking to type "yes", type it. Wait, until everything would be created. You would understand, that it's created with output of IP address of instance and db_instance hostname. During terraform launch you need to provide name for your key and path to your public key (usually it's $HOME/.ssh/id_rsa.pub. If you don't have it, you may use ssh-keygen command). After installing AWS instance you would be able to connect straight to it using your private key which is pair of that public key.

4. When you see instances are created, you are ready to launch ansible to configure services. Do chmod +x on configure.sh file, than launch it inside directory with command ./configure.sh . It will fill some variables for ansible and start playbook to confgire. After completing, you will see message about IP address, DB instance and other stuff. Than it's done.

5. I've created user app with password app to test postgres rights. You may install postgresql-client in instance or inside docker and check rights for this user.

6. Sometimes AWS may hang with dpkg lock, ansible wouldn't able to run playbook. I've seen it once. Workaround was to destroy everything, use "terraform destroy", than start again to create instances and launch playbook.

7. When you are done, don't forget to use "terraform destroy" so it wouldn't consume your money on AWS.

P.s. Dockerfile inside repository was used to create this docker container
