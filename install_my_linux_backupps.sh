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

echo "🐧 Installing Linux settings/config files..."

echo "🛸 Getting latest settings..."
git pull origin main || { echo "⚠️ Failed to get latest settings"; }

if [[ -f "$REPO_DIR/terminal_profiles.dconf" ]]; then
    echo "🛠️ Installing terminal profiles..."
    dconf load /org/gnome/terminal/legacy/profiles:/ < "$REPO_DIR/terminal_profiles.dconf"
else
    echo "⚠️ Loading custom terminal profiles failed: File not found"
fi

if [[ -f "$REPO_DIR/window-shortcuts.txt" ]]; then
    echo "🛠️ Installing window keybinds..."
    dconf load /org/gnome/desktop/wm/keybindings/ < "$REPO_DIR/window-shortcuts.txt"
else
    echo "⚠️ Loading custom window keybinds failed: File not found"
fi

if [[ -f "$REPO_DIR/custom-shortcuts.txt" ]]; then
    echo "🛠️ Installing custom shortcuts..."
    # Ladda in mot media-keys/ basen
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$REPO_DIR/custom-shortcuts.txt"
    echo "✅ Custom shortcuts installed successfully!"
else
    echo "⚠️ Loading custom shortcuts failed: File not found at $REPO_DIR/custom-shortcuts.txt"
fi

if [[ -f "$REPO_DIR/.bash_aliases" ]]; then
    echo "🛠️ Installing bash aliases..."
    cp "$REPO_DIR/.bash_aliases" ~/
else
    echo "⚠️ Could not find .bash_aliases in repository"
fi

if [[ -f "$REPO_DIR/.bash_profile" ]]; then
    echo "🛠️ Installing bash profile..."
    cp "$REPO_DIR/.bash_profile" ~/
else
    echo "⚠️ Could not find .bash_profile in repository"
fi

if [[ -f "$REPO_DIR/mimeapps.list" ]]; then
    echo "🛠️ Installing custom mimeapps config..."
    cp $REPO_DIR/mimeapps.list -t  ~/.config/
else
    echo "⚠️ Could not find .bash_profile in repository"
fi


# Not needed right now
# echo "📶 Installing mutter keybinds ..."
# dconf load /org/gnome/mutter/keybindings/ < "$REPO_DIR/mutter-shortcuts.txt" || echo "⚠️ Loading custom mutter keybinds failed" 
# echo "📶 Installing shell keybinds ..."
# dconf load /org/gnome/shell/keybindings/ < "$REPO_DIR/shell-shortcuts.txt" || echo "⚠️ Loading custom shell keybinds failed"

echo "✅ System settings successfully restored!"
