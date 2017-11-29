#!/bin/zsh

# Set hostname color
[ "$(hostname)" = "yokohama.local" ] || zstyle ':prompt:grml:*:items:host' pre '%F{red}'

# Load up completions.
[[ "$(hostname)" =~ "raijin.*" ]] && fpath+=/usr/share/zsh/4.3.11/functions
fpath+=~/.zfunc

# Make grml completion more like in slimzsh
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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

# Fancy syntax highlighting
[ -d "$HOME/.fast-syntax-highlighting" ] || git clone "https://github.com/zdharma/fast-syntax-highlighting" "$HOME/.fast-syntax-highlighting"
source "$HOME/.fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

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
function resimux {
    if [ ! -z "$TMUX" ]; then
        printf '\ePtmux;\e\e[8;%i;%it\e\' $1 $2
    else
        printf '\e[8;%i;%it' $1 $2
    fi
}

alias big="resimux 49 80"
alias vbig="resimux 49 160"
alias small="resimux 25 80"

# Add cargo to the PATH.
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# And the same for go
[ -d "$HOME/Documents/go" ] && GOPATH="$HOME/Documents/go" && PATH="${GOPATH//://bin:}/bin:$PATH"

# And OCaml
. /Users/mscholz/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

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

# ORCA configuration
if [ -d "/usr/local/orca" ]; then
    alias orca="/usr/local/orca/orca"
fi
