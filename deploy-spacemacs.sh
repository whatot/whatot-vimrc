#!/bin/bash
set -x

PATH_NOW=`pwd`

if [[ -f "/usr/bin/pacman" ]];then
    sudo pacman -S git tig noto-fonts-cjk the_silver_searcher \
        ipython ipython2 python-nose python-pylint python2-pylint yapf flake8 \
        cargo rust go go-tools
    # cargo install rustfmt
    # cargo install racer
fi

if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s ${PATH_NOW}/spacemacs.el ~/.spacemacs

sudo bash -c 'cat > /usr/bin/emacs.wrapper' <<EOF
#! /bin/bash
export LC_CTYPE=zh_CN.UTF-8; emacsclient -c -a emacs
EOF

sudo chmod +x /usr/bin/emacs.wrapper
