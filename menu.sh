#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: All in One Media Server install Script

# Path"s for raw install scripts from a GitHub repository
PLEX_INSTALL_PATH="./assets/scripts/plex-install.sh"
EMBY_INSTALL_PATH="./assets/scripts/emby-install.sh"
JELLYFIN_INSTALL_PATH="./assets/scripts/jellyfin-install.sh"


# 
OPTION=$(whiptail --title "Media Server Installer" --menu "Choose a media server to install" 15 60 4 \
"Plex" "Install Plex Media Server" \
"Emby" "Install Emby Media Server" \
"Jellyfin" "Install Jellyfin Media Server" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    case $OPTION in
        Plex)
            bash "$PLEX_INSTALL_PATH"
            ;;
        Emby)
            bash "$EMBY_INSTALL_PATH"
            ;;
        Jellyfin)
            bash "$JELLYFIN_INSTALL_PATH"
            ;;
    esac
else
    echo "Installation cancelled."
fi