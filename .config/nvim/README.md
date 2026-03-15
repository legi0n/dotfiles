# Neovim Configuration

> [!NOTE]
> This configuration is maintained for my Arch Linux machine, and it may require adjustments on other systems.

## Requirements

Ensure the packages below are installed for the setup to work properly.

```sh
pacman -S --needed neovim unzip npm
```

## Standalone Installation

### Clone the Repository

```sh
git clone https://github.com/legi0n/dotfiles.git
```

### Copy the configuration

Copy the configuration from the repository to your `~/.config/nvim` directory:

```sh
mkdir -p ~/.config && cp -r dotfiles/.config/nvim ~/.config/
```
