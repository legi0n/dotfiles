#!/usr/bin/env bash

set -e

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

info_message() {
    echo -e "${CYAN}[INFO]${RESET} $1"
}

warning_message() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
}

success_message() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
}

dotfiles=(
  .config/nvim
)

for f in "${dotfiles[@]}"; do
    source="$PWD/$f"
    target=~/"$f"

    info_message "Processing $f"

    if [[ -e "$target" && ! -L "$target" ]]; then
        backup="${target}.bak"
        warning_message "Existing file or directory found at $target. Backing up to $backup"
        mv "$target" "$backup"
    fi

    mkdir -p "$(dirname "$target")"

    ln -sfn "$source" "$target"
    success_message "Linked $source → $target"

    if [[ -d "$source" && -f "$source/install.sh" ]]; then
        info_message "Running install.sh in $source..."
        if [[ -x "$source/install.sh" ]]; then
            "$source/install.sh"
        else
            bash "$source/install.sh"
        fi
    fi
done
