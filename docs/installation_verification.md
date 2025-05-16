## 1. **Pre-requirements for CLAB Setup**
------
### 1.1 **SELinux Configuration**

Before starting the setup, **SELinux** should be disabled on your server for this CLAB to function properly. Check the current status of SELinux:

```bash
[root@compute-1 ~]# sestatus
SELinux status:      disabled
```
If status is different then  disabled, change it to disabled in /etc/selinux/config and reboot your server
```bash
[root@compute-1 ~]# more /etc/selinux/config
SELINUX=disabled
SELINUXTYPE=targeted
```

### 1.2 **Firewalld configuration** 
The firewall should be enabled, If the firewall is not enabled or inactive, start the firewalld service:
```bash
[root@compute-1 MAG-cups]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2025-03-09 11:09:29 EDT; 2 days ago
     Docs: man:firewalld(1)
 Main PID: 2015 (firewalld)
    Tasks: 2 (limit: 1646254)
   Memory: 45.7M
   CGroup: /system.slice/firewalld.service
           └─2015 /usr/libexec/platform-python -s /usr/sbin/firewalld --nofork --nopid
 ```   


### 1.3 **Create the needed bridges**

Create the brideges.

```bash   
root@compute-1 scripts]# ./create_bridges.sh
Detected OS: centos
success
success
success
success
success
success														
```
### 1.4 **Install lftp**
lftp needs to be installed to run the `upload-cliscripts.sh` script.
CentOS example:

```bash
yum install lftp
```
---------------------------------------------------  
## 2. **SCTP is supported on host machine**

- Check if SCTP is supported on your host machine as the communication between AMF and gNB is via SCTP over the NGAP interface. and needs to be enabled on your host machine. 
- If you don’t have SCTP enabled, then a 5G session will fail with error and you need to install SCTP.
In AMF.log:
```bash
[sock] ERROR: ogs_sock_socket(family:2 type:1) failed (93:Protocol not supported) (../lib/sctp/ogs-lksctp.c:42)
[sock] ERROR: sctp_server() [10.50.1.2]:38412 failed (93:Protocol not supported) (../lib/sctp/ogs-lksctp.c:112)
[sctp] ERROR: Failed to initialize AMF (../src/amf/app.c:30)
[app] FATAL: Open5GS initialization failed. Aborted (../src/main.c:219
```
- If command checksctp ---> "STCP supported" then skip (2) install SCTP (ubuntu ---> supported by default).
- If command checksctp ---> "not found" then install the needed package "lksctp-tools"

```bash
[root@compute-2 ~]# checksctp
bash: checksctp: command not found...
Install package 'lksctp-tools' to provide command 'checksctp'? [N/y] y
```

```bash
[root@compute-1 MAG-cups]# checksctp
SCTP supported
```
- install sctp as below if not enabled.
```bash
[root@compute-1]# dnf install kernel-modules-extra
[root@compute-1]# rm /etc/modprobe.d/sctp-blacklist.conf
[root@compute-1]# rm /etc/modprobe.d/sctp_diag-blacklist.conf
[root@compute-1]# dnf install lksctp-tools-1.0.18-3.el8.x86_64
```
---------------------------------------------------  
## 3. **Deploy the ContainerLab Environment**

Deploy the containerized network environment using the ContainerLab configuration:

```bash
[root@compute-1 MAG-cups]# export CLAB_SKIP_SROS_SSH_KEY_CONFIG=true  
[root@compute-1 MAG-cups]# clab dep -t cups.clab.yml
15:35:44 INFO Containerlab started version=0.67.0
15:35:44 INFO Parsing & checking topology file=cups.clab.yml
15:35:44 INFO Creating docker network name=cups IPv4 subnet=192.168.40.0/24 IPv6 subnet="" MTU=0
15:35:44 INFO Creating lab directory path=/root/mag-cups/clab-cups
15:35:44 INFO Creating container name=dbctl
15:35:44 INFO Creating container name=mongo
15:35:44 INFO Creating container name=bngblaster
15:35:44 INFO Using existing config file (/root/mag-cups/clab-cups/UP1/tftpboot/config.txt) instead of applying a new one
15:35:44 INFO Creating container name=udr
15:35:44 INFO Using existing config file (/root/mag-cups/clab-cups/CP1/tftpboot/config.txt) instead of applying a new one
15:35:44 INFO Creating container name=amf
15:35:44 INFO Creating container name=UP1
15:35:44 INFO Using existing config file (/root/mag-cups/clab-cups/CP2/tftpboot/config.txt) instead of applying a new one
15:35:44 INFO Creating container name=nssf
15:35:44 INFO Creating container name=udm
15:35:44 INFO Creating container name=ue1
15:35:44 INFO Creating container name=db-2
15:35:44 INFO Creating container name=pcf
15:35:44 INFO Creating container name=ausf
15:35:44 INFO Creating container name=bsf
15:35:44 INFO Using existing config file (/root/mag-cups/clab-cups/TRA-cups/tftpboot/config.txt) instead of applying a new one
15:35:44 INFO Creating container name=nrf
15:35:44 INFO Creating container name=gnb
15:35:44 INFO Using existing config file (/root/mag-cups/clab-cups/UP2/tftpboot/config.txt) instead of applying a new one
15:35:44 INFO Creating container name=radius
15:35:44 INFO Creating container name=db-1
15:35:44 INFO Creating container name=CP1
15:35:44 INFO Creating container name=CP2
15:35:44 INFO Creating container name=TRA-cups
15:35:44 INFO Creating container name=UP2
15:35:45 INFO Creating container name=webui
15:35:46 INFO Created link: gnb:eth3 ▪┄┄▪ ue1:eth1
15:35:47 INFO Created link: UP1:eth1 ▪┄┄▪ TRA-cups:eth7
15:35:47 INFO Created link: UP2:eth1 ▪┄┄▪ TRA-cups:eth8
15:35:47 INFO Created link: TRA-cups:eth9 ▪┄┄▪ UP1:eth2
15:35:47 INFO Created link: TRA-cups:eth10 ▪┄┄▪ UP2:eth2
15:35:47 INFO Created link: CP1:eth1 ▪┄┄▪ br-dsf1:magc1eth1
15:35:47 INFO Created link: CP2:eth2 ▪┄┄▪ TRA-cups:eth6
15:35:47 INFO Created link: CP2:eth1 ▪┄┄▪ br-dsf2:magc2eth1
15:35:47 INFO Created link: br-metric:eth17 ▪┄┄▪ pcf:eth2
15:35:47 INFO Created link: br-sbi:eth23 ▪┄┄▪ TRA-cups:eth4
15:35:47 INFO Created link: br-ngap:eth20 ▪┄┄▪ amf:eth2
15:35:47 INFO Created link: br-gtpu-cups:eth3 ▪┄┄▪ TRA-cups:eth1
15:35:47 INFO Created link: CP1:eth2 ▪┄┄▪ TRA-cups:eth5
15:35:47 INFO Created link: TRA-cups:eth11 ▪┄┄▪ bngblaster:eth1
15:35:47 INFO Created link: br-gtpu-cups:eth4 ▪┄┄▪ gnb:eth2
15:35:48 INFO Created link: CP2:eth5 ▪┄┄▪ br-dsf2:magc2eth2
15:35:48 INFO Created link: br-metric:eth18 ▪┄┄▪ amf:eth3
15:35:48 INFO Created link: CP1:eth5 ▪┄┄▪ br-dsf1:magc1eth2
15:35:48 INFO Created link: br-sbi:eth24 ▪┄┄▪ amf:eth1
15:35:48 INFO Created link: TRA-cups:eth12 ▪┄┄▪ bngblaster:eth2
15:35:48 INFO Created link: br-ngap:eth21 ▪┄┄▪ gnb:eth1
15:35:48 INFO Created link: br-metric:eth19 ▪┄┄▪ TRA-cups:eth2
15:35:48 INFO Created link: br-sbi:eth25 ▪┄┄▪ nrf:eth1
15:35:48 INFO Created link: CP1:eth4 ▪┄┄▪ TRA-cups:eth13
15:35:48 INFO Created link: CP2:eth6 ▪┄┄▪ br-dsf2:magc2eth3
15:35:48 INFO Created link: CP1:eth6 ▪┄┄▪ br-dsf1:magc1eth3
15:35:48 INFO Created link: br-ngap:eth22 ▪┄┄▪ TRA-cups:eth3
15:35:48 INFO Created link: br-sbi:eth26 ▪┄┄▪ ausf:eth1
15:35:48 INFO Created link: CP2:eth4 ▪┄┄▪ TRA-cups:eth14
15:35:48 INFO Created link: CP1:eth3 ▪┄┄▪ TRA-cups:eth15
15:35:48 INFO Created link: br-sbi:eth27 ▪┄┄▪ udm:eth1
15:35:48 INFO Created link: br-sbi:eth28 ▪┄┄▪ pcf:eth1
15:35:48 INFO Created link: br-sbi:eth29 ▪┄┄▪ nssf:eth1
15:35:48 INFO Created link: CP2:eth3 ▪┄┄▪ TRA-cups:eth16
15:35:48 INFO Created link: br-sbi:eth30 ▪┄┄▪ bsf:eth1
15:35:48 INFO Created link: br-sbi:eth31 ▪┄┄▪ udr:eth1
15:35:48 INFO Created link: db-1:eth1 ▪┄┄▪ TRA-cups:eth17
15:35:48 INFO Created link: db-2:eth1 ▪┄┄▪ TRA-cups:eth18
15:35:48 INFO Created link: radius:eth1 ▪┄┄▪ TRA-cups:eth19
15:35:48 INFO Created link: amf:eth4 ▪┄┄▪ TRA-cups:eth20
15:35:48 INFO Executed command node=nrf command="ip addr add 10.40.1.2/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=nrf command="ip route add 1.1.1.1/32 via 10.40.1.1" stdout=""
15:35:48 INFO Executed command node=pcf command="ip addr add 10.40.1.15/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=pcf command="ip add add 10.110.1.4/24 dev eth2" stdout=""
15:35:48 INFO Executed command node=pcf command="ip route add 1.1.1.1/32 via 10.110.1.1" stdout=""
15:35:48 INFO Executed command node=amf command="ip addr add 10.40.1.5/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=amf command="ip addr add 10.50.1.2/24 dev eth2" stdout=""
15:35:48 INFO Executed command node=amf command="ip addr add 10.110.1.6/24 dev eth3" stdout=""
15:35:48 INFO Executed command node=amf command="ip addr add 10.100.1.2/24 dev eth4" stdout=""
15:35:48 INFO Executed command node=amf command="ip route add 1.1.1.1/32 via 10.100.1.1" stdout=""
15:35:48 INFO Executed command node=udm command="ip addr add 10.40.1.4/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=udm command="ip route add 1.1.1.1/32 via 10.40.1.1" stdout=""
15:35:48 INFO Executed command node=ue1 command="ip addr add 10.90.1.2/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=ue1 command="sed -i /imei:/d /etc/ueransim/ue.yaml" stdout=""
15:35:48 INFO Executed command node=ue1 command="sed -i /imeiSv:/d /etc/ueransim/ue.yaml" stdout=""
15:35:48 INFO Executed command node=ue1 command="bash -c envsubst < /etc/ueransim/ue.yaml > ue.yaml" stdout=""
15:35:48 INFO Executed command node=gnb command="ip addr add 10.50.1.10/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=gnb command="ip addr add 10.80.1.10/24 dev eth2" stdout=""
15:35:48 INFO Executed command node=gnb command="ip addr add 10.90.1.10/24 dev eth3" stdout=""
15:35:48 INFO Executed command node=gnb command="ip route add 1.1.1.0/24 via 10.80.1.1" stdout=""
15:35:48 INFO Executed command node=gnb command="bash -c envsubst < /etc/ueransim/gnb.yaml > gnb.yaml" stdout=""
15:35:48 INFO Executed command node=udr command="ip addr add 10.40.1.8/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=nssf command="ip addr add 10.40.1.6/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=ausf command="ip addr add 10.40.1.3/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=bsf command="ip addr add 10.40.1.7/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=db-1 command="ip addr add 192.168.1.100/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=db-1 command="ip route add 1.1.1.1/32 via 192.168.1.1" stdout=""
15:35:48 INFO Executed command node=db-2 command="ip addr add 192.168.1.100/24 dev eth1" stdout=""
15:35:48 INFO Executed command node=db-2 command="ip route add 1.1.1.1/32 via 192.168.1.1" stdout=""
15:35:48 INFO Adding host entries path=/etc/hosts
15:35:48 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-cups.conf
╭─────────────────┬───────────────────────────────────────────┬─────────┬────────────────╮
│       Name      │                 Kind/Image                │  State  │ IPv4/6 Address │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-CP1        │ vr-sros                                   │ running │ 192.168.40.2   │
│                 │ registry.srlinux.dev/pub/mag-c:25.3.R1    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-CP2        │ vr-sros                                   │ running │ 192.168.40.3   │
│                 │ registry.srlinux.dev/pub/mag-c:25.3.R1    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-TRA-cups   │ vr-sros                                   │ running │ 192.168.40.20  │
│                 │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-UP1        │ vr-sros                                   │ running │ 192.168.40.11  │
│                 │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-UP2        │ vr-sros                                   │ running │ 192.168.40.12  │
│                 │ registry.srlinux.dev/pub/vr-sros:25.3.R1  │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-amf        │ linux                                     │ running │ 192.168.40.54  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-ausf       │ linux                                     │ running │ 192.168.40.58  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-bngblaster │ linux                                     │ running │ 192.168.40.21  │
│                 │ htakkey/bngblaster:0.9.18                 │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-bsf        │ linux                                     │ running │ 192.168.40.62  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-db-1       │ linux                                     │ running │ 192.168.40.14  │
│                 │ registry.srlinux.dev/pub/mag-c-db:25.3.R1 │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-db-2       │ linux                                     │ running │ 192.168.40.15  │
│                 │ registry.srlinux.dev/pub/mag-c-db:25.3.R1 │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-dbctl      │ linux                                     │ running │ 192.168.40.52  │
│                 │ gradiant/open5gs-dbctl:0.10.3             │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-gnb        │ linux                                     │ running │ 192.168.40.66  │
│                 │ openverso/ueransim:3.2.6                  │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-mongo      │ linux                                     │ running │ 192.168.40.50  │
│                 │ mongo:5.0.28                              │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-nrf        │ linux                                     │ running │ 192.168.40.57  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-nssf       │ linux                                     │ running │ 192.168.40.61  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-pcf        │ linux                                     │ running │ 192.168.40.60  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-radius     │ linux                                     │ running │ 192.168.40.4   │
│                 │ freeradius/freeradius-server:3.2.3-alpine │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-udm        │ linux                                     │ running │ 192.168.40.59  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-udr        │ linux                                     │ running │ 192.168.40.63  │
│                 │ gradiant/open5gs:2.7.1                    │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-ue1        │ linux                                     │ running │ 192.168.40.67  │
│                 │ openverso/ueransim:3.2.6                  │         │ N/A            │
├─────────────────┼───────────────────────────────────────────┼─────────┼────────────────┤
│ cups-webui      │ linux                                     │ running │ 192.168.40.51  │
│                 │ gradiant/open5gs-webui:2.7.1              │         │ N/A            │
╰─────────────────┴───────────────────────────────────────────┴─────────┴────────────────╯
```
### 3.1 **Access the container nodes**
	
The nodes are accessable via the IP address or the node name.   
```bash  
docker exec -it cups-amf        bash
docker exec -it cups-ausf       bash
docker exec -it cups-bsf        bash   
docker exec -it cups-gnb        bash
docker exec -it cups-ue1        bash   
docker exec -it cups-nrf        bash
docker exec -it cups-nssf       bash
docker exec -it cups-pcf        bash   
docker exec -it cups-udm        bash
docker exec -it cups-udr        bash
docker exec -it cups-db-1       bash
docker exec -it cups-db-2       bash
docker exec -it cups-radius     sh
ssh admin@cups-TRA-cups    ## password=admin    
ssh admin@cups-UP1         ## password=admin     
ssh admin@cups-UP1         ## password=admin     
ssh admin@cups-CP1         ## password=admin
ssh admin@cups-CP2         ## password=admin
```  

## 4. **Check the MAG-C ,DB and UP**

Check the multi-chassis redundancy between the CP, the communication with the DB and the SX status with UP1 and UP2.

### 4.1 **Check the PFCP Reference Point Peers**
The communication with UPs can be checked via the below predefined script.

```bash          
*A:CP1>file cf1:\magc\ #
*A:CP1# exec pfcp-peers
Pre-processing configuration file (V0v0)...
Completed processing 9 lines in 0.0 seconds
show mobile-gateway pdn ref-point-peers sx-n4 peer
================================================================================
MAGC (me)     : 1.1.1.1
================================================================================

===============================================================================
PFCP reference point peers
===============================================================================
Peer address     : 1.1.1.101
Node Id          : up1.nokia.com
Router           : vprn2043
Path Mgmt State  : up
Create Time      : 04/09/2025 12:27:50  Gateway Id       : 1
UP Features      : FTUP TREU EMPU PDIU FRRT ADPDP MNOP IP6PL
UP BBF Features  : PPPOE IPOE LCPKO
UP Nokia Features: BULK-AUDIT LAC SSSG FSG
UP Association   : up                   Last Change Time : 04/09/2025 12:27:50
UP Selection     : True
Enforced PFCP association list : Yes
-------------------------------------------------------------------------------
Peer address     : 1.1.1.102
Node Id          : up2.nokia.com
Router           : vprn2043
Path Mgmt State  : up
Create Time      : 04/09/2025 12:27:50  Gateway Id       : 1
UP Features      : FTUP TREU EMPU PDIU FRRT ADPDP MNOP IP6PL
UP BBF Features  : PPPOE IPOE LCPKO
UP Nokia Features: BULK-AUDIT LAC SSSG FSG
UP Association   : up                   Last Change Time : 04/09/2025 12:27:50
UP Selection     : True
Enforced PFCP association list : Yes
-------------------------------------------------------------------------------
Number of peers : 2
===============================================================================
Executed 9 lines in 0.0 seconds from file cf1:\magc\pfcp-peers
```
   
 
### 4.2 **Check the database communication with the CP**

The communication between the CP and DB should be in `status = HOT` and can be checked via the below predefined script.

```bash 
*A:CP1# exec clouddb
Pre-processing configuration file (V0v0)...
Completed processing 8 lines in 0.0 seconds

show mobile-gateway system
show mobile-gateway pdn ref-point-peers cdbx

Resource Pool    : 1                    Redundancy       : many-to-many
-------------------------------------------------------------------------------
Card/VM          Red State              Group
-------------------------------------------------------------------------------
1/2              active                 1
1/3              standby                N/A
-------------------------------------------------------------------------------
===============================================================================
PDN Cdbx reference point peers
===============================================================================
Peer address    : 192.168.1.100
Router          : vprn1151                         Port          : 5678
Vm              : 2
Admin State     : Up                               Oper State    : Up
DB Sync state   : HOT                              VM Sync state : HOT
-------------------------------------------------------------------------------
Number of peers : 1
===============================================================================
clear mobile-gateway pdn 1 ref-point-stats cdbx

Thu Apr 10 21:30:40 CEST 2025
Executed 8 lines in 0.0 seconds from file cf1:\magc\clouddb
```
    
### 4.3 **Verify MAG-C redundancy status**
Verify that the two control planes are synchronized, with CP1 as the master and CP2 as the standby. 
Ensure the Geo-Redundancy state is set to 'Hot'.
```bash 
*A:CP1# exec icr1
Pre-processing configuration file (V0v0)...
Completed processing 30 lines in 0.0 seconds


--> show redundancy multi-chassis mc-mobile peer 10.10.10.2

===============================================================================
Multi-chassis Peer Mc-Mobile Table
===============================================================================
Peer                 : 10.10.10.2
Last State Change    : 04/08/2025 13:31:12
Admin State          : Up               Oper State           : Up
Peer Version         : TiMOS-AG-C-25.3.R1
Keep Alive           : 500 deci-sec     Hold On Nbr Fail     : 3
BFD Svc ID           : 0                BFD Interface Name   : system
MC-Redirect          : Disabled
Admin MC-complete-ue-sync : Enabled
Oper MC-complete-ue-sync  : Enabled
Slave Traffic Detection Delay Timer : Disabled
Traffic detection Poll timer                    : 5 secs
Master Traffic detection                        : Enabled
Traffic detection                               : Relaxed
Peer Connect                                    : Enabled

-------------------------------------------------------------------------------
Gateway Id           : 1
-------------------------------------------------------------------------------
Admin Role           : Primary          Oper Role            : Master
Peer Admin Role      : Secondary        Peer Oper Role       : Slave
Admin State          : Up               Oper State           : Up
Advertised metric    : Master
Last Time Peer Connected : 04/09/2025 12:27:38

Last Oper Role Change    : 04/09/2025 12:28:38
Last Oper Role Chg Rsn   : Traffic Evnt
Geo-Redundancy State : Hot
FSWO synchronization in progress : no
Mc-redirect trap set : no
MC-complete-ue-sync status : 100%
Mc-master-lock       : disabled
Mc-slave-lock        : disabled
Remaining Slave Traffic Detection Delay Timer : Disabled

-------------------------------------------------------------------------------
FSWO progress complete UE sync
-------------------------------------------------------------------------------
MG group Id            State           MCS sync use   Synced UEs
-------------------------------------------------------------------------------
CPM      : 0    Geo Redundancy : Hot         0%           100%
MG Group : 1    Geo Redundancy : Hot         0%           100%
-------------------------------------------------------------------------------
===============================================================================


--> show mobile-gateway bng  session count

===============================================================================
Total number of sessions : 1
===============================================================================
TOTAL BNG sessions
===============================================================================


--> ICR summary

===============================================================================
Peer Admin Role      : Secondary        Peer Oper Role       : Slave

Admin Role           : Primary          Oper Role            : Master

Geo-Redundancy State : Hot

Last Oper Role Change    : 04/09/2025 12:28:38
===============================================================================


Executed 30 lines in 0.0 seconds from file cf1:\magc\icr1
```


You can toggle master/backup state using a script executed on the master CP node (e.g. exec icr1-switch when CP1 is master or exec icr2-switch when CP2 is master).

```bash 
*A:CP1# exec icr1-switch
```
Or via the equivalent command:

```bash 
*A:CP-1# admin redundancy mc-mobile-switchover mobile-gateway 1 peer 10.10.10.2 now
Switchover will be executed but new Master node may have incomplete UE records, proceed (y/n)?y 
  			
*A:CP1# show redundancy multi-chassis mc-mobile peer 10.10.10.2
===============================================================================
Multi-chassis Peer Mc-Mobile Table
===============================================================================
Peer                 : 10.10.10.2
Last State Change    : 04/08/2025 13:31:12
Admin State          : Up               Oper State           : Up
Peer Version         : TiMOS-AG-C-25.3.R1
Keep Alive           : 500 deci-sec     Hold On Nbr Fail     : 3
BFD Svc ID           : 0                BFD Interface Name   : system
MC-Redirect          : Disabled
Admin MC-complete-ue-sync : Enabled
Oper MC-complete-ue-sync  : Enabled
Slave Traffic Detection Delay Timer : Disabled
Traffic detection Poll timer                    : 5 secs
Master Traffic detection                        : Enabled
Traffic detection                               : Relaxed
Peer Connect                                    : Enabled

-------------------------------------------------------------------------------
Gateway Id           : 1
-------------------------------------------------------------------------------
Admin Role           : Primary          Oper Role            : Slave
Peer Admin Role      : Secondary        Peer Oper Role       : Master
Admin State          : Up               Oper State           : Up
Advertised metric    : Slave
Last Time Peer Connected : 04/10/2025 21:36:08

Last Oper Role Change    : 04/10/2025 21:35:58
Last Oper Role Chg Rsn   : Traffic Evnt
Geo-Redundancy State : Hot
FSWO synchronization in progress : no
Mc-redirect trap set : no
MC-complete-ue-sync status : 100%
Mc-master-lock       : disabled
Mc-slave-lock        : disabled
Remaining Slave Traffic Detection Delay Timer : Disabled

-------------------------------------------------------------------------------
FSWO progress complete UE sync
-------------------------------------------------------------------------------
MG group Id            State           MCS sync use   Synced UEs
-------------------------------------------------------------------------------
CPM      : 0    Geo Redundancy : Hot         0%           100%
MG Group : 1    Geo Redundancy : Hot         0%           100%
-------------------------------------------------------------------------------
===============================================================================
```  

## 5. **Transferring CLI Scripts to Nodes via SFTP**
 
Use the `./upload-cliscripts.sh` script to download the predefined CLI scripts to the CF (Compact Flash) of the nodes directly.

```bash  
[root@compute-3 scripts]# ./upload-cliscripts.sh
cups-UP1 is up, starting SFTP upload...
Upload complete for cups-UP1.
cups-UP2 is up, starting SFTP upload...
Upload complete for cups-UP2.
cups-CP1 is up, starting SFTP upload...
Upload complete for cups-CP1.
cups-CP2 is up, starting SFTP upload...
Upload complete for cups-CP2.
```
