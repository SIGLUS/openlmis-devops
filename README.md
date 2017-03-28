#Ansible Scripts for Open LMIS

This provision project is build for https://github.com/OpenLMIS/open-lmis/tree/2.0-moz project.

##System requirements
* JDK 7
* Postgresql 9
* Git
* Gradle
* Nodejs
* Grunt CLI
* Karma

Instead of installing these requirements one by one. Ansible can help us do the annoying jobs for us. Here are some instructions.

### Requirements for your local machine

#### Install latest Ansible
Before you use Ansible for provision. You should install Ansible in your local environment.

Assuming your local machine is MacOS, install the latest releases via pip:

```
$ sudo easy_install pip
$ sudo pip install ansible
```

Want to install in Ubuntu etc.? Read [Official instruction](http://docs.ansible.com/intro_installation.html)

#### Install SSHPASS

Ansible will use ssh to login your virtual machine. SSHPASS should be installed in advance.

Read [SSHPASS install instruction] (https://gist.github.com/arunoda/7790979)

## Provision CI server
run `ansible-playbook --extra-vars '{"DBPASSWORD":"[specify_a_db_password]", "MAILPASSWORD":"[specify_your_mail_server_password]"}' -i provisioning/hosts provisioning/aws-ci-playbook.yml`

Make sure your local ssh config is set up to use the CI host and user.

## Provision QA server
run `ansible-playbook --extra-vars '{"DBPASSWORD":"[specify_a_db_password]", "MAILPASSWORD":"[specify_your_mail_server_password]"}' -i provisioning/hosts provisioning/aws-qa-playbook.yml`

Make sure your local ssh config is set up to use the QA host and user.

## Deploy to QA
run `ansible-playbook --extra-vars '{"BUILD_NO":"xx", "DBPASSWORD":"[your_db_password]"}' -i provisioning/hosts deployment/deploy-to-qa-playbook.yml`

#### Install via ansible-galaxy

Browse all the ansible roles in [Galaxy Ansible](https://galaxy.ansible.com/list#/roles).

Please find [install_via_galaxy_role.md](https://github.com/gongmingqm10/OpenLMIS-TechOps/blob/master/install_via_galaxy_roles.md)

### Issues you may occurred
When your vagrant machine is running. Ansible will connect to your vagrant file for provision. If you get the error `Host key verification failed` during `vagrant up` or `vagrant provision`, please run the comand `ssh-keygen -R hostname`, the hostname is the address for your virtual machine, like `192.168.33.10`.
