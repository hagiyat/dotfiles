" 文字コード
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin

" escapeキーをマッピング
imap <c-j> <esc>
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" leaderを , に割り当て
let mapleader = ","
noremap \  ,

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

" タブキーで半角スペース入力
set expandtab

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" 256色表示
autocmd Colorscheme * :set t_Co=256

" 不可視文字の表示
set listchars=tab:▸-,trail:=,extends:»,precedes:«,nbsp:%,eol:↲
autocmd Colorscheme * :highlight SpecialKey ctermfg=238

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

" バッファ操作
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>

" 文字コード変換
nnoremap <leader>u :e ++enc=utf8<CR>
nnoremap <leader>s :e ++enc=cp932<CR>


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

NeoBundle 'Shougo/neocomplcache.vim'

NeoBundle 'https://github.com/rking/ag.vim'
NeoBundle 'https://github.com/bling/vim-airline'
NeoBundle 'https://github.com/bling/vim-bufferline'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'osyo-manga/vim-over'

NeoBundle 'Yggdroot/indentLine'

" airline
set laststatus=2
let g:airline_theme='zenburn'
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

NeoBundle 'PDV--phpDocumentor-for-Vim'
nnoremap <silent><space>c :call PhpDocSingle()<CR>

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,tags,*/vendor/*

" syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checker = 'jshint'

NeoBundle 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" vim-over
nnoremap <silent><space>m :OverCommandLine<CR>%s/

" color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'vim-scripts/darkburn'
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jpo/vim-railscasts-theme'

syntax on
filetype plugin on
filetype indent on
set mouse=n

colorscheme darkburn
