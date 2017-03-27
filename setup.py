#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os

directories = [
    ".config/fish"
]
links = [
    (".config/nvim", "nvim"),
    (".config/vimfx", "vimfx"),
    # (".config/fish/config.fish", "fish/config.fish"),
    # (".config/fish/conf.d", "fish/conf.d"),
    (".gitconfig", "gitconfig"),
    # (".hammerspoon", "hammerspoon"),
    (".myclirc", "myclirc"),
    (".spacemacs", "spacemacs"),
    (".tmux.conf", "tmux.conf"),
    # (".vimrc", "vimrc"),
    (".zshrc", "zshrc"),
    (".config/termite", "termite"),
]

home = os.environ["HOME"]
dotfiles = os.path.abspath(os.path.curdir)

for directory in directories:
    path = "/".join([home, directory])
    if os.path.isdir(path):
        print("[exists] %s" % path)
    else:
        os.makedirs(path)
        print("[created] %s" % path)

for (dest, source) in links:
    destpath = "/".join([home, dest])
    sourcepath = "/".join([dotfiles, source])
    if os.path.islink(destpath):
        print("[exists] %s" % destpath)
    else:
        os.symlink(sourcepath, destpath)
        print("[created] %s" % destpath)

