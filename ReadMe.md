# Dotfiles Repository 🚀

Welcome to my dotfiles repository! 🎉 This collection is meticulously crafted to enhance me development environment, integrating configurations for a variety of tools including Neovim, Git, Tmux, Zsh, and more. Leveraging the Nix package manager, this setup ensures a seamless and reproducible environment across different machines.

## Contents Overview 📦

- **Neovim Configuration** 📝: Tailored settings for an improved coding experience, integrating plugins for syntax highlighting, file navigation, and more.
- **Git Configuration** 🌐: Global Git settings and ignore files to streamline version control processes.
- **Tmux Configuration** 🖥️: Custom Tmux settings for efficient session management.
- **Zsh Configuration** 🐚: A refined terminal experience with Zsh, including custom aliases and plugins.
- **Installation Script** 🛠️: A comprehensive script that automates the setup of these dotfiles, leveraging Nix for package management and Stow for applying configurations.

## Installation 📲

The `install.sh` script is designed to automate the setup of your development environment. It performs the following actions:

1. **Installs the Nix Package Manager** 💾: Sets up Nix, providing a powerful package management solution.
2. **Installs Essential Packages** 📦: Utilizes Nix to install essential tools such as Zsh, Neovim, Git, and Tmux, among others.
3. **Applies Dotfiles Configurations** 🖇️: Uses Stow to symlink dotfiles, ensuring your configurations are applied seamlessly.
4. **Sets Zsh as the Default Shell** 🐚: Configures Zsh as the default shell, enhancing your terminal experience.
5. **Installs Neovim Plugins** 🎨: Automatically installs configured Neovim plugins for an enriched editing environment.

To get started, execute the following commands:

```bash
git clone https://github.com/novaDev315/dotfiles.git
cd dotfiles
./install.sh
```
