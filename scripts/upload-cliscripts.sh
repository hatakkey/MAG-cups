#!/bin/bash

# List of hosts with their respective details (host, local directory)
hosts=(
    "cups-UP1:../cliscripts/UP1"
    "cups-UP2:../cliscripts/UP2"
    "cups-CP1:../cliscripts/CP1"
    "cups-CP2:../cliscripts/CP2"
)

USER="admin"
PASS="admin"

# Loop over each host's details
for host_info in "${hosts[@]}"; do
    # Extract host and local directory from the list
    HOST=$(echo "$host_info" | cut -d':' -f1)
    LOCAL_DIR=$(echo "$host_info" | cut -d':' -f2)

    # Determine the remote directory based on the host name
    if [[ "$HOST" == "cups-CP1" || "$HOST" == "cups-CP2" ]]; then
        REMOTE_DIR="magc"  
    else
        REMOTE_DIR="scripts-md" 
    fi

    # Wait until the VM is reachable (adjust timeout and retries if needed)
    until ping -c1 "$HOST" &>/dev/null; do
        echo "Waiting for $HOST to become reachable..."
        sleep 2
    done

    echo "$HOST is up, starting SFTP upload..."

    # Use lftp for scripting SFTP with password
    lftp -u "$USER","$PASS" sftp://$HOST <<EOF
set sftp:connect-program "ssh -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"
cd cf1:/ 
mkdir -p $REMOTE_DIR  
cd $REMOTE_DIR  
mput $LOCAL_DIR/*  
bye
EOF

    echo "Upload complete for $HOST."
done

