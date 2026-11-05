#!/usr/bin/env bash
REPO_DIR="$HOME/my_settings_linux"
echo "📶 Installing terminal profiles ..."
dconf load /org/gnome/terminal/legacy/profiles:/ < $REPO_DIR/terminal_profiles.dconf || echo "⚠️ Loading custom terminal profiles failed" 
echo "📶 Installing window keybinds ..."
dconf load /org/gnome/desktop/wm/keybindings/ < $REPO_DIR/window-shortcuts.txt || echo "⚠️ Loading custom window keybinds failed" 

# Not needed right now
# echo "📶 Installing mutter keybinds ..."
# dconf load /org/gnome/mutter/keybindings/ < $REPO_DIR/mutter-shortcuts.txt || echo "⚠️ Loading custom mutter keybinds failed" 
# echo "📶 Installing shell keybinds ..."
# dconf load /org/gnome/shell/keybindings/ < $REPO_DIR/shell-shortcuts.txt || echo "⚠️ Loading custom shell keybinds failed" 

