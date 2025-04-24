## 1. **Checking the logs**:    
You can check the logs for the open5GS and UERANSIM.
```bash
[root@compute-1 logs]# ls
amf.log   bsf.log  nrf.log   pcf.log      udm.log  ue1.log
ausf.log  gnb.log  nssf.log  radiusd.log  udr.log
```
The below are the logs for 1 IMSI connected.
### 1.1 **Checking the NRF logs** 
The NRF showing that elements are registered to it i.e. MAG-C, AMF, UDM.....
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

### 1.2 **Checking the GNB logs**
The GNB log showing that NGAP is ok with the AMF and NGAP is done successfully.
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
### 1.3 **Checking the UE logs**

UE1 log showing that the session is created with uesimtun0 and IP 43.0.32.1 .
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
### 1.4 **Checking the AMF logs**
AMF log showing that the session is created.
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
    
### 2. **Clearing the logs**

Clear the logs before starting 10 IMSIs.
```bash
[root@compute-1 scripts]# ./clear_logs.sh
```

### 3. **Checking logs of 10 IMSI**

Below are the logs related to the attachment process for 10 IMSIs.

### 3.1 **Checking the GNB logs**
The GNB log indicates that NGAP is active and a new signal has been detected for 10 IMSIs.

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


### 3.2 **Checking the UE logs**

The UE logs indicate that all 10 IMSIs have successfully attached.

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
### 3.3 **Checking the AMF logs**

The AMF log for the 10 IMSIs

```bash
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
