#!/usr/bin/env bash

# ÄNDRA DENNA TILL DIN EGEN REPO-URL:
GITHUB_REPO_URL="git@github.com:focusedcord1337/my_settings_linux.git"

REPO_DIR="$HOME/my_settings_linux"

# Skapa mappen om den inte finns och initiera Git
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "📁 Initierar lokalt Git-arkiv..."
    mkdir -p "$REPO_DIR"
    cd "$REPO_DIR" || exit
    git init
    git remote add origin "$GITHUB_REPO_URL"
    git branch -M main
else
    cd "$REPO_DIR" || exit
    git remote set-url origin "$GITHUB_REPO_URL"
fi

echo "📦 Sparar VS Code-tillägg..."

echo "⚙️  Sparar konfigurationsfiler..."
dconf dump /org/gnome/terminal/legacy/profiles:/ > terminal_profiles.dconf || echo "Ingen gnome terminal profil hittades att spara."
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > custom-shortcuts.txt || echo "Inga keyboard shortcuts hittades!"
cp ~/.bash_aliases -t . || echo "Could not find .bash_aliases"   

echo "🚀 Skickar ändringar till GitHub..."
git add .
git commit -m "Uppdaterade VS Code-inställningar: $(date +'%Y-%m-%d %H:%M')"
git push -u origin main --force

echo "✅ Allt är uppladdat till GitHub!"
