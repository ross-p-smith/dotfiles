# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
plugins=(
    git
    sudo
    web-search
    copypath
    dirhistory
    thefuck
    zsh-autosuggestions
    zsh-syntax-highlighting
    )

# https://github.com/zsh-users/zsh-completions/issues/603
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/.p10k.zsh ]] || source ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/.p10k.zsh
