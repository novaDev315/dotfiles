#!/bin/bash

# Fonts to be installed
fonts=(
    noto-fonts
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    ttf-apple-emoji
)

# Function to prompt for optional packages
prompt_for_package() {
    read -p "Do you want to install $1? (y/n): " choice
    case "$choice" in 
        y|Y ) echo "$2";;
        * ) ;;
    esac
}

# Update the system
sudo pacman -Syu --noconfirm

# Install base development packages
base_packages=(
    zsh
    git
    neovim
    yarn
    fzf
    stow
    tmux
    bat
    direnv
    ripgrep
    zoxide
    tldr
    libnotify
    lsd
    fd
    duf
    nodejs
    npm
    unzip
)

# Prompt for optional Hyperland and related applications
optional_packages=()
optional_packages+=($(prompt_for_package "Hyprland" "hyprland"))
optional_packages+=($(prompt_for_package "Alacritty (terminal emulator)" "alacritty"))
optional_packages+=($(prompt_for_package "Swaylock (screen locker)" "swaylock"))
optional_packages+=($(prompt_for_package "Waybar (status bar)" "waybar"))
optional_packages+=($(prompt_for_package "Wofi (application launcher)" "wofi"))
#optional_packages+=($(prompt_for_package "Hyprsome (multi-monitor management)" "hyprsome"))
optional_packages+=($(prompt_for_package "Nemo (file manager)" "nemo"))
optional_packages+=($(prompt_for_package "Grim (screenshot tool)" "grim"))
optional_packages+=($(prompt_for_package "Slurp (screenshot tool)" "slurp"))
optional_packages+=($(prompt_for_package "Hyprpaper (wallpaper setter)" "hyprpaper"))
optional_packages+=($(prompt_for_package "Wlogout (logout menu)" "wlogout"))
optional_packages+=($(prompt_for_package "Papirus Folders Catppuccin (folder theme)" "papirus-folders-catppuccin-git"))
optional_packages+=($(prompt_for_package "Papirus Icon Theme (icon theme)" "papirus-icon-theme-git"))
optional_packages+=($(prompt_for_package "Catppuccin GTK Theme (theme)" "catppuccin-gtk-theme-mocha-git"))
optional_packages+=($(prompt_for_package "Antidote for zsh shell package manager" "zsh-antidote"))
# Install base packages
sudo pacman -S --noconfirm "${base_packages[@]}"

# Install fonts
sudo pacman -S --noconfirm "${fonts[@]}"

# Install yay for AUR packages if not already installed
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Install optional packages using yay (for AUR)
yay -S --noconfirm "${optional_packages[@]}"

# Create the config folders 
mkdir -p ~/.config/{nvim,bat,hypr,alacritty,swaylock,waybar,wofi,wallpapers}

# Create the screenshots folder for grim and slurp
[ -d ~/Pictures/screenshots ] && mkdir -p ~/Pictures/screenshots

# Stow the config files
[ -d configs/git ] && stow -d configs git -t ~
[ -d configs/zsh ] && stow -d configs zsh -t ~
[ -d configs/nvim ] && stow -d configs nvim -t ~/.config/nvim/
[ -d configs/bat ] && stow -d configs bat -t ~/.config/bat/
[ -d configs/tmux ] && stow -d configs tmux -t ~
[ -d configs/mime ] && stow -d configs mime -t ~

# Stow Hyperland and related applications' config files if they exist
[ -d configs/hypr ] && stow -d configs hypr -t ~/.config/hypr/
[ -d configs/alacritty ] && stow -d configs alacritty -t ~/.config/alacritty/
[ -d configs/swaylock ] && stow -d configs swaylock -t ~/.config/swaylock/
[ -d configs/waybar ] && stow -d configs waybar -t ~/.config/waybar/
[ -d configs/wofi ] && stow -d configs wofi -t ~/.config/wofi/
#[ -d configs/hyprsome ] && stow -d configs hyprsome -t ~/.config/hyprsome/
[ -d configs/wallpapers ] && mkdir -p ~/.config/wallpapers && cp -r configs/wallpapers/* ~/.config/wallpapers/

# Install Node Version Manager 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# Use zsh as default shell
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh # fix chsh PAM Authentication failure
sudo chsh -s $(which zsh) $USER

# Bundle zsh plugins
antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh

# Install neovim plugins
nvim --headless "+Lazy! sync" +qa
