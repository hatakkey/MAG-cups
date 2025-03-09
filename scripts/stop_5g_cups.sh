#!/bin/bash
docker exec -it cups-gnb bash -c "killall nr-gnb; sleep 5; ps -ef"
docker exec -it cups-ue1 bash -c "killall nr-ue; sleep 5; ps -ef"
