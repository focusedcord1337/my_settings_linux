#!/usr/bin/env bash

GITHUB_REPO_URL="git@github.com:focusedcord1337/my_settings_linux.git"

REPO_DIR="$HOME/my_settings_linux"

# Creat dir if there is none and initilize Git repo
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "📁 Initialzing local Git-archive..."
    mkdir -p "$REPO_DIR"
    cd "$REPO_DIR" || exit
    git init
    git remote add origin "$GITHUB_REPO_URL"
    git branch -M main
else
    cd "$REPO_DIR" || exit
    git remote set-url origin "$GITHUB_REPO_URL"
fi

echo "📦 Saving config files..."
dconf dump /org/gnome/terminal/legacy/profiles:/ > terminal_profiles.dconf || echo "⚠️ No gnome terminal profil found!"
echo "📦 Saving bash aliases ..."
cp ~/.bash_aliases -t . || echo "⚠️ Could not find .bash_aliases"

echo "⚙️  Saving custom shorcuts ..."
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > $REPO_DIR/custom-shortcuts.txt || echo "⚠️ No custom shortcut keybinds found!"
echo "⚙️  Saving custom window shorcuts ..."
dconf dump /org/gnome/desktop/wm/keybindings/ > $REPO_DIR/window-shortcuts.txt || echo "⚠️ No custom window keybinds found!"

# Not needed right now
# echo "⚙️  Saving custom mutter shorcuts ..."
# dconf dump /org/gnome/mutter/keybindings/ > $REPO_DIR/mutter-shortcuts.txt || echo "⚠️ No custom mutter keybinds found!"
# echo "⚙️  Saving custom shell shorcuts ..."
# dconf dump /org/gnome/shell/keybindings/ > $REPO_DIR/shell-shortcuts.txt || echo "⚠️ No custom shell keybinds found!"

echo "🚀 Sending changes to GitHub..."
git add .
git commit -m "🐧 Uppdating Linux settings: $(date +'%Y-%m-%d %H:%M')"
git push -u origin main --force

echo "✅ Everything uploaded to GitHub!"
