#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: Emby Install Script

# Get the IP address of the host machine
HOST_IP=$(hostname -I | cut -d' ' -f1)

# Create TMP directory
TMP=$(mktemp -d)

# Detect OS
if [[ "$(uname -s)" == "Linux" ]]; then
    if [[ -f "/etc/os-release" ]]; then
        . /etc/os-release
        OS=$(echo "$ID" | tr '[:upper:]' '[:lower:]')
    elif [[ -f "/etc/lsb-release" ]]; then
        . /etc/lsb-release
        OS=$(echo "$DISTRIB_ID" | tr '[:upper:]' '[:lower:]')
    else
        echo "Unsupported Linux distribution!"
        exit 1
    fi
else
    echo "Unsupported operating system!"
    exit 1
fi

# Get emby server package URLs from the latest release files
DEB_LATEST=$(curl -s "https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest" | jq '.assets[] | select(.name|match("emby-server-deb.*_amd64.deb$")) | .browser_download_url' | tr -d '"')
echo "Found latest release .deb package at: $DEB_LATEST"

RHEL_LATEST=$(curl -s "https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest" | jq '.assets[] | select(.name|match("emby-server-rpm.*_x86_64.rpm$")) | .browser_download_url' | tr -d '"')
echo "Found latest release .rpm package at: $RHEL_LATEST"

# Set package variable based on OS
case "$OS" in
    "debian" | "ubuntu")
        if [ -n "$DEB_LATEST" ]; then
            PACKAGE_URL="$DEB_LATEST"
        else
            echo "Could not find the latest .deb package for $OS!"
            exit 1
        fi
        ;;
    "fedora" | "almalinux" | "rocky" | "rhel" | "centos")
        if [ -n "$RHEL_LATEST" ]; then
            PACKAGE_URL="$RHEL_LATEST"
        else
            echo "Could not find the latest .rpm package for $OS!"
            exit 1
        fi
        ;;
    *)
        echo "Unsupported distribution: $OS"
        exit 1
        ;;
esac

# Get emby server package from the latest release files
PACKAGE=$(curl -s "https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest" | jq ".assets[] | select(.browser_download_url == \"$PACKAGE_URL\") | .browser_download_url" | tr -d '"')
echo "Found latest release package at: $PACKAGE"

# Download emby server package to TMP
if [[ -n "$PACKAGE" ]]; then
    wget -O "$TMP/emby-server.$(echo $PACKAGE | awk -F'.' '{print $NF}')" "$PACKAGE"
    if [ $? -ne 0 ]; then
        echo "Failed to download latest package!"
        exit 1
    fi
else
    echo "Could not find the latest package for $OS!"
    exit 1
fi

# Install emby server package
echo "Installing emby-server..."
case "$OS" in
    "debian" | "ubuntu")
        sudo dpkg -i "$TMP/emby-server.deb"
        if [ $? -ne 0 ]; then
            echo "Failed to install emby-server!"
            exit 1
        fi
        ;;
    "fedora" | "almalinux" | "rocky" | "rhel" | "centos")
        sudo yum install -y "$TMP/emby-server.rpm"
        if [ $? -ne 0 ]; then
            echo "Failed to install emby-server!"
            exit 1
        fi
        ;;
    *)
        echo "Unsupported distribution: $OS"
        exit 1
        ;;
esac

# Remove TMP directory
rm -R $TMP

echo "Emby installed successfully and should now be running at http://${HOST_IP}:8096"
