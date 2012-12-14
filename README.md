-- 導入まで --
●brewをインストール

●zshのインストール
> brew install zsh
> brew install zsh-completions

●gitのインストール
> brew install git
> brew install git-flow

●カラースキーマはsolarizedを入れた
> (wgetでもgitからでも)
> cp /(somedir)/solarized/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/.

●zsh補完シェルの準備
gitをインストールすると、補完シェルがついてくるので、それらを使えるようにする
> cd ~/.zsh/plugin
> ln -s /usr/local/Cellar/git-flow/0.4.1/etc/bash_completion.d/git-flow-completion.bash .
> ln -s /usr/local/Cellar/git/1.8.0.2/etc/bash_completion.d/git-completion.bash .

●cloneしたファイルを~/にコピーして完了

