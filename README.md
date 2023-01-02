Notes
====

for manjaro linux/gnome

desktop applications
---

- terminal emulator
  - **kitty**

- editor
  - **neovim**
  - emacs(doom emacs)

- browser
  - **chromium**
  - firefox

services
---

- xremap

cli applications
---

- ~tmux~
- zsh
  - zinit
- fzf
- ripgrep
- fd
- exa
- delta
- direnv
- ...

setup xremap
---

Download xremap:
https://github.com/k0kubun/xremap/releases

```
mv xremap ~/.local/bin/.
sudo cp xremap/xremap.service /etc/systemd/system/.
sudo chown root:root /etc/systemd/system/xremap.service
```

for neovim
---

* [requires: github personal access token](https://docs.github.com/ja/github/authenticating-to-github/creating-a-personal-access-token)
  * Set to environment variable in an appropriate way. for expample, ```echo "export GITHUB_API_TOKEN=xxxxx" >> /path/to/.zshenv```

## system libraries

* dotnet-runtime

