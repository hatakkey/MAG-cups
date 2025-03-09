#!/bin/bash

## Create Bridges
brctl addbr br-dsf1
brctl addbr br-dsf2
brctl addbr br-gtpu
brctl addbr br-ngap
brctl addbr br-sbi
brctl addbr br-enb
brctl addbr br-metric

## Enable the Bridges
ip link set br-dsf1 up
ip link set br-dsf2 up
ip link set br-gtpu up
ip link set br-ngap up
ip link set br-sbi  up
ip link set  br-enb up
ip link set  br-metric up

## Run the following command to install iptables-persistent, which will create the necessary directories and files for saving iptables rules
## During the installation, you will be prompted to save your current iptables rules. Select "Yes" to save them.
#sudo apt-get install iptables-persistent

##allow communiction for the clab
sudo iptables -I DOCKER-USER -i br-dsf1 -j ACCEPT
sudo iptables -I DOCKER-USER -i br-dsf2 -j ACCEPT
sudo iptables -I DOCKER-USER -i br-gtpu -j ACCEPT
sudo iptables -I DOCKER-USER -i br-ngap -j ACCEPT
sudo iptables -I DOCKER-USER -i br-sbi -j ACCEPT
sudo iptables -I DOCKER-USER -i br-enb -j ACCEPT
sudo iptables -I DOCKER-USER -i br-metric -j ACCEPT

## Save the iptables rules
sudo iptables-save | sudo tee /etc/iptables/rules.v4

