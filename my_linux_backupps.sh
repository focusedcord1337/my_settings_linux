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
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > custom-shortcuts.txt || echo "⚠️ No keyboard shortcuts found!"
echo "⚙️  Saving custom window shorcuts ..."
dconf dump /org/gnome/desktop/wm/keybindings/ > window-shortcuts.txt || echo "⚠️ No window keyboard shortcuts found!"
echo "⚙️  Saving custom mutter shorcuts ..."
dconf dump /org/gnome/mutter/keybindings/ > ~/mutter-shortcuts.txt || echo "⚠️ No mutter shortcuts found!"
echo "⚙️  Saving custom shell shorcuts ..."
dconf dump /org/gnome/shell/keybindings/ > ~/shell-shortcuts.txt || echo "⚠️ No shell shortcuts found!"


echo "🚀 Sending changes to GitHub..."
git add .
git commit -m "🐧 Uppdating Linux settings: $(date +'%Y-%m-%d %H:%M')"
git push -u origin main --force

echo "✅ Everything uploaded to GitHub!"
