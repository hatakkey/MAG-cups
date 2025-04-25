## 1. **Register the 5G Subscribers**
Register the IMSIs used in this MAG-CUPS CLAB using the predefined script below, which includes the IMSI, APN, slice information, and other relevant details.
```bash
[root@compute-1 scripts]# ./register_subscriber.sh
<snip>
{
  acknowledged: true,
  insertedId: ObjectId('67f81a921212cfed965e739c')
}
Added IMSI: 206010000000001
{
  acknowledged: true,
  insertedId: ObjectId('67f81a936edbc17dfe5e739c')
}
Added IMSI: 206010000000002
{
  acknowledged: true,
  insertedId: ObjectId('67f81a93de069acdbe5e739c')
}
<snip>
All subscribers added successfully!
```
 
 
## 2. **Start the Open5GS Core Network (AMF,NRF...)**

Start the open5GS core elements via the below predefined script:

```bash
cd scripts
./start_open5gs.sh  
```
### 2.1 **CP registration with the NRF**

The CP registration to the NRF can be verified via the below predefined script:

```bash
*A:CP1# file cd cf1:\magc
*A:CP1# exec sba-stats
Pre-processing configuration file (V0v0)...
Completed processing 76 lines in 0.0 seconds
===============================================================================
          nf-type pcf
===============================================================================
show mobile-gateway pdn service-stats nf-type pcf

===============================================================================
PCF peer service statistics per peer instance
===============================================================================
No Matching Entries
===============================================================================
===============================================================================
          nf-type nrf
===============================================================================
show mobile-gateway pdn service-stats nf-type nrf

===============================================================================
NRF peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nnrf-nfm
-------------------------------------------------------------------------------
Service Instance       : nnrf_nfm1
NF instance ID         : dbc0409c-8b91-4aaa-8727-3cd7e354e7ac

Registered             : Yes, 04/10/2025 21:46:02
Heartbeat Interval     : 10

NF Register            : 1
NF Register Failures   : 0

NF Update Partial      : 0
NF Update Partial Fail : 0

NF Heartbeat           : 5
NF Heartbeat Failures  : 0
```

Also can be checked via the below command:
 
```bash
*A:CP1# tools dump mobile-gateway 1 nf-profile
Active Nrf Peer IP      : 10.40.1.2
Active Nrf Peer ID      : dbc0409c-8b91-4aaa-8727-3cd7e354e7ac
Active Nrf Prof Name    : nnrf_nfm1
Registered NfProfile
NfInstanceID            : 10a0a0a0-8441-4000-8280-30000ac4b5c7
NfType                  : SMF
Nf Status               : Registered 04/10/2025 21:46:02
PLMN List Elements (0)  :
sNssai List (1) :
        sst             : 1, sd : 0xabcdef
nsi List (0)            :
IpV4 addresses (1)      :
        ip              : 1.1.1.1
Recovery Time           : 1744111696 (2025:04:08 - 11:28:16)
HeartBeat Timer         : 10
SMFInfo                 :
                          Num of slices (1)             :
                                        sst             : 1, sd : 0xabcdef
                                        dnn[0]          : bngvrf
                                        dnn[1]          : defaultbng
                                        dnn[2]          : demo.nokia.mnc001.mcc206.gprs
                          Tai list (3)
                                                        : 001-206-1
                                                        : 001-206-2
                                                        : 001-206-200


NfServices (1)          :

                          NfService[0]                  :
                          ServiceInstanceId             : nsmf_pdusession1
                          ServiceName                   : nsmf-pdusession
                          Scheme                        : HTTP
                          ServiceStatus                 : Registered
                          ApiVersionInUri               : v1
                          ApiFullVersion                : 1.0.2
                          Ip endpoints (1)              :
                                        ip              : 1.1.1.1, port 8080
                          allowedNfTypes (0)            :
                          Allowed PLMN IDs List Elements (0):
                          Allowed Nssais List (0)       :  
```                               
## 3. **Start call-trace for the session**

A call-trace can be initiated using the below predefined script to verify session establishment in case of any issues.

```bash
*A:CP1# configure log log-id 77
*A:CP1>config>log>log-id# info
----------------------------------------------
            from debug-trace
            to session
            no shutdown
----------------------------------------------
*A:CP1>config>log>log-id#

*A:CP1# exec ct-5g
Pre-processing configuration file (V0v0)...
Completed processing 13 lines in 0.0 seconds

From Debug to Session
---------------------
=============================================================
Call-insight UEs
=============================================================
Match    Value              Mask-name         Status    Msgs
-------------------------------------------------------------
imsi     206010000000001    N/A               running   0
imsi     206010000000011    N/A               running   0
-------------------------------------------------------------
Number of call-insight debug jobs: 2
=============================================================

Command:
debug mobile-gateway call-insight  no ue all

Executed 13 lines in 2.0 seconds from file cf1:\magc\ct-5g
*A:CP1#
```
## 4. **Start the 5G session**:
You can start a single session or 10 sessions via prededined scripts.

### 4.1 **Start single session**

The below predefined script can be used to start a single 5G session.

```bash
[root@compute-1 scripts]# ./start_5g_cups.sh
Waiting for uesimtun0 to be ready...
Waiting for uesimtun0 to be ready...
IP route added successfully.
```

### 4.1.1 **Single Session Verification**

The below predefined script can be used to verify the operation:
```bash
*A:CP1# exec s-5g
*A:CP1# exec s-5g
Pre-processing configuration file (V0v0)...
Completed processing 33 lines in 0.0 seconds


===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000011     demo.nok* IPv4    1      43.0.224.1/-            N11/http2
-------------------------------------------------------------------------------
Number of PDN instances : 1
-------------------------------------------------------------------------------
# indicates that the corresponding row is IMEI entry.
^ indicates that the corresponding row is MSISDN entry.
` indicates that the corresponding row is MAC entry.
~ indicates that the corresponding row is SEID entry.
-------------------------------------------------------------------------------
* indicates that the corresponding row element may have been truncated.
===============================================================================
PDN context detail
===============================================================================
SUPI             : 206010000000011
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

UE IPv4 address  : 43.0.224.1
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
AMF PCF ID       : e593cd62-14a5-41f0-b38c-69fe07667a4e
-------------------------------------------------------------------------------
Service Based Interface (SBI) Information
-------------------------------------------------------------------------------
Service Realm    : sbaRealm1

NF Service       : nsmf-pdusession
NF Role          : producer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
URI              : http://1.1.1.1:65520/nsmf-pdusession/v1/sm-contexts/00110120
Service Instance : nsmf_pdusession1

NF Service       : namf-comm
NF Role          : consumer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
Service Instance : namf-comm1

NF Service       : namf-evts
NF Role          : consumer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
URI              : http://1.1.1.1:65520/smfPduSession/00110120

NF Service       : nudm-sdm
NF Role          : consumer
NF ID            : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
URI              : http://10.40.1.4:8080/nudm-sdm/v2/imsi-206010000000011/sdm-
                   subscriptions/5fed5174-15fe-41f0-bba5-1b0a43304fa7
Service Instance : udm-sdm1

NF Service       : nudm-uecm
NF Role          : consumer
NF ID            : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
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
CP Sx-N4 Seid        : 0x110120
UP Sx-N4 Seid        : 0x72
gNb N3 Data TEID     : 0x1
gNb N3 IPv4 Address  : 10.80.1.10
UP N3 Data TEID      : 0x3c0000
UP N3 IPv4 Address   : 1.1.1.101

QFI(s)               : 9

-------------------------------------------------------------------------------

Def PFCP-u Sess  : False
Network/Itf Realm: N/A
-------------------------------------------------------------------------------
Number of PDN contexts : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.

===============================================================================
PDN gateway statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1

Real APNs                  : 3          Roamers                    : 0
Homers                     : 0          Visitors                   : 0
VPRNs                      : 3          IP Local Pools             : 0
PDN Sessions               : 0          Ipv4 PDN Sessions          : 0
Ipv6 PDN Sessions          : 0          Ipv4v6 PDN Sessions        : 0
BNG PDN Sessions           : 0
Bearers                    : 0          Default Bearers            : 0
Dedicated Bearers          : 0          Ipv4 Bearers               : 0
Ipv6 Bearers               : 0          Ipv4v6 Bearers             : 0
SDFs                       : 0
HSS Static IPv4 PDN Sessio*: 0          HSS Static IPv6 PDN Sessio*: 0
HSS Static IPv4v6 PDN Sess*: 0          eHRPD PDN sessions         : 0
LTE PDN sessions           : 0          2G/3G PDN sessions         : 0
PDN sessions in suspend st*: 0          Emergency PDN sessions     : 0
Rf Peers                   : 0          Rf Acct start buffered     : 0
Rf Acct Int buffered       : 0          Rf Acct stop buffered      : 0
Ga DRT Req in queue        : 0          Ga DRT Req max queued      : 0
Ga CDRs buffered           : 0          S2b Sessions               : 0
Redirected Sessions        : 0          Tethered Sessions          : 0
Overload - Dropped requests: 0
Paging in progress         : 0          Allocated Paging Buffers   : 0
Available Paging Buffers   : 1          Paging Buffers n/a Errors  : 0
Charging paused sessions   : 0
Number of ENBs             : 1          Number of MMEs             : 0
Total Number of UEs        : 0          Total Number of Idle UEs   : 0
UEs in suspended state     : 0          Paging drops               : 0
Buff Pkts drop tmr expired : 0          Buff Bytes drop tmr expired: 0 B
Buff Pkts drop max pkt lmt : 0          Buff Bytes drop max pkt lmt: 0 B
Buff Pkts drop max cap lmt : 0          Buff Bytes drop max cap lmt: 0 B
BNG UEs                    : 0
Number of RNCs             : 0          Number of SGSNs            : 0
Combo Bearers              : 0          Combo Default bearers      : 0
Combo Active Bearers       : 0          Combo Idle bearers         : 0
Combo Dedicated bearers    : 0          Combo Ipv4 bearers         : 0
Combo Ipv6 bearers         : 0          Combo Ipv4v6 bearers       : 0
Combo sessions             : 0          Combo Ipv4 sessions        : 0
Combo Ipv6 sessions        : 0          Combo Ipv4v6 sessions      : 0
Ga Big DTRs buffered       : 0
S2a Sessions               : 0
TWAG SaMOG Sessions        : 0          TWAG NSWO sessions         : 0
Steering default sessions  : 0
Low Priority Combo Sessions: 0          Low Priority PGW Sessions  : 0
Unsol. SSG Sess In Att Ret*: 0
PDN sessions w dedic bear  : 0
Number of PFCP Peers       : 2          PDN sessions in Idle state : 0
eMPS IMS Sessions          : 0          eMPS IMS Advance Prio Sess : 0
eMPS dedicated bearers     : 0
5G capable 4G sessions     : 0
PFCP-u Shared Tnl Sess     : 2          PFCP-u Shared Tnl Sess Ipv4: 2
PFCP-u Shared Tnl Sess Ipv6: 0

UL Throughput (Mbps)       : 0
DL Throughput (Mbps)       : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.

===============================================================================
Session Management Function statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1
Real DNNs                  : 0
H-SMF Roamers              : 0          V-SMF Roamers              : 0
Homers                     : 1          Visitors                   : 0
VPRNs                      : 0          IP Local Pools             : 0
PDU Sessions               : 1          Ipv4 PDU Sessions          : 1
Ipv6 PDU Sessions          : 0          Ipv4v6 PDU Sessions        : 0
UDM Static IPv4 PDU Sessio*: 0          UDM Static IPv6 PDU Sessio*: 0
UDM Static IPv4v6 PDU Sess*: 0
Active PDU Sessions        : 1          Idle PDU Sessions          : 0
QoS Flows                  : 1
Default QoS Flows          : 1          Dedicated QoS Flows        : 0
Paging in progress         : 0          Allocated Paging Buffers   : 0
Available Paging Buffers   : 0          Paging Buffers n/a Errors  : 0
Number of GNBs             : 0          Number of AMFs             : 0
Total Number of UEs        : 1          Total Number of Idle UEs   : 0
Num of UEs SGW Serv Node   : 0          Num of UEs ePDG Serv Node  : 0
Num of UEs AMF Serv Node   : 1          5G sessions w N26 Indicati*: 0
Paging drops               : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.
===============================================================================
PDN gateway session attach failure statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1

Create Packet Issue        : 0          GTP No Resource            : 0
Peer Down                  : 0          PMIP No Resource           : 0
Peer Admin Down            : 0          Peer Recovery Count Changed: 0
Missing Invalid IE         : 0          Packet Drop                : 0
Internal Error             : 0          Invalid Peer               : 0
Ip Addr Not Available      : 0          Peer PGW overload          : 0
User Authentication Failed : 0
-------------------------------------------------------------------------------
VNF/VM                     : 1/A        Gateway                    : 1

Create Packet Issue        : 0          GTP No Resource            : 0
Peer Down                  : 0          PMIP No Resource           : 0
Peer Admin Down            : 0          Peer Recovery Count Changed: 0
Missing Invalid IE         : 0          Packet Drop                : 0
Internal Error             : 0          Invalid Peer               : 0
Ip Addr Not Available      : 0          Peer PGW overload          : 0
User Authentication Failed : 0
-------------------------------------------------------------------------------
Number of cards : 2
===============================================================================
APN statistics summary
===============================================================================

APN Admin State    : up                 APN Oper State     : up

APN                : demo.nokia.mnc001.mcc206.gprs
Homers             : 1                  Visitors           : 0
Roamers            : 0
Idle Timeouts      : 0                  Session Timeouts   : 0
PDNs w susp proc   : 0
Dedicated Bearers  : 0
Ipv4 PDN Sessions  : 0                  Ipv6 PDN Sessions  : 0
Ipv4v6 PDN Sessions: 0
Ipv4 PDP Contexts  : 0                  Ipv6 PDP Contexts  : 0
Ipv4v6 PDP Contexts: 0                  Secondary PDP Cont*: 0
Ipv4 PMIP Sessions : 0                  Ipv6 PMIP Sessions : 0
Ipv4v6 PMIP Sessio*: 0
Ipv4 S2a Sessions  : 0                  Ipv6 S2a Sessions  : 0
Ipv4v6 S2a Sessions: 0
Ipv4 S2b Sessions  : 0                  Ipv6 S2b Sessions  : 0
Ipv4v6 S2b Sessions: 0
L2TP Sessions      : 0
Ipv4 IP Local Pool : 0                  Ipv6 IP Local Pool : 0
Ipv4v6 IP Local Po*: 0
Ipv4 AAA Sessions  : 0                  Ipv6 AAA Sessions  : 0
Ipv4v6 AAA Sessions: 0
Ipv4 HSS Sessions  : 0                  Ipv6 HSS Sessions  : 0
Ipv4v6 HSS Sessions: 0
Ipv4 DHCP Sessions : 0                  Ipv6 DHCP Sessions : 0
Ipv4v6 DHCP Sessio*: 0                  Ipv4 DHCP-Relay Se*: 0
Bonded IPv4 Sessio*: 0                  Bonded IPv6 Sessio*: 0
Bonded IPv4v6 Sess*: 0
Pcrf-apn-ambr upda*: 0
Redirected Sessions: 0                  Tethered Sessions  : 0
Selective Radius a*: disabled
eMPS IMS Sessions  : 0
Combo Ses by 5G UEs: 0                  PGW Ses by 5G UEs  : 0

PDN sessions having a dedicated bearer : 0

Statistics for APN used as real
Real APN PDN Sessi*: 1
Ipv4 PDN Sessions  : 0                  Ipv6 PDN Sessions  : 0
Ipv4v6 PDN Sessions: 0                  Non-Ip PDN Sessions: 0
Dedicated Bearers  : 0
Ipv4 PDP Contexts  : 0                  Ipv6 PDP Contexts  : 0
Ipv4v6 PDP Contexts: 0                  Secondary PDP Cont*: 0

Ipv4 S2a Sessions  : 0                  Ipv6 S2a Sessions  : 0
Ipv4v6 S2a Sessions: 0
Ipv4 S2b Sessions  : 0                  Ipv6 S2b Sessions  : 0
Ipv4v6 S2b Sessions: 0

APN override triggers              : 0
APN override triggers failed       : 0
APN override establishments failed : 0

Inactivity Timer Sessions Distribution
0-30m              : 0                  30m-1hr            : 0
1hr-3hr            : 0                  3hr-6hr            : 0
6hr-12hr           : 0                  12hr-24hr          : 0
1d-2d              : 0                  2d-5d              : 0
5d-10d             : 0                  10d+               : 0
TWAG SaMOG Sessions: 0                  TWAG NSWO Sessions : 0
Neighbor Solicitation Packets Rx    : 0
Neighbor Solicitation Packets Droppd: 0
Neighbor Advertisement Packets Tx   : 0

UL Throughput (Mbps)       : 0
DL Throughput (Mbps)       : 0

Service Based Architecture (SBA) Statistics
IPv4 PDU Sessions  : 0                  IPv6 PDU Sessions  : 0
IPv4v6 PDU Sessions: 0                  IPv4 UDM PDU Sessi*: 0
IPv6 UDM PDU Sessi*: 0                  IPv4v6 UDM PDU Ses*: 0
QoS Flows          : 1
PDU Sessions with more than one QoS Flow : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.
===============================================================================
APN delete-sessions statistics
===============================================================================
VNF/VM             : 1/2                Gateway            : 1
Non Attach failures
Acct Idle Timeout  : 0                  Acct Resource Fail : 0
Admn Imsi Clear    : 39                 Admn local Imsi Cl*: 101
Admn Clear Imsi Re*: 0                  Admn clear APN     : 0
Admn Gateway Shutd*: 0                  Dia Internal Error : 0
Dia PCRF Disabled  : 0                  Dia Memory Error   : 0
Dia Tx Timer Expire: 0                  Dia Gen Encode Err*: 0
Dia Gen Decode Err*: 0                  Dia AMS Error      : 0
Dia Session Down   : 0                  Dia Timer Error    : 0
Dia Authorization *: 0                  Dia PCRF Down      : 0
WLAN to LTE HO Fail: 0                  Gx Session Release : 0
Radius Disconnect  : 0                  Rf No Acknowledgem*: 0
ASR Def Bearer     : 0                  Gy Bad Ans Def Bea*: 0
PMIP Inter HSGW HO*: 0                  PMIP Life Time Exp : 0
PMIP To LTE HO Fail: 0                  PMIP PBA Reject    : 0
PMIP PBA Timeout   : 0                  Inter RAT HO Fail  : 0
LTE TO EPDG HO Fail: 0                  EPDG To LTE HO Fail: 0
PMIP Instance Shut : 0                  PMIP Peer Down     : 0
PMIP Reattach      : 0                  Missing CCA Usg Th*: 0
Inter SGW HO Fail  : 0                  SMGR Svc Not Suppo*: 0
3G to 4G HO Fail   : 0                  4G to 3G HO Fail   : 0
Ctxt Not Found     : 0                  Inter SGSN HO Fail : 0
SMGR Memory Error  : 0                  Session Timeout    : 0
SMGR Bad Param     : 0                  Peer Down          : 0
UE Normal Detach   : 0                  Unknown            : 0
LTE TO PMIP HO Fail: 0                  PMIP TO LTE HO Fail: 0
Addr Pool Missing  : 0                  Addr Alloc Fail    : 0
APN Access Denied  : 0                  APN Restricted     : 0
Missing Uknwn APN  : 0                  APN Internal Error : 0
Missing IE         : 0                  Invalid IE         : 0
Other Auth Fail    : 0                  User Auth Fail     : 0
APNMGR Svc Not Sup*: 0                  Connect Type Not S*: 0
Addr Pool Exhausted: 0                  Fh Sess Cont Timer : 0
GTP Peer Restart   : 0                  GTP PGW No Response: 0
GTP Sess Not Found : 0                  GTP UE Not Found   : 0
GTP Missing IE     : 0                  GTP Unknown IE     : 0
GTP UE Nw Init Det*: 0                  GTP HO Fail        : 0
LTE To WLAN HO Fail: 0                  Gy Session Failed  : 0
GTP Internal Error : 0                  GTP PDN Present    : 0
GTP Session Create*: 0                  GTP Ded Bearer Cre*: 0
GTP Dwnl Create Fa*: 0                  GTP SGW No Response: 0
GTP MME No Response: 0                  GTP Addr Alloc Fail: 0
GTP Del In Progress: 0                  GTP Ctx Not Found  : 0
GTP No Bearer Reso*: 0                  GTP Invalid IE     : 0
GTP Bearer Not Fou*: 0                  Geo Red Audit      : 0
HA Audit           : 0                  Mgr Init Session R*: 0
Gy Missing CCA     : 0                  GTP SGW Change     : 0
Stale To Relocation: 0                  Idle To Disallow R*: 0
Cmd Lvl FUA Termin*: 0
CCFH Volume Limit  : 0
Gx Quota Exhausted : 0                  Gx Time Exhausted  : 0
PMIP to WLAN HO Fa*: 0                  Denied No Subscrip*: 0
Roaming Restriction: 0
-------------------------------------------------------------------------------
Number of cards: 1
===============================================================================
* indicates that the corresponding row element may have been truncated.
===============================================================================
APN attach-failure statistics
===============================================================================
VNF/VM             : 1/2                Gateway            : 1
Attach failures
Acct Resource Fail : 0                  Dia Internal Error : 0
Dia PCRF Disabled  : 0                  Dia Memory Error   : 0
Dia Tx Timer Expire: 0                  Dia Gen Encode Err*: 0
Dia Gen Decode Err*: 0                  Dia AMS Error      : 0
Dia Session Down   : 0                  Dia Timer Error    : 0
Dia Authorization *: 0                  Dia Authentication*: 0
Dia PCRF Down      : 0                  Gy Setup Fail      : 0
Rulebase Change Fa*: 0                  Send Gx CCRI Fail  : 0
SMGR Svc Not Suppo*: 0                  Invalid Mandatory *: 0
SMGR Memory Error  : 0                  Addr Pool Exhausted: 0
Addr Pool Missing  : 0                  Addr Alloc Fail    : 0
Addr Pool Invalid *: 0                  APNMGR Msg Send Fa*: 0
APN Access Denied  : 0                  APN Restricted     : 0
Missing Uknwn APN  : 0                  APN Internal Error : 0
Missing IE         : 0                  Invalid IE         : 0
Other Auth Fail    : 0                  User Auth Fail     : 0
APNMGR Svc Not Sup*: 0                  Connect Type Not S*: 0
PCRF Session Relea*: 0                  SMGR Bad Param     : 0
Selection Mode Mis*: 0                  Del while Attach i*: 0
APNMGR No Resources: 0                  Cmd Lvl FUA Term   : 0
Diameter User Unkn*: 0
UP selection       : 0
-------------------------------------------------------------------------------
Number of cards: 1
===============================================================================
* indicates that the corresponding row element may have been truncated.
===============================================================================
===============================================================================
BNG Sessions
===============================================================================
[FWA] IMSI/SUPI                : 206010000000011
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
UP GTP-U TEID                  : 0x003c0000
S11 MME GTP-C IP               : N/A
S11 MME GTP-C TEID             : N/A
S11 CP GTP-C IP                : N/A
S11 CP GTP-C TEID              : N/A
N11 AMF GUAMI                  : 206 01 0x20040
N11 AMF NF Instance Id         : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
N10 UDM SDM NF Instance Id     : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
N10 UDM UECM NF Instance Id    : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
N7 PCF NF Instance Id          : N/A
N40 CHF NF Instance Id         : N/A
N4 UPF NF Instance Id          : N/A
N1 PDU Session Id              : 1
S-NSSAI                        : SST 1, SD 0xabcdef
QFI(s)                         : 9
EBI(s)                         : N/A
Local Priority                 : N/A
UP Security Integrity          : N/A
UP Security Confidentiality    : N/A
UP Security UPIP Max UL Rate   : max-ue-rate
UP Security UPIP Max DL Rate   : max-ue-rate
UP Security UPIP 4G Supported  : No
IPv4 Signaling Method          : NAS
IPv4 Link MTU                  : N/A

Up Time                        : 0d 08:40:11
Provisioned Addresses          : IPv4
Signaled Addresses             : IPv4

UP Peer                        : 1.1.1.101
Selected APN/DNN               : demo.nokia.mnc001.mcc206.gprs
Network Realm                  : bngvrf
IPv4 Pool                      : fwa

IPv4 Address                   : 43.0.224.1
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 19
IPv4 Gateway                   : 43.0.255.254
IPv4 Primary DNS               : 208.67.254.254
IPv4 Secondary DNS             : 208.67.255.255
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 43.0.255.254
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : N/A
DHCPv4 Remaining Lease Time    : N/A

Subscriber                     : 206010000000011 (536871057)
Acct-Session-Id                : F00110120A06B683A0120003E
Acct-Multi-Session-Id          : Y20000091A06B683A00100120
State Id                       : N/A
Sub Profile                    : sub-fwa
Sla Profile                    : sla-fwa
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
Content Filtering Policy Id    : 0
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
PFCP Local SEID                : 0x0000000000110120
PFCP Remote SEID               : 0x0000000000000072

UE Id                          : 0x00100120
PDN Session Id                 : 0x00110120
Group/VM                       : 1/2
Call-Insight                   : disabled

Charging Profile 1             : accounting-1
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A

-------------------------------------------------------------------------------
Number of sessions shown : 1
===============================================================================
===============================================================================
BNG session aggregate statistics
===============================================================================
[FWA] IMSI/SUPI                : 206010000000011
      APN/DNN                  : demo.nokia.mnc001.mcc206.gprs
      N1 PDU Session Id        : 1
-------------------------------------------------------------------------------
Time                           : 04/10/2025 22:04:33
Packets down                   : 0
Packets up                     : 0
Octets down                    : 0
Octets up                      : 0
Packets down dropped           : 0
Packets up dropped             : 0
Octets down dropped            : 0
Octets up dropped              : 0
-------------------------------------------------------------------------------
No. of sessions: 1
===============================================================================

command :
clear mobile-gateway pdn  1 bearer-context imsi 206010000000001

Executed 33 lines in 0.2 seconds from file cf1:\magc\s-5g
```
### 4.1.2 **Call-trace session output**

The call-trace was enabled before the session is started, below you can check the session call-trace debug output.


```bash
*A:CP1#
1 2025/04/10 23:43:25.730 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 21 mda 0
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NSMF_PDU_SESSION
             to application Other

   IP/TCP:   from 10.100.1.2 (port 48600) to 1.1.1.1 (port 8080)

   HTTP2:
:method: POST
:path: /nsmf-pdusession/v1/sm-contexts
content-type: multipart/related; boundary="=-VWKrrZcsiZThCKz/y3ebRg=="
user-agent: AMF
accept: application/json,application/vnd.3gpp.ngap,application/problem+json
content-length: 942
--=-VWKrrZcsiZThCKz/y3ebRg==
Content-Type: application/json

{"supi":"imsi-206010000000011","pduSessionId":1,"dnn":"demo.nokia.mnc001.mcc206.
gprs","sNssai":{"sst":1,"sd":"abcdef"},"servingNfId":"e57ae5f4-14a5-41f0-bc57-c9
f3363aef2c","guami":{"plmnId":{"mcc":"206","mnc":"01"},"amfId":"020040"},"servin
gNetwork":{"mcc":"206","mnc":"01"},"n1SmMsg":{"contentId":"5gnas-sm"},"anType":"
3GPP_ACCESS","ratType":"NR","ueLocation":{"nrLocation":{"tai":{"plmnId":{"mcc":"
206","mnc":"01"},"tac":"000001"},"ncgi":{"plmnId":{"mcc":"206","mnc":"01"},"nrCe
llId":"000000100"},"ueLocationTimestamp":"2025-04-10T21:43:24.283859Z"}},"ueTime
Zone":"+00:00","smContextStatusUri":"http://10.40.1.5:8080/namf-callback/v1/imsi
-206010000000011/sm-context-status/1","pcfId":"e593cd62-14a5-41f0-b38c-69fe07667
a4e"}
--=-VWKrrZcsiZThCKz/y3ebRg==
Content-Id: 5gnas-sm
Content-Type: application/vnd.3gpp.5gnas

.11c1ffff91a1(10{07800
000
--=-VWKrrZcsiZThCKz/y3ebRg==--
"

2 2025/04/10 23:43:25.766 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NUDM_SDM
             from application Other

   IP/TCP:   from 1.1.1.1 (port 65471) to 10.40.1.4 (port 8080)

   HTTP2:
:method: GET
:path: /nudm-sdm/v2/imsi-206010000000011/sm-data?dnn=demo.nokia.mnc001.mcc206.gp
rs&single-nssai=%7b%22sst%22%3a1%2c%22sd%22%3a%22ABCDEF%22%7d
"

3 2025/04/10 23:43:25.776 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NUDM_SDM
             to application Other

   IP/TCP:   from 10.40.1.4 (port 8080) to 1.1.1.1 (port 65471)

   HTTP2:
:status: 200
server: Open5GS v2.7.1
content-length: 486
content-type: application/json
[{"singleNssai":{"sst":1,"sd":"abcdef"},"dnnConfigurations":{"demo.nokia.mnc001.
mcc206.gprs":{"pduSessionTypes":{"defaultSessionType":"IPV4V6","allowedSessionTy
pes":["IPV4","IPV6","IPV4V6"]},"sscModes":{"defaultSscMode":"SSC_MODE_1","allowe
dSscModes":["SSC_MODE_1","SSC_MODE_2","SSC_MODE_3"]},"5gQosProfile":{"5qi":9,"ar
p":{"priorityLevel":8,"preemptCap":"NOT_PREEMPT","preemptVuln":"PREEMPTABLE"},"p
riorityLevel":8},"sessionAmbr":{"uplink":"1000000 Kbps","downlink":"1000000 Kbps
"}}}}]"

4 2025/04/10 23:43:25.776 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NUDM_SDM
             from application Other

   IP/TCP:   from 1.1.1.1 (port 65472) to 10.40.1.4 (port 8080)

   HTTP2:
:method: POST
:path: /nudm-sdm/v2/imsi-206010000000011/sdm-subscriptions
content-type: application/json
{"nfInstanceId":"10a0a0a0-8441-4000-8280-30000ac4b5c7","implicitUnsubscribe":tru
e,"callbackReference":"http://1.1.1.1:65522/nudm-notification/v1/00010110-demo.n
okia.mnc001.mcc206.gprs~1abcdef~0","monitoredResourceUris":["http://10.40.1.4:80
80/nudm-sdm/v1/imsi-206010000000011/sm-data"],"singleNssai":{"sst":1,"sd":"ABCDE
F"},"dnn":"demo.nokia.mnc001.mcc206.gprs"}"

5 2025/04/10 23:43:25.776 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Other
   Info:          and module sessmgr

   apnmgr ADB message
      authentication-db: adbfwa
      matched entry: 5G
      search circuit-id:
      search remote-id:
      search l2-access-id:
      search username:
      search username-domain:
      search vendor-class:
      search UPip: ::
      search sVlan: 0
      search cVlan: 0
      search apn: demo.nokia.mnc001.mcc206.gprs
      search imsi-mcc: 206
      search imsi-mnc: 01
      search imei-tac:
      search derivedId:
      search UPgroup:
      search UPnode-id:
      search MAC: 00:00:00:00:00:00
      search client-id:
      search source-ip-prefix: ::/0
      search s-snssai-sst: 1
      search s-snssai-sd: 11259375
      search pdn-type: 1
      search charging-characteristics: 0
      search tai-mcc: 206
      search tai-mnc: 01
      search tai-tac:
      search tai-list-id: 0
      search cell-id-list-id: 0
"

6 2025/04/10 23:43:25.776 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Other
   Info:          and module lrdm

   lrdm event
      apnRadGrpID 8
      radSesReqType 0
      code 1
"

7 2025/04/10 23:43:25.776 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface Rad
             from application Radius-auth

   IP/UDP:   from 1.1.1.1 (port 65449) to 100.0.0.2 (port 1812)

   RADIUS:   Access Request (1) id=189 len=299
   - User-Name: "206010000000011"
   - User-Password: <encrypted>
   - NAS-IP-Address: 1.1.1.1
   - Service-Type: Framed-User (2)
   - Framed-Protocol: 7
   - Called-Station-Id: "demo.nokia.mnc001.mcc206.gprs"
   - 3GPP-IMSI: "206010000000011"
   - 3GPP-GPRS-Negotiated-QoS-profile: "15-60090C1000000 Kbps0C1000000 Kbps"
   - 3GPP-RAT-Type: 51
   - 3GPP-Location-Info: 0x8902f61000000102f6100000000100
   - 3GPP-Session-S-NSSAI: 0x01abcdef
   - 3GPP-Supported-Features: 0x000028af0000000100000001
   - NAS-Identifier: "CP1"
   - Acct-Session-Id: "F00010110A06B683A0110004B"
   - Acct-Multi-Session-Id: "Y20000093A06B683A00010110"
   - NAS-Port-Type: Virtual (5)
"

8 2025/04/10 23:43:25.777 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface Rad
             to application Radius-auth

   IP/UDP:   from 100.0.0.2 (port 1812) to 1.1.1.1 (port 65449)

   RADIUS:   Access Accept (2) id=189 len=32
   - Service-Type: Framed-User (2)
   - Framed-Protocol: 7
"

9 2025/04/10 23:43:25.796 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   Sessmgr to PFCP
      msgType: PFCP_SESSION_CREATE_REQ (= 1)
      PFCP Sessmgr header
         ueId 0x10110
         ueBndlIdx 0x0
         tunnelInfo
            endPtIpAddr 1.1.1.102
            secEndPtIpAddr 0.0.0.0
            endPtSeId 0x0
            lclSeId 0x10110
            refPtId 1
         pfcpOpaque 0
         smgrTransId 0x4001
         transErrCode: Success (= 0)
"

10 2025/04/10 23:43:25.796 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface Sx
             from application Connectivity-management

   IP/UDP:   from 1.1.1.1 (port 8805) to 1.1.1.102 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 50 [SESS_EST_REQ]
   - Msg len: 1064
   - SEID: 0x00000000
   - Seq nbr: 589825
   - Msg prio: 15

   IEs:
   - T: 60 [Node Id]     L: 18
     Type: FQDN
     Id: 206.01.PGW.1.1.1
   - T: 57 [FSEID]     L: 13
     SEID: 0x00010110
     IPv4 Addr: 1.1.1.1
   - T: 1 [Create PDR]     L: 124
     Payload:
     - T: 56 [PDR Id]     L: 2
       V: 18944
     - T: 29 [Precedence]     L: 4
       V: 65535
     - T: 2 [PDI]     L: 61
       Payload:
       - T: 20 [Src Intf]     L: 1
         Intf: Access
       - T: 131 [Traffic End Pt Id]     L: 1
         V: 69
       - T: 23 [SDF Filter]     L: 42
         Flow Desc: permit out ip from any to assigned
         Filter ID: 4096
       - T: 124 [QoS Flow Identifier]     L: 1
         QFI: 9
     - T: 95 [Out Hdr Rem]     L: 1
       Desc: GTP-U/UDP/IP
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 327680
     - T: 81 [URR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1073741825
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4112
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4121
   - T: 1 [Create PDR]     L: 78
     Payload:
     - T: 56 [PDR Id]     L: 2
       V: 35328
     - T: 29 [Precedence]     L: 4
       V: 65535
     - T: 2 [PDI]     L: 20
       Payload:
       - T: 20 [Src Intf]     L: 1
         Intf: Core
       - T: 131 [Traffic End Pt Id]     L: 1
         V: 128
       - T: 23 [SDF Filter]     L: 6
         Filter ID: 4096
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 537198592
     - T: 81 [URR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1073741825
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4112
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4121
   - T: 1 [Create PDR]     L: 163
     Payload:
     - T: 56 [PDR Id]     L: 2
       V: 27136
     - T: 29 [Precedence]     L: 4
       V: 4096
     - T: 2 [PDI]     L: 132
       Payload:
       - T: 20 [Src Intf]     L: 1
         Intf: Access
       - T: 131 [Traffic End Pt Id]     L: 1
         V: 69
       - T: 23 [SDF Filter]     L: 36
         Flow Desc: permit out 17 from any 67 to any
       - T: 23 [SDF Filter]     L: 37
         Flow Desc: permit out 17 from any 547 to any
       - T: 23 [SDF Filter]     L: 37
         Flow Desc: permit out 58 from FF02::2 to any
     - T: 95 [Out Hdr Rem]     L: 1
       Desc: GTP-U/UDP/IP
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 134545408
   - T: 1 [Create PDR]     L: 41
     Payload:
     - T: 56 [PDR Id]     L: 2
       V: 43520
     - T: 29 [Precedence]     L: 4
       V: 4096
     - T: 2 [PDI]     L: 10
       Payload:
       - T: 20 [Src Intf]     L: 1
         Intf: CP-function
       - T: 131 [Traffic End Pt Id]     L: 1
         V: 144
     - T: 95 [Out Hdr Rem]     L: 1
       Desc: GTP-U/UDP/IP
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 537198592
   - T: 3 [Create FAR]     L: 38
     Payload:
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 327680
     - T: 44 [Apply Act]     L: 1
       Action(s): FORW
     - T: 4 [Forw Param]     L: 21
       Payload:
       - T: 42 [Dest Intf]     L: 1
         Intf: Core
       - T: 160 [3gpp Intf Type]     L: 1
         Intf Type: N6
       - T: 22 [NW Inst]     L: 7
         Netw Inst: bngvrf
   - T: 3 [Create FAR]     L: 36
     Payload:
     - T: 108 [FAR Id]     L: 4
*"

11 2025/04/10 23:43:25.796 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1 (Cont'd)
*
       Alloc Type: Dynamic by CP      Id: 134545408
     - T: 44 [Apply Act]     L: 1
       Action(s): FORW
     - T: 4 [Forw Param]     L: 19
       Payload:
       - T: 42 [Dest Intf]     L: 1
         Intf: CP-func
       - T: 84 [Out Hdr Creat]     L: 10
         TEID: 0x40010112
         IPv4 Addr: 1.1.1.1
         N19/N6 Ind: NO/NO
   - T: 3 [Create FAR]     L: 27
     Payload:
     - T: 108 [FAR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 537198592
     - T: 44 [Apply Act]     L: 1
       Action(s): BUFF
     - T: 4 [Forw Param]     L: 5
       Payload:
       - T: 42 [Dest Intf]     L: 1
         Intf: Access
     - T: 88 [BAR Id]     L: 1
       V: 5
   - T: 7 [Create QER]     L: 21
     Payload:
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4112
     - T: 28 [QER Corr Id]     L: 4
       V: 536871059
     - T: 25 [Gate Status]     L: 1
       UL Gate: Open
       DL Gate: Open
   - T: 7 [Create QER]     L: 27
     Payload:
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1
     - T: 25 [Gate Status]     L: 1
       UL Gate: Open
       DL Gate: Open
     - T: 26 [MBR]     L: 10
       MBR UL 1000000, MBR DL 1000000
   - T: 7 [Create QER]     L: 18
     Payload:
     - T: 109 [QER Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 4121
     - T: 25 [Gate Status]     L: 1
       UL Gate: Open
       DL Gate: Open
     - T: 124 [QoS Flow Identifier]     L: 1
       QFI: 9
   - T: 6 [Create URR]     L: 32
     Payload:
     - T: 81 [URR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1073741825
     - T: 62 [Mea Method]     L: 1
       Method(s): VOLUM
     - T: 37 [Rep Triggers]     L: 2
       Trigger(s): PERIO
     - T: 64 [Mea Period]     L: 4
       V: 30
     - T: 100 [Mea Info]     L: 1
       Info bit(s): MNOP
   - T: 85 [Create BAR]     L: 10
     Payload:
     - T: 88 [BAR Id]     L: 1
       V: 5
     - T: 46 [DL Data Notify Delay]     L: 1
       V: 0 ms
   - T: 127 [Create Traffic EndPt]     L: 30
     Payload:
     - T: 131 [Traffic End Pt Id]     L: 1
       V: 128
     - T: 22 [NW Inst]     L: 7
       Netw Inst: bngvrf
     - T: 93 [UE IP]     L: 5
       IPv4 Addr: 43.0.32.1
     - T: 160 [3gpp Intf Type]     L: 1
       Intf Type: N6
   - T: 127 [Create Traffic EndPt]     L: 23
     Payload:
     - T: 131 [Traffic End Pt Id]     L: 1
       V: 69
     - T: 21 [FTEID]     L: 2
       FLAGS: CHID,CH,V6,V4
       CHOOSE ID: 197
     - T: 22 [NW Inst]     L: 3
       Netw Inst: sx
     - T: 160 [3gpp Intf Type]     L: 1
       Intf Type: N3 3GPP Access
   - T: 127 [Create Traffic EndPt]     L: 10
     Payload:
     - T: 131 [Traffic End Pt Id]     L: 1
       V: 144
     - T: 21 [FTEID]     L: 1
       FLAGS: CH,V6,V4
   - T: 113 [PDN Type]     L: 1
     V: IPv4
   - T: 159 [APN/DNN]     L: 30
     APN/DNN: demonokiamnc001mcc206gprs
   - T: 141 [User Id]     L: 10
     Flag(s): IMSIF
     IMSI:  L: 8 V: 206010000000011
   - T: 50001 [Random Vector]     L: 18
     Ent ID: 3729 (Nokia)
     V: (encrypted) c8 03 98 4c a7 60 48 07 ac 74 91 77 05 4b be 09
   - T: 50002 [LI Container]     L: 74
     Ent ID: 3729 (Nokia)
     V: (encrypted) f5 90 5f 7d 53 0b 23 01 b0 33 9b 5b 09 9d 72 39 93 1f ce
   a8 be f2 1f da 7b 97 44 8e 4d 36 6e e7 f1 26 50 cf 08 85 82 d0 f4 3c bc 78
   70 c7 c9 97 61 23 42 f4 9f f2 43 3d e8 22 cb a1 77 98 ea 3d 88 01 f4 55 e4
   5a c6 b2
   - T: 32774 [UP Aggregate Route]     L: 31
     Ent ID: 3729 (Nokia)
     Payload:
     - T: 22 [NW Inst]     L: 7
       Netw Inst: bngvrf
     - T: 153 [Framed Route]     L: 14
       V: 43.0.63.254/19
   - T: 32775 [SAP Template]     L: 8
     Ent ID: 3729 (Nokia)
     V: templ1
   - T: 32776 [MTU]     L: 8
     Ent ID: 3729 (Nokia)
     V: 29797
   - T: 32832 [UP Profiles]     L: 33
     Ent ID: 3729 (Nokia)
     V: subprof:sub-fwa;slaprof:sla-fwa
   - T: 32837 [Calltrace Profile]     L: 14
     Ent ID: 3729 (Nokia)
     Profile Name: debug-output
*"

12 2025/04/10 23:43:25.796 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1 (Cont'd)
*
   - T: 257 [Nssai Type]     L: 4
     SST: 0x01
     SD: 0xcdef00
"

13 2025/04/10 23:43:25.836 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface Sx
             to application Connectivity-management

   IP/UDP:   from 1.1.1.102 (port 8805) to 1.1.1.1 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 51 [SESS_EST_RSP]
   - Msg len: 135
   - SEID: 0x00010110
   - Seq nbr: 589825
   - Msg prio: 15

   IEs:
   - T: 60 [Node Id]     L: 15
     Type: FQDN
     Id: up2.nokia.com
   - T: 19 [Cause]     L: 1
     Cause: 1 [Accepted]
   - T: 50002 [LI Container]     L: 34
     Ent ID: 3729 (Nokia)
     V: (encrypted) f5 bc 58 52 53 2f 1f 07 3f 2e bb 39 58 7e 19 92 38 b8 14
   9f e5 f3 d9 53 a6 de f9 f3 9e 5a d3 10
   - T: 57 [FSEID]     L: 13
     SEID: 0x00000072
     IPv4 Addr: 1.1.1.102
   - T: 128 [Created Traffic EndPt]     L: 18
     Payload:
     - T: 131 [Traffic End Pt Id]     L: 1
       V: 144
     - T: 21 [FTEID]     L: 9
       FLAGS: V4
       TEID: 0x803e0000
       IPv4 Addr: 1.1.1.102
   - T: 128 [Created Traffic EndPt]     L: 18
     Payload:
     - T: 131 [Traffic End Pt Id]     L: 1
       V: 69
     - T: 21 [FTEID]     L: 9
       FLAGS: V4
       TEID: 0x00400000
       IPv4 Addr: 1.1.1.102
"

14 2025/04/10 23:43:25.836 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NUDM_SDM
             to application Other

   IP/TCP:   from 10.40.1.4 (port 8080) to 1.1.1.1 (port 65472)

   HTTP2:
:status: 201
server: Open5GS v2.7.1
content-length: 362
location: http://10.40.1.4:8080/nudm-sdm/v2/imsi-206010000000011/sdm-subscriptio
ns/d47c65f6-1654-41f0-bba5-1b0a43304fa7
content-type: application/json
{"nfInstanceId":"10a0a0a0-8441-4000-8280-30000ac4b5c7","implicitUnsubscribe":tru
e,"callbackReference":"http://1.1.1.1:65522/nudm-notification/v1/00010110-demo.n
okia.mnc001.mcc206.gprs~1abcdef~0","monitoredResourceUris":["http://10.40.1.4:80
80/nudm-sdm/v1/imsi-206010000000011/sm-data"],"singleNssai":{"sst":1,"sd":"ABCDE
F"},"dnn":"demo.nokia.mnc001.mcc206.gprs"}"

15 2025/04/10 23:43:25.836 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   PFCP to sessmgr
      msgType: E_SMGR_PFCP_SESSION_CREATE_RSP (= 383)
      PFCP Sessmgr header
         ueId 0x10110
         ueBndlIdx 0x0
         tunnelInfo
            endPtIpAddr 1.1.1.102
            secEndPtIpAddr ::
            endPtSeId 0x72
            lclSeId 0x10110
            refPtId 1
         pfcpOpaque 1
         smgrTransId 0x4001
         transErrCode: Success (= 0)
"

16 2025/04/10 23:43:25.846 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NUDM_UECM
             from application Other

   IP/TCP:   from 1.1.1.1 (port 65473) to 10.40.1.4 (port 8080)

   HTTP2:
:method: PUT
:path: /nudm-uecm/v1/imsi-206010000000011/registrations/smf-registrations/1
content-type: application/json
{"smfInstanceId":"10a0a0a0-8441-4000-8280-30000ac4b5c7","pduSessionId":1,"single
Nssai":{"sst":1,"sd":"ABCDEF"},"dnn":"demo.nokia.mnc001.mcc206.gprs","plmnId":{"
mcc":"206","mnc":"01"}}"

17 2025/04/10 23:43:25.880 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 21 mda 0
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NSMF_PDU_SESSION
             from application Other

   IP/TCP:   from 1.1.1.1 (port 8080) to 10.100.1.2 (port 48600)

   HTTP2:
:status: 201
location: http://1.1.1.1:65520/nsmf-pdusession/v1/sm-contexts/00010110
content-type: application/json
{"smfServiceInstanceId":"10a0a0a0-8441-4000-8280-30000ac4b5c7","recoveryTime":"2
025-04-08T11:28:16Z"}"

18 2025/04/10 23:43:25.906 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NUDM_UECM
             to application Other

   IP/TCP:   from 10.40.1.4 (port 8080) to 1.1.1.1 (port 65473)

   HTTP2:
:status: 200
server: Open5GS v2.7.1
content-length: 183
content-type: application/json
{"smfInstanceId":"10a0a0a0-8441-4000-8280-30000ac4b5c7","pduSessionId":1,"single
Nssai":{"sst":1,"sd":"ABCDEF"},"dnn":"demo.nokia.mnc001.mcc206.gprs","plmnId":{"
mcc":"206","mnc":"01"}}"

19 2025/04/10 23:43:25.936 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NAMF_COMM
             from application Other

   IP/TCP:   from 1.1.1.1 (port 65472) to 10.40.1.5 (port 8080)

   HTTP2:
:method: POST
:path: /namf-comm/v1/ue-contexts/imsi-206010000000011/n1-n2-messages
content-type: multipart/related; boundary=gc0pJq08jU534c

--gc0pJq08jU534c
Content-Type: application/json

{"n1MessageContainer":{"n1MessageClass":"SM","n1MessageContent":{"contentId":"n1
ContentId1"}},"n2InfoContainer":{"n2InformationClass":"SM","smInfo":{"pduSession
Id":1,"n2InfoContent":{"ngapIeType":"PDU_RES_SETUP_REQ","ngapData":{"contentId":
"n2ContentId1"}},"sNssai":{"sst":1,"sd":"ABCDEF"}}},"lastMsgIndication":false,"p
duSessionId":1,"n1n2FailureTxfNotifURI":"http://1.1.1.1:65521/namf-comm/v1/ue-co
ntexts/00010110","smfReallocationInd":false}
--gc0pJq08jU534c
Content-Type: application/vnd.3gpp.5gnas
Content-Id: n1ContentId1

.11c211091061111fe96b01b01)51+0 1"41abcdefy069 A119{0f8004d0Cfefe04d0Cffff%1e4de
mo5nokia6mnc0016mcc2064gprs
--gc0pJq08jU534c
Content-Type: application/vnd.3gpp.ngap
Content-Id: n2ContentId1

0040820
c;9aca00;9aca008b0
1f0111f0@0008601008807090091c@
--gc0pJq08jU534c--
"

20 2025/04/10 23:43:25.996 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NAMF_COMM
             to application Other

   IP/TCP:   from 10.40.1.5 (port 8080) to 1.1.1.1 (port 65472)

   HTTP2:
:status: 200
server: Open5GS v2.7.1
content-length: 36
content-type: application/json
{"cause":"N1_N2_TRANSFER_INITIATED"}"

21 2025/04/10 23:43:25.996 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface NSMF_PDU_SESSION
             to application Other

   IP/TCP:   from 10.100.1.2 (port 32786) to 1.1.1.1 (port 65520)

   HTTP2:
:method: POST
:path: /nsmf-pdusession/v1/sm-contexts/00010110/modify
content-type: multipart/related; boundary="=-WDPlHcXr25kavwFu+WPNqA=="
user-agent: AMF
accept: application/json,application/problem+json
content-length: 278
--=-WDPlHcXr25kavwFu+WPNqA==
Content-Type: application/json

{"n2SmInfo":{"contentId":"ngap-sm"},"n2SmInfoType":"PDU_RES_SETUP_RSP"}
--=-WDPlHcXr25kavwFu+WPNqA==
Content-Id: ngap-sm
Content-Type: application/vnd.3gpp.ngap

03e0P1000309
--=-WDPlHcXr25kavwFu+WPNqA==--
"

22 2025/04/10 23:43:25.996 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   Sessmgr to PFCP
      msgType: PFCP_SESSION_MODIFY_REQ (= 2)
      PFCP Sessmgr header
         ueId 0x10110
         ueBndlIdx 0x0
         tunnelInfo
            endPtIpAddr 1.1.1.102
            secEndPtIpAddr 0.0.0.0
            endPtSeId 0x72
            lclSeId 0x10110
            refPtId 1
         pfcpOpaque 0
         smgrTransId 0x2
         transErrCode: Success (= 0)
"

23 2025/04/10 23:43:25.996 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface Sx
             from application Connectivity-management

   IP/UDP:   from 1.1.1.1 (port 8805) to 1.1.1.102 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 52 [SESS_MOD_REQ]
   - Msg len: 187
   - SEID: 0x00000072
   - Seq nbr: 589826
   - Msg prio: 12

   IEs:
   - T: 10 [Upd FAR]     L: 53
     FAR ID: 537198592
     Action(s): FORW
     Upd Fwd Par:
       Intf: Access
       Intf Type: N3 3GPP Access
       Netw Inst: sx
       Outer Hdr Creation:
         TEID: 0x00000003
         IPv4 Addr: 10.80.1.10
         N19/N6 Ind: NO/NO
       Traff Endp Id: 69
   - T: 50001 [Random Vector]     L: 18
     Ent ID: 3729 (Nokia)
     V: (encrypted) 98 01 6e 4f 0c 36 cb 07 62 22 b3 79 34 41 ea 71
   - T: 50002 [LI Container]     L: 74
     Ent ID: 3729 (Nokia)
     V: (encrypted) 04 0b 34 ec 41 9c 2f 7c b8 3f 09 9f 7c a1 05 b5 98 39 eb
   dd 7d f1 2f 20 ed 7e f8 1b 19 2e fb 0d 9a f2 45 1c f5 69 9e dd 0c 0a 28 a9
   6f 10 60 51 b4 4d d4 dc 6c 69 87 bd 94 54 4a 7e 63 e3 66 6c 2e 71 c8 b3 d2
   9a 68 52
   - T: 32837 [Calltrace Profile]     L: 14
     Ent ID: 3729 (Nokia)
     Profile Name: debug-output
"

24 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface Sx
             to application Connectivity-management

   IP/UDP:   from 1.1.1.102 (port 8805) to 1.1.1.1 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 53 [SESS_MOD_RSP]
   - Msg len: 55
   - SEID: 0x00010110
   - Seq nbr: 589826
   - Msg prio: 12

   IEs:
   - T: 19 [Cause]     L: 1
     Cause: 1 [Accepted]
   - T: 50002 [LI Container]     L: 34
     Ent ID: 3729 (Nokia)
     V: (encrypted) 04 27 33 c3 41 b8 13 7a 37 22 29 fd 2d 42 6e 1e 12 f9 aa
   38 95 38 9d e8 c9 51 5e 16 b3 3c 8b c9
"

25 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   PFCP to sessmgr
      msgType: E_SMGR_PFCP_SESSION_MODIFY_RSP (= 384)
      PFCP Sessmgr header
         ueId 0x10110
         ueBndlIdx 0x0
         tunnelInfo
            endPtIpAddr ::
            secEndPtIpAddr ::
            endPtSeId 0x0
            lclSeId 0x10110
            refPtId 0
         pfcpOpaque 2
         smgrTransId 0x2
         transErrCode: Success (= 0)
"

26 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011
   Info:          Public event from application Other
   Info:          and module lrdm

   lrdm event
      apnRadGrpID 8
      radSesReqType 17
      code 0
"

27 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface Rad
             from application Radius-auth

   IP/UDP:   from 1.1.1.1 (port 65445) to 100.0.0.2 (port 1813)

   RADIUS:   Accounting Request (4) id=166 len=328
   - Acct-Status-Type: Start (1)
   - NAS-IP-Address: 1.1.1.1
   - Acct-Delay-Time: 0
   - User-Name: "206010000000011"
   - Service-Type: Framed-User (2)
   - Framed-Protocol: 7
   - Framed-IP-Address: 43.0.32.1
   - Framed-IP-Netmask: 255.255.224.0
   - NAS-Identifier: "CP1"
   - Acct-Session-Id: "F00010110A06B683A0110004B"
   - Acct-Multi-Session-Id: "Y20000093A06B683A00010110"
   - Acct-Authentic: RADIUS (1)
   - Event-Timestamp: THU APR 10 21:43:25 2025

   - Called-Station-Id: "demo.nokia.mnc001.mcc206.gprs"
   - NAS-Port-Type: Virtual (5)
   - Alc-Subsc-ID-Str: "206010000000011"
   - Alc-Subsc-Prof-Str: "sub-fwa"
   - Alc-SLA-Prof-Str: "sla-fwa"
   - Alc-UPId: "up2.nokia.com"
   - Alc-UPIp-Address: 1.1.1.102
   - Alc-UPSubscriber-Id: 536871059
   - Alc-Active-Addresses: v4 (1)
   - 3GPP-IMSI: "206010000000011"
   - 3GPP-RAT-Type: 51
   - 3GPP-Location-Info: 0x8902f61000000102f6100000000100
"

28 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     egressing frame on interface NSMF_PDU_SESSION
             from application Other

   IP/TCP:   from 1.1.1.1 (port 65520) to 10.100.1.2 (port 32786)

   HTTP2:
:status: 200
content-type: application/json
{"upCnxState":"ACTIVATED"}"

29 2025/04/10 23:43:26.006 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000011

   Info:     ingressing frame on interface Rad
             to application Radius-auth

   IP/UDP:   from 100.0.0.2 (port 1813) to 1.1.1.1 (port 65445)

   RADIUS:   Accounting Response (5) id=166 len=20
"
```

### 4.1.3 **Checking the UP**
The session is created on UP1 and can be verified via the below predefined script:

```bash
A:admin@UP1# show s-5g
===============================================================================
GTP statistics
===============================================================================
===============================================================================

===============================================================================
PFCP Sessions
===============================================================================
Local Session Id                     : 0x0000000000000001 (default tunnel)
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : N/A
Remote Session Id                    : 0x0000000000010100
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x0001fff0
PFCP Association                     : sx
Data Upstream PDR-ID                 : N/A
Data Downstream PDR-ID               : N/A
IBCP Upstream PDR-ID                 : 0x0a00
IBCP Downstream PDR-ID               : N/A
StateId                              : N/A
Protocols                            : IPOE_DHCP4 IPOE_DHCP6 PPPOE_DISC
===============================================================================
Local Session Id                     : 0x0000000000000074
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80420000
Remote Session Id                    : 0x0000000000010130
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010132
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:00
StateId                              : N/A
Subscriber Id                        : _cups_536871060
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000011
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00440000
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000001
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.64.1
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
No. of PFCP Sessions: 2
===============================================================================

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_536871060
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:00 - svc:500
           |   PFCP session-id      : 0x0000000000000074
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000011
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.64.1 - PFCP

-------------------------------------------------------------------------------
Number of active subscribers : 1
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
Executed 8 lines in 0.0 seconds from file "cf1:\scripts-md\s-5g"

```

### 4.1.4 **Checking the 5G FWA home-user**

You can check the UE VM that uesimtun0 is created with the UE IP address 43.0.64.1/32.

```bash
ue1>ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
3219: eth0@if3220: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:28:43 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.40.67/24 brd 192.168.40.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:2843/64 scope link
       valid_lft forever preferred_lft forever
149: uesimtun0: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.64.1/32 scope global uesimtun0
       valid_lft forever preferred_lft forever
    inet6 fe80::77fc:2341:6180:d63c/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
3264: eth1@if3263: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:15:43:d7 brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 10.90.1.2/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe15:43d7/64 scope link
       valid_lft forever preferred_lft forever    
```
### 4.1.5 **Checking the dataplane**

The 5G FWA home-user can reach the UP via the uesimtun0.

```bash
[root@compute-1 scripts]# docker exec -it cups-ue1 bash
ue1>ip r
default via 192.168.40.1 dev eth0
1.1.1.0/24 dev uesimtun0 scope link
10.90.1.0/24 dev eth1 proto kernel scope link src 10.90.1.2
192.168.40.0/24 dev eth0 proto kernel scope link src 192.168.40.67

ue1>ping 1.1.1.101
PING 1.1.1.101 (1.1.1.101): 56 data bytes
64 bytes from 1.1.1.101: seq=0 ttl=64 time=10.692 ms
64 bytes from 1.1.1.101: seq=1 ttl=64 time=6.130 ms
64 bytes from 1.1.1.101: seq=2 ttl=64 time=7.301 ms
```

## 4.2 **Testing 10 IMSI 5G sessions**
Start the session using the below predefined script:

```bash
[root@compute-1 scripts]# ./start_5g_cups_10IMSI.sh
Waiting for uesimtun interfaces to appear...
All uesimtun interfaces are ready. Adding routes...
Routes added successfully: ip route add 1.1.1.0/24 nexthop dev uesimtun0 nexthop dev uesimtun1 nexthop dev uesimtun2 nexthop dev uesimtun3 nexthop dev uesimtun4 nexthop dev uesimtun5 nexthop dev uesimtun6 nexthop dev uesimtun7 nexthop dev uesimtun8 nexthop dev uesimtun9
```
### 4.2.1 **CP session check**
The session are created on CP1 and CP2 via the below predefined script.
```bash
*A:CP1# exec s-5g
Pre-processing configuration file (V0v0)...
Completed processing 33 lines in 0.0 seconds


===============================================================================
IMSI/IMEI(#)        APN       Type    Beare* UE Address (IPv4/IPv6)  Ref-pt/Si*
  /MSISDN(^)/MAC(`)
  /SubId/SEID(~)
===============================================================================
206010000000007     demo.nok* IPv4    1      43.0.128.5/-            N11/http2
206010000000005     demo.nok* IPv4    1      43.0.128.1/-            N11/http2
206010000000003     demo.nok* IPv4    1      43.0.128.2/-            N11/http2
206010000000010     demo.nok* IPv4    1      43.0.96.5/-             N11/http2
206010000000001     demo.nok* IPv4    1      43.0.96.1/-             N11/http2
206010000000006     demo.nok* IPv4    1      43.0.96.3/-             N11/http2
206010000000008     demo.nok* IPv4    1      43.0.96.4/-             N11/http2
206010000000002     demo.nok* IPv4    1      43.0.96.2/-             N11/http2
206010000000004     demo.nok* IPv4    1      43.0.128.3/-            N11/http2
206010000000009     demo.nok* IPv4    1      43.0.128.4/-            N11/http2
-------------------------------------------------------------------------------
Number of PDN instances : 10
-------------------------------------------------------------------------------
# indicates that the corresponding row is IMEI entry.
^ indicates that the corresponding row is MSISDN entry.
` indicates that the corresponding row is MAC entry.
~ indicates that the corresponding row is SEID entry.
-------------------------------------------------------------------------------
* indicates that the corresponding row element may have been truncated.


===============================================================================
PDN context detail
===============================================================================
SUPI             : 206010000000001
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

UE IPv4 address  : 43.0.96.1
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
AMF PCF ID       : e593cd62-14a5-41f0-b38c-69fe07667a4e
-------------------------------------------------------------------------------
Service Based Interface (SBI) Information
-------------------------------------------------------------------------------
Service Realm    : sbaRealm1

NF Service       : nsmf-pdusession
NF Role          : producer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
URI              : http://1.1.1.1:65520/nsmf-pdusession/v1/sm-contexts/00020120
Service Instance : nsmf_pdusession1

NF Service       : namf-comm
NF Role          : consumer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
Service Instance : namf-comm1

NF Service       : namf-evts
NF Role          : consumer
NF ID            : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
URI              : http://1.1.1.1:65520/smfPduSession/00020120

NF Service       : nudm-sdm
NF Role          : consumer
NF ID            : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
URI              : http://10.40.1.4:8080/nudm-sdm/v2/imsi-206010000000001/sdm-
                   subscriptions/c8a770c4-1657-41f0-bba5-1b0a43304fa7
Service Instance : udm-sdm1

NF Service       : nudm-uecm
NF Role          : consumer
NF ID            : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
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
UP Sx-N4 Ctl V4      : 1.1.1.102
CP Sx-N4 Ctl V4      : 1.1.1.1
CP Sx-N4 Seid        : 0x20120
UP Sx-N4 Seid        : 0x73
gNb N3 Data TEID     : 0x4
gNb N3 IPv4 Address  : 10.80.1.10
UP N3 Data TEID      : 0x440000
UP N3 IPv4 Address   : 1.1.1.102

QFI(s)               : 9

-------------------------------------------------------------------------------

Def PFCP-u Sess  : False
Network/Itf Realm: N/A
-------------------------------------------------------------------------------
Number of PDN contexts : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.


===============================================================================
PDN context detail
===============================================================================
No Matching Entries
===============================================================================

===============================================================================
PDN gateway statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1

Real APNs                  : 3          Roamers                    : 0
Homers                     : 0          Visitors                   : 0
VPRNs                      : 3          IP Local Pools             : 0
PDN Sessions               : 0          Ipv4 PDN Sessions          : 0
Ipv6 PDN Sessions          : 0          Ipv4v6 PDN Sessions        : 0
BNG PDN Sessions           : 0
Bearers                    : 0          Default Bearers            : 0
Dedicated Bearers          : 0          Ipv4 Bearers               : 0
Ipv6 Bearers               : 0          Ipv4v6 Bearers             : 0
SDFs                       : 0
HSS Static IPv4 PDN Sessio*: 0          HSS Static IPv6 PDN Sessio*: 0
HSS Static IPv4v6 PDN Sess*: 0          eHRPD PDN sessions         : 0
LTE PDN sessions           : 0          2G/3G PDN sessions         : 0
PDN sessions in suspend st*: 0          Emergency PDN sessions     : 0
Rf Peers                   : 0          Rf Acct start buffered     : 0
Rf Acct Int buffered       : 0          Rf Acct stop buffered      : 0
Ga DRT Req in queue        : 0          Ga DRT Req max queued      : 0
Ga CDRs buffered           : 0          S2b Sessions               : 0
Redirected Sessions        : 0          Tethered Sessions          : 0
Overload - Dropped requests: 0
Paging in progress         : 0          Allocated Paging Buffers   : 0
Available Paging Buffers   : 1          Paging Buffers n/a Errors  : 0
Charging paused sessions   : 0
Number of ENBs             : 1          Number of MMEs             : 0
Total Number of UEs        : 0          Total Number of Idle UEs   : 0
UEs in suspended state     : 0          Paging drops               : 0
Buff Pkts drop tmr expired : 0          Buff Bytes drop tmr expired: 0 B
Buff Pkts drop max pkt lmt : 0          Buff Bytes drop max pkt lmt: 0 B
Buff Pkts drop max cap lmt : 0          Buff Bytes drop max cap lmt: 0 B
BNG UEs                    : 0
Number of RNCs             : 0          Number of SGSNs            : 0
Combo Bearers              : 0          Combo Default bearers      : 0
Combo Active Bearers       : 0          Combo Idle bearers         : 0
Combo Dedicated bearers    : 0          Combo Ipv4 bearers         : 0
Combo Ipv6 bearers         : 0          Combo Ipv4v6 bearers       : 0
Combo sessions             : 0          Combo Ipv4 sessions        : 0
Combo Ipv6 sessions        : 0          Combo Ipv4v6 sessions      : 0
Ga Big DTRs buffered       : 0
S2a Sessions               : 0
TWAG SaMOG Sessions        : 0          TWAG NSWO sessions         : 0
Steering default sessions  : 0
Low Priority Combo Sessions: 0          Low Priority PGW Sessions  : 0
Unsol. SSG Sess In Att Ret*: 0
PDN sessions w dedic bear  : 0
Number of PFCP Peers       : 2          PDN sessions in Idle state : 0
eMPS IMS Sessions          : 0          eMPS IMS Advance Prio Sess : 0
eMPS dedicated bearers     : 0
5G capable 4G sessions     : 0
PFCP-u Shared Tnl Sess     : 2          PFCP-u Shared Tnl Sess Ipv4: 2
PFCP-u Shared Tnl Sess Ipv6: 0

UL Throughput (Mbps)       : 0
DL Throughput (Mbps)       : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.

===============================================================================
Session Management Function statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1
Real DNNs                  : 0
H-SMF Roamers              : 0          V-SMF Roamers              : 0
Homers                     : 10         Visitors                   : 0
VPRNs                      : 0          IP Local Pools             : 0
PDU Sessions               : 10         Ipv4 PDU Sessions          : 10
Ipv6 PDU Sessions          : 0          Ipv4v6 PDU Sessions        : 0
UDM Static IPv4 PDU Sessio*: 0          UDM Static IPv6 PDU Sessio*: 0
UDM Static IPv4v6 PDU Sess*: 0
Active PDU Sessions        : 10         Idle PDU Sessions          : 0
QoS Flows                  : 10
Default QoS Flows          : 10         Dedicated QoS Flows        : 0
Paging in progress         : 0          Allocated Paging Buffers   : 0
Available Paging Buffers   : 0          Paging Buffers n/a Errors  : 0
Number of GNBs             : 0          Number of AMFs             : 0
Total Number of UEs        : 10         Total Number of Idle UEs   : 0
Num of UEs SGW Serv Node   : 0          Num of UEs ePDG Serv Node  : 0
Num of UEs AMF Serv Node   : 10         5G sessions w N26 Indicati*: 0
Paging drops               : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.


===============================================================================
PDN gateway session attach failure statistics
===============================================================================
VNF/VM                     : 1/2        Gateway                    : 1

Create Packet Issue        : 0          GTP No Resource            : 0
Peer Down                  : 0          PMIP No Resource           : 0
Peer Admin Down            : 0          Peer Recovery Count Changed: 0
Missing Invalid IE         : 0          Packet Drop                : 0
Internal Error             : 0          Invalid Peer               : 0
Ip Addr Not Available      : 0          Peer PGW overload          : 0
User Authentication Failed : 0
-------------------------------------------------------------------------------
VNF/VM                     : 1/A        Gateway                    : 1

Create Packet Issue        : 0          GTP No Resource            : 0
Peer Down                  : 0          PMIP No Resource           : 0
Peer Admin Down            : 0          Peer Recovery Count Changed: 0
Missing Invalid IE         : 0          Packet Drop                : 0
Internal Error             : 0          Invalid Peer               : 0
Ip Addr Not Available      : 0          Peer PGW overload          : 0
User Authentication Failed : 0
-------------------------------------------------------------------------------
Number of cards : 2
===============================================================================


===============================================================================
APN statistics summary
===============================================================================

APN Admin State    : up                 APN Oper State     : up

APN                : demo.nokia.mnc001.mcc206.gprs
Homers             : 10                 Visitors           : 0
Roamers            : 0
Idle Timeouts      : 0                  Session Timeouts   : 0
PDNs w susp proc   : 0
Dedicated Bearers  : 0
Ipv4 PDN Sessions  : 0                  Ipv6 PDN Sessions  : 0
Ipv4v6 PDN Sessions: 0
Ipv4 PDP Contexts  : 0                  Ipv6 PDP Contexts  : 0
Ipv4v6 PDP Contexts: 0                  Secondary PDP Cont*: 0
Ipv4 PMIP Sessions : 0                  Ipv6 PMIP Sessions : 0
Ipv4v6 PMIP Sessio*: 0
Ipv4 S2a Sessions  : 0                  Ipv6 S2a Sessions  : 0
Ipv4v6 S2a Sessions: 0
Ipv4 S2b Sessions  : 0                  Ipv6 S2b Sessions  : 0
Ipv4v6 S2b Sessions: 0
L2TP Sessions      : 0
Ipv4 IP Local Pool : 0                  Ipv6 IP Local Pool : 0
Ipv4v6 IP Local Po*: 0
Ipv4 AAA Sessions  : 0                  Ipv6 AAA Sessions  : 0
Ipv4v6 AAA Sessions: 0
Ipv4 HSS Sessions  : 0                  Ipv6 HSS Sessions  : 0
Ipv4v6 HSS Sessions: 0
Ipv4 DHCP Sessions : 0                  Ipv6 DHCP Sessions : 0
Ipv4v6 DHCP Sessio*: 0                  Ipv4 DHCP-Relay Se*: 0
Bonded IPv4 Sessio*: 0                  Bonded IPv6 Sessio*: 0
Bonded IPv4v6 Sess*: 0
Pcrf-apn-ambr upda*: 0
Redirected Sessions: 0                  Tethered Sessions  : 0
Selective Radius a*: disabled
eMPS IMS Sessions  : 0
Combo Ses by 5G UEs: 0                  PGW Ses by 5G UEs  : 0

PDN sessions having a dedicated bearer : 0

Statistics for APN used as real
Real APN PDN Sessi*: 10
Ipv4 PDN Sessions  : 0                  Ipv6 PDN Sessions  : 0
Ipv4v6 PDN Sessions: 0                  Non-Ip PDN Sessions: 0
Dedicated Bearers  : 0
Ipv4 PDP Contexts  : 0                  Ipv6 PDP Contexts  : 0
Ipv4v6 PDP Contexts: 0                  Secondary PDP Cont*: 0

Ipv4 S2a Sessions  : 0                  Ipv6 S2a Sessions  : 0
Ipv4v6 S2a Sessions: 0
Ipv4 S2b Sessions  : 0                  Ipv6 S2b Sessions  : 0
Ipv4v6 S2b Sessions: 0

APN override triggers              : 0
APN override triggers failed       : 0
APN override establishments failed : 0

Inactivity Timer Sessions Distribution
0-30m              : 0                  30m-1hr            : 0
1hr-3hr            : 0                  3hr-6hr            : 0
6hr-12hr           : 0                  12hr-24hr          : 0
1d-2d              : 0                  2d-5d              : 0
5d-10d             : 0                  10d+               : 0
TWAG SaMOG Sessions: 0                  TWAG NSWO Sessions : 0
Neighbor Solicitation Packets Rx    : 0
Neighbor Solicitation Packets Droppd: 0
Neighbor Advertisement Packets Tx   : 0

UL Throughput (Mbps)       : 0
DL Throughput (Mbps)       : 0

Service Based Architecture (SBA) Statistics
IPv4 PDU Sessions  : 0                  IPv6 PDU Sessions  : 0
IPv4v6 PDU Sessions: 0                  IPv4 UDM PDU Sessi*: 0
IPv6 UDM PDU Sessi*: 0                  IPv4v6 UDM PDU Ses*: 0
QoS Flows          : 10
PDU Sessions with more than one QoS Flow : 0
-------------------------------------------------------------------------------
Number of VMs : 1
===============================================================================
* indicates that the corresponding row element may have been truncated.


===============================================================================
APN delete-sessions statistics
===============================================================================
VNF/VM             : 1/2                Gateway            : 1
Non Attach failures
Acct Idle Timeout  : 0                  Acct Resource Fail : 0
Admn Imsi Clear    : 39                 Admn local Imsi Cl*: 103
Admn Clear Imsi Re*: 0                  Admn clear APN     : 0
Admn Gateway Shutd*: 0                  Dia Internal Error : 0
Dia PCRF Disabled  : 0                  Dia Memory Error   : 0
Dia Tx Timer Expire: 0                  Dia Gen Encode Err*: 0
Dia Gen Decode Err*: 0                  Dia AMS Error      : 0
Dia Session Down   : 0                  Dia Timer Error    : 0
Dia Authorization *: 0                  Dia PCRF Down      : 0
WLAN to LTE HO Fail: 0                  Gx Session Release : 0
Radius Disconnect  : 0                  Rf No Acknowledgem*: 0
ASR Def Bearer     : 0                  Gy Bad Ans Def Bea*: 0
PMIP Inter HSGW HO*: 0                  PMIP Life Time Exp : 0
PMIP To LTE HO Fail: 0                  PMIP PBA Reject    : 0
PMIP PBA Timeout   : 0                  Inter RAT HO Fail  : 0
LTE TO EPDG HO Fail: 0                  EPDG To LTE HO Fail: 0
PMIP Instance Shut : 0                  PMIP Peer Down     : 0
PMIP Reattach      : 0                  Missing CCA Usg Th*: 0
Inter SGW HO Fail  : 0                  SMGR Svc Not Suppo*: 0
3G to 4G HO Fail   : 0                  4G to 3G HO Fail   : 0
Ctxt Not Found     : 0                  Inter SGSN HO Fail : 0
SMGR Memory Error  : 0                  Session Timeout    : 0
SMGR Bad Param     : 0                  Peer Down          : 0
UE Normal Detach   : 0                  Unknown            : 0
LTE TO PMIP HO Fail: 0                  PMIP TO LTE HO Fail: 0
Addr Pool Missing  : 0                  Addr Alloc Fail    : 0
APN Access Denied  : 0                  APN Restricted     : 0
Missing Uknwn APN  : 0                  APN Internal Error : 0
Missing IE         : 0                  Invalid IE         : 0
Other Auth Fail    : 0                  User Auth Fail     : 0
APNMGR Svc Not Sup*: 0                  Connect Type Not S*: 0
Addr Pool Exhausted: 0                  Fh Sess Cont Timer : 0
GTP Peer Restart   : 0                  GTP PGW No Response: 0
GTP Sess Not Found : 0                  GTP UE Not Found   : 0
GTP Missing IE     : 0                  GTP Unknown IE     : 0
GTP UE Nw Init Det*: 0                  GTP HO Fail        : 0
LTE To WLAN HO Fail: 0                  Gy Session Failed  : 0
GTP Internal Error : 0                  GTP PDN Present    : 0
GTP Session Create*: 0                  GTP Ded Bearer Cre*: 0
GTP Dwnl Create Fa*: 0                  GTP SGW No Response: 0
GTP MME No Response: 0                  GTP Addr Alloc Fail: 0
GTP Del In Progress: 0                  GTP Ctx Not Found  : 0
GTP No Bearer Reso*: 0                  GTP Invalid IE     : 0
GTP Bearer Not Fou*: 0                  Geo Red Audit      : 0
HA Audit           : 0                  Mgr Init Session R*: 0
Gy Missing CCA     : 0                  GTP SGW Change     : 0
Stale To Relocation: 0                  Idle To Disallow R*: 0
Cmd Lvl FUA Termin*: 0
CCFH Volume Limit  : 0
Gx Quota Exhausted : 0                  Gx Time Exhausted  : 0
PMIP to WLAN HO Fa*: 0                  Denied No Subscrip*: 0
Roaming Restriction: 0
-------------------------------------------------------------------------------
Number of cards: 1
===============================================================================
* indicates that the corresponding row element may have been truncated.


===============================================================================
APN attach-failure statistics
===============================================================================
VNF/VM             : 1/2                Gateway            : 1
Attach failures
Acct Resource Fail : 0                  Dia Internal Error : 0
Dia PCRF Disabled  : 0                  Dia Memory Error   : 0
Dia Tx Timer Expire: 0                  Dia Gen Encode Err*: 0
Dia Gen Decode Err*: 0                  Dia AMS Error      : 0
Dia Session Down   : 0                  Dia Timer Error    : 0
Dia Authorization *: 0                  Dia Authentication*: 0
Dia PCRF Down      : 0                  Gy Setup Fail      : 0
Rulebase Change Fa*: 0                  Send Gx CCRI Fail  : 0
SMGR Svc Not Suppo*: 0                  Invalid Mandatory *: 0
SMGR Memory Error  : 0                  Addr Pool Exhausted: 0
Addr Pool Missing  : 0                  Addr Alloc Fail    : 0
Addr Pool Invalid *: 0                  APNMGR Msg Send Fa*: 0
APN Access Denied  : 0                  APN Restricted     : 0
Missing Uknwn APN  : 0                  APN Internal Error : 0
Missing IE         : 0                  Invalid IE         : 0
Other Auth Fail    : 0                  User Auth Fail     : 0
APNMGR Svc Not Sup*: 0                  Connect Type Not S*: 0
PCRF Session Relea*: 0                  SMGR Bad Param     : 0
Selection Mode Mis*: 0                  Del while Attach i*: 0
APNMGR No Resources: 0                  Cmd Lvl FUA Term   : 0
Diameter User Unkn*: 0
UP selection       : 0
-------------------------------------------------------------------------------
Number of cards: 1
===============================================================================
* indicates that the corresponding row element may have been truncated.


===============================================================================
BNG Sessions
===============================================================================
[FWA] IMSI/SUPI                : 206010000000001
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
RAN GTP-U TEID                 : 0x00000004
UP GTP-U IP                    : 1.1.1.102
UP GTP-U TEID                  : 0x00440000
S11 MME GTP-C IP               : N/A
S11 MME GTP-C TEID             : N/A
S11 CP GTP-C IP                : N/A
S11 CP GTP-C TEID              : N/A
N11 AMF GUAMI                  : 206 01 0x20040
N11 AMF NF Instance Id         : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
N10 UDM SDM NF Instance Id     : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
N10 UDM UECM NF Instance Id    : e58b6eba-14a5-41f0-bba5-1b0a43304fa7
N7 PCF NF Instance Id          : N/A
N40 CHF NF Instance Id         : N/A
N4 UPF NF Instance Id          : N/A
N1 PDU Session Id              : 1
S-NSSAI                        : SST 1, SD 0xabcdef
QFI(s)                         : 9
EBI(s)                         : N/A
Local Priority                 : N/A
UP Security Integrity          : N/A
UP Security Confidentiality    : N/A
UP Security UPIP Max UL Rate   : max-ue-rate
UP Security UPIP Max DL Rate   : max-ue-rate
UP Security UPIP 4G Supported  : No
IPv4 Signaling Method          : NAS
IPv4 Link MTU                  : N/A

Up Time                        : 0d 00:00:41
Provisioned Addresses          : IPv4
Signaled Addresses             : IPv4

UP Peer                        : 1.1.1.102
Selected APN/DNN               : demo.nokia.mnc001.mcc206.gprs
Network Realm                  : bngvrf
IPv4 Pool                      : fwa

IPv4 Address                   : 43.0.96.1
IPv4 Address Origin            : Local pool
IPv4 Prefix Len                : 19
IPv4 Gateway                   : 43.0.127.254
IPv4 Primary DNS               : 208.67.254.254
IPv4 Secondary DNS             : 208.67.255.255
IPv4 Primary NBNS              : 0.0.0.0
IPv4 Secondary NBNS            : 0.0.0.0
DHCPv4 Server IP               : 43.0.127.254
DHCPv4 Lease Time              : 7d 00:00:00
DHCPv4 Renew Time              : 3d 12:00:00
DHCPv4 Rebind Time             : 6d 03:00:00
DHCPv4 Lease End               : N/A
DHCPv4 Remaining Lease Time    : N/A

Subscriber                     : 206010000000001 (536871061)
Acct-Session-Id                : F00020120A06B683A01200040
Acct-Multi-Session-Id          : Y20000095A06B683A00020120
State Id                       : N/A
Sub Profile                    : sub-fwa
Sla Profile                    : sla-fwa
UP Alternate Sub Profile       : N/A
UP Alternate Sla Profile       : N/A
App Profile                    : N/A
Content Filtering Policy Id    : 0
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

PFCP Node ID                   : up2.nokia.com
PFCP Local SEID                : 0x0000000000020120
PFCP Remote SEID               : 0x0000000000000073

UE Id                          : 0x00020120
PDN Session Id                 : 0x00020120
Group/VM                       : 1/2
Call-Insight                   : enabled

Charging Profile 1             : accounting-1
  Radius enabled               : Yes
  CHF enabled                  : No
  CHF rating group             : N/A

-------------------------------------------------------------------------------
Number of sessions shown : 1
===============================================================================
===============================================================================
BNG session aggregate statistics
===============================================================================
[FWA] IMSI/SUPI                : 206010000000001
      APN/DNN                  : demo.nokia.mnc001.mcc206.gprs
      N1 PDU Session Id        : 1
-------------------------------------------------------------------------------
Time                           : 04/11/2025 00:05:04
Packets down                   : 0
Packets up                     : 0
Octets down                    : 0
Octets up                      : 0
Packets down dropped           : 0
Packets up dropped             : 0
Octets down dropped            : 0
Octets up dropped              : 0
-------------------------------------------------------------------------------
No. of sessions: 1
===============================================================================

command :
clear mobile-gateway pdn  1 bearer-context imsi 206010000000001

Executed 33 lines in 0.2 seconds from file cf1:\magc\s-5g
```
### 4.2.2 **Checking the 5G FWA home-user IP setting**

Check the 5G FWA home-user to verify that 10 IMSI are attached i.e.uesimtun0 to uesimtun9 are created.

```bash
ue1>ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
3219: eth0@if3220: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:a8:28:43 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.40.67/24 brd 192.168.40.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:c0ff:fea8:2843/64 scope link
       valid_lft forever preferred_lft forever
150: uesimtun0: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.2/32 scope global uesimtun0
       valid_lft forever preferred_lft forever
    inet6 fe80::a100:a6f:f980:2688/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
151: uesimtun1: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.4/32 scope global uesimtun1
       valid_lft forever preferred_lft forever
    inet6 fe80::2c8b:fa42:869:3a0d/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
152: uesimtun2: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.128.1/32 scope global uesimtun2
       valid_lft forever preferred_lft forever
    inet6 fe80::265f:c43e:1a0e:e887/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
153: uesimtun3: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.1/32 scope global uesimtun3
       valid_lft forever preferred_lft forever
    inet6 fe80::6d3f:4b3b:a442:19/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
154: uesimtun4: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.128.3/32 scope global uesimtun4
       valid_lft forever preferred_lft forever
    inet6 fe80::96a:9be1:ad31:fd54/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
155: uesimtun5: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.3/32 scope global uesimtun5
       valid_lft forever preferred_lft forever
    inet6 fe80::f5ae:fe92:e7c0:4ece/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
156: uesimtun6: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.128.2/32 scope global uesimtun6
       valid_lft forever preferred_lft forever
    inet6 fe80::bdb7:6762:5074:1dfa/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
157: uesimtun7: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.96.5/32 scope global uesimtun7
       valid_lft forever preferred_lft forever
    inet6 fe80::2beb:5c0f:8633:2bef/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
158: uesimtun8: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.128.5/32 scope global uesimtun8
       valid_lft forever preferred_lft forever
    inet6 fe80::6f90:9e0b:c741:d27d/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
159: uesimtun9: <POINTOPOINT,PROMISC,NOTRAILERS,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 43.0.128.4/32 scope global uesimtun9
       valid_lft forever preferred_lft forever
    inet6 fe80::41ae:1a4a:2121:6df6/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
3264: eth1@if3263: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP group default
    link/ether aa:c1:ab:15:43:d7 brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 10.90.1.2/24 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe15:43d7/64 scope link
       valid_lft forever preferred_lft forever
```
### 4.2.3 **Sessions load balancing**

The 10 IMSIs are load balanced over the 2 UPs.
There are 6 PFCP sessions i.e. 5 IMSIs + default PCFP session between the CP and UP.

```bash
A:admin@UP1# show s-5g
===============================================================================
GTP statistics
===============================================================================
===============================================================================

===============================================================================
PFCP Sessions
===============================================================================
Local Session Id                     : 0x0000000000000001 (default tunnel)
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : N/A
Remote Session Id                    : 0x0000000000010100
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x0001fff0
PFCP Association                     : sx
Data Upstream PDR-ID                 : N/A
Data Downstream PDR-ID               : N/A
IBCP Upstream PDR-ID                 : 0x0a00
IBCP Downstream PDR-ID               : N/A
StateId                              : N/A
Protocols                            : IPOE_DHCP4 IPOE_DHCP6 PPPOE_DISC
===============================================================================
Local Session Id                     : 0x0000000000000075
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80460000
Remote Session Id                    : 0x0000000000020110
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40020112
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:48:00:00
StateId                              : N/A
Subscriber Id                        : _cups_536871062
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000005
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00480000
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000003
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.128.1
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000076
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80460001
Remote Session Id                    : 0x0000000000010170
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010172
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:48:00:10
StateId                              : N/A
Subscriber Id                        : _cups_536871064
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000004
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00480010
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000005
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.128.3
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000077
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80460002
Remote Session Id                    : 0x0000000000010150
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010152
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:48:00:20
StateId                              : N/A
Subscriber Id                        : _cups_536871065
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000003
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00480020
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000007
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.128.2
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000078
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80460003
Remote Session Id                    : 0x00000000000101b0
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x400101b2
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:48:00:30
StateId                              : N/A
Subscriber Id                        : _cups_536871069
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000009
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00480030
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x0000000a
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.128.4
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000079
Local Peer Address                   : 1.1.1.101
Local Router                         : sx
Local TE-ID                          : 0x80460004
Remote Session Id                    : 0x0000000000010180
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010182
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:48:00:40
StateId                              : N/A
Subscriber Id                        : _cups_536871068
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000007
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.101
Local Gtpu TE-ID                     : 0x00480040
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000009
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.128.5
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
No. of PFCP Sessions: 6
===============================================================================

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_536871062
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:48:00:00 - svc:500
           |   PFCP session-id      : 0x0000000000000075
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000005
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.128.1 - PFCP

-- _cups_536871064
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:48:00:10 - svc:500
           |   PFCP session-id      : 0x0000000000000076
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000004
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.128.3 - PFCP

-- _cups_536871065
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:48:00:20 - svc:500
           |   PFCP session-id      : 0x0000000000000077
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000003
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.128.2 - PFCP

-- _cups_536871068
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:48:00:40 - svc:500
           |   PFCP session-id      : 0x0000000000000079
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000007
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.128.5 - PFCP

-- _cups_536871069
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:48:00:30 - svc:500
           |   PFCP session-id      : 0x0000000000000078
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000009
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.128.4 - PFCP

-------------------------------------------------------------------------------
Number of active subscribers : 5
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
Executed 8 lines in 0.0 seconds from file "cf1:\scripts-md\s-5g"

```

The other 5 IMSIs are created on UP2.

```bash
A:admin@UP2# show s-5g
===============================================================================
GTP statistics
===============================================================================
===============================================================================

===============================================================================
PFCP Sessions
===============================================================================
Local Session Id                     : 0x0000000000000001 (default tunnel)
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : N/A
Remote Session Id                    : 0x0000000000010140
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x0002fff0
PFCP Association                     : sx
Data Upstream PDR-ID                 : N/A
Data Downstream PDR-ID               : N/A
IBCP Upstream PDR-ID                 : 0x0a00
IBCP Downstream PDR-ID               : N/A
StateId                              : N/A
Protocols                            : IPOE_DHCP4 IPOE_DHCP6 PPPOE_DISC
===============================================================================
Local Session Id                     : 0x0000000000000073
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80420000
Remote Session Id                    : 0x0000000000020120
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40020122
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:00
StateId                              : N/A
Subscriber Id                        : _cups_536871061
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000001
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.102
Local Gtpu TE-ID                     : 0x00440000
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000004
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.96.1
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000074
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80420001
Remote Session Id                    : 0x0000000000020130
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40020132
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:10
StateId                              : N/A
Subscriber Id                        : _cups_536871063
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000002
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.102
Local Gtpu TE-ID                     : 0x00440010
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000001
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.96.2
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000075
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80420002
Remote Session Id                    : 0x0000000000010160
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010162
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:20
StateId                              : N/A
Subscriber Id                        : _cups_536871066
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000006
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.102
Local Gtpu TE-ID                     : 0x00440020
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000006
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.96.3
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000076
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80420003
Remote Session Id                    : 0x00000000000101a0
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x400101a2
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:30
StateId                              : N/A
Subscriber Id                        : _cups_536871067
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000008
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.102
Local Gtpu TE-ID                     : 0x00440030
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000002
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.96.4
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
Local Session Id                     : 0x0000000000000077
Local Peer Address                   : 1.1.1.102
Local Router                         : sx
Local TE-ID                          : 0x80420004
Remote Session Id                    : 0x0000000000010190
Remote Peer Address                  : 1.1.1.1
Remote TE-ID                         : 0x40010192
PFCP Association                     : sx
Data Upstream PDR-ID                 : 0x4a00
Data Downstream PDR-ID               : 0x8a00
IBCP Upstream PDR-ID                 : 0x6a00
IBCP Downstream PDR-ID               : 0xaa00
Session Type                         : IPoE
Sap                                  : pxc-1.b:1.80
Mac                                  : 00:03:00:44:00:40
StateId                              : N/A
Subscriber Id                        : _cups_536871070
Sub Profile                          : sub-fwa
SLA Profile                          : sla-fwa
Fate Sharing Group Id                : N/A
Default Qfi                          : 9
Default Rqi                          : false
IMSI                                 : 206010000000010
APN                                  : demo.nokia.mnc001.mcc206.gprs
Local Gtpu Router                    : sx
Local Gtpu Address                   : 1.1.1.102
Local Gtpu TE-ID                     : 0x00440040
Remote Gtpu Address                  : 10.80.1.10
Remote Gtpu TE-ID                    : 0x00000008
Call-trace profile                   : (Not Specified)
-------------------------------------------------------------------------------
    Host                             :
        IP Address                   : 43.0.96.5
        Forwarding                   : Yes
        L2-Aware                     : No
===============================================================================
No. of PFCP Sessions: 6
===============================================================================

===============================================================================
Active Subscribers Hierarchy
===============================================================================
-- _cups_536871061
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:00 - svc:500
           |   PFCP session-id      : 0x0000000000000073
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000001
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.96.1 - PFCP

-- _cups_536871063
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:10 - svc:500
           |   PFCP session-id      : 0x0000000000000074
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000002
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.96.2 - PFCP

-- _cups_536871066
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:20 - svc:500
           |   PFCP session-id      : 0x0000000000000075
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000006
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.96.3 - PFCP

-- _cups_536871067
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:30 - svc:500
           |   PFCP session-id      : 0x0000000000000076
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000008
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.96.4 - PFCP

-- _cups_536871070
   (sub-fwa)
   |
   +-- sap:[pxc-1.b:1.80] - sla:sla-fwa
       |
       +-- PFCP-session (IPoE) - mac:00:03:00:44:00:40 - svc:500
           |   PFCP session-id      : 0x0000000000000077
           |   Fate-Sharing-Group   : N/A
           |   Imsi                 : 206010000000010
           |   Apn                  : demo.nokia.mnc001.mcc206.gprs
           |
           +-- 43.0.96.5 - PFCP

-------------------------------------------------------------------------------
Number of active subscribers : 5
Flags: (N) = the host or the managed route is in non-forwarding state
===============================================================================
Executed 8 lines in 0.0 seconds from file "cf1:\scripts-md\s-5g"

[/]
A:admin@UP2#
```





### 4.2.4 **Checking the data-plane** 

The UPs are reached via the uesimtunx.

```bash
ue1>ip r
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
ue1>
```



```bash
ue1>ping 1.1.1.102 -I uesimtun0
PING 1.1.1.102 (1.1.1.102): 56 data bytes
64 bytes from 1.1.1.102: seq=0 ttl=64 time=5.940 ms
64 bytes from 1.1.1.102: seq=1 ttl=64 time=5.134 ms
^C
--- 1.1.1.102 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 5.134/5.537/5.940 ms
ue1>ping 1.1.1.102 -I uesimtun1
PING 1.1.1.102 (1.1.1.102): 56 data bytes
64 bytes from 1.1.1.102: seq=0 ttl=64 time=3.905 ms
64 bytes from 1.1.1.102: seq=1 ttl=64 time=4.959 ms
64 bytes from 1.1.1.102: seq=2 ttl=64 time=4.704 ms

ue1>ping 1.1.1.101 -I uesimtun2
PING 1.1.1.101 (1.1.1.101): 56 data bytes
64 bytes from 1.1.1.101: seq=0 ttl=64 time=5.780 ms
64 bytes from 1.1.1.101: seq=1 ttl=64 time=5.881 ms
^C
--- 1.1.1.101 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 5.780/5.830/5.881 ms

ue1>ping 1.1.1.102 -I uesimtun3
PING 1.1.1.102 (1.1.1.102): 56 data bytes
64 bytes from 1.1.1.102: seq=0 ttl=64 time=5.965 ms
64 bytes from 1.1.1.102: seq=1 ttl=64 time=5.217 ms

ue1>ping 1.1.1.101 -I uesimtun4
PING 1.1.1.101 (1.1.1.101): 56 data bytes
64 bytes from 1.1.1.101: seq=0 ttl=64 time=5.052 ms
64 bytes from 1.1.1.101: seq=1 ttl=64 time=5.256 ms
^C
--- 1.1.1.101 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 5.052/5.154/5.256 ms
```



## 5. **General show commands**
Some general show commands to check the CP communication with other elements i.e. UDM,AMF and NRF via the below predefined script.

```bash
*A:CP1# exec sba-stats
Pre-processing configuration file (V0v0)...
Completed processing 76 lines in 0.0 seconds
===============================================================================
          nf-type pcf
===============================================================================
show mobile-gateway pdn service-stats nf-type pcf

===============================================================================
PCF peer service statistics per peer instance
===============================================================================
No Matching Entries
===============================================================================
===============================================================================
          nf-type nrf
===============================================================================
show mobile-gateway pdn service-stats nf-type nrf

===============================================================================
NRF peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nnrf-nfm
-------------------------------------------------------------------------------
Service Instance       : nnrf_nfm1
NF instance ID         : dbc0409c-8b91-4aaa-8727-3cd7e354e7ac

Registered             : Yes, 04/10/2025 21:46:02
Heartbeat Interval     : 10

NF Register            : 1
NF Register Failures   : 0

NF Update Partial      : 0
NF Update Partial Fail : 0

NF Heartbeat           : 925
NF Heartbeat Failures  : 0

NF Update Full         : 0
NF Update Full Fail    : 0

NF Deregister          : 0
NF Deregister Failures : 0

NF Status Subscribe    : 6
NF Status Subscrb Fail : 6
NF Status Subs Update  : 0
NF .. Subs Update Fail : 0
AMF Status Subscribe   : 2              UDM Status Subscribe   : 4
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

NF Discovery           : 6              NF Discovery Pending   : 0
NF Discovery Failures  : 0
AMF Discovery          : 2              AMF Discovery Pending  : 0
AMF Discovery Failures : 0
UDM Discovery          : 4              UDM Discovery Pending  : 0
UDM Discovery Failures : 0
PCF Discovery          : 0              PCF Discovery Pending  : 0
PCF Discovery Failures : 0
CHF Discovery          : 0              CHF Discovery Pending  : 0
CHF Discovery Failures : 0
-------------------------------------------------------------------------------
Number of instances    : 1
===============================================================================
===============================================================================
          nf-type amf
===============================================================================
show mobile-gateway pdn service-stats nf-type amf

===============================================================================
AMF peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : namf-comm
-------------------------------------------------------------------------------
Service Instance       : namf-comm1
NF instance ID         : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
N1N2 Message Transfer  : 14
  N1 PDU Session Establishment Reject                    : 0
  N1 PDU Session Modification Command                    : 0
  N1 PDU Session Release Command                         : 1
  N2 PDU Session Resource Setup Request                  : 13
  N1 PDU Session Establishment Accept                    : 13
  N2 PDU Session Resource Modify Request                 : 0
  N2 PDU Session Resource Release Command                : 1
N1N2 Msg Transf Succ   : 14             N1N2 Msg Transf Fail   : 0
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
Update SM Ctx Req      : 0
  N1 PDU Session Modification Request                    : 0
  N1 PDU Session Modification Complete                   : 0
  N1 PDU Session Modification Command Reject             : 0
  N1 PDU Session Release Request                         : 0
  N1 PDU Session Release Complete                        : 0
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
Update SM Ctx Fail     : 0
  N1 PDU Session Modification Reject                     : 0
  N1 PDU Session Release Reject                          : 0
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Modify Indication Unsuccessful : 0
  N2 Path Switch Request Unsuccessful                    : 0
  N2 Handover Preparation Unsuccessful                   : 0
Release SM Ctx Req     : 11
  With PDU session status mismatch                       : 0
Release SM Ctx Succ    : 0              Release SM Ctx Fail    : 11
SM Ctx Stat Notif      : 0              SM Ctx Stat Notif Succ : 0
SM Ctx Stat Notif Fail : 0
Retrieve SM Ctx Req    : 0              Retrieve SM Ctx Succ   : 0
Retrieve SM Ctx Fail   : 0
Number Of Sessions     : 0
-------------------------------------------------------------------------------
Service Instance       : nsmf_pdusession1
NF instance ID         : e57ae5f4-14a5-41f0-bc57-c9f3363aef2c
Create SM Ctx Req      : 13
  N1 PDU Session Establishment Request                   : 13
  N2 Handover Required                                   : 0
  N2 Path Switch Request                                 : 0
Create SM Ctx Succ     : 13
  N2 PDU Session Resource Setup Request                  : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Path Switch Request Unsuccessful                    : 0
Create SM Ctx Fail     : 0
  N1 PDU Session Establishment Reject                    : 0
  N1 5GSM Status                                         : 0
Update SM Ctx Req      : 16
  N1 PDU Session Modification Request                    : 0
  N1 PDU Session Modification Complete                   : 0
  N1 PDU Session Modification Command Reject             : 0
  N1 PDU Session Release Request                         : 0
  N1 PDU Session Release Complete                        : 1
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Setup Response                 : 13
  N2 PDU Session Resource Setup Unsuccessful             : 0
  N2 PDU Session Resource Notify                         : 0
  N2 PDU Session Resource Modify Indication              : 0
  N2 PDU Session Resource Modify Response                : 0
  N2 PDU Session Resource Modify Unsuccessful            : 0
  N2 PDU Session Resource Release Response               : 1
  N2 PDU Session Resource Notify Released                : 0
  N2 Path Switch Request                                 : 0
  N2 Path Switch Request Setup Failed                    : 0
  N2 Handover Required                                   : 0
  N2 Handover Request Acknowledge                        : 0
  N2 Handover Resource Allocation Unsuccessful           : 0
  With HoState Completed                                 : 0
  With HoState Cancelled                                 : 0
  With upCnxState Activating                             : 0
  With upCnxState Deactivated                            : 1
  With amfId change                                      : 0
  With dataForwarding True                               : 0
  With dataForwarding False                              : 0
  With release due to reactivation                       : 0
  With release due to duplicate session Id               : 0
  With release due to slice not available                : 0
  With AN not responding                                 : 0
Update SM Ctx Succ     : 16
  N1 PDU Session Modification Command                    : 0
  N1 PDU Session Release Command                         : 0
  N1 PDU Session Establishment Reject                    : 0
  N2 PDU Session Resource Setup Request                  : 0
  N2 PDU Session Resource Modify Confirm                 : 0
  N2 PDU Session Resource Modify Request                 : 0
  N2 PDU Session Resource Release Command                : 0
  N2 Path Switch Request Acknowledge                     : 0
  N2 Handover Command                                    : 0
  With upCnxState Deactivated                            : 1
Update SM Ctx Fail     : 0
  N1 PDU Session Modification Reject                     : 0
  N1 PDU Session Release Reject                          : 0
  N1 5GSM Status                                         : 0
  N2 PDU Session Resource Modify Indication Unsuccessful : 0
  N2 Path Switch Request Unsuccessful                    : 0
  N2 Handover Preparation Unsuccessful                   : 0
Release SM Ctx Req     : 1
  With PDU session status mismatch                       : 0
Release SM Ctx Succ    : 1              Release SM Ctx Fail    : 0
SM Ctx Stat Notif      : 1              SM Ctx Stat Notif Succ : 1
SM Ctx Stat Notif Fail : 0
Retrieve SM Ctx Req    : 0              Retrieve SM Ctx Succ   : 0
Retrieve SM Ctx Fail   : 0
Number Of Sessions     : 10
-------------------------------------------------------------------------------
Number of instances    : 2
===============================================================================
===============================================================================
          nf-type udm
===============================================================================
show mobile-gateway pdn service-stats nf-type udm

===============================================================================
UDM peer service statistics
===============================================================================
Service Realm          : sbaRealm1                            Gateway Id   : 1
Service Name           : nudm-sdm
-------------------------------------------------------------------------------
Service Instance                              : udm-sdm1
NF instance ID                                : e58b6eba-14a5-41f0-bba5-
                                                1b0a43304fa7

Get SM Subscription Data
  Request Tx                                  : 13
  Response Success Rx                         : 13
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

Subscribe SDM Notification
  Request Tx                                  : 13
  Response Success Rx                         : 13
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
NF instance ID                                : e58b6eba-14a5-41f0-bba5-
                                                1b0a43304fa7

SMF Registration
  Request Tx                                  : 13
  Response Success Rx                         : 13
  Response Fail Rx                            : 0
  Request Failure Tx                          : 0
  Request Timeout Tx                          : 0
  Request Retransmission Tx                   : 0
  Malformed Response Rx                       : 0
  Unknown Session Response Rx                 : 0
  Peer Failover                               : 0

SMF Deregistration
  Request Tx                                  : 1
  Response Success Rx                         : 1
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



command:
/clear mobile-gateway pdn  1 service-stats nf-type amf
/clear mobile-gateway pdn  1 service-stats nf-type nrf
/clear mobile-gateway pdn  1 service-stats nf-type udm
/clear mobile-gateway pdn  1 service-stats nf-type smf
/clear mobile-gateway pdn  1 service-stats nf-type pcf

/clear mobile-gateway pdn 1 nrf-client-cache

Executed 76 lines in 0.1 seconds from file cf1:\magc\sba-stats
```

## 6. **Stopping the session** 
You can stop the 5G session (single session or 10 sessions) using the below predefined script.

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

Also a clear command from CP can be used via the predefined script to clear the single session or 10 session.
as the call trace was still running you will the debug for the clear session.

```bash
*A:CP1# exec clear-5g
Pre-processing configuration file (V0v0)...
Completed processing 14 lines in 0.0 seconds


Executed 14 lines in 0.0 seconds from file cf1:\magc\clear-5g
*A:CP1#
140 2025/04/11 00:22:41.067 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000001
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   Sessmgr to PFCP
      msgType: PFCP_SESSION_DELETE_REQ (= 3)
      PFCP Sessmgr header
         ueId 0x20120
         ueBndlIdx 0x0
         tunnelInfo
            endPtIpAddr 1.1.1.102
            secEndPtIpAddr 0.0.0.0
            endPtSeId 0x73
            lclSeId 0x20120
            refPtId 1
         pfcpOpaque 0
         smgrTransId 0x0
         transErrCode: Clear IMSI Local (= 49)
"

141 2025/04/11 00:22:41.067 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000001

   Info:     egressing frame on interface Sx
             from application Connectivity-management

   IP/UDP:   from 1.1.1.1 (port 8805) to 1.1.1.102 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 54 [SESS_DEL_REQ]
   - Msg len: 12
   - SEID: 0x00000073
   - Seq nbr: 655367
   - Msg prio: 14

   No IEs
"

142 2025/04/11 00:22:41.077 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000001

   Info:     ingressing frame on interface Sx
             to application Connectivity-management

   IP/UDP:   from 1.1.1.102 (port 8805) to 1.1.1.1 (port 8805)

   PFCP:
   Header:
   - Version: 1
   - MP: 1    FO: 0    S: 1
   - Msg type: 55 [SESS_DEL_RSP]
   - Msg len: 152
   - SEID: 0x00020120
   - Seq nbr: 655367
   - Msg prio: 14

   IEs:
   - T: 19 [Cause]     L: 1
     Cause: 1 [Accepted]
   - T: 79 [Usg Rep DsRsp]     L: 131
     Payload:
     - T: 81 [URR Id]     L: 4
       Alloc Type: Dynamic by CP      Id: 1073741825
     - T: 104 [UR-SEQN]     L: 4
       V: 3
     - T: 63 [Usg Rep Trigger]     L: 3
       Trigger(s): TERMR
     - T: 66 [Vol Mea]     L: 49
       Total Vol: 0
       Uplink Vol: 0
       Downlink Vol: 0
       Total Pkts: 0
       Uplink Pkts: 0
       Downlink Pkts: 0
     - T: 32841 [Dropped Vol Measurement]     L: 51
       Ent ID: 3729 (Nokia)
       Total Vol: 0
       Uplink Vol: 0
       Downlink Vol: 0
       Total Pkts: 0
       Uplink Pkts: 0
       Downlink Pkts: 0
"

143 2025/04/11 00:22:41.077 CEST MINOR: CALLTRACE #2003 N/A CALL-TRACE
"CALL-TRACE: msgType 2 slot 2 mda 1
   Profile:       debug-output
   IMSI:          206010000000001
   Info:          Public event from application Connectivity-management
   Info:          and module pfcp

   PFCP to AcctMgr
      msgType: E_ACCTMGR_PFCP_SESS_DEL_RESP (= 57)
      PFCP AcctMgr header
         ueId 0x20120
         ueBndlIdx 0x0
         pdnSessId 0x20120
         acctmgrXid 0
         senderXid 0
         transErrCode: Success (= 0)
"
*A:CP1#
```
