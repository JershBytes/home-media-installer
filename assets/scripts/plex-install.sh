#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: Plex Install Script

# Variables 
HOST_IP=$(hostname -I | cut -d' ' -f1)
REPO_URL="https://raw.githubusercontent.com/coloredbytes/home-media-installer/refs/heads/main/assets/repos/plex.repo"
DEUBUNTU_REPO="/etc/apt/sources.list.d/plexmediaserver.list"
RHEL_REPO_LOCATION="/etc/yum.repos.d/plex.repo"

# Functions for type of OS.
install_plex_on_debubuntu() {
    # Add Plex repository and key
    echo "Adding Plex repository for Debian-based systems..."
    echo deb https://downloads.plex.tv/repo/deb public main | sudo tee $DEUBUNTU_REPO > /dev/null
    curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

    # Update package index
    sudo apt update

    # Install Plex Media Server
    echo "Installing Plex Media Server for Debian-based systems..."
    sudo apt install -y plexmediaserver
}

install_plex_on_rhel() {
    
# Write the repository configuration to a file in /etc/yum.repos.d
    sudo curl -o "$RHEL_REPO_LOCATION" "$REPO_URL"
    #Updating System
    echo "Updating system..."
    sudo dnf makecache
    sudo dnf -y update 

    # Install Plex Media Server
    echo "Installing Plex Media Server for RHEL-based systems..."
    sudo dnf install -y plexmediaserver
}

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
else
    OS=$(uname -s)
fi

# Install Plex based on the distribution
case "$OS" in
    "Ubuntu" | "Debian GNU/Linux")
        install_plex_on_debubuntu || echo "Error installing Plex Media Server on $OS"
        ;;
    "Red Hat Enterprise Linux" | "Fedora" | "Rocky Linux" | "AlmaLinux")
        install_plex_on_rhel || echo "Error installing Plex Media Server on $OS"
        ;;
    *)
        echo "Unsupported distribution: $OS"
        exit 1
        ;;
esac


if [ $? -eq 0 ]; then
    echo "Plex Media Server has been installed successfully and should be running at http://${HOST_IP}:32400/web"
else
    echo "Installation of Plex Media Server failed. Please check the error messages above."
fi

