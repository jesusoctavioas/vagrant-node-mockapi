#!/bin/bash

#Heavily inspired by clivewalkden/centos-7-package.sh
# ( https://gist.github.com/clivewalkden/b4df0074fc3a84f5bc0a39dc4b344c57 )
#However, this one was tested... 2017-JAN-09

vagrant init centos/7
vagrant up
vagrant ssh -c "sudo yum -y update"
vagrant ssh -c "sudo yum -y install wget nano kernel-devel gcc"
vagrant ssh -c "sudo cd /opt && sudo wget http://download.virtualbox.org/virtualbox/5.1.12/VBoxGuestAdditions_5.1.12.iso -O /opt/VBGAdd.iso"
vagrant ssh -c "sudo mount /opt/VBGAdd.iso -o loop /mnt"
vagrant ssh -c "sudo sh /mnt/VBoxLinuxAdditions.run --nox11"
vagrant ssh -c "sudo umount /mnt"
vagrant ssh -c "sudo rm /opt/VBGAdd.iso"
vagrant ssh -c "firewall-cmd --permanent --zone=public --add-port=3000/tcp #firewall-cmd --reload"
vagrant ssh -c "curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -"
vagrant ssh -c "sudo yum install nodejs -y"
vagrant ssh -c "sudo yum install git -y"
vagrant ssh -c "sudo npm --version"
vagrant ssh -c "sudo git clone https://github.com/jesusoctavioas/mockapi.git"
vagrant ssh -c "cd /mockapi"
vagrant ssh -c "sudo npm install -g json-server" 
#vagrant ssh -c "sudo json-server --watch db.json" 
#vagrant ssh -c "sudo json-server --host 127.0.0.1 db.json"


#Check that we can halt and boot
vagrant halt
vagrant up

#Halt again and package
vagrant halt
vagrant package

#And finally, clean up 
mv package.box centos7node-mockapi.box
rm Vagrantfile