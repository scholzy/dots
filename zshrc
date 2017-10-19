#!/bin/zsh

# First, install the slimzsh base configuration.
if ! [ -d ~/.slimzsh ]; then
    git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
fi

# Load up completions.
fpath+=~/.zfunc

# If the terminal is running in e.g. Emacs, make sure to not set a complicated
# prompt and skip loading slimzsh to speed up load time.
if [ $TERM = "dumb" ]; then
    export PROMPT="$ "
else
    export PURE_PROMPT_SYMBOL='»'
    source ~/.slimzsh/slim.zsh
fi

# Color in filenames and directories in ls. MacOS and GNU ls use different flags
# for this for some reason.
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

# If neovim is installed, prefer it to regular vim.
if command -v nvim > /dev/null; then
    alias vi='nvim'
    alias vim='nvim'
else
    alias vi='vim'
fi

# A brief alias to check running jobs on the University of Melbourne HPC
# cluster.
if [ "$(hostname)" = "spartan.hpc.unimelb.edu.au" ]; then
    alias sq="squeue -u mscholz"
else
    alias sq="ssh spartan.hpc.unimelb.edu.au squeue -u mscholz"
fi

# Make it faster and easier to background/foreground vim.
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

# Resize terminal from zsh.
alias big="printf '\e[8;49;80t'"
alias small="printf '\e[8;25;80t'"

# Add cargo to the PATH.
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# And the same for go
[ -d "$HOME/Documents/go" ] && GOPATH="$HOME/Documents/go" && PATH="${GOPATH//://bin:}/bin:$PATH"
export PATH

# Load up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
