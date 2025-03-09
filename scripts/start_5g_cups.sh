#!/bin/bash

docker exec -d cups-gnb bin/bash -c "nr-gnb -c gnb.yaml > /opt/open5gs/var/log/open5gs/gnb.log"
docker exec -d cups-ue1 bin/bash -c "nr-ue -c ue.yaml > /opt/open5gs/var/log/open5gs/ue1.log"
docker exec -it cups-ue1 /bin/bash -c 'while ! ip link show uesimtun0 > /dev/null 2>&1; do
    echo "Waiting for uesimtun0 to be ready..."
    sleep 1
done
ip route add 1.1.1.0/24 dev uesimtun0
echo "IP route added successfully."'
