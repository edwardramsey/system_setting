system_setting
==============
##Intro
Files prepared for work environment

With this I can use MacOS with linux(VPS, Digital Ocean and Aliyun) together.

## Linux setting files
linux_setting.sh is designed for ubuntu and CentOS to install vim, C++, python, mysql and nginx automactically

## SSH Tool 
This is a tool which I copy code from others's blog before.

add target ssh machine to the list and decrease typing hostnames time.

## Vim Theme
A same theme file may show different colors in different terminals. For my terminal I use Monokai and it seems can't work with Solarized theme well together. so I adjust a Monokai vim theme file for my own terminal and iTerm2.

Just like this:
	```
	highlight Comment cterm=underline ctermbg=Blue ctermfg=White
	```

References:

[sickill/Monokai](https://github.com/sickill/vim-monokai/blob/master/colors/monokai.vim)

[rickharris/Monokai](https://github.com/rickharris/vim-monokai/blob/master/colors/monokai.vim)

sickill's theme is more popular, but I don't like the background.

##.vimrc配置 .vimrc Setting
`.vimrc` setting is mainly for my C++ programming environment.

这是我的`.vimrc` 配置文件，主要用来做C++方面的一些开发

**使用平台：**

- MacOSX Yosemite 10.10.1
- xcode command line tools
- latest MacVim(7.4)

I use [bundle](https://github.com/gmarik/Vundle.vim) to manage my vim plugins.

我用 [bundle](https://github.com/gmarik/Vundle.vim)来管理我的vim的插件

几个觉得比较好用的插件：

Some awesome plugins in vim:

- Plugin `nerdtree`

	[scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)

- Plugin `L9`

	新的vundle管理在vimscript网站里的可以直接写名字

- Plugin `auto-pairs`

	自动完成括号的自动补全

- Plugin `YouCompleteMe`
	
	代码补全跳转插件，支持C++标准库，[地址](https://github.com/Valloric/YouCompleteMe)，但某些时候，某些时候ctags的函数跳转比YCM好用。

- Plugin `majutsushi/tagbar`  

	显示函数、类信息，依赖`ctags`。

- plugin `tcomment_vim` 

	注释插件

- Plugin `Lokaltog/vim-powerline`

	状态栏插件，记录行数、字符编码、系统信息等

- Plugin `scrooloose/syntastic` 

	配合YouCompleteMe使用，纠错插件，感觉意义不是很大（已不用）
	
- Plugin `kien/ctrlp.vim`
	
	查找文件插件


##Tips for installing YouCompleteMe
Although vundle is convenient to finish installing these plugins, there would be some problems with installing YouCompleteMe.

其他的plugin只要按照vundle中的说明就可以搞定了，但是YouCompleteMe会有一些问题。


1. Remember to `./install --clang-completer` and it may cost you a lot of time.

	安装完之后要记得`./install --clang-completer`，如果网络有问题这个过程会很慢。

2. There is no `.ycm_extra_conf.py`. If you dont't want to just use the basic function of the plugin, you have to add this `.py` file to you project or add this command to .vimrc.

	没有`.ycm_extra_conf.py`文件。我安装完之后是没有/cpp这个文件夹的，需要自己放一个`.ycm_extra_conf.py`（配置编译信息啊等等）进去。按照YouCompleteMe的说法是每个工程都该有一个自己的`.ycm_extra_conf.py`文件，但是大部分其实可以统一的，加一行

		let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py
		
	设置到你的`.ycm_extra_conf.py`的路径下即可。

3. Can't find iostream after open C++ file.

	打开C++代码提示iostream等标准库找不到

  	这是因为YouCompleteMe的配置文件找不到STL所在的路径，可以通过如下命令来找
  	
  	`echo | clang -std=c++11 -stdlib=libc++ -v -E -x c++ -`
  	
  	[参考文章：YouCompleteMe安装遇到的问题及解决办法](http://blog.marchtea.com/archives/175)


##cscope 配置
cscope是一个很好查询函数等的插件

配置cscope会遇到路径的文件，即cs add path 之后找不到文件，因为在项目目录中生成的是相对路径

解决办法：

在/usr/local/bin路径下写一个cscopemake.sh的脚本:


```
#!/bin/sh
usage(){
	echo "Usage: cscopemake.sh src_path project_name"
}

if [ $# -ne 2 ];then
	usage
		exit
fi
SRC_PATH=$1
# set CSCOPE_DB (set in .bash_peofile) = CSCOPE_PATH
CSCOPE_PATH=~/cscope/$2
mkdir -p $CSCOPE_PATH
cd $CSCOPE_PATH

find $SRC_PATH -name "*.h" -o -name "*.c" -o -name "*.cpp" > cscope.files
cscope -bkq -i ./cscope.files

```

[参考文章1:Vim + cscope handle大型C++项目](http://www.dreamingo.com:9999/blog/vim-cscope-handle-project)

[参考文章2：使用vim看代码：cscope ](http://blog.chinaunix.net/uid-10319840-id-3653097.html)







