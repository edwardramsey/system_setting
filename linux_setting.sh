#!/bin/bash
PKG_MANAGER=$( command -v yum || command -v apt-get || echo "no pkgManager")
LOG_FILE="config.log"

echo "$PKG_MANAGER"
if [ 'whoami'="root" ]; then
	echo "root user" > $LOG_FILE
else
	echo "need add sudo" >$LOG_FILE
	if [ command -v apt-get ]; then
		PKG_MANAGER = sudo PKG_MANAGER
	fi
fi

$PKG_MANAGER update -y
$PKG_MANAGER upgrage -y

echo "install vim \n" >> $LOG_FILE
$PKG_MANAGER install vim -y

# use own .vimrc setting
if [ -f ~/.vimrc ]; then 
	echo "exist .vimrc \n" >>$LOG_FILE
else
	git clone https://github.com/edwardramsey/system-setting/linux_vim/.vimrc 
	mv ~/system-setting/linux_vim/.vimrc ~/
	rm -rf system-setting/
	echo "already install .vimrc \n" >>$LOG_FILE
fi

# use vundle to manage vim plugin
if [ ! -d ~/.vim/bundle ]; then
	mkdir -p ~/.vim/bundle
fi
if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	echo "install vundle already\n" >>$LOG_FILE
fi

# theme
if [ ! -d ~/.vim/colors ]; then
	mkdir -p ~/.vim/colors
	git clone https://github.com/sickill/vim-monokai
	mv vim-monokai/colors/monokai.vim ~/.vim/colors
	rm -rf vim-monokai
	echo "install monokai theme already\n" >>$LOG_FILE
fi

# install C++ pkg
$PKG_MANAGER install -y build-essential 
echo "install C++ pkg \n" >> $LOG_FILE

# install python pkg
$PKG_MANAGER install -y python-pip python-dev
sudo pip install virtualenv
echo "install python pkg \n" >>$LOG_FILE

# install ngnix
$PKG_MANAGER install -y nginx
echo "install nginx pkg already \n" >>$LOG_FILE

# install mysql
$PKG_MANAGER install -y mysql-server
echo "install mysql-server pkg already \n" >>$LOG_FILE




