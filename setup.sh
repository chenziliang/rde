#!/bin/bash

cd ~/
ln -s ~/code/rde/.zshrc
ln -s ~/code/rde/.vimrc
ln -s ~/code/rde/.tmux
ln -s ~/code/rde/.tmux.conf
ln -s ~/code/rde/.dir_colors


git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qa

sed -i"" "s/<leader>q/<leader>h/g"  ~/.vim/bundle/ListToggle/plugin/listtoggle.vim

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

sed -i"" "/^  'completion'/a \  'git' \\\\\n  'syntax-highlighting' \\\\" ~/.zprezto/runcoms/zpreztorc
sed -i"" "s/key-bindings 'emacs'/key-bindings 'vi'/g" ~/.zprezto/runcoms/zpreztorc

sudo mkdir -p /usr/local/bin/
sudo cp rde /usr/local/bin
sudo sh -c 'curl https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > /usr/local/bin/aws_zsh_completer.sh' && sudo chmod +x /usr/local/bin/aws_zsh_completer.sh

# VNC AWS EC2 Ubuntu https://ubuntu.com/tutorials/ubuntu-desktop-aws#1-overview
# vncserver -kill :1
# vncserver -geometry 2560x1440 :1
