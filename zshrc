#!/bin/zsh

# Load up completions.
[[ "$(hostname)" =~ "raijin.*" ]] && fpath+=/usr/share/zsh/4.3.11/functions
fpath+=~/.zfunc

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
# cluster and on raijin at the NCI.
if [ "$(hostname)" = "spartan.hpc.unimelb.edu.au" ]; then
    alias sq="squeue -u mscholz"
else
    alias sq="ssh spartan.hpc.unimelb.edu.au squeue -u mscholz"
fi

if [[ "$(hostname)" =~ "raijin.*" ]]; then
    alias qs="qstat -u ms9470"
else
    alias qs="ssh ms9470@raijin.nci.org.au /opt/pbs/default/bin/qstat -u ms9470"
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

# Add miniconda
if [ "$(hostname)" = "spartan.hpc.unimelb.edu.au" ]; then
    PATH="$HOME/punim0008/local/miniconda2/bin:$PATH"
else
    PATH="$PATH:/usr/local/miniconda3/bin"
fi
export PATH

# Load up fzf and use rg by default if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v rg > /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"' 
fi
