#!/usr/bin/env bash

GITHUB_REPO_URL="git@github.com:focusedcord1337/my_settings_linux.git"

REPO_DIR="$HOME/my_settings_linux"

# Create directory if it does not exist and initialize Git repo
if [[ ! -d "$REPO_DIR/.git" ]]; then
    echo "📁 Initializing local Git repository..."
    mkdir -p "$REPO_DIR"
    cd "$REPO_DIR" || exit 1
    git init
    git remote add origin "$GITHUB_REPO_URL"
    git branch -M main
else
    cd "$REPO_DIR" || exit 1
    git remote set-url origin "$GITHUB_REPO_URL"
fi

echo "🛸 Getting latest settings..."
git pull origin main || { echo "⚠️ Failed to get latest settings"; exit 1; }

echo "🛠️ Installing terminal profiles..."
if [[ -f "$REPO_DIR/terminal_profiles.dconf" ]]; then
    dconf load /org/gnome/terminal/legacy/profiles:/ < "$REPO_DIR/terminal_profiles.dconf"
else
    echo "⚠️ Loading custom terminal profiles failed: File not found"
fi

echo "🛠️ Installing window keybinds..."
if [[ -f "$REPO_DIR/window-shortcuts.txt" ]]; then
    dconf load /org/gnome/desktop/wm/keybindings/ < "$REPO_DIR/window-shortcuts.txt"
else
    echo "⚠️ Loading custom window keybinds failed: File not found"
fi

echo "🛠️ Installing bash aliases..."
if [[ -f "$REPO_DIR/.bash_aliases" ]]; then
    cp "$REPO_DIR/.bash_aliases" ~/
else
    echo "⚠️ Could not find .bash_aliases in repository"
fi

echo "🛠️ Installing bash profile..."
if [[ -f "$REPO_DIR/.bash_profile" ]]; then
    cp "$REPO_DIR/.bash_profile" ~/
else
    echo "⚠️ Could not find .bash_profile in repository"
fi

# Not needed right now
# echo "📶 Installing mutter keybinds ..."
# dconf load /org/gnome/mutter/keybindings/ < "$REPO_DIR/mutter-shortcuts.txt" || echo "⚠️ Loading custom mutter keybinds failed" 
# echo "📶 Installing shell keybinds ..."
# dconf load /org/gnome/shell/keybindings/ < "$REPO_DIR/shell-shortcuts.txt" || echo "⚠️ Loading custom shell keybinds failed"

echo "✅ System settings successfully restored!"
