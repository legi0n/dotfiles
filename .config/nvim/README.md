# Neovim Configuration

A modern Neovim setup with LSP support, fuzzy finding git integration and more.

## Standalone Installation

### Prerequisites

Before proceeding with the installation, ensure the following dependencies are installed on your system:
* `git`
* `curl`

### Clone the Repository

```sh
git clone https://github.com/legi0n/dotfiles.git
```

### Copy the Neovim Configuration

Copy the configuration from the repository to your `~/.config/nvim` directory:

```sh
mkdir -p ~/.config && cp -r dotfiles/.config/nvim ~/.config/
```

### Run the Installation Script

Navigate to the directory and execute the installation script:
```sh
cd ~/.config/nvim && bash install.sh
```

### Post Installation

Once the installation is complete, launch Neovim to allow the configuration to sync and install any necessary plugins:

```sh
nvim
```
