# Pre-requirements for CLAB Setup

## 1. SELinux Configuration

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

## 2. firewalld configuration 
The firewall should be enabled ,If the firewall is not enabled or inactive, start the firewalld service:
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



## 3. **create the needed bridges**:
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
  
## 4. **Deploy the ContainerLab Environment**:

   Deploy the containerized network environment using the ContainerLab configuration:
   ```bash     
   [root@compute-1 MAG-cups]# clab dep -t cups.clab.yml
   19:05:18 INFO Containerlab started version=0.66.0
   19:05:18 INFO Parsing & checking topology file=cups.clab.yml
   19:05:18 INFO Creating docker network name=cups IPv4 subnet=192.168.40.0/24 IPv6 subnet="" MTU=0
 ╯
## 5. **check the MAG-C ,DB and UP**:
   check the multi-chassis redundancy between the MAG-C , the communcation with the DB and the sx satus with UP-1 and UP-2

### 5.1 **Check the PFCP Reference Point Peers**:
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
   
 
### 5.2 **check the database communication with the MAG-C,it should be in HOT satus**:
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
    
### 5.3 **check the two MAG-C sysnc with each other i.e. MAG-C1 is master , MAG-C2 is standby and Geo-Redundancy State: Hot**:
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

