#!/usr/bin/env python
import os

links = [
    (".config/nvim", "nvim"),
    # (".config/fish/config.fish", "fish/config.fish"),
    # (".config/fish/conf.d", "fish/conf.d"),
    (".gitconfig", "gitconfig"),
    (".myclirc", "myclirc"),
    # (".spacemacs", "spacemacs"),
    (".tmux.conf", "tmux.conf"),
    # (".vimrc", "vimrc"),
    (".zshrc", "zshrc"),
    (".config/termite", "termite"),
    (".config/alacritty", "alacritty"),
    #  (".config/rofi", "rofi"),
    (".config/fontconfig", "fontconfig"),
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
