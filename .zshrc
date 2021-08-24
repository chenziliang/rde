#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Customize to your needs...
#
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    if [[ ! -s "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]; then
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
done

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# export spx="${spx:--mac}"
if [ -e ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

if [[ `uname` =~ "Darwin" ]]; then
    if brew list --formula | grep coreutils > /dev/null ; then
        PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        alias ls='ls -F --show-control-chars --color=auto'
        eval `gdircolors -b $HOME/.dir_colors`
    fi
fi


export PATH=/usr/local/go/bin:$PATH
export GOHOME=$HOME/gocode


#function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%} [% VIM]%  %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
export KEYTIMEOUT=1
autoload -U edit-command-line
zle -N edit-command-line

alias ..="cd .."
alias ...="cd ../.."

gopath() {
    export GOPATH=$GOHOME/"${1}"
}

strip_line() {
    echo -e "${1}" | sed -e "s/^$2//" -e "s/$2$//"
}

strip_ext() {
    echo ${1%.*}
}

# export GREP_OPTIONS='--color=auto'

# For Linux
export GREP_COLORS="sl=97;48;5;236:cx=37;40:mt=30;48;5;186:fn=38;5;197:ln=38;5;154:bn=38;5;141:se=38;5;81"

# For MacOS
export GREP_COLOR='1;35;40'

ulimit -n 10240
ulimit -c unlimited

bindkey -v
bindkey 'ctrl+P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^e' edit-command-line

export PATH="/usr/local/bin:$PATH:$HOME/.toolbox/bin"
alias rdpproxy='ssh -N -L 13390:localhost:3389 clouddesk &'

export EDITOR=vim
export VISUAL=vim

source /usr/local/bin/aws_zsh_completer.sh

alias ghost='ssh ghost@ghost'
alias wireshark='sudo /Applications/Wireshark.app/Contents/MacOS/Wireshark &'

export PATH=$PATH:~/.cargo/bin
# source $HOME/.cargo/env

export CXX=clang++-12
export CC=clang-12

rde()
{
    if [ $# -eq 0 ]; then
        docker run --cap-add=sys_nice --hostname "λ" -it rde;
    elif [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
            r=`basename "$1"`
            docker run -v "$1":"/$r" -w "/$r" --cap-add=sys_nice --hostname "λ" -it rde;
        fi
    elif [ $# -eq 2 ]; then
        if [ -d "$1" ]; then
            docker run -v "$1":"$2" -w "$2" --cap-add=sys_nice --hostname "λ" -it rde;
        fi
    else
        docker run --cap-add=sys_nice --hostname "λ" -it rde;
    fi
}
