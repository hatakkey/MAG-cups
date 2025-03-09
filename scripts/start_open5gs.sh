#!/bin/bash

## clear log files
for filename in ../logs/*.log; do
    > "$filename"
done

docker exec -d cups-nrf open5gs-nrfd
docker exec -d cups-amf open5gs-amfd
docker exec -d cups-ausf open5gs-ausfd
docker exec -d cups-udm open5gs-udmd
docker exec -d cups-pcf open5gs-pcfd
docker exec -d cups-nssf open5gs-nssfd
docker exec -d cups-bsf open5gs-bsfd
docker exec -d cups-udr open5gs-udrd

