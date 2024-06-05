#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: Jellyfin install script

# Get the IP address of the host machine
HOST_IP=$(hostname -I | cut -d' ' -f1)


# Functions
install_jellyfin_on_debubuntu() {
    echo "Installing Jellyfin Media Server on Debian/Ubuntu..."
    curl -s https://repo.jellyfin.org/install-debuntu.sh | sudo bash
}

install_jellyfin_on_rhel() {
    echo "Installing Jellyfin Media Server on RHEL Like System..."
    sudo dnf -y install jellyfin
    sudo systemctl restart jellyfin
    sudo systemctl enable jellyfin
}

install_rpmfusion() {
    if [ -f /etc/fedora-release ]; then
        # If it's Fedora
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    elif [ -f /etc/redhat-release ]; then
        # If it's RHEL or CentOS
        sudo dnf install -y https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm
        sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm
    else
        echo "Unsupported distribution"
        return 1
    fi

    # Update package cache
    sudo dnf update -y
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

# Install Jellyfin based on the distribution
case "$OS" in
    "Ubuntu" | "Debian GNU/Linux") 
        install_jellyfin_on_debubuntu || echo "Error installing Jellyfin Media Server on $OS"
        ;;
    "Red Hat Enterprise Linux" | "Fedora" | "Rocky Linux" | "AlmaLinux")
        install_rpmfusion|| echo "Error enabling EPEL repository on $OS"
        install_jellyfin_on_rhel || echo "Error installing Jellyfin Media Server on $OS"
        ;;
    *)
        echo "Unsupported distribution: $OS"
        exit 1
        ;;
esac

# Check exit status
if [ $? -eq 0 ]; then
    echo "Jellyfin Media Server has been installed successfully."
else
    echo "Installation of Jellyfin Media Server failed. Please check the error messages above."
fi

# Exit with appropriate code
exit $?

# Display the message with the IP address and port
echo "Jellyfin has been installed and is now running at http://${HOST_IP}:8096"
