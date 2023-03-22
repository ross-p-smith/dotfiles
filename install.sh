#!/bin/bash

#
# This script installs dependencies
# It is intended to be run to set up the dotfiles
# And adds to .zshrc to source the load.sh script 
#

BASE_DIR=$(dirname "$0")
BASE_DIR=$(cd $BASE_DIR; pwd)

echo -e "\e[38;5;33mdotfiles/install.sh - starting...     \e[38;5;40m(DEV_CONTAINER=$DEV_CONTAINER)\n"

# Install a custom theme.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

git clone --depth 1 "https://github.com/zsh-users/zsh-autosuggestions.git" \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone --depth 1 "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 "https://github.com/zsh-users/zsh-completions" \
  ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

cp "$BASE_DIR/p10k.zsh" ~/.p10k.zsh
mv ~/.zshrc ~/.zshrc.vscode_version
cp "$BASE_DIR/zshrc" ~/.zshrc

if grep -q DOTFILES_FOLDER ~/.bashrc; then
    echo "dotfiles loader already in .bashrc - skipping"
else
    echo "Adding dotfiles loader to .bashrc..."
    echo -e "# DOTFILES_START" >> ~/.bashrc
    echo -e "DOTFILES_FOLDER=\"$BASE_DIR\"" >> ~/.bashrc
    if [[ -n $DEV_CONTAINER ]]; then
        echo -e "DEV_CONTAINER=1" >> ~/.bashrc
    fi
    echo -e "source \"$BASE_DIR/load.sh\"" >> ~/.bashrc
    echo -e "# DOTFILES_END\n" >> ~/.bashrc
fi

echo -e "\e[38;5;33mdotfiles/install.sh - done.\e[38;5;40m\n"