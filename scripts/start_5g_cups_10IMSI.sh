#!/bin/bash

# Start the gNB
docker exec -d cups-gnb bin/bash -c "nr-gnb -c gnb.yaml > /opt/open5gs/var/log/open5gs/gnb.log"

# Start UEs dynamically (10 IMSIs)
docker exec -d cups-ue1 bin/bash -c "nr-ue -c ue.yaml -i 206010000000001 -n 10 > /opt/open5gs/var/log/open5gs/ue1.log"

# Wait for all uesimtun interfaces to be ready and add routes
docker exec -it cups-ue1 /bin/bash -c '
    while true; do
        tun_interfaces=$(ip -o link show | awk -F": " "/uesimtun[0-9]+/ {print \$2}")

        if [[ -z "$tun_interfaces" ]]; then
            echo "Waiting for uesimtun interfaces to appear..."
            sleep 1
            continue
        fi

        all_ready=true
        for tun in $tun_interfaces; do
            if ! ip link show "$tun" > /dev/null 2>&1; then
                echo "Waiting for $tun to be ready..."
                all_ready=false
                break
            fi
        done

        if [[ "$all_ready" == true ]]; then
            echo "All uesimtun interfaces are ready. Adding routes..."

            # Delete old route to avoid conflicts
            ip route del 1.1.1.0/24 2>/dev/null

            # Add a multipath route over all uesimtunX interfaces
            route_cmd="ip route add 1.1.1.0/24"
            for tun in $tun_interfaces; do
                route_cmd+=" nexthop dev $tun"
            done

            eval "$route_cmd"
            echo "Routes added successfully: $route_cmd"
            break
        fi

        sleep 1
    done
'

