# Hyprland Configuration

> Maintained for my Arch Linux machine - may require adjustments on other systems.

## Requirements

Ensure the packages below are installed for the setup to work properly.

```sh
# Packages
pacman -S --needed kitty, nautilus, waybar, wl-clip-persist, wf-recorder, hyprshot, hyprlock, hypridle

# AUR packages (yay, paru, etc.)
paru -S --needed zen-browser-bin
```

## Standalone Installation

### Clone the Repository

```sh
git clone https://github.com/legi0n/dotfiles.git
```

### Copy the configuration

Copy the configuration from the repository to your `~/.config/hypr` directory:

```sh
mkdir -p ~/.config && cp -r dotfiles/.config/hypr ~/.config/
```
