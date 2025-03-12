## 1.   **Start PPPoE/IPoE Session using BNGBlaste**
----
Start the broadband session using BNGBlaster to simulate PPPoE or IPoE session management
### 1.1. **start dhcp redundncy session**
10 dhcp sessions are established using the BNGBlaster
```bash
     ./start_dhcp_red.sh
```
![dhcp_red](images/dhcp-red.png)

The 10 IPOEs sessions are established on UP-2 and UP1 with hot-standby,can be verified following the below show commands:

   
```bash 
*A:SMF1>config>mobile>profile>bng# entry-point "e1"
*A:SMF1>config>mobile>profile>bng>ep# info
----------------------------------------------
                    match 1 attribute up-group
                        optional
                    exit
                    match 2 attribute up-ip
                        optional
                    exit
                    match 3 attribute s-vlan
                        optional
                    exit             
                    entry "up1-up2-1003"
                        description "pppoe and ipoe svlan"
                        ipoe
                            ipoe-profile "mydefault"
                            authentication-flow
                                adb "adb1-group" "adb2-group"
                            exit
                        exit
                        match
                            up-group "HOT1-UP1-UP2-VPLS-A/A"
                            vlan
                                s-vlan start 1003 end 1003
                            exit
                        exit
                        pppoe
                            pppoe-profile "pppoeProf1"
                            authentication-flow
                                pap-chap-adb "adb1-group" "adb2-group"
                            exit
                        exit
                        no shutdown
                    exit

```
The below show commands display 10 fixed IPoE on UP-2
 

```bash 
*A:UP2# exec s-dhcp_red
Pre-processing configuration file (V0v0)...
Completed processing 7 lines in 0.0 seconds
===============================================================================
Subscriber Host table
===============================================================================
Sap
  IP Address
    MAC Address                PPPoE-SID       Origin          Fwding State
      Subscriber
-------------------------------------------------------------------------------
[1/1/c2/1:1003.1]
  172.16.11.7
    02:00:03:00:00:01          N/A             PFCP            Fwding
      _cups_61
-------------------------------------------------------------------------------
Number of subscriber hosts : 1
===============================================================================
==============================================================================
PFCP Sessions
===============================================================================
Local Session Id                     : 0x000000000000005c
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80200006
Remote Session Id                    : 0x0000000000011110
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40011111
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x0a01
Data Downstream PDR-ID               : 0x8a01
IBCP Upstream PDR-ID                 : 0x0a00
IBCP Downstream PDR-ID               : 0x8a00
Session Type                         : IPoE
Sap                                  : 1/1/c2/1:1003.1
Mac                                  : 02:00:03:00:00:01
StateId                              : 0x67d1669f00000000
Subscriber Id                        : _cups_61
Sub Profile                          : sub-base
SLA Profile                          : sla-base
Fate Sharing Group Id                : 4 (standby)
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 172.16.11.7
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
<snip>
```

```bash
*A:UP2# show service active-subscribers hierarchy
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_61
   (sub-base)
   |
   +-- sap:[1/1/c2/1:1003.1] - sla:sla-base
       |
       +-- PFCP-session (IPoE) - mac:02:00:03:00:00:01 - svc:500
           |   PFCP session-id      : 0x000000000000005c
           |   Fate-Sharing-Group   : 4 (standby)
           |
           +-- 172.16.11.7 - PFCP

<snip>
-------------------------------------------------------------------------------
Number of active subscribers : 10
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
```






You can check the statistics via the below show command on UP2
```bash
*A:UP2#
*A:UP2# exec sessions
Pre-processing configuration file (V0v0)...
Completed processing 20 lines in 0.0 seconds


===============================================================================
Subscriber Management Statistics for System
===============================================================================
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   IPOE Hosts       - PFCP                  10       10 03/12/2025 11:03:12
-------------------------------------------------------------------------------
Total  IPOE Hosts                               10       10 03/12/2025 11:03:12
       IPv4 Hosts                               10       10 03/12/2025 11:03:12
       PFCP Hosts                               10       10 03/12/2025 11:03:12
       System Hosts Scale                       10       10 03/12/2025 11:03:12
-------------------------------------------------------------------------------
===============================================================================
<snip>
```

Check the session are also created on UP-1
```bash
*A:UP-1# show service active-subscribers
===============================================================================
Active Subscribers
===============================================================================
-------------------------------------------------------------------------------
Subscriber _cups_61
           (sub-base)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[1/1/c2/1:1003.1] - sla:sla-base
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
172.16.11.7
              02:00:03:00:00:01  0x000000000000003e PFCP         500        Y
-------------------------------------------------------------------------------
```


The statistaic on UP-1 also shows the 10 users
```bash
*A:UP-1>file cf1:\up\ #
*A:UP-1# exec sessions
Pre-processing configuration file (V0v0)...
Completed processing 20 lines in 0.0 seconds
===============================================================================
Subscriber Management Statistics for System
===============================================================================
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   IPOE Hosts       - PFCP                  10       10 03/12/2025 11:04:24
-------------------------------------------------------------------------------
Total  IPOE Hosts                               10       10 03/12/2025 11:04:24
       IPv4 Hosts                               10       10 03/12/2025 11:04:24
       PFCP Hosts                               10       10 03/12/2025 11:04:24
       System Hosts Scale                       10       10 03/12/2025 11:04:24
-------------------------------------------------------------------------------
<snip>
```

Check  the UPF Resiliency Type : Hot Standby  in the below show commands
```bash
*A:SMF1# exec fsg
Pre-processing configuration file (V0v0)...
Completed processing 12 lines in 0.0 seconds

===============================================================================
Up Table
===============================================================================
Gw UpId
        L2-Access-Id           S-Vlan    C-Vlan    Up-Group       Fsg     Role
-------------------------------------------------------------------------------
1 up1.nokia.com (1.1.1.101)
        1/1/c2/1               1003      1-1000    HOT1-UP1-UP2-  4       Act
                                                   VPLS-A/A
-------------------------------------------------------------------------------
1 up2.nokia.com (1.1.1.102)
        1/1/c2/1               1003      1-1000    HOT1-UP1-UP2-  4       Std
                                                   VPLS-A/A
-------------------------------------------------------------------------------
No. of UPs : 2
===============================================================================

===============================================================================
Up-Group 'HOT1-UP1-UP2-VPLS-A/A'
===============================================================================
PDN gateway                            : 1
Description                            : (Not Specified)
Admin State                            : up

FSG Profile                            : fsg1
    Default Standby Type               : hot

-------------------------------------------------------------------------------
     FSG Active UP                Standby UP                 Sessions  Hold-Off
-------------------------------------------------------------------------------
       4 up1.nokia.com            up2.nokia.com (ready)            10         0
-------------------------------------------------------------------------------
No. of FSGs: 1
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
UP                                           Pref Drain Health    Fsg     Role
-------------------------------------------------------------------------------
up1.nokia.com (1.1.1.101)                    yes  no       100    4       Act
up2.nokia.com (1.1.1.102)                    no   no       100    4       Std
-------------------------------------------------------------------------------
No. of UPs: 2
-------------------------------------------------------------------------------
===============================================================================

===============================================================================
Fate Sharing Group Table
===============================================================================
FSG     Gw Up-Group          Active UP                               Sessions
                             Standby UP
-------------------------------------------------------------------------------
4       1  HOT1-UP1-UP2-     up1.nokia.com                                 10
           VPLS-A/A          up2.nokia.com
-------------------------------------------------------------------------------
No. of Sessions  : 10
-------------------------------------------------------------------------------
No. of FSGs      : 1
=====================
```

Another command can be use to check the Resiliency

```bash
*A:SMF1# show mobile-gateway bng session s-vlan 1003
===============================================================================
BNG Sessions
===============================================================================
[IPoE] MAC                     : 02:00:03:00:00:08
-------------------------------------------------------------------------------
L2 Access Id                   : 1/1/c2/1
S-Vlan                         : 1003
C-Vlan                         : 8
MAC                            : 02:00:03:00:00:08

Up Time                        : 0d 00:25:17
Circuit Id                     : 0.0.0.0/0.0.0.0 eth 1:8
Remote Id                      : 7750bng-sub.8
Provisioned Addresses          : IPv4
Signaled Addresses             : IPv4

UP Peer                        : 1.1.1.101
Selected APN/DNN               : bngvrf
Network Realm                  : bngvrf
IPv4 Pool                      : pool3

IPv4 Address                   : 172.16.11.3
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 25
IPv4 Gateway                   : 172.16.11.126
IPv4 Primary DNS               : 208.67.5.1
IPv4 Secondary DNS             : 0.0.0.0
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 172.16.11.126
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : 03/19/2025 10:49:04
DHCPv4 Remaining Lease Time    : 6d 23:34:43

Subscriber                     : auto_sub_68 (68)
Acct-Session-Id                : X00011180D560813A00000044
Acct-Multi-Session-Id          : Y00000044D560813A00000043
State Id                       : 0x67d1669f00000000
Sub Profile                    : sub-base
Sla Profile                    : sla-base
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
SAP-Template                   : defaultsap
Group-itf-template             : defaultgrp
Number of Framed IPv4 Routes   : 0
Number of Framed IPv6 Routes   : 0
NAT Profile                    : N/A
HTTP Redirect URL              : N/A
Intermediate Destination Id    : N/A
Ingress IPv4 filter override   : N/A
Egress IPv4 filter override    : N/A
Ingress IPv6 filter override   : N/A
Egress IPv6 filter override    : N/A
Number of QoS Overrides        : 0

PFCP Node ID                   : up1.nokia.com
PFCP Local SEID                : 0x0000000000021180
PFCP Remote SEID               : 0x000000000000003b

UE Id                          : 0x00011180
PDN Session Id                 : 0x00011180
Group/VM                       : 1/2
Call-Insight                   : disabled

Fate Sharing Group Id          : 4
UP Group                       : HOT1-UP1-UP2-VPLS-A/A
UPF Resiliency Type            : Hot Standby
Active UPF Session State       : Created
Standby UPF Session State      : Created
Standby UPF PFCP Remote IP     : 1.1.1.102
Standby UPF PFCP Node ID       : up2.nokia.com
Standby UPF PFCP Local SEID    : 0x0000000000011180
Standby UPF PFCP Remote SEID   : 0x0000000000000058
Standby UPF IBCP Remote IP     : 1.1.1.102
Standby UPF IBCP Remote TEID   : 0x80200002
Standby UPF L2 Access Id       : 1/1/c2/1
Standby UPF S-Vlan             : 1003
Standby UPF C-Vlan             : 8

Charging Profile 1             : mybngcharging
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A

<snip>

Subscriber                     : auto_sub_3 (3)
Acct-Session-Id                : X000101C0D560813A00000003
Acct-Multi-Session-Id          : Y00000003D560813A00000002
State Id                       : 0x67cf3fd300000000
Sub Profile                    : sub-base
Sla Profile                    : sla-base
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
SAP-Template                   : defaultsap
Group-itf-template             : defaultgrp
Number of Framed IPv4 Routes   : 0
Number of Framed IPv6 Routes   : 0
NAT Profile                    : N/A
HTTP Redirect URL              : N/A
Intermediate Destination Id    : N/A
Ingress IPv4 filter override   : N/A
Egress IPv4 filter override    : N/A
Ingress IPv6 filter override   : N/A
Egress IPv6 filter override    : N/A
Number of QoS Overrides        : 0

PFCP Node ID                   : up1.nokia.com
PFCP Local SEID                : 0x00000000000101c0
PFCP Remote SEID               : 0x0000000000000018

UE Id                          : 0x000101c0
PDN Session Id                 : 0x000101c0
Group/VM                       : 1/3
Call-Insight                   : disabled

Fate Sharing Group Id          : 1
UP Group                       : HOT1-UP1-UP2-VPLS-A/A
UPF Resiliency Type            : Hot Standby
Active UPF Session State       : Created
Standby UPF Session State      : Created
Standby UPF PFCP Remote IP     : 1.1.1.104
Standby UPF PFCP Node ID       : up2.nokia.com
Standby UPF PFCP Local SEID    : 0x00000000000201c0
Standby UPF PFCP Remote SEID   : 0x0000000000000017
Standby UPF IBCP Remote IP     : 1.1.1.104
Standby UPF IBCP Remote TEID   : 0x800e0006
Standby UPF L2 Access Id       : 1/1/c2/1
Standby UPF S-Vlan             : 1003
Standby UPF C-Vlan             : 1

Charging Profile 1             : mybngcharging
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A

<snip>
```



### 1.2. **start dhcp session no redundancy**
  
 Another example with 10 DHCP sessions without redundancy
 
```bash
./start_dhcp.sh
```

![dhcp_red](images/dhcp.png)
  
The 10 sessions are created on UP2
  
```bash 
*A:SMF1# configure mobile-gateway profile bng entry-point "e1"
 A:SMF1>config>mobile>profile>bng>ep>entry# info
----------------------------------------------
                        description "ipoe only svlan"
                        ipoe
                            ipoe-profile "mydefault"
                            authentication-flow
                                adb "adb1" "adb2"
                            exit
                        exit
                        match
                            up-ip 1.1.1.102
                            vlan
                                s-vlan start 102 end 102
                            exit
                        exit
                        no shutdown
----------------------------------------------
```
  
```bash  
*A:UP2# /show subscriber-mgmt statistics host system non-zero-value-only | match Peak invert-match

===============================================================================
Subscriber Management Statistics for System
===============================================================================
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   IPOE Hosts       - PFCP                  10       20 03/12/2025 11:22:41
-------------------------------------------------------------------------------
IPv6   IPOE Hosts       - PFCP (NA)             10       10 03/12/2025 11:26:58
       IPOE Hosts       - PFCP (PD)             10       10 03/12/2025 11:26:58
-------------------------------------------------------------------------------
Total  IPOE Hosts                               30       40 03/12/2025 11:22:41
       IPv4 Hosts                               10       20 03/12/2025 11:22:41
       IPv6 Hosts                               20       20 03/12/2025 11:26:58
       PFCP Hosts                               30       40 03/12/2025 11:22:41
       System Hosts Scale                       30       40 03/12/2025 11:22:41
-------------------------------------------------------------------------------
```
  


```bash
*A:UP2# show service active-subscribers hierarchy

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_81
   (sub-base)
   |
   +-- sap:[1/1/c2/1:102.1] - sla:sla-base
       |
       +-- PFCP-session (IPoE) - mac:02:00:02:00:00:01 - svc:500
           |   PFCP session-id      : 0x000000000000006c
           |   Fate-Sharing-Group   : N/A
           |
           |-- 111.250.0.5 - PFCP
           |
           |-- c01d:1::4/128 - PFCP
           |
           +-- c01d:2:0:400::/56 - PFCP
```

```bash
*A:SMF1# show mobile-gateway bng session s-vlan 102
===============================================================================
BNG Sessions
===============================================================================
[IPoE] MAC                     : 02:00:02:00:00:08
-------------------------------------------------------------------------------
L2 Access Id                   : 1/1/c2/1
S-Vlan                         : 102
C-Vlan                         : 8
MAC                            : 02:00:02:00:00:08

Up Time                        : 0d 00:07:51
Circuit Id                     : 0.0.0.0/0.0.0.0 eth 1:8
Remote Id                      : 7750bng-sub.8
Provisioned Addresses          : IPv4, IPv6_PD, IPv6_NA
Signaled Addresses             : IPv4, IPv6_PD, IPv6_NA

UP Peer                        : 1.1.1.102
Selected APN/DNN               : bngvrf
Network Realm                  : bngvrf
IPv4 Pool                      : ipoe-pool1

IPv4 Address                   : 111.250.0.1
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 19
IPv4 Gateway                   : 111.250.31.254
IPv4 Primary DNS               : 208.67.5.1
IPv4 Secondary DNS             : 0.0.0.0
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 111.250.31.254
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : 03/19/2025 11:26:59
DHCPv4 Remaining Lease Time    : 6d 23:52:09

IPv6 Delegated Prefix          : c01d:2::/56
IPv6 Delegated Prefix Origin   : Local pool
IPv6 PD Subnet Length          : 42
IPv6 PD as Framed Route        : No
IPv6 Delegated Prefix Pool     : ipoe-pool1
IPv6 NA                        : c01d:1::
IPv6 NA Origin                 : Local pool
IPv6 NA Subnet Length          : 114
IPv6 NA Pool                   : ipoe-pool1
IPv6 Link-local                : fe80::e00:cbff:fe7e:ad00
IPv6 Preferred Lifetime        : 7d 00:00:00
IPv6 Valid Lifetime            : 30d 00:00:00
IPv6 Primary DNS               : 4001::208:67:5:1
IPv6 Secondary DNS             : ::
DHCPv6 Server DUID             : (hex) 00 02 00 00 19 7f 53 4d 46 31
DHCPv6 Client DUID             : (hex) 00 03 00 01 02 00 02 00 00 08
DHCPv6 IA_PD id                : 268435456
DHCPv6 IA_NA id                : 251658240
DHCPv6 T1                      : 3d 12:00:00
DHCPv6 T2                      : 5d 14:24:00
DHCPv6 Lease End               : 04/11/2025 11:26:59
DHCPv6 Remaining Lease Time    : 29d 23:52:09
DHCPv6 LDRA                    : No

Subscriber                     : auto_sub_88 (88)
Acct-Session-Id                : X00012180D560813A00000058
Acct-Multi-Session-Id          : Y00000058D560813A00000057
State Id                       : 0x67d16f8200000012
Sub Profile                    : sub-base
Sla Profile                    : sla-base
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
SAP-Template                   : defaultsap
Group-itf-template             : defaultgrp
Number of Framed IPv4 Routes   : 0
Number of Framed IPv6 Routes   : 0
NAT Profile                    : N/A
HTTP Redirect URL              : N/A
Intermediate Destination Id    : N/A
Ingress IPv4 filter override   : N/A
Egress IPv4 filter override    : N/A
Ingress IPv6 filter override   : N/A
Egress IPv6 filter override    : N/A
Number of QoS Overrides        : 0

PFCP Node ID                   : up2.nokia.com
PFCP Local SEID                : 0x0000000000012180
PFCP Remote SEID               : 0x000000000000006b

UE Id                          : 0x00012180
PDN Session Id                 : 0x00012180
Group/VM                       : 1/3
Call-Insight                   : disabled

Charging Profile 1             : mybngcharging
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A
```

### 1.3. **start PPPoE session **

Another example for PPPoE 
```bash
./start_pppoe.sh
```
![pppoe](images/pppoe.png)

PPPoE session are created on UP-1
```bash 
*A:SMF1# configure mobile-gateway profile bng entry-point "e1"
*A:SMF1>config>mobile>profile>bng>ep# info
----------------------------------------------
                    match 1 attribute up-group
                        optional
                    exit
                    match 2 attribute up-ip
                        optional
                    exit
                    match 3 attribute s-vlan
                        optional
                    exit                  
                    entry "up2-102"
                        description "ipoe only svlan"
                        ipoe
                            ipoe-profile "mydefault"
                            authentication-flow
                                adb "adb1" "adb2"
                            exit
                        exit
                        match
                            up-ip 1.1.1.102
                            vlan
                                s-vlan start 102 end 102
                            exit
                        exit
                        no shutdown
                    exit
                    no shutdown
```                    
     
```bash     
*A:UP-1# /show subscriber-mgmt statistics host system non-zero-value-only | match Peak invert-match

===============================================================================
Subscriber Management Statistics for System
===============================================================================
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Host & Protocol Statistics
-------------------------------------------------------------------------------
IPv4   PPP Hosts        - PFCP                  10       10 03/12/2025 11:38:52
       IPOE Hosts       - PFCP                   0       10 03/12/2025 11:04:24
-------------------------------------------------------------------------------
IPv6   PPP Hosts        - PFCP (SLAAC)          10       10 03/12/2025 11:38:52
       PPP Hosts        - PFCP (PD)             10       10 03/12/2025 11:38:52
-------------------------------------------------------------------------------
Total  PPP Hosts                                30       30 03/12/2025 11:38:52
       IPOE Hosts                                0       10 03/12/2025 11:04:24
       IPv4 Hosts                               10       10 03/12/2025 11:38:52
       IPv6 Hosts                               20       20 03/12/2025 11:38:52
       PFCP Hosts                               30       30 03/12/2025 11:38:52
       System Hosts Scale                       30       30 03/12/2025 11:38:52
-------------------------------------------------------------------------------
===============================================================================
```
The sessions are created on UP1
```bash     
*A:UP-1# show service active-subscribers hierarchy
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_100
   (sub-default)
   |
   +-- sap:[1/1/c2/1:101.9] - sla:sla-default
       |
       +-- PFCP-session (PPP) - mac:02:00:01:00:00:09 - svc:500
           |   PFCP session-id      : 0x000000000000004f
           |   Fate-Sharing-Group   : N/A
           |   pppoe-session-id     : 1
           |
           |-- 110.250.0.8 - PFCP
           |
           |-- c00d:2:0:700::/56 - PFCP
           |
           +-- c00d:3:0:7::/64 - PFCP
```
The sessions are created on MAG-C1 

```bash
*A:SMF1# show mobile-gateway bng session s-vlan 102

===============================================================================
BNG Sessions
===============================================================================
[IPoE] MAC                     : 02:00:02:00:00:08
-------------------------------------------------------------------------------
L2 Access Id                   : 1/1/c2/1
S-Vlan                         : 102
C-Vlan                         : 8
MAC                            : 02:00:02:00:00:08

Up Time                        : 0d 00:07:51
Circuit Id                     : 0.0.0.0/0.0.0.0 eth 1:8
Remote Id                      : 7750bng-sub.8
Provisioned Addresses          : IPv4, IPv6_PD, IPv6_NA
Signaled Addresses             : IPv4, IPv6_PD, IPv6_NA

UP Peer                        : 1.1.1.102
Selected APN/DNN               : bngvrf
Network Realm                  : bngvrf
IPv4 Pool                      : ipoe-pool1

IPv4 Address                   : 111.250.0.1
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 19
IPv4 Gateway                   : 111.250.31.254
IPv4 Primary DNS               : 208.67.5.1
IPv4 Secondary DNS             : 0.0.0.0
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 111.250.31.254
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : 03/19/2025 11:26:59
DHCPv4 Remaining Lease Time    : 6d 23:52:09

IPv6 Delegated Prefix          : c01d:2::/56
IPv6 Delegated Prefix Origin   : Local pool
IPv6 PD Subnet Length          : 42
IPv6 PD as Framed Route        : No
IPv6 Delegated Prefix Pool     : ipoe-pool1
IPv6 NA                        : c01d:1::
IPv6 NA Origin                 : Local pool
IPv6 NA Subnet Length          : 114
IPv6 NA Pool                   : ipoe-pool1
IPv6 Link-local                : fe80::e00:cbff:fe7e:ad00
IPv6 Preferred Lifetime        : 7d 00:00:00
IPv6 Valid Lifetime            : 30d 00:00:00
IPv6 Primary DNS               : 4001::208:67:5:1
IPv6 Secondary DNS             : ::
DHCPv6 Server DUID             : (hex) 00 02 00 00 19 7f 53 4d 46 31
DHCPv6 Client DUID             : (hex) 00 03 00 01 02 00 02 00 00 08
DHCPv6 IA_PD id                : 268435456
DHCPv6 IA_NA id                : 251658240
DHCPv6 T1                      : 3d 12:00:00
DHCPv6 T2                      : 5d 14:24:00
DHCPv6 Lease End               : 04/11/2025 11:26:59
DHCPv6 Remaining Lease Time    : 29d 23:52:09
DHCPv6 LDRA                    : No

Subscriber                     : auto_sub_88 (88)
Acct-Session-Id                : X00012180D560813A00000058
Acct-Multi-Session-Id          : Y00000058D560813A00000057
State Id                       : 0x67d16f8200000012
Sub Profile                    : sub-base
Sla Profile                    : sla-base
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
SAP-Template                   : defaultsap
Group-itf-template             : defaultgrp
Number of Framed IPv4 Routes   : 0
Number of Framed IPv6 Routes   : 0
NAT Profile                    : N/A
HTTP Redirect URL              : N/A
Intermediate Destination Id    : N/A
Ingress IPv4 filter override   : N/A
Egress IPv4 filter override    : N/A
Ingress IPv6 filter override   : N/A
Egress IPv6 filter override    : N/A
Number of QoS Overrides        : 0

PFCP Node ID                   : up2.nokia.com
PFCP Local SEID                : 0x0000000000012180
PFCP Remote SEID               : 0x000000000000006b

UE Id                          : 0x00012180
PDN Session Id                 : 0x00012180
Group/VM                       : 1/3
Call-Insight                   : disabled

Charging Profile 1             : mybngcharging
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A
```



   
