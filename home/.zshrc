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


export PATH=/usr/local/go/bin:$HOME/go/bin:$PATH
export GOHOME=$HOME/go


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

export CXX=/opt/homebrew/opt/llvm@21/bin/clang++
export PKG_CONFIG_PATH=/usr/local/opt/openssl@1.1/lib/pkgconfig/

# Don't use Apple vim
if (command -v brew && brew list --formula | grep -c vim) > /dev/null 2>&1; then
    alias vim="$(brew --prefix vim)/bin/vim"
fi


# bun completions
[ -s "/Users/k/.bun/_bun" ] && source "/Users/k/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:/Users/k/code/proton-enterprise/release-build/programs/:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/k/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/k/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/k/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/k/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="$HOME/.local/bin:/Applications/Visual Studio Code.app/Contents/MacOS/:$PATH"

# zsh-autosuggestions — fish-style grey inline history hints (accept with →)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'   # dim grey suggestion text


# Opt out of agentic-tool telemetry (Umami phone-home to a.kunchenguid.com).
# Audited 2026-06-26: payloads are anonymous metadata only, but disable anyway.
export GNHF_TELEMETRY=0
export NO_MISTAKES_TELEMETRY=0
export LAVISH_AXI_TELEMETRY=0
