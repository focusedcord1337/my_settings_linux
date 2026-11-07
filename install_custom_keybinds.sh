#!/bin/bash

REPO_DIR="$HOME/my_settings_linux"

echo "🛠️ Installing custom shortcuts..."

if [[ -f "$REPO_DIR/custom-shortcuts.txt" ]]; then
    # Ladda in mot media-keys/ basen
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$REPO_DIR/custom-shortcuts.txt"
    echo "✅ Custom shortcuts installed successfully!"
else
    echo "⚠️ Loading custom shortcuts failed: File not found at $REPO_DIR/custom-shortcuts.txt"
fi
