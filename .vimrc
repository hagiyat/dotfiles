"set background=dark

"新しい行のインデントを現在行と同じにする
set autoindent
"Vi互換をオフ
set nocompatible
"インクリメンタルサーチを行う
set incsearch
"行番号を表示する
set number
"シフト移動幅
set shiftwidth=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]

" 大文字小文字を区別しない
set ignorecase
" 検索文字に大文字がある場合は大文字小文字を区別
set smartcase
" インクリメンタルサーチ
set incsearch
" 検索マッチテキストをハイライト
set hlsearch

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" 補完時に大文字小文字を区別しない
set infercase
" カーソルを文字が存在しない部分でも動けるようにする
set virtualedit=all
" バッファを閉じる代わりに隠す（Undo履歴を残すため）
set hidden
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" 対応する括弧などをハイライト表示する
set showmatch
" 対応括弧のハイライト表示を3秒にする
set matchtime=3

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" Swapファイル,Backupファイルなど全て無効化する
set nowritebackup
set nobackup
set noswapfile

" 不可視文字の可視化
set list
" 長いテキストの折り返し
set wrap
" 自動的に改行が入るのを無効化
set textwidth=0

" スクリーンベルを無効化
set t_vb=
set novisualbell

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" 不可視文字の表示
set listchars=tab:▸-,trail:=,extends:»,precedes:«,nbsp:%,eol:↲


" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
"
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n','g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
"nnoremap g* g*zz
"nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>


" Neobundle
scriptencoding utf-8

if has('vim_starting')
	filetype plugin off
	filetype indent off
	execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'https://github.com/kien/ctrlp.vim.git'
NeoBundle 'https://github.com/Shougo/neobundle.vim.git'
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
NeoBundle 'https://github.com/scrooloose/syntastic.git'

NeoBundle 'Shougo/vimproc'
"NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'

NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}

NeoBundleLazy 'alpaca-tc/alpaca_tags', {
\	'depends': 'Shougo/vimproc',
\	'autoload' : {
\		'commands': ['AlpacaTagsUpdate', 'AlpacaTagsSet', 'AlpacaTagsBundle']
\	}
\}

NeoBundle 'https://github.com/mileszs/ack.vim.git'
NeoBundle 'https://github.com/vim-scripts/buftabs'

"buftabs
" バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename=1
" バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1
" 現在のバッファをハイライト
let g:buftabs_active_highlight_group="Visual"
" ステータスライン
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]
" ステータスラインを常に表示
set laststatus=2

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'


syntax on
filetype plugin on
filetype indent on
set mouse=n

"colorscheme solarized
"set background=dark

"colorscheme zenburn
colorscheme hybrid
"colorscheme twilight
