#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sed -i"" "s/<leader>q/<leader>h/g"  ~/.vim/bundle/ListToggle/plugin/listtoggle.vim

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

sed -i"" "/^  'completion'/a \  'git' \\\\\n  'syntax-highlighting' \\\\" ~/.zprezto/runcoms/zpreztorc
sed -i"" "s/key-bindings 'emacs'/key-bindings 'vi'/g" ~/.zprezto/runcoms/zpreztorc

# update ~/.zprezto/runcoms/zpreztorc
# zstyle ':prezto:load' pmodule
# ...
#   'completion' \
#   'git' \
#   'syntax-highlighting' \
#   'history-substring-search' \
#   'prompt'

# zstyle ':prezto:module:editor' key-bindings 'vi'
# zstyle ':prezto:module:git:status:ignore' submodules 'all'
