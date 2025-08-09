#!/bin/bash

installdir="/home/$USER/.local/bin"

if [ ! -d "$installdir" ]; then
    echo "installdir does not exist. Creating installdir."
    mkdir -p $installdir
    echo "Successfully created installdir on $installdir"
fi

if [ -f /home/$USER/.local/bin/waybarctl.sh ]; then
    rm /home/$USER/.local/bin/waybarctl.sh
    echo "Found existing waybarctl. Removing the old one."
fi

touch /home/$USER/.local/bin/waybarctl.sh
curl https://raw.githubusercontent.com/elrondforwin/waybarctl/refs/heads/main/waybarctl.sh >> /home/$USER/.local/bin/waybarctl.sh

if [ -f /home/$USER/.local/bin/waybarctl.sh ]; then
    if [ -f /bin/bash ]; then
        if ! grep -Fxq "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" /home/$USER/.bashrc; then
            printf "\n%s\n" "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" >> "/home/$USER/.bashrc"
            echo "Succesfully installed BASH configration."
        fi
    fi

    if [ -f /bin/zsh ]; then
        if ! grep -Fxq "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" /home/$USER/.zshrc; then
            printf "\n%s\n" "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" >> "/home/$USER/.zshrc"
            echo "Succesfully installed ZSH configration."
        fi
    fi

    if [ -f /bin/fish ]; then
        if ! grep -Fxq "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" /home/$USER/.config/fish/config.fish; then
            printf "\n%s\n" "alias waybarctl='bash /home/$USER/.local/bin/waybarctl.sh'" >> "/home/$USER/.config/fish/config.fish"
            echo "Succesfully installed fish configration."
        fi
    fi
else
    echo "Cannot find script on $installdir. Exiting."
fi
