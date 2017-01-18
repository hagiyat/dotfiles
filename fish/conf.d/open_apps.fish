# emacs-mac
if test -d /Applications/Emacs.app/
  alias spacemacs "open -a /Applications/Emacs.app"
end

# openコマンドでfile uri schemeをブラウザで開く(markdown preview用)
if test -d "/Applications/Firefox.app"
  alias _firefox="open -a /Applications/Firefox.app"
end
# developer editionだとmarkdown preview動かない・・？
if test -d "/Applications/FirefoxDeveloperEdition.app"
  alias firefox="open -a /Applications/FirefoxDeveloperEdition.app"
end
alias browse=_firefox
