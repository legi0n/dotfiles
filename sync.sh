#!/usr/bin/env bash

set -e

dotfiles=(
    ".bashrc"
    ".tmux.conf"
    ".config/hypr"
    ".config/nvim"
    ".config/waybar"
    ".local/bin/toggle-screen-recorder"
)

link() {
    src="$PWD$1"
    dest="$HOME/$1"

    mkdir -p "$(dirname "$dest")"

    if [[ -L "$dest" ]]; then
        current="$(readlink "$dest")"

        if [[ "$current" == "$src" ]]; then
            echo "$dest is already linked to $src"
            return
        else
            echo "$dest is a symlink to $current (not $src)! Replacing it ..."
            rm "$dest"
        fi
    fi

    if [[ -e "$dest" ]]; then
        backup="$dest.bak"
        echo "$dest already exists! Backing up to $backup ..."
        mv "$dest" "$backup"
    fi

    ln -s "$src" "$dest"
    echo "Linked $src -> $dest"
}

for f in "${dotfiles[@]}"; do
    link "$f"
done
