#!/bin/bash

PKG_MANAGER=$( command -v yum || command -v apt-get || echo "no pkgManager")
PKG_INSTALL=$PKG_MANAGER" install -y"

$PKG_INSTALL epel-release
$PKG_INSTALL tmux

echo "----- add tmux conf file ------"
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
