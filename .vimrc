"关闭vi兼容模式
set nocompatible
filetype off                  " required!


"语法高亮
syntax enable
syntax on  

"编码
set encoding=utf-8
set fileencodings=utf-8,gb18030,ucs-bom,gb2312,cp936,big5,utf-16

"字体
"set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
"set gfw=幼圆:h10:cGB2312
set guifont=Monaco:h13

"去工具栏
set go=aAce

"如下符号不被分割
set iskeyword+=_,$,@,%,#,-

"保存命令条数
set history=400

"设置行号
set number

set nowrap "不自动换行

set showmatch

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
  
set background=dark
"set background=light

"colorscheme jellybeans
colorscheme solarized

"总是显示状态栏
set laststatus=2

set nobackup

"绑定Ctags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

" Bundle """"""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
" Plugin 'wesleyche/SrcExpl'

Plugin 'L9'
"代码补全，跳转工具
Plugin 'Valloric/YouCompleteMe'
"Plugin 'ervandew/supertab'
"括号补全
Plugin 'jiangmiao/auto-pairs'
"注释工具
Plugin 'tomtom/tcomment_vim'
"显示类，函数信息
"Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar'
"配合YouCompleteMe使用，纠错插件
Plugin 'scrooloose/syntastic'
"状态栏插件
Plugin 'Lokaltog/vim-powerline'
"查找文件
Plugin 'kien/ctrlp.vim'

call vundle#end()


filetype plugin indent on
 
"配做taglist的一些属性
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"快捷键
"nnoremap <F3> :TlistToggle<CR>

"默认设置的YouCompleteMe的.py文件
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

"配置NerdTree的位置和快捷键
let NERDTreeWinPos='right'
nnoremap <F2> :NERDTreeToggle<CR>

"tagbar设置
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_left = 1
let Tlist_WinWidth = 30
nnoremap <F3> :TagbarToggle<CR>

"tcomment快捷键
map <leader>c <c-_><c-_>

"窗口跳转
nmap <C-H> <C-W>h "control+h进入左边的窗口
nmap <C-J> <C-W>j  "control+j进入下边的窗口
nmap <C-K> <C-W>k "control+k进入上边的窗口
nmap <C-L> <C-W>l  "control+l进入右边的窗口
 
" 恢复上次文件打开位置  
set viminfo='10,\"100,:20,%,n~/.viminfo  
au BufReadPost * if line("'\"") > 0|if line("'\"") <=line("$")| exe("norm '\"")|else|exe "norm $" |endif|endif
 
" 
"键盘命令
"F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
 	elseif &filetype == 'cpp'
 		exec "!g++ % -o %<"
 		exec "! ./%<"
 	elseif &filetype == 'java'
 		exec "!javac %"
 		exec "!java %<"
 	elseif &filetype == 'sh'
 		:!./%
 	endif
endfunc
" <F8>调试i
" map <F8> :call Rungdb()<CR>
"func! Rungdb()
"	exec "w"
"	exec "!g++ % -g -o %<"
"	exec "!gdb ./%<"
"endfunc
 
 
 
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()" 
"定义函数SetTitle，自动插入文件头 
func SetTitle() 
"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\###########################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
 		call append(line(".")+1, "\# Author: Edward") 
 		call append(line(".")+2, "\# Created Time:".strftime("%c")) 
 		call append(line(".")+3, "\####################################################")
 		call append(line(".")+4, "\#!/bin/bash") 
 		call append(line(".")+5, "")
 	elseif &filetype == 'python'
 		call setline(1,"#!/usr/bin/env python")
 		call append(line("."),"#coding=utf-8")
 		call append(line(".")+1, "")
 	 else 
 		call setline(1, "/*************************************************************") 
 		call append(line("."), "    > File Name: ".expand("%")) 
 		call append(line(".")+1, "    > Author: Edward") 
 		call append(line(".")+2, "    > Mail: chenyq6@asiainfo.com ") 
 		call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
 		call append(line(".")+4, " ****************************************************/")
		call append(line(".")+5, "")
 	 endif
 	 if &filetype == 'cpp'
 		call append(line(".")+6, "#include<iostream>")
 		call append(line(".")+7, "using namespace std;")													  
 		call append(line(".")+8, "")	
 	 endif																							
 	 if &filetype == 'c'
 		 call append(line(".")+6, "#include<stdio.h>")
 		 call append(line(".")+7, "") 
 	 endif

"新建文件后，自动定位到文件末尾
 	autocmd BufNewFile * normal G
 endfunc
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
