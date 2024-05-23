# install nix package manager:
 curl -L https://nixos.org/nix/install | sh

# source nix:
 . ~/.nix-profile/etc/profile.d/nix.sh

# install packages:
 nix-env -iA \
        nixpkgs.zsh \
        nixpkgs.antibody \
        nixpkgs.git \
        nixpkgs.neovim \
        nixpkgs.yarn \
        nixpkgs.fzf \
        nixpkgs.stow \
        nixpkgs.tmux \
        nixpkgs.bat \
        nixpkgs.direnv \
        nixpkgs.ripgrep \
        nixpkgs.zoxide \
        nixpkgs.tldr \
        nixpkgs.libnotify \
        nixpkgs.lsd \
        nixpkgs.fd \
        nixpkgs.duf

# create the config folders 
mkdir -p ~/.config/{nvim, bat}
# stow the configs files
 [ -d configs/git ] && stow -d configs git -t ~
 [ -d configs/zsh ] && stow -d configs zsh -t ~
 [ -d configs/nvim ] && stow -d configs nvim -t ~/.config/nvim/
 [ -d configs/bat ] && stow -d configs bat -t ~/.config/bat/
 [ -d configs/tmux ] && stow -d configs tmux -t ~
 [ -d configs/mime ] && stow -d configs mime -t ~

# install node version manager 
 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
 
# add zsh to valid login shells:
 command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell:
 sudo sed s/required/sufficient/g -i /etc/pam.d/chsh # fix chsh PAM Authentication failure
 sudo chsh -s $(which zsh) $USER

# bundle zsh plugins
 antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh

# install neovim plugins
 nvim --headless "+Lazy! sync" +qa
