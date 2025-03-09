#!/bin/bash

echo "Stopping Open5GS services and checking processes..."

docker exec -it cups-nrf bash -c "killall open5gs-nrfd; sleep 5; ps -ef"
docker exec -it cups-amf bash -c "killall open5gs-amfd; sleep 5; ps -ef"
docker exec -it cups-ausf bash -c "killall open5gs-ausfd; sleep 5; ps -ef"
docker exec -it cups-udm bash -c "killall open5gs-udmd; sleep 5; ps -ef"
docker exec -it cups-pcf bash -c "killall open5gs-pcfd; sleep 5; ps -ef"
docker exec -it cups-nssf bash -c "killall open5gs-nssfd; sleep 5; ps -ef"
docker exec -it cups-bsf bash -c "killall open5gs-bsfd; sleep 5; ps -ef"
docker exec -it cups-udr bash -c "killall open5gs-udrd; sleep 5; ps -ef"

echo "Process check completed."

