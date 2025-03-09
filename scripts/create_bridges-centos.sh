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
#allow communiction for the clab
firewall-cmd --permanent --zone=docker --add-interface=br-dsf1
firewall-cmd --permanent --zone=docker --add-interface=br-dsf2
firewall-cmd --permanent --zone=docker --add-interface=br-gtpu
firewall-cmd --permanent --zone=docker --add-interface=br-ngap
firewall-cmd --permanent --zone=docker --add-interface=br-sbi
firewall-cmd --permanent --zone=docker --add-interface=br-enb
firewall-cmd --permanent --zone=docker --add-interface=br-metric

#reload the firewalld

firewall-cmd --reload



#then you need to enable that command to allow everything
#iptables -I FORWARD -i eno1 -o virbr0 -j ACCEPT
#iptables -D FORWARD -i eno1 -o virbr0 -j ACCEPT ; iptables -I FORWARD -i eno1 -o virbr0 -j ACCEPT

