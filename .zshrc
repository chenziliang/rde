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

# Symlink dot files
for rcfile in alias tmux tmux.conf vimrc zshrc dir_colors bashrc_local; do
    if [[ ! -s "$HOME/.${rcfile:t}" ]]; then
        ln -s "$HOME/code/rde/.$rcfile" ~
    fi
done

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# export spx="${spx:--mac}"
source ~/.alias
source ~/.bashrc_local

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

export CXX=clang++-15
export CC=clang-15

grep timeplus /etc/hosts > /dev/null
if [[ $? -ne 0 ]]; then
    sudo sh -c 'echo "127.0.0.1 timeplus" >> /etc/hosts'
fi

export PATH=$PATH:~/bin/clion/bin:~/bin/idea/bin

alias clion='clion.sh &'
alias idea='idea.sh &'
alias laptop='vncserver -geometry 2000x1200 :1'
alias bigscreen='vncserver -geometry 2680x1440 :1'
alias du1='du -h --exclude=./code --max-depth=1'

# Fix for alpine linux
unalias ls
unalias ln
