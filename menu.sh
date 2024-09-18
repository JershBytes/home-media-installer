#!/usr/bin/env bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes
# Purpose: All in One Media Server install Script

# URLs for raw install scripts from a GitHub repository
PLEX_INSTALL_URL="https://raw.githubusercontent.com/coloredbytes/home-media-installer/main/assets/scripts/plex-install.sh"
EMBY_INSTALL_URL="https://raw.githubusercontent.com/coloredbytes/home-media-installer/main/assets/scripts/emby-install.sh"
JELLYFIN_INSTALL_URL="https://raw.githubusercontent.com/coloredbytes/home-media-installer/main/assets/scripts/jellyfin-install.sh"

# Function to display a simple menu if gum is not available
fallback_menu() {
    echo "Choose a media server to install:"
    echo "1) Plex"
    echo "2) Emby"
    echo "3) Jellyfin"
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1) echo "Plex" ;;
        2) echo "Emby" ;;
        3) echo "Jellyfin" ;;
        *) echo "Invalid choice!" && exit 1 ;;
    esac
}

# Check if gum is installed
if command -v gum &> /dev/null
then
    # Use gum if available
    CHOICE=$(gum choose "Plex" "Emby" "Jellyfin")

    # Apply styling using gum
    gum style \
        --border normal \
        --margin "1" \
        --padding "1" \
        " Home Media Installer"
else
    # Fallback if gum is not installed
    echo "gum is not installed. Using fallback menu."
    CHOICE=$(fallback_menu)
fi

# Act based on the user's choice and install via curl | bash
case $CHOICE in
    Plex)
        echo "Installing Plex Media Server..."
        curl -fsSL "$PLEX_INSTALL_URL" | bash
        ;;
    Emby)
        echo "Installing Emby Media Server..."
        curl -fsSL "$EMBY_INSTALL_URL" | bash
        ;;
    Jellyfin)
        echo "Installing Jellyfin Media Server..."
        curl -fsSL "$JELLYFIN_INSTALL_URL" | bash
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
