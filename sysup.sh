#!/bin/bash

# Function to install yay if not already installed
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "yay not found, installing yay..."
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    else
        echo "yay is already installed."
    fi
}

# Update the system and install necessary packages
install_packages() {
    echo "Updating system and installing packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel git feh

    # Install AUR packages using yay
    yay -S --noconfirm discord librewolf-bin
}

# Clone and install dwm, dmenu, and slstatus
install_suckless() {
    echo "Installing dwm, dmenu, and slstatus..."
    git clone https://github.com/Bingo76/dwm.git
    cd dwm
    sudo make clean install
    cd ..

    git clone https://git.suckless.org/dmenu
    cd dmenu
    sudo make clean install
    cd ..

    git clone https://git.suckless.org/slstatus
    cd slstatus
    sudo make clean install
    cd ..
}

# Main execution
main() {
    install_yay
    install_packages
    install_suckless

    echo "Installation completed. Please configure your display manager or .xinitrc to start dwm."
}

# Run the main function
main
