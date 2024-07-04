#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: All in One Media Server install Script



# Use whiptail to create a menu
CHOICE=$(whiptail --title "FlexMediaInstaller" --menu "Choose a media server to install" 15 60 4 \
"Plex" "Install Plex Media Server" \
"Emby" "Install Emby Server" \
"Jellyfin" "Install Jellyfin Media Server" 3>&1 1>&2 2>&3)

# Act based on the user's choice
case $CHOICE in
    Plex)
        bash assets/scripts/plex-install.sh
        ;;
    Emby)
        bash assets/scripts/emby-install.sh
        ;;
    Jellyfin)
        bash assets/scripts/jellyfin-install.sh
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
