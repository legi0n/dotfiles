# Kitty Configuration

> [!NOTE]
> This configuration is maintained for my Arch Linux machine, and it may require adjustments on other systems.

## Requirements

Ensure the packages below are installed for the setup to work properly.

```sh
sudo pacman -S --needed kitty ttf-hack-nerd
```

## Standalone Installation

### Clone the repository

```sh
git clone https://github.com/legi0n/dotfiles.git
```

### Copy the configuration

Copy the configuration from the repository to your `~/.config/kitty` directory:

```sh
mkdir -p ~/.config && cp -r dotfiles/.config/kitty ~/.config/
```
