#!/usr/bin/env python
import os

links = [
    (".config/nvim", "nvim"),
    (".config/bat", "bat"),
    (".gitconfig", "gitconfig"),
    (".config/git/ignore", "gitignore_global"),
    (".myclirc", "myclirc"),
    (".vimrc", "vimrc"),
    (".zshrc", "zshrc"),
    (".config/kitty", "kitty"),
    (".config/wezterm", "wezterm"),
    (".config/fontconfig", "fontconfig"),
    (".config/pmy", "pmy"),
    (".config/flake8", "flake8"),
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
