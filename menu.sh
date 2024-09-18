#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: All in One Media Server install Script using gum

# Check if gum is installed
if ! command -v gum &> /dev/null
then
    echo "gum is not installed. Please install gum to proceed."
    echo "You can install gum by following the instructions at https://github.com/charmbracelet/gum"
    exit 1
fi

# Use gum to create a menu
CHOICE=$(gum choose "Plex" "Emby" "Jellyfin")

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
