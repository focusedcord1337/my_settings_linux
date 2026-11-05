#!/usr/bin/env bash

    dconf load /org/gnome/terminal/legacy/profiles:/ < terminal_profiles.dconf || printf "Loading saved terminal profiles failed\n" 
    
    dconf load /org/gnome/desktop/wm/keybindings/ < ~/window-shortcuts.txt

    dconf load /org/gnome/desktop/wm/keybindings/ < ~/window-shortcuts.txt
    dconf load /org/gnome/mutter/keybindings/ < ~/mutter-shortcuts.txt
    dconf load /org/gnome/shell/keybindings/ < ~/shell-shortcuts.txt
