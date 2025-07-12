#!/usr/bin/env bash

set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

PREFIX="${BOLD}[NVIM]${RESET}"

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

if ! sudo -v &> /dev/null; then
    error_message "You need to have sudo privileges to run this script."
    exit 1
fi

if ! command -v dpkg &> /dev/null; then
    error_message "dpkg is not available. Are you sure you're on a Debian-based system?"
    exit 1
fi

BASE_PACKAGES=(
    git
    curl
    unzip
)

OPTIONAL_PACKAGES=(
    build-essential
    nodejs
    npm
    python3
    python3-venv
    openjdk-21-jdk
)

check_and_install_packages() {
    local packages=("$@")
    local missing=()

    for pkg in "${packages[@]}"; do
        if ! dpkg -s "$pkg" &> /dev/null; then
            missing+=("$pkg")
        fi
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        success_message "All required packages are already installed."
    else
        warning_message "Missing packages:"
        for pkg in "${missing[@]}"; do
            echo -e "${PREFIX}   - ${pkg}"
        done

        echo
        read -p "$(echo -e "${PREFIX} ${BOLD}Do you want to install the above packages? [Y/n] ${RESET}")" confirm
        confirm=${confirm,,}

        if [[ "$confirm" == "y" || "$confirm" == "" ]]; then
            info_message "Installing packages..."
            sudo apt update
            sudo apt-get install -y "${missing[@]}"
            success_message "Installation complete."
        else
            warning_message "User chose not to install these packages."
        fi
    fi
}

info_message "Checking base packages..."
check_and_install_packages "${BASE_PACKAGES[@]}"

echo
info_message "Do you want to install optional packages for development (language support etc.)?"
for pkg in "${OPTIONAL_PACKAGES[@]}"; do
    if ! dpkg -s "$pkg" &> /dev/null; then
        read -p "$(echo -e "${PREFIX} Install ${BOLD}${pkg}${RESET}? [Y/n] ")" confirm_pkg
        confirm_pkg=${confirm_pkg,,}
        if [[ "$confirm_pkg" == "y" || "$confirm_pkg" == "" ]]; then
            OPTIONAL_TO_INSTALL+=("$pkg")
        fi
    fi
done

if [[ ${#OPTIONAL_TO_INSTALL[@]} -gt 0 ]]; then
    info_message "Installing selected optional packages..."
    sudo apt update
    sudo apt-get install -y "${OPTIONAL_TO_INSTALL[@]}"
    success_message "Optional packages installed."
else
    info_message "No optional packages selected for installation."
fi
