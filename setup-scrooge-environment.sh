#!/bin/bash

# Setup script for Scrooge environment
# This script must be run with sudo or as root

# Check if running with sudo or as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script requires sudo or root privileges. Please run with sudo."
    exit 1
fi

echo "Setting up Scrooge environment..."

# 1. Add entries to hosts file
HOSTS_FILE="/etc/hosts"
HOSTS_ENTRY="127.0.0.1 api.scrooge.io sso.scrooge.io www.scrooge.io"

# Check if entry already exists
if grep -q "$HOSTS_ENTRY" "$HOSTS_FILE"; then
    echo "Hosts entries already exist."
else
    echo "Adding hosts entries..."
    echo "$HOSTS_ENTRY" >> "$HOSTS_FILE"
    echo "Hosts entries added successfully."
fi

# 2. Add certificate to trusted root CA store
# This varies by distribution, so we'll handle common cases

CERT_PATH="$(pwd)/_nginx/certs/scrooge.io.crt"

# Function to detect the distribution
detect_distro() {
    if [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/redhat-release ]; then
        echo "redhat"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/SuSE-release ]; then
        echo "suse"
    elif [ -f /etc/alpine-release ]; then
        echo "alpine"
    elif [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

DISTRO=$(detect_distro)

echo "Detected distribution: $DISTRO"
echo "Adding certificate to trusted root CA store..."

case "$DISTRO" in
    debian|ubuntu)
        # For Debian/Ubuntu
        cp "$CERT_PATH" /usr/local/share/ca-certificates/scrooge.io.crt
        update-ca-certificates
        ;;
    redhat|centos|fedora)
        # For RHEL/CentOS/Fedora
        cp "$CERT_PATH" /etc/pki/ca-trust/source/anchors/scrooge.io.crt
        update-ca-trust extract
        ;;
    arch|manjaro)
        # For Arch/Manjaro
        cp "$CERT_PATH" /etc/ca-certificates/trust-source/anchors/scrooge.io.crt
        trust extract-compat
        ;;
    alpine)
        # For Alpine
        cp "$CERT_PATH" /usr/local/share/ca-certificates/scrooge.io.crt
        update-ca-certificates
        ;;
    *)
        echo "Warning: Unsupported distribution. Please manually add the certificate to your trusted CA store."
        echo "Certificate path: $CERT_PATH"
        ;;
esac

echo "Scrooge environment setup completed successfully!"
echo "You can now access the following URLs:"
echo "  - https://www.scrooge.io"
echo "  - https://sso.scrooge.io"
echo "  - https://api.scrooge.io"