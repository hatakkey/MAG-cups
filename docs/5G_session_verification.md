## 1.   **start the 5G session**
----
### 1.1. start 1 5G session
use the below script to start 1 session, we have later another example for 10 IMSIs
```bash
[root@compute-1 scripts]# ./start_5g_cups.sh
Waiting for uesimtun0 to be ready...
Waiting for uesimtun0 to be ready...
IP route added successfully.
[root@compute-1 scripts]#
```
### 1.1.1 check the session on MAG-C1 
```bash
*A:SMF1# show mobile-gateway pdn pdn-context
===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000002     demo.nok* IPv4    1      43.0.32.1/-             N11/http2
-------------------------------------------------------------------------------
```
### 1.1.2. Check the session on MAG-C2
```bash
*A:SMF2# show mobile-gateway pdn pdn-context
===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000002     demo.nok* IPv4    1      43.0.32.1/-             N11/http2
-------------------------------------------------------------------------------
Number of PDN instances : 1
-------------------------------------------------------------------------------
```
### 1.1.3. Check the session details
check the details of the session including AMF and UDM info
```bash
*A:SMF1# show mobile-gateway pdn pdn-context imsi 206010000000002  detail
===============================================================================
PDN context detail
===============================================================================
SUPI             : 206010000000002
DNN              : demo.nokia.mnc001.mcc206.gprs
Public DNN       : N/A
Virtual DNN      : N/A
Virtual DNN sel  : -
Virtual DNN sel user-range type              : -
Virtual DNN sel scope                        : N/A
Auth Status      : IMSI authenticated
PEI              : N/A
GPSI             : N/A
RAT              : NR
Interworking     : Not Subscribed
SMF type         : SMF
Ref-point/Sig-pr*: N11/http2            DNN restriction  : 0
5G Capability
  RQI            : Disabled               Multihoming    : Disabled
PDU Session ID   : 1
PCF Subscribed PRAs
CHF Subscribed PRAs
UL DNN AMBR      : 1000.00 Mbps         DL DNN AMBR      : 1000.00 Mbps
Bearer contexts  : 1                    SDFs             : 0

Primary DNS IPv4 address   : 208.67.254.254
Secondary DNS IPv4 address : 208.67.255.255
Primary DNS IPv6 address   : -
Secondary DNS IPv6 address : -

Pri NBNS IPv4 ad*: -                    Sec NBNS IPv4 ad*: -
Pri NBNS IPv6 ad*: -
Sec NBNS IPv6 ad*: -

Charging bearer *: Home

UE IPv4 address  : 43.0.32.1
UE IPv4 address source     : unknown


Framed Routes    : 0

P-CSCF Reselection         : Y

Override Rating Group      : N/A
Override Online Billing Method  : Disabled
Override Offline Billing Method : Disabled
MO Exception Cou*: 0                    MO Exception Tim*: 0

ULI Timestmp(sec): 0                    SSC Mode         : 1
N3 State         : Active
LADN state       : Inactive

NSSAI
SST              : 1                    SD               : 0xabcdef
AMF PCF ID       : 13c9b4a8-fddb-41ef-95b6-69f4d9a36783
-------------------------------------------------------------------------------
Service Based Interface (SBI) Information
-------------------------------------------------------------------------------
Service Realm    : sbaRealm1

NF Service       : nsmf-pdusession
NF Role          : producer
NF ID            : 13064c34-fddb-41ef-a24a-95054fdc4815
URI              : http://1.1.1.1:65522/nsmf-pdusession/v1/sm-contexts/00010110
Service Instance : nsmf_pdusession1

NF Service       : namf-comm
NF Role          : consumer
NF ID            : 13064c34-fddb-41ef-a24a-95054fdc4815
Service Instance : namf-comm1

NF Service       : namf-evts
NF Role          : consumer
NF ID            : 13064c34-fddb-41ef-a24a-95054fdc4815
URI              : http://1.1.1.1:65522/smfPduSession/00010110

NF Service       : nudm-sdm
NF Role          : consumer
NF ID            : 132bf86c-fddb-41ef-8277-2b544ba6f1ba
URI              : http://10.40.1.4:8080/nudm-sdm/v2/imsi-206010000000002/sdm-
                   subscriptions/06910b04-fddd-41ef-8277-2b544ba6f1ba
Service Instance : udm-sdm1

NF Service       : nudm-uecm
NF Role          : consumer
NF ID            : 132bf86c-fddb-41ef-8277-2b544ba6f1ba
URI              : http://10.40.1.4:8080/nudm-uecm/v1/imsi-206010000000002/
                   registrations/smf-registrations/1
Service Instance : udm-uecm1
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
QoS Information
-------------------------------------------------------------------------------
QFI : 9   QFI Type : 5QI      QoS Flow Type : Default
-------------------------------------------------------------------------------
QoS Profile
5QI/ARP              : 9/8              Priority Level       : 0
Avg Window (ms)      : 0                Max Bst Vol (bytes)  : 0
QNC                  : Disabled         RQI                  : Disabled
UL MBR (kbps)        : 0                DL MBR (kbps)        : 0
UL GBR (kbps)        : 0                DL GBR (kbps)        : 0
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
User Plane (UP) Information
-------------------------------------------------------------------------------
UP Type              : Original PSA
UP Sx-N4 Ctl V4      : 1.1.1.101
CP Sx-N4 Ctl V4      : 1.1.1.1
CP Sx-N4 Seid        : 0x10110
UP Sx-N4 Seid        : 0x2
gNb N3 Data TEID     : 0x1
gNb N3 IPv4 Address  : 10.80.1.10
UP N3 Data TEID      : 0x40000
UP N3 IPv4 Address   : 1.1.1.101

QFI(s)               : 9

-------------------------------------------------------------------------------

Def PFCP-u Sess  : False
Network/Itf Realm: N/A
-------------------------------------------------------------------------------
Number of PDN contexts : 1
```

### 1.1.4 check the IP information
The IP information details can be checked using the below command
```bash
*A:SMF1# show mobile-gateway bng session
===============================================================================
BNG Sessions
===============================================================================
[FWA] IMSI/SUPI                : 206010000000002
      APN/DNN                  : demo.nokia.mnc001.mcc206.gprs
      N1 PDU Session Id        : 1
-------------------------------------------------------------------------------
IMEI/PEI                       : N/A
MSISDN/GPSI                    : N/A
PAP/CHAP User Name             : N/A
RAT                            : NR
Tracking Area Code             : 0x1
Cell Id                        : 0x100
RAN GTP-U IP                   : 10.80.1.10
RAN GTP-U TEID                 : 0x00000001
UP GTP-U IP                    : 1.1.1.101
UP GTP-U TEID                  : 0x00040000
S11 MME GTP-C IP               : N/A
S11 MME GTP-C TEID             : N/A
S11 CP GTP-C IP                : N/A
S11 CP GTP-C TEID              : N/A
N11 AMF GUAMI                  : 206 01 0x20040
N11 AMF NF Instance Id         : 13064c34-fddb-41ef-a24a-95054fdc4815
N10 UDM SDM NF Instance Id     : 132bf86c-fddb-41ef-8277-2b544ba6f1ba
N10 UDM UECM NF Instance Id    : 132bf86c-fddb-41ef-8277-2b544ba6f1ba
N7 PCF NF Instance Id          : N/A
N40 CHF NF Instance Id         : N/A
N4 UPF NF Instance Id          : N/A
N1 PDU Session Id              : 1
S-NSSAI                        : SST 1, SD 0xabcdef
QFI(s)                         : 9
EBI(s)                         : N/A
Local Priority                 : N/A

Up Time                        : 0d 00:02:03
Provisioned Addresses          : IPv4
Signaled Addresses             : IPv4

UP Peer                        : 1.1.1.101
Selected APN/DNN               : demo.nokia.mnc001.mcc206.gprs
Network Realm                  : bngvrf
IPv4 Pool                      : fwa
IPv4 Signaling Method          : NAS

IPv4 Address                   : 43.0.32.1
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 19
IPv4 Gateway                   : 43.0.63.254
IPv4 Primary DNS               : 208.67.254.254
IPv4 Secondary DNS             : 208.67.255.255
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 43.0.63.254
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : N/A
DHCPv4 Remaining Lease Time    : N/A

Subscriber                     : 206010000000002 (536870913)
Acct-Session-Id                : F00010110D560813A01100032
Acct-Multi-Session-Id          : Y20000001D560813A00010110
State Id                       : N/A
Sub Profile                    : sub-fwa
Sla Profile                    : sla-fwa
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
SAP-Template                   : templ1
Group-itf-template             : templ2
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
PFCP Local SEID                : 0x0000000000010110
PFCP Remote SEID               : 0x0000000000000002

UE Id                          : 0x00010110
PDN Session Id                 : 0x00010110
Group/VM                       : 1/3
Call-Insight                   : disabled

Charging Profile 1             : accounting-1
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A

-------------------------------------------------------------------------------
Number of sessions shown : 1
```

### 1.5. checking the UP
The session is created on UP-1 as shown below

```bash
*A:UP-1# show service active-subscribers hierarchy
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_536870913
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:00 - svc:500
           |   PFCP session-id      : 0x0000000000000002
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000002
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.1 - PFCP    
-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
```

### 1.6. checking the UE 
 You can check the UE VM that uesimtun0 is created with the UE IP address 43.0.32.1/32 ,and the route to the UP-1 is via uesimtun0
```bash
[root@compute-1 scripts]# docker exec -it cups-ue1 bash
bash-5.1# ip r
default via 192.168.40.1 dev eth0
1.1.1.0/24 dev uesimtun0 scope link
10.90.1.0/24 dev eth1 proto kernel scope link src 10.90.1.2
192.168.40.0/24 dev eth0 proto kernel scope link src 192.168.40.67
bash-5.1# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: uesimtun0: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.1/32 scope global uesimtun0
       valid_lft forever preferred_lft forever
    inet6 fe80::e6cb:72b8:892:9db1/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
1722: eth0@if1723: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:28:43 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.40.67/24 brd 192.168.40.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:2843/64 scope link
       valid_lft forever preferred_lft forever
1747: eth1@if1746: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:1a:7c:7b brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 10.90.1.2/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe1a:7c7b/64 scope link
       valid_lft forever preferred_lft forever
    
```
## 1.7 **checking the dataplane**

the UE can reach the UP via the uesimtun0
```bash
[root@compute-1 scripts]# docker exec -it cups-ue1  bash
bash-5.1# ip r
default via 192.168.40.1 dev eth0
1.1.1.0/24 dev uesimtun0 scope link
10.90.1.0/24 dev eth1 proto kernel scope link src 10.90.1.2
192.168.40.0/24 dev eth0 proto kernel scope link src 192.168.40.67
```
```bash
bash-5.1# ping 1.1.1.101
PING 1.1.1.101 (1.1.1.101): 56 data bytes
^C
--- 1.1.1.101 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
bash-5.1# ping 1.1.1.102
PING 1.1.1.102 (1.1.1.102): 56 data bytes
64 bytes from 1.1.1.102: seq=0 ttl=64 time=23.432 ms
^C
```



## 3. **testing 10 IMSI 5G sessions**
start the sesssion using the below script

```bash
[root@compute-1 scripts]# ./start_5g_cups_10IMSI.sh
Waiting for uesimtun interfaces to appear...
All uesimtun interfaces are ready. Adding routes...
Routes added successfully: ip route add 1.1.1.0/24 nexthop dev uesimtun0 nexthop dev uesimtun1 nexthop dev uesimtun2 nexthop dev uesimtun3 nexthop dev uesimtun4 nexthop dev uesimtun5 nexthop dev uesimtun6 nexthop dev uesimtun7 nexthop dev uesimtun8 nexthop dev uesimtun9
```
### 3.1. MAG-C session check
the session are created on MAG-c1 and MAG-c2 as below
```bash
*A:SMF1# show mobile-gateway pdn pdn-context
===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000015     demo.nok* IPv4    1      43.0.96.3/-             N11/http2
206010000000013     demo.nok* IPv4    1      43.0.32.10/-            N11/http2
206010000000016     demo.nok* IPv4    1      43.0.32.9/-             N11/http2
206010000000014     demo.nok* IPv4    1      43.0.96.1/-             N11/http2
206010000000011     demo.nok* IPv4    1      43.0.32.8/-             N11/http2
206010000000017     demo.nok* IPv4    1      43.0.32.11/-            N11/http2
206010000000018     demo.nok* IPv4    1      43.0.96.5/-             N11/http2
206010000000012     demo.nok* IPv4    1      43.0.32.7/-             N11/http2
206010000000010     demo.nok* IPv4    1      43.0.96.2/-             N11/http2
206010000000009     demo.nok* IPv4    1      43.0.96.4/-             N11/http2
-------------------------------------------------------------------------------
Number of PDN instances : 10
```


```bash
*A:SMF2# show mobile-gateway pdn pdn-context
===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000015     demo.nok* IPv4    1      43.0.96.3/-             N11/http2
206010000000013     demo.nok* IPv4    1      43.0.32.10/-            N11/http2
206010000000016     demo.nok* IPv4    1      43.0.32.9/-             N11/http2
206010000000014     demo.nok* IPv4    1      43.0.96.1/-             N11/http2
206010000000011     demo.nok* IPv4    1      43.0.32.8/-             N11/http2
206010000000017     demo.nok* IPv4    1      43.0.32.11/-            N11/http2
206010000000018     demo.nok* IPv4    1      43.0.96.5/-             N11/http2
206010000000012     demo.nok* IPv4    1      43.0.32.7/-             N11/http2
206010000000010     demo.nok* IPv4    1      43.0.96.2/-             N11/http2
206010000000009     demo.nok* IPv4    1      43.0.96.4/-             N11/http2
-------------------------------------------------------------------------------
Number of PDN instances : 10
```
### 3.2. **Checking the UE IP setting **

Check the UE to verify that 10 IMSI are attached i.e.uesimtun0 to uesimtun9 are created

```bash
bash-5.1# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
13: uesimtun0: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.1/32 scope global uesimtun0
       valid_lft forever preferred_lft forever
    inet6 fe80::ca6:6418:5013:bd46/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
14: uesimtun1: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.7/32 scope global uesimtun1
       valid_lft forever preferred_lft forever
    inet6 fe80::1991:9cbb:8097:1f62/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
15: uesimtun2: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.2/32 scope global uesimtun2
       valid_lft forever preferred_lft forever
    inet6 fe80::29df:631e:5ad1:d1df/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
16: uesimtun3: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.8/32 scope global uesimtun3
       valid_lft forever preferred_lft forever
    inet6 fe80::3351:9b76:56d8:8a0f/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
17: uesimtun4: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.3/32 scope global uesimtun4
       valid_lft forever preferred_lft forever
    inet6 fe80::9034:dac0:a0c3:71b3/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
18: uesimtun5: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.9/32 scope global uesimtun5
       valid_lft forever preferred_lft forever
    inet6 fe80::242c:f059:840c:2361/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
19: uesimtun6: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.5/32 scope global uesimtun6
       valid_lft forever preferred_lft forever
    inet6 fe80::7c4c:28ec:677d:92f9/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
20: uesimtun7: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.11/32 scope global uesimtun7
       valid_lft forever preferred_lft forever
    inet6 fe80::8d9d:2411:319a:161a/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
21: uesimtun8: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.4/32 scope global uesimtun8
       valid_lft forever preferred_lft forever
    inet6 fe80::7dc2:f23a:11a:ee65/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
22: uesimtun9: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.32.10/32 scope global uesimtun9
       valid_lft forever preferred_lft forever
    inet6 fe80::c702:f859:ff4e:b707/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
1722: eth0@if1723: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:28:43 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.40.67/24 brd 192.168.40.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:2843/64 scope link
       valid_lft forever preferred_lft forever
1747: eth1@if1746: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:1a:7c:7b brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 10.90.1.2/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe1a:7c7b/64 scope link
       valid_lft forever preferred_lft forever 
```      

### 3.3. **checking the data-plane 

The UP are reached via the uesimtunx

```bash
bash-5.1# ip r
default via 192.168.40.1 dev eth0
1.1.1.0/24
        nexthop dev uesimtun0 weight 1
        nexthop dev uesimtun1 weight 1
        nexthop dev uesimtun2 weight 1 
        nexthop dev uesimtun3 weight 1
        nexthop dev uesimtun4 weight 1
        nexthop dev uesimtun5 weight 1
        nexthop dev uesimtun6 weight 1
        nexthop dev uesimtun7 weight 1
        nexthop dev uesimtun8 weight 1
        nexthop dev uesimtun9 weight 1
10.90.1.0/24 dev eth1 proto kernel scope link src 10.90.1.2
192.168.40.0/24 dev eth0 proto kernel scope link src 192.168.40.67
```

You can reach the UP-1 and UP2 from the UE, the odd UE are deployed on UP-1 1.1.1.101 and even UEs are deployed on UP-2 1.1.1.102

```bash
bash-5.1# ping 1.1.1.102 -I uesimtun0
PING 1.1.1.102 (1.1.1.102): 56 data bytes
64 bytes from 1.1.1.102: seq=0 ttl=64 time=22.121 ms
--- 1.1.1.102 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss

round-trip min/avg/max = 22.121/22.121/22.121 ms
bash-5.1# ping 1.1.1.101 -I uesimtun0
PING 1.1.1.101 (1.1.1.101): 56 data bytes
-- 1.1.1.101 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss

bash-5.1# ping 1.1.1.101 -I uesimtun1
PING 1.1.1.101 (1.1.1.101): 56 data bytes
64 bytes from 1.1.1.101: seq=0 ttl=64 time=38.207 ms
--- 1.1.1.101 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 38.207/38.207/38.207 ms

bash-5.1# ping 1.1.1.102 -I uesimtun1
PING 1.1.1.102 (1.1.1.102): 56 data bytes
--- 1.1.1.102 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss

```

### 3.3. **sessions load balancing**

The 10 IMSIs are load balanced over the 2 UPs

```bash
*A:UP-1# show service active-subscribers hierarchy
===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_536870925
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:60 - svc:500
           |   PFCP session-id      : 0x0000000000000008
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000012
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.7 - PFCP

-- _cups_536870927
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:70 - svc:500
           |   PFCP session-id      : 0x0000000000000009
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000011
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.8 - PFCP

-- _cups_536870928
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:90 - svc:500
           |   PFCP session-id      : 0x000000000000000b
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000013
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.10 - PFCP

-- _cups_536870929
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:80 - svc:500
           |   PFCP session-id      : 0x000000000000000a
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000016
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.9 - PFCP

-- _cups_536870932
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.8] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:04:00:a0 - svc:500
           |   PFCP session-id      : 0x000000000000000c
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000017
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.32.11 - PFCP

-------------------------------------------------------------------------------
Number of active subscribers : 5
```

The other 5 IMSIs are created on UP2

```bash
*A:UP2# show service active-subscribers
===============================================================================
Active Subscribers
===============================================================================
-------------------------------------------------------------------------------
Subscriber _cups_536870924
           (sub-fwa)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[pxc-1.b:1.16] - sla:sla-fwa
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
43.0.96.1
              00:03:00:08:00:00  0x0000000000000007 PFCP         500        Y
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Subscriber _cups_536870926
           (sub-fwa)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[pxc-1.b:1.16] - sla:sla-fwa
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
43.0.96.2
              00:03:00:08:00:10  0x0000000000000008 PFCP         500        Y
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Subscriber _cups_536870930
           (sub-fwa)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[pxc-1.b:1.16] - sla:sla-fwa
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
43.0.96.3
              00:03:00:08:00:20  0x0000000000000009 PFCP         500        Y
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Subscriber _cups_536870931
           (sub-fwa)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[pxc-1.b:1.16] - sla:sla-fwa
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
43.0.96.4
              00:03:00:08:00:30  0x000000000000000a PFCP         500        Y
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Subscriber _cups_536870933
           (sub-fwa)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(1) SLA Profile Instance sap:[pxc-1.b:1.16] - sla:sla-fwa
-------------------------------------------------------------------------------
IP Address
              MAC Address        Session            Origin       Svc        Fwd
-------------------------------------------------------------------------------
43.0.96.5
              00:03:00:08:00:40  0x000000000000000b PFCP         500        Y
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Number of active subscribers : 5

```

```
### 3.4.3 **general show commands**
General show commands to check the  MAG-c communciation with other elements i.e. UDM,AMF and NRF

#### 3.4.3.1 **The UDM info** 

```bash
A:SMF1# show mobile-gateway pdn service-stats nf-type udm
===============================================================================
UDM peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nudm-sdm
-------------------------------------------------------------------------------
Service Instance                              : udm-sdm1
NF instance ID                                : 132bf86c-fddb-41ef-8277-
                                                2b544ba6f1ba

Get SM Subscription Data
  Request Tx                                  : 64
  Response Success Rx                         : 64
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

Subscribe SDM Notification
  Request Tx                                  : 64
  Response Success Rx                         : 64
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

Unsubscribe SDM Notification
  Request Tx                                  : 0
  Response Success Rx                         : 0
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

SDM Notification
  Request Rx                                  : 0
  Response Success Tx                         : 0
  Response Fail Tx                            : 0
  Malformed Request Rx                        : 0
  Unknown Session Request Rx                  : 0

Number of SDM Subscriptions                   : 10
-------------------------------------------------------------------------------
Number of instances    : 1
-------------------------------------------------------------------------------
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nudm-uecm
-------------------------------------------------------------------------------
Service Instance                              : udm-uecm1
NF instance ID                                : 132bf86c-fddb-41ef-8277-
                                                2b544ba6f1ba

SMF Registration
  Request Tx                                  : 64
  Response Success Rx                         : 64
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

SMF Deregistration
  Request Tx                                  : 31
  Response Success Rx                         : 31
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0
-------------------------------------------------------------------------------
Number of instances    : 1
===============================================================================
```
#### 3.4.3.2 **The AMF info** 
The AMF Information can be shown as below

```bash
*A:SMF1# show mobile-gateway pdn service-stats nf-type amf
===============================================================================
AMF peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : namf-comm
-------------------------------------------------------------------------------
Service Instance       : namf-comm1
NF instance ID         : 13064c34-fddb-41ef-a24a-95054fdc4815
N1N2 Message Transfer  : 149
  N1 PDU Session Establishment Reject                    : 0
  N1 PDU Session Modification Command                    : 0
  N1 PDU Session Release Command                         : 85
  N2 PDU Session Resource Setup Request                  : 64
  N1 PDU Session Establishment Accept                    : 64
  N2 PDU Session Resource Modify Request                 : 0
  N2 PDU Session Resource Release Command                : 23
N1N2 Msg Transf Succ   : 118            N1N2 Msg Transf Fail   : 31
N1N2 Transf Fail Notif : 0
N1N2 Req Timed Out     : 0
EBI Assignment Req     : 0              EBI Assignment Succ    : 0
EBI Assignment Fail    : 0
EBI Asgn Req Timed Out : 0
Number Of Sessions     : 10
-------------------------------------------------------------------------------
Number of instances    : 1
-------------------------------------------------------------------------------
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nsmf-pdusession
-------------------------------------------------------------------------------
Service Instance       : nsmf_pdusession1
NF instance ID         : unknown
Create SM Ctx Req      : 0
  N1 PDU Session Establishment Request                   : 0
  N2 Handover Required                                   : 0
  N2 Path Switch Request                                 : 0
Create SM Ctx Succ     : 0
  N2 PDU Session Resource Setup Request                  : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Path Switch Request Unsuccessful                    : 0
Create SM Ctx Fail     : 0
  N1 PDU Session Establishment Reject                    : 0
  N1 5GSM Status                                         : 0
Update SM Ctx Req      : 4
  N1 PDU Session Modification Request                    : 0
  N1 PDU Session Modification Complete                   : 0
  N1 PDU Session Modification Command Reject             : 0
  N1 PDU Session Release Request                         : 0
  N1 PDU Session Release Complete                        : 4
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Setup Response                 : 0
  N2 PDU Session Resource Setup Unsuccessful             : 0
  N2 PDU Session Resource Notify                         : 0
  N2 PDU Session Resource Modify Indication              : 0
  N2 PDU Session Resource Modify Response                : 0
  N2 PDU Session Resource Modify Unsuccessful            : 0
  N2 PDU Session Resource Release Response               : 0
  N2 PDU Session Resource Notify Released                : 0
  N2 Path Switch Request                                 : 0
  N2 Path Switch Request Setup Failed                    : 0
  N2 Handover Required                                   : 0
  N2 Handover Request Acknowledge                        : 0
  N2 Handover Resource Allocation Unsuccessful           : 0
  With HoState Completed                                 : 0
  With HoState Cancelled                                 : 0
  With upCnxState Activating                             : 0
  With upCnxState Deactivated                            : 0
  With amfId change                                      : 0
  With dataForwarding True                               : 0
  With dataForwarding False                              : 0
  With release due to reactivation                       : 0
  With release due to duplicate session Id               : 0
  With release due to slice not available                : 0
  With AN not responding                                 : 0
Update SM Ctx Succ     : 0
  N1 PDU Session Modification Command                    : 0
  N1 PDU Session Release Command                         : 0
  N1 PDU Session Establishment Reject                    : 0
  N2 PDU Session Resource Setup Request                  : 0
  N2 PDU Session Resource Modify Confirm                 : 0
  N2 PDU Session Resource Modify Request                 : 0
  N2 PDU Session Resource Release Command                : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Handover Command                                    : 0
  With upCnxState Deactivated                            : 0
Update SM Ctx Fail     : 4
  N1 PDU Session Modification Reject                     : 0
  N1 PDU Session Release Reject                          : 0
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Modify Indication Unsuccessful : 0
  N2 Path Switch Request Unsuccessful                    : 0
  N2 Handover Preparation Unsuccessful                   : 0
Release SM Ctx Req     : 0
  With PDU session status mismatch                       : 0
Release SM Ctx Succ    : 0              Release SM Ctx Fail    : 0
SM Ctx Stat Notif      : 0              SM Ctx Stat Notif Succ : 0
SM Ctx Stat Notif Fail : 0
Retrieve SM Ctx Req    : 0              Retrieve SM Ctx Succ   : 0
Retrieve SM Ctx Fail   : 0
Number Of Sessions     : 0
-------------------------------------------------------------------------------
Service Instance       : nsmf_pdusession1
NF instance ID         : 13064c34-fddb-41ef-a24a-95054fdc4815
Create SM Ctx Req      : 64
  N1 PDU Session Establishment Request                   : 64
  N2 Handover Required                                   : 0
  N2 Path Switch Request                                 : 0
Create SM Ctx Succ     : 64
  N2 PDU Session Resource Setup Request                  : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Path Switch Request Unsuccessful                    : 0
Create SM Ctx Fail     : 0
  N1 PDU Session Establishment Reject                    : 0
  N1 5GSM Status                                         : 0
Update SM Ctx Req      : 137
  N1 PDU Session Modification Request                    : 0
  N1 PDU Session Modification Complete                   : 0
  N1 PDU Session Modification Command Reject             : 0
  N1 PDU Session Release Request                         : 0
  N1 PDU Session Release Complete                        : 19
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Setup Response                 : 64
  N2 PDU Session Resource Setup Unsuccessful             : 0
  N2 PDU Session Resource Notify                         : 0
  N2 PDU Session Resource Modify Indication              : 0
  N2 PDU Session Resource Modify Response                : 0
  N2 PDU Session Resource Modify Unsuccessful            : 0
  N2 PDU Session Resource Release Response               : 23
  N2 PDU Session Resource Notify Released                : 0
  N2 Path Switch Request                                 : 0
  N2 Path Switch Request Setup Failed                    : 0
  N2 Handover Required                                   : 0
  N2 Handover Request Acknowledge                        : 0
  N2 Handover Resource Allocation Unsuccessful           : 0
  With HoState Completed                                 : 0
  With HoState Cancelled                                 : 0
  With upCnxState Activating                             : 0
  With upCnxState Deactivated                            : 31
  With amfId change                                      : 0
  With dataForwarding True                               : 0
  With dataForwarding False                              : 0
  With release due to reactivation                       : 0
  With release due to duplicate session Id               : 0
  With release due to slice not available                : 0
  With AN not responding                                 : 0
Update SM Ctx Succ     : 133
  N1 PDU Session Modification Command                    : 0
  N1 PDU Session Release Command                         : 0
  N1 PDU Session Establishment Reject                    : 0
  N2 PDU Session Resource Setup Request                  : 0
  N2 PDU Session Resource Modify Confirm                 : 0
  N2 PDU Session Resource Modify Request                 : 0
  N2 PDU Session Resource Release Command                : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Handover Command                                    : 0
  With upCnxState Deactivated                            : 31
Update SM Ctx Fail     : 4
  N1 PDU Session Modification Reject                     : 0
  N1 PDU Session Release Reject                          : 0
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Modify Indication Unsuccessful : 0
  N2 Path Switch Request Unsuccessful                    : 0
  N2 Handover Preparation Unsuccessful                   : 0
Release SM Ctx Req     : 0
  With PDU session status mismatch                       : 0
Release SM Ctx Succ    : 0              Release SM Ctx Fail    : 0
SM Ctx Stat Notif      : 46             SM Ctx Stat Notif Succ : 15
SM Ctx Stat Notif Fail : 31
Retrieve SM Ctx Req    : 0              Retrieve SM Ctx Succ   : 0
Retrieve SM Ctx Fail   : 0
Number Of Sessions     : 10
-------------------------------------------------------------------------------
Number of instances    : 2
===============================================================================
```
#### 3.4.3.3 **The NRF info** 
The NRF Information can be shown as below

```bash
*A:SMF1# show mobile-gateway pdn service-stats nf-type nrf
===============================================================================
NRF peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nnrf-nfm
-------------------------------------------------------------------------------
Service Instance       : nnrf_nfm1
NF instance ID         : dbc0409c-8b91-4aaa-8727-3cd7e354e7ac

Registered             : Yes, 03/10/2025 18:22:52
Heartbeat Interval     : 10

NF Register            : 1
NF Register Failures   : 0

NF Update Partial      : 1
NF Update Partial Fail : 0

NF Heartbeat           : 1053
NF Heartbeat Failures  : 0

NF Update Full         : 0
NF Update Full Fail    : 0

NF Deregister          : 0
NF Deregister Failures : 0

NF Status Subscribe    : 25
NF Status Subscrb Fail : 25
NF Status Subs Update  : 0
NF .. Subs Update Fail : 0
AMF Status Subscribe   : 7              UDM Status Subscribe   : 18
PCF Status Subscribe   : 0              CHF Status Subscribe   : 0

NF Status UnSubscribe  : 0
NF Status UnSubsc Fail : 0
AMF Status UnSubscribe : 0              UDM Status UnSubscribe : 0
PCF Status UnSubscribe : 0              CHF Status UnSubscribe : 0

NF Status Notify       : 0
NF Status Notify Fail  : 0
AMF Deregister Notify  : 0              AMF Failure Notify     : 0
AMF Restart Notify     : 0              AMF Service Fail Notify: 0
UDM Deregister Notify  : 0              UDM Failure Notify     : 0
UDM Restart Notify     : 0              UDM Service Fail Notify: 0
PCF Deregister Notify  : 0              PCF Failure Notify     : 0
PCF Restart Notify     : 0              PCF Service Fail Notify: 0
CHF Deregister Notify  : 0              CHF Failure Notify     : 0
CHF Restart Notify     : 0              CHF Service Fail Notify: 0
-------------------------------------------------------------------------------
Number of instances    : 2
-------------------------------------------------------------------------------
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nnrf-disc
-------------------------------------------------------------------------------
Service Instance       : nnrf_disc1
NF instance ID         : dbc0409c-8b91-4aaa-8727-3cd7e354e7ac

Cache Validity receive : 0              Cache Validity applied : 0

NF Discovery           : 25             NF Discovery Pending   : 0
NF Discovery Failures  : 0
AMF Discovery          : 7              AMF Discovery Pending  : 0
AMF Discovery Failures : 0
UDM Discovery          : 18             UDM Discovery Pending  : 0
UDM Discovery Failures : 0
PCF Discovery          : 0              PCF Discovery Pending  : 0
PCF Discovery Failures : 0
CHF Discovery          : 0              CHF Discovery Pending  : 0
CHF Discovery Failures : 0
-------------------------------------------------------------------------------
Number of instances    : 1
===============================================================================
```






#### 3.4.3.4 **stopping the session** 
You can stop the 5G session using this script

```bash
[root@compute-1 scripts]# ./stop_5g_cups.sh
PID   USER     TIME  COMMAND
    1 root      0:00 /bin/bash
   72 root      0:00 ps -ef
PID   USER     TIME  COMMAND
    1 root      0:00 /bin/bash
   63 root      0:00 bash
  213 root      0:00 ps -ef
  
```

Also a clear command from MAG-C can be used
```bash
*A:SMF1# clear mobile-gateway pdn 1 bearer-context imsi 206010000000009
```
