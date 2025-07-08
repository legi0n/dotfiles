#!/usr/bin/env bash

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

PREFIX="${BOLD}[NVIM]${RESET}"

if ! sudo -v &> /dev/null; then
    error_message "You need to have sudo privileges to run this script."
    exit 1
fi

if ! command -v dpkg &> /dev/null; then
    error_message "dpkg is not available. Are you sure you're on a Debian-based system?"
    exit 1
fi

info_message() {
    echo -e "${PREFIX} ${CYAN}[INFO]${RESET} $1"
}

warning_message() {
    echo -e "${PREFIX} ${YELLOW}[WARNING]${RESET} $1"
}

error_message() {
    echo -e "${PREFIX} ${RED}[ERROR]${RESET} $1"
}

success_message() {
    echo -e "${PREFIX} ${GREEN}[SUCCESS]${RESET} $1"
}

info_message "Checking for required packages..."

REQUIRED_PACKAGES=(
  build-essential
  curl
  git
  nodejs
  npm
  python3
  python3-venv
  openjdk-21-jdk
  unzip
)

MISSING_PACKAGES=()

for pkg in "${REQUIRED_PACKAGES[@]}"; do
    if ! dpkg -s "$pkg" &> /dev/null; then
        MISSING_PACKAGES+=("$pkg")
    fi
done

if [[ ${#MISSING_PACKAGES[@]} -eq 0 ]]; then
    success_message "All required packages are already installed."
    exit 0
else
    warning_message "The following packages are missing:"
    for pkg in "${MISSING_PACKAGES[@]}"; do
        echo -e "${PREFIX}   - ${pkg}"
    done
    echo
    read -p "$(echo -e "${PREFIX} ${BOLD}Do you want to install the missing packages? [Y/n] ${RESET}")" confirm
    confirm=${confirm,,}  # Convert to lowercase

    if [[ "$confirm" == "y" || "$confirm" == "" ]]; then
        info_message "Installing missing packages..."
        sudo apt update

        if command -v apt-get &> /dev/null; then
            sudo apt-get install -y "${MISSING_PACKAGES[@]}"
        elif command -v yum &> /dev/null; then
            sudo yum install -y "${MISSING_PACKAGES[@]}"
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y "${MISSING_PACKAGES[@]}"
        else
            error_message "Package manager not found. Installation failed."
            exit 1
        fi

        success_message "Installation complete."
    else
        error_message "Installation cancelled by user."
        exit 1
    fi
fi
