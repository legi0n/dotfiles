# Dotfiles

These are my personal configuration files for my development environment.

> [!NOTE]
> This configuration is maintained for my Arch Linux machine, and it may require adjustments on other systems.

## Requirements

Ensure the packages below are installed for the setup to work properly.

```sh
sudo pacman -S --needed base-devel git less tmux
```

## Additional Requirements

Some of the larger configurations have their own dependencies and setup instructions. For additional details, see the respective README:

- [Hyprland](./.config/hypr/README.md)
- [Noctalia](./.config/noctalia/README.md)
- [Neovim](./.config/nvim/README.md)

## Installation

Clone the repository:

```sh
git clone https://github.com/legi0n/dotfiles.git && cd dotfiles
```

Run the synchronization script:

```sh
./sync.sh
```
