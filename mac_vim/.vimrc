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
set cursorline
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
  
" set background=dark
"set background=light

if has("gui_running")
    colorscheme solarized
	set guioptions-=L       " 隐藏左侧滚动条
    set guioptions-=r 
	set guioptions-=T  
	set background=dark
else
   colorscheme monokai
   " set t_Co=256
   
endif
"colorscheme jellybeans
" colorscheme solarized
"colorscheme monokai

"总是显示状态栏
set laststatus=2

set nobackup

"设置宽度不明的文字为双宽度文本
set ambiwidth=double

"设置<leader>
let mapleader = ","

set path =/usr/local/include/**,.,,  

"关闭搜索
nmap <leader>/ :nohlsearch<CR>

"绑定Ctags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

set tags=~/asiainfo_program/tags

" Bunde """"""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"bundle 包管理
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
"Plugin 'wesleyche/SrcExpl'
"
Plugin 'vim-scripts/cscope.vim'
"基础库
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
"Plugin 'scrooloose/syntastic'
"状态栏插件
Plugin 'Lokaltog/vim-powerline'
"查找文件
Plugin 'kien/ctrlp.vim'
"代码对齐
Plugin 'godlygeek/tabular'
"Markdown插件
Plugin 'plasticboy/vim-markdown'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"dash plugin
Plugin 'rizzatti/dash.vim'

"redo
"Plugin 'sjl/gundo.vim'

call vundle#end()


filetype plugin indent on
 


"默认设置的YouCompleteMe的.py文件
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

"设置路径
let &path.="/usr/local/include, /Users/edward/asiainfo_program/include, /Users/edward/asiainfo_program/app, /Users/edward/asiainfo_program/public, /Users/edward/asiainfo_program/dbe_v2"

"开启标签
let g:ycm_collect_identifiers_from_tags_files = 1

"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap hd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"nnoremap hs :YcmCompleter GoTo<CR>


"修改代码检查标志
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0

"语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	
"注释补全
let g:ycm_complete_in_comments = 1

"syntastic
"let g:loaded_syntastic_cpp_cppcheck_checker = 0
"let g:syntastic_cpp_include_dirs = ['/usr/local/include/', '/Users/edward/asiainfo_program/include']
"let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'

"warning icon
"let g:syntastic_warning_symbol = '⚠'

" ignore cpp error
"let g:syntastic_ignore_files=[".*\.cpp$"]

"Gundo
"map <leader>gd :GundoToggle

"cscope
set csprg=/usr/local/bin/cscope
if filereadable("cscope.out")
    cs add cscope.out
endif

"UltiSnips
let g:UltiSnipsExpandTrigger ="<c-n>"
let g:UltiSnipsListSnippets = "<c-y>"
let g:UltiSnipsJumpBackwardTrigger="II"
let g:UltiSnipsEditSplit="vertical"


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
 	 else 
 		call setline(1, "/*************************************************************") 
 		call append(line("."), "    > File Name: ".expand("%")) 
 		call append(line(".")+1, "    > Author: Edward") 
 		call append(line(".")+2, "    > Mail: chenyq6@asiainfo.com ") 
 		call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
 		call append(line(".")+4, " ****************************************************/")
		call append(line(".")+5, "")
 	 endif

"新建文件后，自动定位到文件末尾
 	autocmd BufNewFile * normal G
 endfunc
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
