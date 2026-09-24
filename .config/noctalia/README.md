# Noctalia Configuration

> [!NOTE]
> This configuration is maintained for my Arch Linux machine, and it may require adjustments on other systems.

## Requirements

Ensure the packages below are installed for the setup to work properly.

```sh
# Packages
sudo pacman -S --needed noctalia gpu-screen-recorder

# AUR packages (yay, paru, etc.)
paru -S --needed wl-screenrec
```

## Standalone Installation

### Clone the repository

```sh
git clone https://github.com/legi0n/dotfiles.git
```

### Copy the configuration

Copy the configuration from the repository to your `~/.config/noctalia` directory:

```sh
mkdir -p ~/.config && cp -r dotfiles/.config/noctalia ~/.config/
```
