#!/bin/bash

docker exec -it cups-bngblaster bash -c "bngblaster -I -C dhcp.json -L dhcp.log -c 10"
