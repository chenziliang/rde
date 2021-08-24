#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sed -i"" "s/<leader>q/<leader>h/g"  ~/.vim/bundle/ListToggle/plugin/listtoggle.vim

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

sed -i"" "/^  'completion'/a \  'git' \\\\\n  'syntax-highlighting' \\\\" ~/.zprezto/runcoms/zpreztorc
sed -i"" "s/key-bindings 'emacs'/key-bindings 'vi'/g" ~/.zprezto/runcoms/zpreztorc

rde()
{
    if [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
            echo "Mapping $1 to /root"
            docker run -v "$1":/root -w /root --cap-add=sys_nice --hostname λ -it rde;
        fi
    elif [ $# -eq 2 ]; then
        if [ -d "$1" -a -d "$2" ]; then
            base=`basename $2`
            echo "Mapping $1 to /root and $2 to /$base"
            docker run -v "$1":/root -w /root -v "$2":"/$base" --cap-add=sys_nice --hostname λ -it rde;
        fi
    else
        docker run --cap-add=sys_nice --hostname λ -it rde;
    fi
}
