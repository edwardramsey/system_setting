#!/bin/bash

PKG_INSTALL=yum install -y

$PKG_INSTALL epel-release
$PKG_INSTALL tmux

cat >> /root/.tmux.conf << "EOF"
set -g prefix C-a
unbind C-b

# prefix 被拦截，在vim,emacs中按两次生效
set -g status-utf8 on
set -g history-limit 1000
 
# pane movement shortcuts
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
 
# Resize pane shortcuts
bind -r H resize-pane -L 10
bind -r J resize-pane -D 10
bind -r K resize-pane -U 10
bind -r L resize-pane -R 10
 
# 分割pane
bind | split-window -h
bind - split-window -v
EOF

echo "install basic tool: vim wget gcc " 
$PKG_INSTALL vim 
$PKG_INSTALL wget
$PKG_INSTALL gcc

cat >>/root/.vimrc << "EOF"
set nocompatible
filetype off
syntax enable
syntax on  
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big5,utf-16
set number
set showmatch
"切换buffer时自动保存文档
set autowrite
"当文件在外部被修改时自动重新读取
set autoread
"对齐
set autoindent  
set smartindent
set cindent
set incsearch
set hlsearch
set tabstop=4  
set shiftwidth=4  
set laststatus=2
let mapleader = ","
"move block easier
vnoremap < <gv
vnoremap > >gv
"关闭搜索
nmap <leader>/ :nohlsearch<CR>

" Bunde """"""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tomtom/tcomment_vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Mizuchi/STL-Syntax'

call vundle#end()
filetype plugin indent on
 
"tcomment快捷键
map <leader>c <c-_><c-_>

""""""""""" 自定义快捷键，不依赖插件""""""""""""""

"窗口跳转
"control+h进入左边的窗口
nmap <C-H> <C-W>h 
"control+j进入下边的窗口
nmap <C-J> <C-W>j 
"control+k进入上边的窗口
nmap <C-K> <C-W>k
"control+l进入右边的窗口
nmap <C-L> <C-W>l  
 
" 恢复上次文件打开位置  
set viminfo='10,\"100,:20,%,n~/.viminfo  
au BufReadPost * if line("'\"") > 0|if line("'\"") <=line("$")| exe("norm '\"")|else|exe "norm $" |endif|endif

EOF

vim +PluginInstall +qall
