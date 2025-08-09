#!/bin/bash

# set variables

configdir="/home/$USER/.config/waybar/"
themedir="/home/$USER/.config/waybar/themes/"

case "$1" in
  help|theme|reload)
  ;;
  *)
  echo "Command not found. Type 'waybarctl help' for help."
  ;;
esac

######################################
## 'waybarctl reload' functionality ##
######################################

# reload function
reload() {
  if pgrep -x "waybar" > /dev/null; then
    killall -q waybar
    while pgrep -x waybar > /dev/null; do sleep 1; done
    waybar &
    echo "Waybar succesfully reloaded."
  else
    waybar &
    echo "Waybar is not running. Starting waybar."
  fi
}

# call reload function if second argument is 'reload'
if [ "$1" = "reload" ]; then
  reload
  echo "Succesfully reloaded Waybar."
fi

#############
# help page #
#############

if [ "$1" = "help" ]; then
  echo ""
  echo "Welcome to waybarctl!"
  echo ""
  echo "Type 'waybarctl reload' to reload Waybar."
  echo ""
  echo "Type 'waybarctl theme <themename>' to set a waybar theme."
  echo ""
  echo "Type 'waybarctl theme list' to list all available themes."
  echo ""
  echo "Type 'waybarctl theme remove' to apply the default theme."
  echo ""
  echo "You can create themes in ~/.config/waybar/themes directory."
  echo "You have to create a directory for each theme and place the configs and styles inside the directory."
  echo ""
  exit 1
fi

##########################################
# waybar theme <themename> functionality #
##########################################

if [ "$1" = "theme" ]; then

  # create themedir if it does not exist
  if [ ! -d "$themedir" ]; then
    echo "Theme directory does NOT exist. Creating theme directory."
    mkdir -p $themedir
    echo "Successfully created themedir on $themedir."
  fi

  # if second argument (theme) is set, link their files to waybarconfig 
  if [ "$2" ]; then
    # list all available themes
    if [ "$2" = "list" ]; then
      echo ""
      echo "Available themes:"
      echo ""
      ls -w 1 $themedir
      echo ""
      exit 1
    fi
    # remove current theme
    if [ "$2" = "remove" ]; then
        for links in $(find /home/$USER/.config/waybar -maxdepth 1 -type l)
        do
          rm -r "$links"
        done
        echo "Succesfully deactivated the $2 theme. Falling back to default one."
        exit 1
    fi
    # if the given theme is valid, change to this theme.
    if [ -d "/home/$USER/.config/waybar/themes/$2" ]; then
      for f in $(find /home/$USER/.config/waybar/themes/$2 -mindepth 1 -maxdepth 1 -type f -printf "%f\n")
        do
          ln -sf "/home/$USER/.config/waybar/themes/$2/$f" "$configdir"
        done
      for f in $(find /home/$USER/.config/waybar/themes/$2 -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
        do
          ln -sf "/home/$USER/.config/waybar/themes/$2/$f" "$configdir"
        done
      reload
      echo "Theme succesfully updated to $2"
    else
      echo "Theme $2 does not exist. List all themes with 'waybarctl theme list'"
    fi
  else
    echo "Usage: waybarctl theme <themename>|list|remove"
  fi
fi
