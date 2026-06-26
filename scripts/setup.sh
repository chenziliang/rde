#!/bin/bash

cd ~/
ln -sfn ~/code/rde/home/.zshrc .zshrc
ln -sfn ~/code/rde/home/.vimrc .vimrc
ln -sfn ~/code/rde/home/.tmux .tmux
ln -sfn ~/code/rde/home/.tmux.conf .tmux.conf
ln -sfn ~/code/rde/home/.dir_colors .dir_colors

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qa

sed -i"" "s/<leader>q/<leader>h/g"  ~/.vim/bundle/ListToggle/plugin/listtoggle.vim

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Add 'git' and 'syntax-highlighting' to zstyle
#   'completion' \
#   'git' \
#   'syntax-highlighting' \
sed -i"" "/^  'completion'/a \  'git' \\\\\n  'syntax-highlighting' \\\\" ~/.zprezto/runcoms/zpreztorc

# Use vim key bindings
sed -i"" "s/key-bindings 'emacs'/key-bindings 'vi'/g" ~/.zprezto/runcoms/zpreztorc

sudo mkdir -p /usr/local/bin/
sudo cp ~/code/rde/scripts/rde /usr/local/bin
sudo sh -c 'curl https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > /usr/local/bin/aws_zsh_completer.sh' && sudo chmod +x /usr/local/bin/aws_zsh_completer.sh

sudo sh -c 'curl https://raw.githubusercontent.com/llvm-mirror/clang/master/tools/clang-format/clang-format.py > /usr/local/bin/clang-format.py'


wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# VNC AWS EC2 Ubuntu https://ubuntu.com/tutorials/ubuntu-desktop-aws#1-overview
# check /home/kc/.vnc/ip-172-31-52-11:1.log
# may need install dbus for 22.04
# sudo apt install dbus-x11
# vncserver -kill :1
# vncserver -geometry 2560x1440 :1

# Reference: https://stackoverflow.com/questions/42296329/how-to-properly-configure-xstartup-file-for-tightvnc-with-ubuntu-vps-gnome-envir
# sudo apt-get install ubuntu-gnome-desktop
# sudo apt-get install tightvncserver xtightvncviewer tightvnc-java
# sudo locale-gen de_DE.UTF-8
# sudo apt-get install xfonts-75dpi
# sudo apt-get install xfonts-100dpi
# sudo apt-get install gnome-panel
# sudo apt-get install metacity
# sudo apt-get install light-themes
