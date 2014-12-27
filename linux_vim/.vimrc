"关闭vi兼容模式
set nocompatible
filetype off                  " required!

"语法高亮
syntax enable
syntax on  

"编码
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big5,utf-16

"判断是dos还是unix结尾
"set fileformats=unix,dos,mac

"字体
"set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
"set gfw=幼圆:h10:cGB2312
set guifont=Monaco:h13

"去工具栏
"set go=aAce

"如下符号不被分割
set iskeyword+=_,$,@,%,#,-

"保存命令条数
set history=500

"设置行号
set number

"不自动换行
set nowrap 

set showmatch

"高亮当前行
"set cursorline
"highlight clear LineNr

"切换buffer时自动保存文档
set autowrite
"当文件在外部被修改时自动重新读取
set autoread

"对齐
set autoindent  
set smartindent
set cindent

"搜索匹配/高亮搜索
set incsearch
set hlsearch

set tabstop=4  
set shiftwidth=4  
  
colorscheme monokai

"总是显示状态栏
set laststatus=2

set nobackup

"设置宽度不明的文字为双宽度文本
set ambiwidth=double

"设置<leader>
let mapleader = ","

"set path =/usr/local/include/**,.,,  

"关闭搜索
nmap <leader>/ :nohlsearch<CR>

"绑定Ctags
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

"set tags=~/asiainfo_program/tags

" Bunde """"""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"bundle 包管理
Plugin 'gmarik/Vundle.vim'
"目录
Plugin 'scrooloose/nerdtree'
"基础库
Plugin 'L9'
"括号补全
Plugin 'jiangmiao/auto-pairs'
"注释工具
Plugin 'tomtom/tcomment_vim'
"显示类，函数信息
Plugin 'majutsushi/tagbar'
"状态栏插件
Plugin 'Lokaltog/vim-powerline'
"查找文件
Plugin 'kien/ctrlp.vim'
"Markdown插件
Plugin 'plasticboy/vim-markdown'
" for python
Plugin 'davidhalter/jedi-vim'

call vundle#end()

filetype plugin indent on
 
"设置路径
"let &path.="/usr/local/include, /Users/edward/asiainfo_program/include, /Users/edward/asiainfo_program/app, /Users/edward/asiainfo_program/public, /Users/edward/asiainfo_program/dbe_v2"

"ctrlp
"显示隐藏文件
let g:ctrlp_show_hidden = 1

"tagbar设置
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_left = 1
let Tlist_WinWidth = 30
nnoremap <F2> :TagbarToggle<CR>

"配置NerdTree的位置和快捷键
let NERDTreeWinPos='right'
nnoremap <F3> :NERDTreeToggle<CR>

"tcomment快捷键
map <leader>c <c-_><c-_>

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
 
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()" 
"定义函数SetTitle，自动插入文件头 
func SetTitle() 
"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
 	elseif &filetype == 'python'
 		call setline(1,"#!/usr/bin/env python")
 		call append(line("."),"#coding=utf-8")
 		call append(line(".")+1, "")
 	 endif

"新建文件后，自动定位到文件末尾
 	autocmd BufNewFile * normal G
 endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
