1. some requiremnt before starting
   For this CLAB its important that SELinux is disabled on your server. Example Centos os-release
   If status is disabled, then nothing to do.
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

1. firewalld should be en 
**create the needed bridges**:
   create the brideges
   ```bash   
   [root@compute-1 scripts]# ./create_bridges-centos.sh
   Warning: ALREADY_ENABLED: br-s1ap
   success
   Warning: ALREADY_ENABLED: br-gtpc
   success
   Warning: ALREADY_ENABLED: br-gtpu
   success
   Warning: ALREADY_ENABLED: br-diam
   success
   Warning: ALREADY_ENABLED: br-enb
   success
   success
			```
  
3. **Deploy the ContainerLab Environment**:

   Deploy the containerized network environment using the ContainerLab configuration:
   ```bash     
   [root@compute-1 MAG-cups]# clab dep -t cups.clab.yml
   19:05:18 INFO Containerlab started version=0.66.0
   19:05:18 INFO Parsing & checking topology file=cups.clab.yml
   19:05:18 INFO Creating docker network name=cups IPv4 subnet=192.168.40.0/24 IPv6 subnet="" MTU=0
   19:05:18 INFO Creating lab directory path=/root/MAG-cups/clab-cups
   19:05:18 INFO Creating container name=pcf
   19:05:18 INFO Creating container name=udr
   19:05:18 INFO Creating container name=amf
   19:05:18 INFO Using existing config file (/root/MAG-cups/clab-cups/up-1/tftpboot/config.txt) instead of applying a new one
   19:05:18 INFO Using existing config file (/root/MAG-cups/clab-cups/mag-c2/tftpboot/config.txt) instead of applying a new one
   19:05:18 INFO Creating container name=nssf
   19:05:18 INFO Creating container name=dbctl
   19:05:18 INFO Creating container name=ausf
   19:05:18 INFO Creating container name=radius
   19:05:18 INFO Creating container name=udm
   19:05:18 INFO Creating container name=bngblaster
   19:05:18 INFO Creating container name=mag-c1
   19:05:18 INFO Creating container name=mag-c2
   19:05:18 INFO Creating container name=up-1
   19:05:21 INFO Creating container name=mongo
   19:05:21 INFO Using existing config file (/root/MAG-cups/clab-cups/TRA/tftpboot/config.txt) instead of applying a new one
   19:05:21 INFO Creating container name=TRA
   19:05:22 INFO Creating container name=bsf
   19:05:22 INFO Creating container name=db-1
   19:05:23 INFO Creating container name=ue1
   19:05:23 INFO Creating container name=db-2
   19:05:24 INFO Creating container name=nrf
   19:05:25 INFO Creating container name=gnb
   19:05:26 INFO Using existing config file (/root/MAG-cups/clab-cups/up-2/tftpboot/config.txt) instead of applying a new one
   19:05:26 INFO Creating container name=up-2
   19:05:28 INFO Creating container name=webui
   19:05:34 INFO Created link: mag-c1:eth2 ▪┄┄▪ TRA:eth5
   19:05:37 INFO Created link: mag-c2:eth2 ▪┄┄▪ TRA:eth6
   19:05:38 INFO Created link: up-1:eth1 ▪┄┄▪ TRA:eth7
   19:05:39 INFO Created link: TRA:eth9 ▪┄┄▪ up-1:eth2
   19:05:39 INFO Created link: TRA:eth11 ▪┄┄▪ bngblaster:eth1
   19:05:39 INFO Created link: TRA:eth12 ▪┄┄▪ bngblaster:eth2
   19:05:39 INFO Created link: mag-c1:eth4 ▪┄┄▪ TRA:eth13
   19:05:39 INFO Created link: mag-c2:eth4 ▪┄┄▪ TRA:eth14
   19:05:39 INFO Created link: mag-c1:eth3 ▪┄┄▪ TRA:eth15
   19:05:40 INFO Created link: mag-c2:eth3 ▪┄┄▪ TRA:eth16
   19:05:40 INFO Created link: db-1:eth1 ▪┄┄▪ TRA:eth17
   19:05:43 INFO Created link: up-2:eth1 ▪┄┄▪ TRA:eth8
   19:05:47 INFO Created link: TRA:eth10 ▪┄┄▪ up-2:eth2
   19:05:47 INFO Created link: db-2:eth1 ▪┄┄▪ TRA:eth18
   19:05:48 INFO Created link: br-sbi:eth23 ▪┄┄▪ TRA:eth4
   19:05:48 INFO Created link: mag-c2:eth1 ▪┄┄▪ br-dsf2:magc2eth1
   19:05:48 INFO Created link: br-metric:eth17 ▪┄┄▪ pcf:eth2
   19:05:48 INFO Created link: br-gtpu:eth3 ▪┄┄▪ TRA:eth1
   19:05:48 INFO Created link: mag-c2:eth5 ▪┄┄▪ br-dsf2:magc2eth2
   19:05:48 INFO Created link: br-ngap:eth20 ▪┄┄▪ amf:eth2
   19:05:48 INFO Created link: mag-c1:eth1 ▪┄┄▪ br-dsf1:magc1eth1
   19:05:49 INFO Created link: radius:eth1 ▪┄┄▪ TRA:eth19
   19:05:49 INFO Created link: br-gtpu:eth4 ▪┄┄▪ gnb:eth2
   19:05:49 INFO Created link: br-metric:eth18 ▪┄┄▪ amf:eth3
   19:05:49 INFO Created link: gnb:eth3 ▪┄┄▪ ue1:eth1
   19:05:49 INFO Created link: mag-c1:eth5 ▪┄┄▪ br-dsf1:magc1eth2
   19:05:49 INFO Created link: br-metric:eth19 ▪┄┄▪ TRA:eth2
   19:05:49 INFO Created link: mag-c2:eth6 ▪┄┄▪ br-dsf2:magc2eth3
   19:05:49 INFO Created link: br-ngap:eth21 ▪┄┄▪ gnb:eth1
   19:05:49 INFO Created link: amf:eth4 ▪┄┄▪ TRA:eth20
   19:05:49 INFO Created link: br-sbi:eth24 ▪┄┄▪ amf:eth1
   19:05:49 INFO Created link: mag-c1:eth6 ▪┄┄▪ br-dsf1:magc1eth3
   19:05:49 INFO Created link: br-sbi:eth25 ▪┄┄▪ nrf:eth1
   19:05:49 INFO Created link: br-ngap:eth22 ▪┄┄▪ TRA:eth3
   19:05:49 INFO Created link: br-sbi:eth26 ▪┄┄▪ ausf:eth1
   19:05:50 INFO Created link: br-sbi:eth27 ▪┄┄▪ udm:eth1
   19:05:50 INFO Created link: br-sbi:eth28 ▪┄┄▪ pcf:eth1
   19:05:52 INFO Created link: br-sbi:eth29 ▪┄┄▪ nssf:eth1
   19:05:52 INFO Created link: br-sbi:eth30 ▪┄┄▪ bsf:eth1
   19:05:52 INFO Created link: br-sbi:eth31 ▪┄┄▪ udr:eth1
   19:05:52 INFO Executed command node=udr command="ip addr add 10.40.1.8/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=amf command="ip addr add 10.40.1.5/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=amf command="ip addr add 10.50.1.2/24 dev eth2" stdout=""
   19:05:52 INFO Executed command node=amf command="ip addr add 10.110.1.6/24 dev eth3" stdout=""
   19:05:52 INFO Executed command node=amf command="ip addr add 10.100.1.2/24 dev eth4" stdout=""
   19:05:52 INFO Executed command node=amf command="ip route add 1.1.1.1/32 via 10.100.1.1" stdout=""
   19:05:52 INFO Executed command node=nssf command="ip addr add 10.40.1.6/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=ue1 command="ip addr add 10.90.1.2/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=ue1 command="sed -i /imei:/d /etc/ueransim/ue.yaml" stdout=""
   19:05:52 INFO Executed command node=ue1 command="sed -i /imeiSv:/d /etc/ueransim/ue.yaml" stdout=""
   19:05:52 INFO Executed command node=ue1 command="bash -c envsubst < /etc/ueransim/ue.yaml > ue.yaml" stdout=""
   19:05:52 INFO Executed command node=db-2 command="ip addr add 192.168.1.100/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=db-2 command="ip route add 1.1.1.1/32 via 192.168.1.1" stdout=""
   19:05:52 INFO Executed command node=gnb command="ip addr add 10.50.1.10/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=gnb command="ip addr add 10.80.1.10/24 dev eth2" stdout=""
   19:05:52 INFO Executed command node=gnb command="ip addr add 10.90.1.10/24 dev eth3" stdout=""
   19:05:52 INFO Executed command node=gnb command="ip route add 1.1.1.0/24 via 10.80.1.1" stdout=""
   19:05:52 INFO Executed command node=gnb command="bash -c envsubst < /etc/ueransim/gnb.yaml > gnb.yaml" stdout=""
   19:05:52 INFO Executed command node=pcf command="ip addr add 10.40.1.15/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=pcf command="ip add add 10.110.1.4/24 dev eth2" stdout=""
   19:05:52 INFO Executed command node=pcf command="ip route add 1.1.1.1/32 via 10.110.1.1" stdout=""
   19:05:52 INFO Executed command node=udm command="ip addr add 10.40.1.4/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=udm command="ip route add 1.1.1.1/32 via 10.40.1.1" stdout=""
   19:05:52 INFO Executed command node=db-1 command="ip addr add 192.168.1.100/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=db-1 command="ip route add 1.1.1.1/32 via 192.168.1.1" stdout=""
   19:05:52 INFO Executed command node=bsf command="ip addr add 10.40.1.7/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=nrf command="ip addr add 10.40.1.2/24 dev eth1" stdout=""
   19:05:52 INFO Executed command node=nrf command="ip route add 1.1.1.1/32 via 10.40.1.1" stdout=""
   19:05:52 INFO Executed command node=ausf command="ip addr add 10.40.1.3/24 dev eth1" stdout=""
   19:05:52 INFO Adding host entries path=/etc/hosts
   19:05:52 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-cups.conf
   ╭─────────────────┬────────────────────────────────────────────┬─────────┬────────────────╮
   │       Name      │                 Kind/Image                 │  State  │ IPv4/6 Address │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-TRA        │ vr-sros                                    │ running │ 192.168.40.20  │
   │                 │ registry.srlinux.dev/pub/vr-sros:24.10.R3  │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-amf        │ linux                                      │ running │ 192.168.40.54  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-ausf       │ linux                                      │ running │ 192.168.40.58  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-bngblaster │ linux                                      │ running │ 192.168.40.21  │
   │                 │ ghcr.io/asadarafat/bngblaster:main         │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-bsf        │ linux                                      │ running │ 192.168.40.62  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-db-1       │ linux                                      │ running │ 192.168.40.14  │
   │                 │ registry.srlinux.dev/pub/mag-c-db:24.10.R3 │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-db-2       │ linux                                      │ running │ 192.168.40.15  │
   │                 │ registry.srlinux.dev/pub/mag-c-db:24.10.R3 │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-dbctl      │ linux                                      │ running │ 192.168.40.52  │
   │                 │ gradiant/open5gs-dbctl:0.10.3              │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-gnb        │ linux                                      │ running │ 192.168.40.66  │
   │                 │ openverso/ueransim:3.2.6                   │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-mag-c1     │ vr-sros                                    │ running │ 192.168.40.2   │
   │                 │ registry.srlinux.dev/pub/mag-c:24.10.R3    │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-mag-c2     │ vr-sros                                    │ running │ 192.168.40.3   │
   │                 │ registry.srlinux.dev/pub/mag-c:24.10.R3    │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-mongo      │ linux                                      │ running │ 192.168.40.50  │
   │                 │ mongo:5.0.28                               │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-nrf        │ linux                                      │ running │ 192.168.40.57  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-nssf       │ linux                                      │ running │ 192.168.40.61  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-pcf        │ linux                                      │ running │ 192.168.40.60  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-radius     │ linux                                      │ running │ 192.168.40.4   │
   │                 │ freeradius/freeradius-server:3.2.3-alpine  │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-udm        │ linux                                      │ running │ 192.168.40.59  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-udr        │ linux                                      │ running │ 192.168.40.63  │
   │                 │ gradiant/open5gs:2.7.1                     │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-ue1        │ linux                                      │ running │ 192.168.40.67  │
   │                 │ openverso/ueransim:3.2.6                   │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-up-1       │ vr-sros                                    │ running │ 192.168.40.11  │
   │                 │ registry.srlinux.dev/pub/vr-sros:24.10.R3  │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-up-2       │ vr-sros                                    │ running │ 192.168.40.12  │
   │                 │ registry.srlinux.dev/pub/vr-sros:24.10.R3  │         │ N/A            │
   ├─────────────────┼────────────────────────────────────────────┼─────────┼────────────────┤
   │ cups-webui      │ linux                                      │ running │ 192.168.40.51  │
   │                 │ gradiant/open5gs-webui:2.7.1               │         │ N/A            │
   ╰─────────────────┴────────────────────────────────────────────┴─────────┴────────────────╯
### **3   check the MAG-C ,DB and UP**:
   check the multi-chassis redundancy between the MAG-C , the communcation with the DB and the sx satus with UP-1 and UP-2


#### **3.1 Check the PFCP Reference Point Peers**
   ```bash          
   *A:SMF1# show mobile-gateway pdn ref-point-peers sx-n4
   ===============================================================================
   PFCP reference point peers
   ===============================================================================
   Peer address     : 1.1.1.101
   Node Id          : up1.nokia.com
   Router           : vprn2043
   Path Mgmt State  : up
   Create Time      : 03/10/2025 19:54:57  Gateway Id       : 1
   UP Features      : FTUP TREU EMPU PDIU FRRT ADPDP MNOP IP6PL
   UP BBF Features  : PPPOE IPOE LCPKO
   UP Nokia Features: BULK-AUDIT LAC SSSG FSG
   UP Association   : up                   Last Change Time : 03/10/2025 21:00:10
   UP Selection     : True
   Enforced PFCP association list : Yes
   -------------------------------------------------------------------------------
   Peer address     : 1.1.1.102
   Node Id          : up2.nokia.com
   Router           : vprn2043
   Path Mgmt State  : up
   Create Time      : 03/10/2025 19:55:02  Gateway Id       : 1
   UP Features      : FTUP TREU EMPU PDIU FRRT ADPDP MNOP IP6PL
   UP BBF Features  : PPPOE IPOE LCPKO
   UP Nokia Features: BULK-AUDIT LAC SSSG FSG
   UP Association   : up                   Last Change Time : 03/10/2025 20:59:53
   UP Selection     : True
   Enforced PFCP association list : Yes
   ```
   
 
#### **3.2 check the database communication with the MAG-C,it should be in HOT satus**
   ```bash 
   *A:SMF1#  show mobile-gateway pdn ref-point-peers cdbx
   ===============================================================================
   PDN Cdbx reference point peers
   ===============================================================================
   Peer address    : 192.168.1.100
   Router          : vprn1151                         Port          : 5678
   Vm              : 3
   Admin State     : Up                               Oper State    : Up
   Create Time     : 03/10/2025 18:12:15              Gateway Id    : 1
   cloud-db-prof   : cdb-test
   Interface       : system
   DB Sync state   : HOT                              VM Sync state : HOT
   Last status chng: 03/10/2025 18:13:30
   -------------------------------------------------------------------------------
   Number of peers : 1
   ```
    
#### **3.3 check the two MAG-C sysnc with each other i.e. MAG-C1 is master , MAG-C2 is standby and Geo-Redundancy State: Hot**
   ```bash 
   *A:SMF1# show redundancy multi-chassis mc-mobile peer 10.10.10.2
   ===============================================================================
   Multi-chassis Peer Mc-Mobile Table
   ===============================================================================
   Peer                 : 10.10.10.2
   Last State Change    : 03/10/2025 18:13:04
   Admin State          : Up               Oper State           : Up
   Peer Version         : TiMOS-AG-C-24.10.R3
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
   Last Time Peer Connected : 03/10/2025 18:13:04

   Last Oper Role Change    : 03/10/2025 18:13:04
   Last Oper Role Chg Rsn   : No Peer
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

#### **3.4 MAG-C1 started as primary and slave ,you can change that to be Primary master if needed**
   ```bash 
   *A:SMF2# admin redundancy mc-mobile-switchover mobile-gateway 1 peer 10.10.10.1 now
   Switchover will be executed but new Master node may have incomplete UE records, proceed (y/n)?y   
   *A:SMF1# show redundancy multi-chassis mc-mobile peer 10.10.10.2
   ===============================================================================
   Multi-chassis Peer Mc-Mobile Table
   ===============================================================================
   Peer                 : 10.10.10.2
   Last State Change    : 03/10/2025 18:22:57
   Admin State          : Up               Oper State           : Up
   Peer Version         : TiMOS-AG-C-24.10.R3
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
   Last Time Peer Connected : 03/10/2025 18:23:00

   Last Oper Role Change    : 03/10/2025 18:22:45
   Last Oper Role Chg Rsn   : Peer Disconnect
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
   ------------------------------------------------------------------------------
   ```  

### **4 Register the 5G Subscriber**:
    you can subscriber the needed imsi using the below script,it contains the IMSI,APN ,Slice info....etc
     ```bash
     [root@compute-1 scripts]# ./register_subscriber.sh
     ./register_subscriber.sh: line 27: :open5gs-dbctl: Open5GS Database Configuration Tool (0.10.3)
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ad08fb9e1025e5e739c')
     }
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ad4d50fa261355e739c')
     }
     Added IMSI: 206010000000009
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ad67dfdb7ffec5e739c')
     }
     Added IMSI: 206010000000010
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ad8e4705054a45e739c')
     }
     Added IMSI: 206010000000011
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ada2996ef54765e739c')
     }
     Added IMSI: 206010000000012
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2adc1029d469d35e739c')
     }
     Added IMSI: 206010000000013
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ade5d4508f66b5e739c')
     }
     Added IMSI: 206010000000014
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ae13daf71e7a15e739c')
     }
     Added IMSI: 206010000000015
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ae260a7d1b5b35e739c')
     }
     Added IMSI: 206010000000016
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ae453d59aa9545e739c')
     }
     Added IMSI: 206010000000017
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ae51e7cd00eb65e739c')
     }
     Added IMSI: 206010000000018
     {
       acknowledged: true,
       insertedId: ObjectId('67cf2ae7bf25e2851e5e739c')
     }
     Added IMSI: 206010000000019
     All subscribers added successfully!
      ```
 ####  **4.1  GUI access to the database **:
	      You can check the users are created in the database via http://x.x.x.x:10000/   username/password: admin/1423
 
###5 **Start the Open5GS Core Network (AMF,NRF...)**:
     ```bash
     cd scripts
     ./start_open5gs.sh

6.   **Start PPPoE/IPoE Session using BNGBlaster**:
     Start the broadband session using BNGBlaster to simulate PPPoE or IPoE session management
     ```bash
     ./start_dhcp_red.sh
     ./start_pppoe.sh   # To start session with traffic
6.   **Start the 5G Session**:
     Finally, start the 5G session (just 1 IMSI or 10 IMSIs)
     ```bash
     cd scripts
     ./start_5g_cups_10IMSI.sh
     ./start_5g_cups.sh

