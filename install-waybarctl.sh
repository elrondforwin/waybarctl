#!/bin/bash

installdir="/home/$USER/.local/bin"

if [ ! -d "$installdir" ]; then
  echo "installdir does not exist. Creating installdir."
  mkdir -p $installdir
  echo "Successfully created installdir on $installdir"
fi

if [ -f /home/$USER/.local/bin/waybarctl ]; then
  rm /home/$USER/.local/bin/waybarctl
  echo "Found existing waybarctl. Removing the old one."
fi

touch /home/$USER/.local/bin/waybarctl
echo "Installing waybarctl..."
curl -fsSL https://raw.githubusercontent.com/elrondforwin/waybarctl/refs/heads/main/waybarctl >>/home/$USER/.local/bin/waybarctl
chmod +x /home/$USER/.local/bin/waybarctl
echo "Succesfully installed waybarctl."
