#!/bin/bash

docker exec -it cups-bngblaster bash -c "bngblaster -I -C dhcp_red.json -L dhcp_red.log -c 10"
