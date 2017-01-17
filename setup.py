#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os

links = [
    (".config/nvim", "nvim"),
    (".config/vimfx", "vimfx"),
    (".config/fish/config.fish", "fish/config.fish"),
    (".config/fish/fishfile", "fish/fishfile"),
    (".config/fish/functions", "fish/functions"),
    (".config/fish/conf.d", "fish/conf.d"),
    (".gitconfig", "gitconfig"),
    (".hammerspoon", "hammerspoon"),
    (".myclirc", "myclirc"),
    (".spacemacs", "spacemacs"),
    (".tmux.conf", "tmux.conf"),
    (".vimrc", "vimrc"),
    (".zshrc", "zshrc"),
]

home = os.environ["HOME"]
dotfiles = os.path.abspath(os.path.curdir)

for (dest, source) in links:
    destpath = "/".join([home, dest])
    sourcepath = "/".join([dotfiles, source])
    if os.path.islink(destpath):
        print("[exists] %s" % destpath)
    else:
        os.symlink(sourcepath, destpath)
        print("[created] %s" % destpath)

