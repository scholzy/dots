#!/bin/zsh

# First, install the slimzsh base configuration
if ! [ -d ~/.slimzsh ]; then
    git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
fi

# Load up completions
fpath+=~/.zfunc

# Fix the prompt symbol then load up slimzsh
export PURE_PROMPT_SYMBOL='»'
source ~/.slimzsh/slim.zsh

# Color in filenames and directories in ls
# MacOS and GNU ls use different flags for this for some reason
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

# If neovim is installed, prefer it to regular vim
if command -v nvim > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
else
    alias vi='vim'
fi

export EDITOR="emacsclient -t -a ''"

# A brief alias to check running jobs on the University of Melbourne HPC cluster
if [ "$(hostname)" == "spartan.hpc.unimelb.edu.au" ]; then
    alias sq="squeue -u mscholz"
else
    alias sq="ssh spartan.hpc.unimelb.edu.au squeue -u mscholz"
fi

# Make it faster and easier to background/foreground vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Resize terminal from zsh
alias big="printf '\e[8;49;80t'"
alias small="printf '\e[8;25;80t'"

# Add miniconda to the PATH
export PATH="/usr/local/miniconda3/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
