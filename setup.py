#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os

links = [
    (".config/nvim", "nvim"),
    (".config/vimfx", "vimfx"),
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

