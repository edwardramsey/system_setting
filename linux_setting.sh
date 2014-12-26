#!/bin/bash
PKG_MANAGER=$( command -v yum || command -v apt-get || echo "no pkgManager")

echo "$PKG_MANAGER"
if [ 'whoami'="root" ]; then
	echo "root user"
else
	echo "need add sudo"
	if [ command -v apt-get ]; then
		PKG_MANAGER = sudo PKG_MANAGER
	fi
fi

$PKG_MANAGER update -y
$PKG_MANAGER upgrage -y

echo "install vim"
$PKG_MANAGER install vim -y

# use own .vimrc setting
if [ -f ~/.vimrc ]; then 
	rm ~/.vimrc
else
	git clone https://github.com/edwardramsey/systrm-setting
	cd system-setting 
	mv .vimrc ~/
	rm -rf system-setting/
fi

if [ ! -d ~/.vim ]; then
	mkdir -p ~/.vim/
fi
# theme
#git clone https://github.com/sickill/vim-monokai

# install C++ pkg
$PKG_MANAGER install -y build-essential 

# install python pkg
$PKG_MANAGER install -y python-pip python-dev
pip install virtualenv

# install ngnix
$PKG_MANAGER install -y nginx

# install mysql
$PKG_MANAGER install -y mysql-server




