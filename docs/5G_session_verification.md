## 1.   **start the 5G session**
----
### 1.1. start 1 5G session
use the below script to start 1 session, we jave later another example for 10 IMSIs
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
## 2. **checking the logs**:    
you can check the logs for the open5GS and UERANSIM
```bash
[root@compute-1 logs]# ls
amf.log   bsf.log  nrf.log   pcf.log   udm.log  ue1.log
ausf.log  gnb.log  nssf.log  pcrf.log  udr.log
```
###2.1. **checking the NRF** 
The NRF showing that elements are registered to it i.e. MAG-C,AMF,UDM.....
```bash
[root@compute-1 logs]# more nrf.log
Open5GS daemon v2.7.1
03/10 18:11:23.058: [app] INFO: Configuration: '/opt/open5gs/etc/open5gs/nrf.yaml' (../lib/app/o
gs-init.c:133)
03/10 18:11:23.058: [app] INFO: File Logging: '/opt/open5gs/var/log/open5gs/nrf.log' (../lib/app
/ogs-init.c:136)
03/10 18:11:23.061: [sbi] INFO: nghttp2_server() [http://10.40.1.2]:8080 (../lib/sbi/nghttp2-ser
ver.c:414)
03/10 18:11:23.067: [nrf] INFO: [13050e28-fddb-41ef-8060-f1f318ecdc6f] NF registered [Heartbeat:
10s] (../src/nrf/nf-sm.c:192)
03/10 18:11:23.068: [app] INFO: NRF initialize...done (../src/nrf/app.c:31)
03/10 18:11:23.068: [nrf] INFO: [13064c34-fddb-41ef-a24a-95054fdc4815] NF registered [Heartbeat:
10s] (../src/nrf/nf-sm.c:192)
03/10 18:11:23.075: [nrf] INFO: [13086262-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075680+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.075: [nrf] INFO: [13086938-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075830+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.075: [nrf] INFO: [13086d34-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075931+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [1308713a-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076034+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [13087504-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076130+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [1308793c-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076240+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [13087d6a-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076345+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [13088846-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076626+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.076: [nrf] INFO: [13088bb6-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076712+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.347: [nrf] INFO: [132bf86c-fddb-41ef-8277-2b544ba6f1ba] NF registered [Heartbeat:
10s] (../src/nrf/nf-sm.c:192)
03/10 18:11:23.351: [nrf] INFO: [13326d46-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.351190+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
03/10 18:11:23.351: [nrf] INFO: [13327214-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.351313+00:00 [validity_duration:86400] (../src/nrf/nnrf-handler.c:446)
```
### 2.2. **checking the GNB logs**
The GNB log showing that NGAP is ok with the AMF and NGAP is done successfully
```bash
[root@compute-1 logs]# more gnb.log
UERANSIM v3.2.6
[2025-03-10 18:25:19.611] [sctp] [info] Trying to establish SCTP connection... (10.50.1.2:38412)
[2025-03-10 18:25:19.630] [sctp] [info] SCTP connection established (10.50.1.2:38412)
[2025-03-10 18:25:19.639] [sctp] [debug] SCTP association setup ascId[105]
[2025-03-10 18:25:19.639] [ngap] [debug] Sending NG Setup Request
[2025-03-10 18:25:19.650] [ngap] [debug] NG Setup Response received
[2025-03-10 18:25:19.650] [ngap] [info] NG Setup procedure is successful
[2025-03-10 18:25:20.030] [rrc] [debug] UE[1] new signal detected
[2025-03-10 18:25:20.075] [rrc] [info] RRC Setup for UE[1]
[2025-03-10 18:25:20.097] [ngap] [debug] Initial NAS message received from UE[1]
[2025-03-10 18:25:20.245] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:25:22.069] [ngap] [info] PDU session resource(s) setup for UE[1] count[1]
```
### 2.3. **checking the UE logs**

UE1 log showing that the session is created with uesimtun0 and IP 43.0.32.1
```bash
[root@compute-1 logs]# more ue1.log
UERANSIM v3.2.6
[2025-03-10 18:25:20.022] [nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:25:20.035] [rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:25:20.046] [nas] [info] Selected plmn[206/01]
[2025-03-10 18:25:20.053] [rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:25:20.053] [nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:25:20.053] [nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:25:20.053] [nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:25:20.075] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:25:20.075] [nas] [debug] Sending Initial Registration
[2025-03-10 18:25:20.075] [nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:25:20.075] [rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:25:20.086] [rrc] [info] RRC connection established
[2025-03-10 18:25:20.086] [rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:25:20.086] [nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:25:20.143] [nas] [debug] Authentication Request received
[2025-03-10 18:25:20.143] [nas] [debug] Sending Authentication Failure due to SQN out of range
[2025-03-10 18:25:20.168] [nas] [debug] Authentication Request received
[2025-03-10 18:25:20.208] [nas] [debug] Security Mode Command received2
[2025-03-10 18:25:20.208] [nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:25:20.246] [nas] [debug] Registration accept received
[2025-03-10 18:25:20.246] [nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:25:20.246] [nas] [debug] Sending Registration Complete
[2025-03-10 18:25:20.246] [nas] [info] Initial Registration is successful
[2025-03-10 18:25:20.246] [nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:25:20.258] [nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:25:20.469] [nas] [debug] Configuration Update Command received
[2025-03-10 18:25:22.069] [nas] [debug] PDU 2Session Establishment Accept received
[2025-03-10 18:25:22.069] [nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:25:22.395] [app] [info] Connection setup for PDU session[1] is successful, TUN in
terface[uesimtun0, 43.0.32.1] is up.
```
### 2.4. **checking the AMF logs**
AMF log showing that the session is created
```bash
[root@compute-1 logs]# more amf.log
Open5GS daemon v2.7.1

03/10 18:11:23.054: [app] INFO: Configuration: '/opt/open5gs/etc/open5gs/amf.yaml' (../lib/app/ogs-init.c:133)
03/10 18:11:23.054: [app] INFO: File Logging: '/opt/open5gs/var/log/open5gs/amf.log' (../lib/app/ogs-init.c:136)
03/10 18:11:23.065: [metrics] INFO: metrics_server() [http://10.110.1.6]:9090 (../lib/metrics/prometheus/context.c:299)
03/10 18:11:23.065: [sbi] INFO: NF Service [namf-comm] (../lib/sbi/context.c:1841)
03/10 18:11:23.066: [sbi] INFO: nghttp2_server() [http://10.40.1.5]:8080 (../lib/sbi/nghttp2-server.c:414)
03/10 18:11:23.066: [amf] INFO: ngap_server() [10.50.1.2]:38412 (../src/amf/ngap-sctp.c:61)
03/10 18:11:23.067: [sctp] INFO: AMF initialize...done (../src/amf/app.c:33)
03/10 18:11:23.074: [sbi] INFO: [13064c34-fddb-41ef-a24a-95054fdc4815] NF registered [Heartbeat:10s] (../lib/sbi/nf-sm.c:221)
03/10 18:11:23.079: [sbi] INFO: [13086262-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075680+00:00 [duration:86400,validity:86399.996515,patch:43199.998257] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.079: [sbi] INFO: [13086938-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075830+00:00 [duration:86400,validity:86399.996078,patch:43199.998039] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.079: [sbi] INFO: [13086d34-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.075931+00:00 [duration:86400,validity:86399.996074,patch:43199.998037] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.079: [sbi] INFO: [1308713a-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076034+00:00 [duration:86400,validity:86399.996096,patch:43199.998048] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.080: [sbi] INFO: [13087504-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076130+00:00 [duration:86400,validity:86399.996117,patch:43199.998058] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.080: [sbi] INFO: [1308793c-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076240+00:00 [duration:86400,validity:86399.996153,patch:43199.998076] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.080: [sbi] INFO: [13087d6a-fddb-41ef-8fd6-fb368622a690] Subscription created unti
l 2025-03-11T18:11:23.076345+00:00 [duration:86400,validity:86399.996139,patch:43199.998069] (../lib/sbi/nnrf-handler.c:813)
03/10 18:11:23.349: [sbi] INFO: (NRF-notify) NF registered [132bf86c-fddb-41ef-8277-2b544ba6f1ba:1] (../lib/sbi/nnrf-handler.c:1058)
03/10 18:11:23.349: [sbi] INFO: [UDM] (NRF-notify) NF Profile updated [132bf86c-fddb-41ef-8277-2b544ba6f1ba:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:11:23.350: [sbi] WARNING: [UDM] (NRF-notify) NF has already been added [132bf86c-fddb-41ef-8277-2b544ba6f1ba:1] (../lib/sbi/nnrf-handler.c:1061)
03/10 18:11:23.350: [sbi] INFO: [UDM] (NRF-notify) NF Profile updated [132bf86c-fddb-41ef-8277-2b544ba6f1ba:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:11:23.350: [sbi] WARNING: NF EndPoint(addr) updated [10.40.1.4:80] (../lib/sbi/context.c:2210)
03/10 18:11:23.350: [sbi] WARNING: NF EndPoint(addr) updated [10.40.1.4:8080] (../lib/sbi/context.c:1946)
03/10 18:11:24.206: [sbi] INFO: (NRF-notify) NF registered [13b3f802-fddb-41ef-86db-c9fba5b52990:1] (../lib/sbi/nnrf-handler.c:1058)
03/10 18:11:24.206: [sbi] INFO: [NSSF] (NRF-notify) NF Profile updated [13b3f802-fddb-41ef-86db-c9fba5b52990:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:11:24.442: [sbi] INFO: (NRF-notify) NF registered [13c9b4a8-fddb-41ef-95b6-69f4d9a36783:1] (../lib/sbi/nnrf-handler.c:1058)
03/10 18:11:24.442: [sbi] INFO: [PCF] (NRF-notify) NF Profile updated [13c9b4a8-fddb-41ef-95b6-69f4d9a36783:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:11:45.381: [sbi] INFO: (NRF-notify) NF registered [20a0a0a0-4043-4000-8864-30000ce4b5c7:1] (../lib/sbi/nnrf-handler.c:1058)
03/10 18:11:45.381: [sbi] INFO: [SMF] (NRF-notify) NF Profile updated [20a0a0a0-4043-4000-8864-30000ce4b5c7:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:22:49.754: [sbi] INFO: [SMF] (NRF-notify) NF_DEREGISTERED event [20a0a0a0-4043-4000-8864-30000ce4b5c7:1] (../lib/sbi/nnrf-handler.c:1104)
03/10 18:22:52.659: [sbi] INFO: (NRF-notify) NF registered [10a0a0a0-8441-4000-8280-30000ac4b5c7:1] (../lib/sbi/nnrf-handler.c:1058)
03/10 18:22:52.659: [sbi] INFO: [SMF] (NRF-notify) NF Profile updated [10a0a0a0-8441-4000-8280-30000ac4b5c7:1] (../lib/sbi/nnrf-handler.c:1072)
03/10 18:25:19.620: [amf] INFO: gNB-N2 accepted[10.50.1.10]:48477 in ng-path module (../src/amf/ngap-sctp.c:113)
03/10 18:25:19.620: [amf] INFO: gNB-N2 accepted[10.50.1.10] in master_sm module (../src/amf/amf-sm.c:757)
03/10 18:25:19.628: [amf] INFO: [Added] Number of gNBs is now 1 (../src/amf/context.c:1236)
03/10 18:25:19.628: [amf] INFO: gNB-N2[10.50.1.10] max_num_of_ostreams : 10 (../src/amf/amf-sm.c:796)
03/10 18:25:20.097: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 18:25:20.097: [amf] INFO: [Added] Number of gNB-UEs is now 1 (../src/amf/context.c:2662)
03/10 18:25:20.097: [amf] INFO:     RAN_UE_NGAP_ID[1] AMF_UE_NGAP_ID[1] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 18:25:20.097: [amf] INFO: [suci-0-206-01-0000-0-0-0000000002] Unknown UE by SUCI (../src/amf/context.c:1844)
03/10 18:25:20.097: [amf] INFO: [Added] Number of AMF-UEs is now 1 (../src/amf/context.c:1621)
03/10 18:25:20.097: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 18:25:20.097: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000002]    SUCI (../src/amf/gmm-handler.c:172)
03/10 18:25:20.097: [sbi] WARNING: Try to discover [nausf-auth] (../lib/sbi/path.c:528)
03/10 18:25:20.099: [sbi] INFO: [NULL] (NRF-discover) NF registered [13050e28-fddb-41ef-8060-f1f318ecdc6f:1] (../lib/sbi/nnrf-handler.c:1187)
03/10 18:25:20.099: [sbi] INFO: [AUSF] (NF-discover) NF Profile updated [13050e28-fddb-41ef-8060-f1f318ecdc6f:1] (../lib/sbi/nnrf-handler.c:1230)
03/10 18:25:20.143: [gmm] WARNING: Authentication failure(Synch failure) (../src/amf/gmm-sm.c:1719)
03/10 18:25:20.158: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 18:25:20.245: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.4:8080] (../src/amf/npcf-handler.c:143)
03/10 18:25:20.453: [gmm] INFO: [imsi-206010000000002] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 18:25:20.453: [amf] INFO: [imsi-206010000000002] Configuration update command (../src/amf/nas-path.c:591)
03/10 18:25:20.453: [gmm] INFO:     UTC [2025-03-10T18:25:20] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 18:25:20.453: [gmm] INFO:     LOCAL [2025-03-10T18:25:20] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 18:25:20.453: [amf] INFO: [Added] Number of AMF-Sessions is now 1 (../src/amf/context.c:2683)
03/10 18:25:20.453: [gmm] INFO: UE SUPI[imsi-206010000000002] DNN[demo.nokia.mnc001.mcc206.gprs]
 S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 18:25:20.453: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 18:25:22.412: [amf] INFO: [imsi-206010000000002:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
```    
    
### 2.5. **clearing the logs**

clear the logs before starting 10 IMSIs
```bash
[root@compute-1 scripts]# ./clear_logs.sh
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
### 3.4. **checking the logs**

logs can be checked as before

### 3.4.1 **checking the GNB logs**

```bash
[root@compute-1 logs]# more gnb.log
UERANSIM v3.2.6
[2025-03-10 18:50:39.262] [sctp] [info] Trying to establish SCTP connection... (10.50.1.2:38412)
[2025-03-10 18:50:39.272] [sctp] [info] SCTP connection established (10.50.1.2:38412)
[2025-03-10 18:50:39.274] [sctp] [debug] SCTP association setup ascId[109]
[2025-03-10 18:50:39.285] [ngap] [debug] Sending NG Setup Request
[2025-03-10 18:50:39.307] [ngap] [debug] NG Setup Response received
[2025-03-10 18:50:39.307] [ngap] [info] NG Setup procedure is successful
[2025-03-10 18:50:39.535] [rrc] [debug] UE[1] new signal detected
[2025-03-10 18:50:39.537] [rrc] [debug] UE[2] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[3] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[4] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[5] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[6] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[7] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[8] new signal detected
[2025-03-10 18:50:39.557] [rrc] [debug] UE[9] new signal detected
[2025-03-10 18:50:39.558] [rrc] [debug] UE[10] new signal detected
[2025-03-10 18:50:39.573] [rrc] [info] RRC Setup for UE[5]
[2025-03-10 18:50:39.573] [rrc] [info] RRC Setup for UE[9]
[2025-03-10 18:50:39.577] [ngap] [debug] Initial NAS message received from UE[5]
[2025-03-10 18:50:39.577] [ngap] [debug] Initial NAS message received from UE[9]
[2025-03-10 18:50:39.577] [rrc] [info] RRC Setup for UE[6]
[2025-03-10 18:50:39.577] [rrc] [info] RRC Setup for UE[7]
[2025-03-10 18:50:39.577] [rrc] [info] RRC Setup for UE[2]
[2025-03-10 18:50:39.578] [rrc] [info] RRC Setup for UE[1]
[2025-03-10 18:50:39.578] [ngap] [debug] Initial NAS message received from UE[6]
[2025-03-10 18:50:39.578] [ngap] [debug] Initial NAS message received from UE[1]
[2025-03-10 18:50:39.578] [ngap] [debug] Initial NAS message received from UE[7]
[2025-03-10 18:50:39.589] [rrc] [info] RRC Setup for UE[10]
[2025-03-10 18:50:39.589] [rrc] [info] RRC Setup for UE[4]
[2025-03-10 18:50:39.589] [ngap] [debug] Initial NAS message received from UE[2]
[2025-03-10 18:50:39.609] [rrc] [info] RRC Setup for UE[3]
[2025-03-10 18:50:39.609] [rrc] [info] RRC Setup for UE[8]
[2025-03-10 18:50:39.609] [ngap] [debug] Initial NAS message received from UE[10]
[2025-03-10 18:50:39.609] [ngap] [debug] Initial NAS message received from UE[4]
[2025-03-10 18:50:39.609] [ngap] [debug] Initial NAS message received from UE[3]
[2025-03-10 18:50:39.609] [ngap] [debug] Initial NAS message received from UE[8]
[2025-03-10 18:50:39.676] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.722] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.725] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.725] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.725] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.740] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.740] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.740] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.758] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:39.758] [ngap] [debug] Initial Context Setup Request received
[2025-03-10 18:50:40.290] [ngap] [info] PDU session resource(s) setup for UE[1] count[1]
[2025-03-10 18:50:40.298] [ngap] [info] PDU session resource(s) setup for UE[7] count[1]
[2025-03-10 18:50:40.342] [ngap] [info] PDU session resource(s) setup for UE[6] count[1]
[2025-03-10 18:50:40.365] [ngap] [info] PDU session resource(s) setup for UE[9] count[1]
[2025-03-10 18:50:40.488] [ngap] [info] PDU session resource(s) setup for UE[10] count[1]
[2025-03-10 18:50:40.496] [ngap] [info] PDU session resource(s) setup for UE[2] count[1]
[2025-03-10 18:50:40.504] [ngap] [info] PDU session resource(s) setup for UE[4] count[1]
[2025-03-10 18:50:40.523] [ngap] [info] PDU session resource(s) setup for UE[3] count[1]
[2025-03-10 18:50:40.553] [ngap] [info] PDU session resource(s) setup for UE[5] count[1]
[2025-03-10 18:50:40.587] [ngap] [info] PDU session resource(s) setup for UE[8] count[1
```


### 3.4.2 **checking the UE logs**

The UE logs shows the 10 IMSIs are attached

```bash
[root@compute-1 logs]# more ue1.log
UERANSIM v3.2.6
[2025-03-10 18:50:39.527] [206010000000018|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.535] [206010000000016|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.535] [206010000000014|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.546] [206010000000014|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.546] [206010000000016|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.546] [206010000000017|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000010|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000014|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.547] [206010000000014|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.547] [206010000000014|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.547] [206010000000014|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.547] [206010000000014|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.547] [206010000000013|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000017|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.547] [206010000000012|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000009|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000015|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.547] [206010000000009|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.552] [206010000000013|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.552] [206010000000011|nas] [info] UE switches to state [MM-DEREGISTERED/PLMN-SEARCH]
[2025-03-10 18:50:39.552] [206010000000012|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.552] [206010000000011|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.557] [206010000000018|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.557] [206010000000010|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.557] [206010000000016|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.557] [206010000000016|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.557] [206010000000016|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.557] [206010000000016|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.557] [206010000000016|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.562] [206010000000011|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.562] [206010000000011|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.562] [206010000000011|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.562] [206010000000011|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.562] [206010000000011|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.570] [206010000000010|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.570] [206010000000017|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.571] [206010000000017|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.572] [206010000000017|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.572] [206010000000017|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.572] [206010000000017|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.572] [206010000000017|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.572] [206010000000010|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.572] [206010000000017|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.572] [206010000000010|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.572] [206010000000010|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.572] [206010000000010|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.572] [206010000000017|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.572] [206010000000017|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.573] [206010000000011|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.573] [206010000000011|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.573] [206010000000011|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.573] [206010000000011|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.573] [206010000000017|rrc] [info] RRC connection established
[2025-03-10 18:50:39.573] [206010000000017|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.573] [206010000000017|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.573] [206010000000011|rrc] [info] RRC connection established
[2025-03-10 18:50:39.573] [206010000000011|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.573] [206010000000011|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.574] [206010000000012|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.574] [206010000000012|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.574] [206010000000012|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.574] [206010000000012|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.574] [206010000000012|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.574] [206010000000012|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.574] [206010000000012|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.574] [206010000000012|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.574] [206010000000012|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.577] [206010000000010|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.577] [206010000000010|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.577] [206010000000010|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.577] [206010000000010|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.557] [206010000000014|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.577] [206010000000014|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.577] [206010000000014|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.577] [206010000000014|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.577] [206010000000016|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.577] [206010000000016|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.577] [206010000000016|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.577] [206010000000016|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.577] [206010000000015|rrc] [debug] New signal detected for cell[1], total [1] cells in coverage
[2025-03-10 18:50:39.578] [206010000000010|rrc] [info] RRC connection established
[2025-03-10 18:50:39.578] [206010000000010|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.578] [206010000000010|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.578] [206010000000012|rrc] [info] RRC connection established
[2025-03-10 18:50:39.578] [206010000000012|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.578] [206010000000014|rrc] [info] RRC connection established
[2025-03-10 18:50:39.578] [206010000000014|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.578] [206010000000014|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.579] [206010000000016|rrc] [info] RRC connection established
[2025-03-10 18:50:39.579] [206010000000016|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.580] [206010000000016|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.581] [206010000000015|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.581] [206010000000015|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.581] [206010000000015|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.581] [206010000000015|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.581] [206010000000015|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.581] [206010000000015|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.581] [206010000000015|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.581] [206010000000015|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.581] [206010000000015|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.582] [206010000000013|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.583] [206010000000013|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.583] [206010000000013|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.583] [206010000000013|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.583] [206010000000013|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.583] [206010000000013|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.583] [206010000000013|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.583] [206010000000013|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.583] [206010000000013|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.584] [206010000000009|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.585] [206010000000012|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.585] [206010000000009|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.585] [206010000000009|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.585] [206010000000009|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.585] [206010000000009|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.587] [206010000000018|nas] [info] Selected plmn[206/01]
[2025-03-10 18:50:39.587] [206010000000018|rrc] [info] Selected cell plmn[206/01] tac[1] category[SUITABLE]
[2025-03-10 18:50:39.587] [206010000000018|nas] [info] UE switches to state [MM-DEREGISTERED/PS]
[2025-03-10 18:50:39.587] [206010000000018|nas] [info] UE switches to state [MM-DEREGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.587] [206010000000018|nas] [debug] Initial registration required due to [MM-DEREG-NORMAL-SERVICE]
[2025-03-10 18:50:39.588] [206010000000018|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.588] [206010000000018|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.588] [206010000000018|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.588] [206010000000018|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.589] [206010000000017|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.597] [206010000000015|rrc] [info] RRC connection established
[2025-03-10 18:50:39.597] [206010000000015|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.597] [206010000000015|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.608] [206010000000013|rrc] [info] RRC connection established
[2025-03-10 18:50:39.608] [206010000000013|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.608] [206010000000013|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.608] [206010000000009|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.608] [206010000000009|nas] [debug] Sending Initial Registration
[2025-03-10 18:50:39.608] [206010000000009|nas] [info] UE switches to state [MM-REGISTER-INITIATED]
[2025-03-10 18:50:39.608] [206010000000009|rrc] [debug] Sending RRC Setup Request
[2025-03-10 18:50:39.609] [206010000000018|rrc] [info] RRC connection established
[2025-03-10 18:50:39.609] [206010000000018|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.609] [206010000000009|rrc] [info] RRC connection established
[2025-03-10 18:50:39.609] [206010000000009|rrc] [info] UE switches to state [RRC-CONNECTED]
[2025-03-10 18:50:39.609] [206010000000009|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.614] [206010000000018|nas] [info] UE switches to state [CM-CONNECTED]
[2025-03-10 18:50:39.625] [206010000000010|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.625] [206010000000014|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.625] [206010000000011|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.625] [206010000000012|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.636] [206010000000013|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.645] [206010000000018|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.646] [206010000000014|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.646] [206010000000014|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.646] [206010000000012|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.646] [206010000000012|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.646] [206010000000011|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.646] [206010000000011|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.654] [206010000000016|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.654] [206010000000017|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.654] [206010000000017|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.654] [206010000000010|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.654] [206010000000010|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.654] [206010000000015|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.659] [206010000000013|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.659] [206010000000013|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.659] [206010000000009|nas] [debug] Authentication Request received
[2025-03-10 18:50:39.672] [206010000000016|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.672] [206010000000016|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.673] [206010000000015|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.673] [206010000000015|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.676] [206010000000014|nas] [debug] Registration accept received
[2025-03-10 18:50:39.676] [206010000000014|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.676] [206010000000014|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.676] [206010000000014|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.676] [206010000000014|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.676] [206010000000014|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.685] [206010000000018|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.685] [206010000000018|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.688] [206010000000009|nas] [debug] Security Mode Command received
[2025-03-10 18:50:39.688] [206010000000009|nas] [debug] Selected integrity[2] ciphering[0]
[2025-03-10 18:50:39.696] [206010000000014|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.723] [206010000000012|nas] [debug] Registration accept received
[2025-03-10 18:50:39.723] [206010000000012|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.723] [206010000000012|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.723] [206010000000012|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.723] [206010000000012|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.725] [206010000000010|nas] [debug] Registration accept received
[2025-03-10 18:50:39.725] [206010000000010|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.725] [206010000000010|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.725] [206010000000010|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.726] [206010000000010|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.727] [206010000000012|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.729] [206010000000017|nas] [debug] Registration accept received
[2025-03-10 18:50:39.729] [206010000000017|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.729] [206010000000017|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.729] [206010000000017|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.729] [206010000000017|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.738] [206010000000010|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.738] [206010000000011|nas] [debug] Registration accept received
[2025-03-10 18:50:39.738] [206010000000011|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.738] [206010000000011|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.738] [206010000000011|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.738] [206010000000011|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.740] [206010000000016|nas] [debug] Registration accept received
[2025-03-10 18:50:39.740] [206010000000016|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.740] [206010000000016|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.740] [206010000000016|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.740] [206010000000016|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.743] [206010000000011|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.751] [206010000000013|nas] [debug] Registration accept received
[2025-03-10 18:50:39.751] [206010000000013|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.751] [206010000000013|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.751] [206010000000013|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.751] [206010000000013|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.751] [206010000000015|nas] [debug] Registration accept received
[2025-03-10 18:50:39.751] [206010000000015|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.751] [206010000000015|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.751] [206010000000015|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.751] [206010000000015|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.758] [206010000000013|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.758] [206010000000016|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.758] [206010000000017|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.758] [206010000000012|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.758] [206010000000009|nas] [debug] Registration accept received
[2025-03-10 18:50:39.759] [206010000000009|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.759] [206010000000009|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.759] [206010000000009|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.759] [206010000000009|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.759] [206010000000009|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.759] [206010000000015|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.759] [206010000000017|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.759] [206010000000010|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.759] [206010000000011|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.760] [206010000000018|nas] [debug] Registration accept received
[2025-03-10 18:50:39.760] [206010000000018|nas] [info] UE switches to state [MM-REGISTERED/NORMAL-SERVICE]
[2025-03-10 18:50:39.760] [206010000000018|nas] [debug] Sending Registration Complete
[2025-03-10 18:50:39.760] [206010000000018|nas] [info] Initial Registration is successful
[2025-03-10 18:50:39.760] [206010000000018|nas] [debug] Sending PDU Session Establishment Request
[2025-03-10 18:50:39.761] [206010000000016|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.772] [206010000000018|nas] [debug] UAC access attempt is allowed for identity[0], category[MO_sig]
[2025-03-10 18:50:39.990] [206010000000013|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:39.991] [206010000000018|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:40.001] [206010000000009|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:40.012] [206010000000015|nas] [debug] Configuration Update Command received
[2025-03-10 18:50:40.298] [206010000000014|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.298] [206010000000014|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.301] [206010000000012|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.301] [206010000000012|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.305] [206010000000014|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun0, 43.0.96.1] is up.
[2025-03-10 18:50:40.311] [206010000000012|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun1, 43.0.32.7] is up.
[2025-03-10 18:50:40.353] [206010000000010|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.353] [206010000000010|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.380] [206010000000011|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.380] [206010000000011|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.381] [206010000000010|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun2, 43.0.96.2] is up.
[2025-03-10 18:50:40.424] [206010000000011|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun3, 43.0.32.8] is up.
[2025-03-10 18:50:40.489] [206010000000015|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.489] [206010000000015|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.496] [206010000000015|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun4, 43.0.96.3] is up.
[2025-03-10 18:50:40.503] [206010000000016|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.503] [206010000000016|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.520] [206010000000013|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.520] [206010000000013|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.528] [206010000000018|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.528] [206010000000018|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.553] [206010000000017|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.553] [206010000000017|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.561] [206010000000016|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun5, 43.0.32.9] is up.
[2025-03-10 18:50:40.588] [206010000000009|nas] [debug] PDU Session Establishment Accept received
[2025-03-10 18:50:40.588] [206010000000009|nas] [info] PDU Session establishment is successful PSI[1]
[2025-03-10 18:50:40.595] [206010000000018|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun6, 43.0.96.5] is up.
[2025-03-10 18:50:40.646] [206010000000017|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun7, 43.0.32.11] is up.
[2025-03-10 18:50:40.672] [206010000000009|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun8, 43.0.96.4] is up.
[2025-03-10 18:50:40.710] [206010000000013|app] [info] Connection setup for PDU session[1] is successful, TUN interface[uesimtun9, 43.0.32.10] is up.
```
### 3.4.3 **checking the AMF logs**

The AMF log for the 10 IMSIs

```bash
[root@compute-1 logs]# more amf.log
[root@compute-1 logs]# more amf.log
03/10 19:35:09.192: [amf] INFO: gNB-N2 accepted[10.50.1.10]:39844 in ng-path module (../src/amf/ngap-sctp.c:113)
03/10 19:35:09.192: [amf] INFO: gNB-N2 accepted[10.50.1.10] in master_sm module (../src/amf/amf-sm.c:757)
03/10 19:35:09.201: [amf] INFO: [Added] Number of gNBs is now 1 (../src/amf/context.c:1236)
03/10 19:35:09.201: [amf] INFO: gNB-N2[10.50.1.10] max_num_of_ostreams : 10 (../src/amf/amf-sm.c:796)
03/10 19:35:09.338: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.338: [amf] INFO: [Added] Number of gNB-UEs is now 1 (../src/amf/context.c:2662)
03/10 19:35:09.338: [amf] INFO:     RAN_UE_NGAP_ID[1] AMF_UE_NGAP_ID[22] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.338: [amf] INFO: [suci-0-206-01-0000-0-0-0000000014] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.338: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.338: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000014]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.373: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.374: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.374: [amf] INFO: [Added] Number of gNB-UEs is now 2 (../src/amf/context.c:2662)
03/10 19:35:09.374: [amf] INFO:     RAN_UE_NGAP_ID[2] AMF_UE_NGAP_ID[23] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.374: [amf] INFO: [suci-0-206-01-0000-0-0-0000000010] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.374: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.374: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000010]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.374: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.374: [amf] INFO: [Added] Number of gNB-UEs is now 3 (../src/amf/context.c:2662)
03/10 19:35:09.374: [amf] INFO:     RAN_UE_NGAP_ID[3] AMF_UE_NGAP_ID[24] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.374: [amf] INFO: [suci-0-206-01-0000-0-0-0000000016] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.374: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.374: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000016]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.374: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.374: [amf] INFO: [Added] Number of gNB-UEs is now 4 (../src/amf/context.c:2662)
03/10 19:35:09.374: [amf] INFO:     RAN_UE_NGAP_ID[4] AMF_UE_NGAP_ID[25] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.374: [amf] INFO: [suci-0-206-01-0000-0-0-0000000018] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.374: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.374: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000018]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.375: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.375: [amf] INFO: [Added] Number of gNB-UEs is now 5 (../src/amf/context.c:2662)
03/10 19:35:09.375: [amf] INFO:     RAN_UE_NGAP_ID[5] AMF_UE_NGAP_ID[26] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.375: [amf] INFO: [suci-0-206-01-0000-0-0-0000000013] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.375: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.375: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000013]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.375: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.375: [amf] INFO: [Added] Number of gNB-UEs is now 6 (../src/amf/context.c:2662)
03/10 19:35:09.375: [amf] INFO:     RAN_UE_NGAP_ID[6] AMF_UE_NGAP_ID[27] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.375: [amf] INFO: [suci-0-206-01-0000-0-0-0000000009] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.375: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.375: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000009]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.375: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.375: [amf] INFO: [Added] Number of gNB-UEs is now 7 (../src/amf/context.c:2662)
03/10 19:35:09.375: [amf] INFO:     RAN_UE_NGAP_ID[7] AMF_UE_NGAP_ID[28] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.375: [amf] INFO: [suci-0-206-01-0000-0-0-0000000011] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.375: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.375: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000011]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.403: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.404: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.404: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.404: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.404: [amf] INFO: [Added] Number of gNB-UEs is now 8 (../src/amf/context.c:2662)
03/10 19:35:09.404: [amf] INFO:     RAN_UE_NGAP_ID[8] AMF_UE_NGAP_ID[29] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.404: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.405: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.405: [amf] INFO: [suci-0-206-01-0000-0-0-0000000015] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.405: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.405: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000015]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.405: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.405: [amf] INFO: [Added] Number of gNB-UEs is now 9 (../src/amf/context.c:2662)
03/10 19:35:09.405: [amf] INFO:     RAN_UE_NGAP_ID[9] AMF_UE_NGAP_ID[30] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.405: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.405: [amf] INFO: [suci-0-206-01-0000-0-0-0000000017] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.405: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.405: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000017]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.413: [amf] INFO: InitialUEMessage (../src/amf/ngap-handler.c:401)
03/10 19:35:09.413: [amf] INFO: [Added] Number of gNB-UEs is now 10 (../src/amf/context.c:2662)
03/10 19:35:09.413: [amf] INFO:     RAN_UE_NGAP_ID[10] AMF_UE_NGAP_ID[31] TAC[1] CellID[0x100] (../src/amf/ngap-handler.c:562)
03/10 19:35:09.413: [amf] INFO: [suci-0-206-01-0000-0-0-0000000012] known UE by SUCI (../src/amf/context.c:1842)
03/10 19:35:09.413: [gmm] INFO: Registration request (../src/amf/gmm-sm.c:1214)
03/10 19:35:09.413: [gmm] INFO: [suci-0-206-01-0000-0-0-0000000012]    SUCI (../src/amf/gmm-handler.c:172)
03/10 19:35:09.415: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.415: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.417: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.3:8080] (../src/amf/nausf-handler.c:130)
03/10 19:35:09.485: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.488: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.489: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.489: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.492: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.493: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.493: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.515: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.515: [gmm] INFO: [imsi-206010000000012] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.515: [amf] INFO: [imsi-206010000000012] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.515: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.515: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.516: [amf] INFO: [Added] Number of AMF-Sessions is now 1 (../src/amf/context.c:2683)
03/10 19:35:09.516: [gmm] INFO: UE SUPI[imsi-206010000000012] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.516: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.516: [gmm] INFO: [imsi-206010000000011] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.516: [amf] INFO: [imsi-206010000000011] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.516: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.516: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.516: [gmm] INFO: [imsi-206010000000010] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.516: [amf] INFO: [imsi-206010000000010] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.516: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.516: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.533: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.534: [amf] WARNING: NF EndPoint(addr) updated [10.40.1.15:8080] (../src/amf/npcf-handler.c:143)
03/10 19:35:09.534: [gmm] INFO: [imsi-206010000000013] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.534: [amf] INFO: [imsi-206010000000013] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.534: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.534: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.534: [amf] INFO: [Added] Number of AMF-Sessions is now 2 (../src/amf/context.c:2683)
03/10 19:35:09.534: [gmm] INFO: UE SUPI[imsi-206010000000011] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.534: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.534: [gmm] INFO: [imsi-206010000000018] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.534: [amf] INFO: [imsi-206010000000018] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.534: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.534: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.535: [amf] INFO: [Added] Number of AMF-Sessions is now 3 (../src/amf/context.c:2683)
03/10 19:35:09.535: [gmm] INFO: UE SUPI[imsi-206010000000010] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.535: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.535: [amf] INFO: [Added] Number of AMF-Sessions is now 4 (../src/amf/context.c:2683)
03/10 19:35:09.535: [gmm] INFO: UE SUPI[imsi-206010000000018] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.535: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.535: [amf] INFO: [Added] Number of AMF-Sessions is now 5 (../src/amf/context.c:2683)
03/10 19:35:09.535: [gmm] INFO: UE SUPI[imsi-206010000000013] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.535: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.765: [gmm] INFO: [imsi-206010000000014] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.765: [amf] INFO: [imsi-206010000000014] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.765: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.765: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.765: [amf] INFO: [Added] Number of AMF-Sessions is now 6 (../src/amf/context.c:2683)
03/10 19:35:09.765: [gmm] INFO: UE SUPI[imsi-206010000000014] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.765: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.766: [gmm] INFO: [imsi-206010000000009] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.766: [amf] INFO: [imsi-206010000000009] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.766: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.766: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.766: [gmm] INFO: [imsi-206010000000016] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.766: [amf] INFO: [imsi-206010000000016] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.766: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.766: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.766: [amf] INFO: [Added] Number of AMF-Sessions is now 7 (../src/amf/context.c:2683)
03/10 19:35:09.766: [gmm] INFO: UE SUPI[imsi-206010000000009] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.766: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.767: [amf] INFO: [Added] Number of AMF-Sessions is now 8 (../src/amf/context.c:2683)
03/10 19:35:09.767: [gmm] INFO: UE SUPI[imsi-206010000000016] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.767: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.767: [gmm] INFO: [imsi-206010000000015] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.767: [amf] INFO: [imsi-206010000000015] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.767: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.767: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.767: [amf] INFO: [Added] Number of AMF-Sessions is now 9 (../src/amf/context.c:2683)
03/10 19:35:09.767: [gmm] INFO: UE SUPI[imsi-206010000000015] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.767: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:09.767: [gmm] INFO: [imsi-206010000000017] Registration complete (../src/amf/gmm-sm.c:2313)
03/10 19:35:09.767: [amf] INFO: [imsi-206010000000017] Configuration update command (../src/amf/nas-path.c:591)
03/10 19:35:09.767: [gmm] INFO:     UTC [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:558)
03/10 19:35:09.768: [gmm] INFO:     LOCAL [2025-03-10T19:35:09] Timezone[0]/DST[0] (../src/amf/gmm-build.c:563)
03/10 19:35:09.768: [amf] INFO: [Added] Number of AMF-Sessions is now 10 (../src/amf/context.c:2683)
03/10 19:35:09.768: [gmm] INFO: UE SUPI[imsi-206010000000017] DNN[demo.nokia.mnc001.mcc206.gprs] S_NSSAI[SST:1 SD:0xabcdef] smContextRef[NULL] smContextResourceURI[NULL] (../src/amf/gmm-handler.c:1285)
03/10 19:35:09.768: [gmm] INFO: SMF Instance [10a0a0a0-8441-4000-8280-30000ac4b5c7] (../src/amf/gmm-handler.c:1326)
03/10 19:35:10.672: [amf] INFO: [imsi-206010000000018:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.672: [amf] INFO: [imsi-206010000000016:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.684: [amf] INFO: [imsi-206010000000010:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.750: [amf] INFO: [imsi-206010000000011:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.772: [amf] INFO: [imsi-206010000000012:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.792: [amf] INFO: [imsi-206010000000013:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.842: [amf] INFO: [imsi-206010000000015:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.842: [amf] INFO: [imsi-206010000000009:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.862: [amf] INFO: [imsi-206010000000014:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
03/10 19:35:10.892: [amf] INFO: [imsi-206010000000017:1:11][0:0:NULL] /nsmf-pdusession/v1/sm-contexts/{smContextRef}/modify (../src/amf/nsmf-handler.c:915)
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
