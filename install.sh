#!/bin/bash

#
# This script installs dependencies
# It is intended to be run to set up the dotfiles
# And adds to .zshrc to source the load.sh script 
#

BASE_DIR=$(dirname "$0")
BASE_DIR=$(cd $BASE_DIR; pwd)

echo -e "\e[38;5;33mdotfiles/install.sh - starting...     \e[38;5;40m(REMOTE_CONTAINERS=$REMOTE_CONTAINERS)\e[0m\n"

pull_from_git_repo() {
    local repo=$1
    local dir=$2
    if [[ -d $dir ]]; then
        echo -e "\e[38;5;33mPulling $repo into $dir \e[0m"
        git -C $dir pull
    else
        echo -e "\e[38;5;33mCloning $repo\e[0m"
        git clone --depth 1 $repo $dir
    fi
}

# Install a custom theme.
pull_from_git_repo "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}/themes/powerlevel10k"
pull_from_git_repo "https://github.com/zsh-users/zsh-autosuggestions.git" "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
pull_from_git_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
pull_from_git_repo "https://github.com/zsh-users/zsh-completions" "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}/plugins/zsh-completions"

cp "$BASE_DIR/p10k.zsh" ~/.p10k.zsh
mv ~/.zshrc ~/.zshrc.vscode_version
cp "$BASE_DIR/.zshrc" ~/.zshrc

# Copy the .gitignore file
cp "$BASE_DIR/.gitignore_global" ~/.gitignore_global

# Add the dotfiles loader to .bashrc
if grep -q DOTFILES_FOLDER ~/.bashrc; then
    echo -e "\e[38;5;33mdotfiles loader already in .bashrc - skipping\e[0m"
else
    echo -e "\e[38;5;33mAdding dotfiles loader to .bashrc...\e[0m"
    echo -e "# DOTFILES_START" >> ~/.bashrc
    echo -e "DOTFILES_FOLDER=\"$BASE_DIR\"" >> ~/.bashrc
    if [[ -n $DEV_CONTAINER ]]; then
        echo -e "DEV_CONTAINER=1" >> ~/.bashrc
    fi
    echo -e "source \"$BASE_DIR/load.sh\"" >> ~/.bashrc
    echo -e "# DOTFILES_END\n" >> ~/.bashrc
fi

# Add the dotfiles loader to .bashrc
if grep -q DOTFILES_FOLDER ~/.zshrc; then
    echo -e "\e[38;5;33mdotfiles loader already in .zshrc - skipping\e[0m"
else
    echo -e "\e[38;5;33mAdding dotfiles loader to .zshrc...\e[0m"
    echo -e "# DOTFILES_START" >> ~/.zshrc
    echo -e "DOTFILES_FOLDER=\"$BASE_DIR\"" >> ~/.zshrc
    if [[ -n $DEV_CONTAINER ]]; then
        echo -e "DEV_CONTAINER=1" >> ~/.zshrc
    fi
    echo -e "source \"$BASE_DIR/load.sh\"" >> ~/.zshrc
    echo -e "# DOTFILES_END\n" >> ~/.zshrc
fi

# Add aliases
if grep -q DOTFILES_START ~/.bash_aliases; then
    echo -e "\e[38;5;33mdotfiles aliases already in .bash_aliases - skipping\e[0m"
else
    echo -e "\e[38;5;33mAdding dotfiles aliases to .bash_aliases...\e[0m"
    echo -e "# DOTFILES_START" >> ~/.bash_aliases
    cat $BASE_DIR/.bash_aliases >> ~/.bash_aliases
    echo -e "# DOTFILES_END\n" >> ~/.bash_aliases
fi

echo -e "\e[38;5;33mdotfiles/install.sh - done.\e[0m\n"