#!/bin/bash

# Detect OS (CentOS, RHEL, Fedora, Ubuntu, Debian, etc.)
function detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID=${ID,,}  
        echo "Detected OS: $OS_ID"
    else
        echo "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
}

# Create bridges (common for both)
function create_bridges() {
    BRIDGES=("br-dsf1" "br-dsf2" "br-gtpu-cups" "br-ngap" "br-sbi" "br-gnb" "br-metric")

    for br in "${BRIDGES[@]}"; do
        if ! ip link show "$br" &>/dev/null; then
            echo "Creating bridge $br..."
            ip link add name "$br" type bridge
        else
            echo "Bridge $br already exists, skipping creation."
        fi
        ip link set "$br" up
    done
}

# CentOS/RHEL/Fedora-specific configuration
function configure_firewalld() {
    echo "Configuring firewalld..."
    for br in "${BRIDGES[@]}"; do
        firewall-cmd --permanent --zone=docker --add-interface="$br"
    done
    firewall-cmd --reload
}

# Ubuntu/Debian-specific configuration
function configure_iptables() {
    echo "Configuring iptables..."
    for br in "${BRIDGES[@]}"; do
        iptables -C DOCKER-USER -i "$br" -j ACCEPT 2>/dev/null || iptables -I DOCKER-USER -i "$br" -j ACCEPT
    done

    # Save the iptables rules
    iptables-save > /etc/iptables/rules.v4
}

# Main execution
function main() {
    detect_os
    create_bridges

    case "$OS_ID" in
        centos|rhel|fedora)
            configure_firewalld
            ;;
        ubuntu|debian)
            configure_iptables
            ;;
        *)
            echo "Unsupported OS: $OS_ID"
            exit 2
            ;;
    esac

    echo "Bridge creation and configuration completed successfully."
}

main

