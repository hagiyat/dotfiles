:" 文字コード
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin

" escapeキーをマッピング
imap <c-j> <esc>
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" leaderを , に割り当て
"let mapleader = ","
"noremap \  ,

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
:"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]

" このへんは2文字インデント
autocmd! FileType ruby,php,javascript,html,zsh setlocal shiftwidth=2 tabstop=2

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

" 全角文字対策
set ambiwidth=double

" タブキーで半角スペース入力
set expandtab

" カーソル行強調
set cursorline

" yankしつつpbcopy
"set clipboard=unnamed

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

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" 文字コード変換
nnoremap <leader>u :e ++enc=utf8<CR>
nnoremap <leader>s :e ++enc=cp932<CR>

" paste切り替え
nnoremap <silent><space>cv :set paste<CR>:startinsert<CR>
" pdvとあたる・・・！
"autocmd InsertLeave * set nopaste

" Dash.app連携
function! s:dash(...)
  if len(a:000) == 1 && len(a:1) == 0
    echomsg 'No keyword'
else
    let ft = &filetype
    if &filetype == 'python'
      let ft = ft.'2'
    endif
    let ft = ft.':'
    let word = len(a:000) == 0 ? input('Keyword: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
    call system(printf("open dash://'%s'", word))
  endif
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)
nnoremap <Space>d :call <SID>dash(expand('<cword>'))<CR>

" Neobundle
scriptencoding utf-8

if has('vim_starting')
	filetype plugin off
	filetype indent off
	execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'https://github.com/Shougo/neobundle.vim.git'

NeoBundle 'https://github.com/kien/ctrlp.vim.git'
NeoBundle 'https://github.com/tacahiroy/ctrlp-funky.git'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,tags,*/vendor/*,*/.git/*,/dev/fd/,*/stdin*
let g:ctrlp_mruf_exclude = '/dev/fd/\|.git\|fugitive'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 500
"let g:ctrlp_use_migemo = 1
let g:ctrlp_extensions = ['funky']
"let g:ctrlp_user_command = 'ag %s -l'
nnoremap <Space>pb :<C-u>CtrlPBuffer<CR>
nnoremap <Space>pp :<C-u>CtrlP<CR>
nnoremap <Space>pl :<C-u>CtrlPLine<CR>
nnoremap <Space>pm :<C-u>CtrlPMRUFiles<CR>
nnoremap <Space>pq :<C-u>CtrlPQuickfix<CR>
nnoremap <Space>ps :<C-u>CtrlPMixed<CR>
nnoremap <Space>pf :<C-u>CtrlPFunky<CR>

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
nnoremap <Space>n :VimFilerExplorer<CR>

NeoBundle 'https://github.com/scrooloose/syntastic.git'
let g:syntastic_auto_loc_list = 1
"let g:syntastic_javascript_checker = 'jshint'

" if_luaが有効ならneocompleteを使う
" 動作が遅くなってきたらLazyにする
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

elseif neobundle#is_installed('neocomplcache')
    " neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1

endif

NeoBundleLazy "Shougo/neosnippet", {"autoload": {"insert": 1,}}
NeoBundleLazy "Shougo/neosnippet-snippets", {"autoload": {"insert": 1,}}
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


NeoBundle 'https://github.com/rking/ag.vim'

NeoBundle 'https://github.com/bling/vim-airline'
set laststatus=2
let g:airline_theme='wombat'
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

NeoBundle 'https://github.com/bling/vim-bufferline'

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'gregsexton/gitv'
autocmd FileType git :setlocal foldlevel=99

NeoBundle 'osyo-manga/vim-over'
nnoremap <silent><space>m :OverCommandLine<CR>%s/

"NeoBundle 'Yggdroot/indentLine'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'

NeoBundle 'majutsushi/tagbar'
nnoremap <silent><space>t :TagbarToggle<CR>

NeoBundle 'vim-scripts/tagbar-phpctags', {
  \   'build' : {
  \     'others' : 'chmod +x bin/phpctags',
  \   },
  \ }

NeoBundle 'git://github.com/kana/vim-fakeclip.git'
map y <Plug>(fakeclip-y)
map yy <Plug>(fakeclip-Y)
map p <Plug>(fakeclip-p)
"map dd <Plug>(fakeclip-D)

NeoBundle 'PDV--phpDocumentor-for-Vim'
nnoremap <silent><space>cc :call PhpDocSingle()<CR>

NeoBundle 'koron/codic-vim'

" quickrun
NeoBundle 'thinca/vim-quickrun'
nnoremap <silent><Leader>r :call QuickRun -outputter/buffer/split \":botright 12sp\" -hook/time/enable 1<CR>
" 一番下にウィンドウを分割させて出力
" :QuickRun -outputter/buffer/split ":botright"
"
" " ウィンドウの高さを指定する場合
" :QuickRun -outputter/buffer/split ":botright 8sp"
"
" " 出力がなかった場合に出力バッファを自動的に閉じる
" :QuickRun -outputter/buffer/close_on_empty 1
"
" " quickfix へと出力する
" :QuickRun -outputter quickfix
"
" " 実行時間を計測し、その結果も最後に出力する
" :QuickRun ruby -hook/time/enable 1

" fugitive
noremap <Leader>ga :!git add .<CR>
noremap <Leader>gc :!git commit -m '<C-R>="'"<CR>
noremap <Leader>gsh :!git push<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/darkburn'
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jpo/vim-railscasts-theme'

" nanapi only
NeoBundle 'kana/vim-gf-user'
NeoBundle 'git@github.com:nanapi/nanapi.vim.git'

syntax on
filetype plugin on
filetype indent on
set mouse=n

colorscheme jellybeans
set background=dark

function! s:diffColor() "{{{
  colorscheme solarized
  set background=dark
endfunction "}}}
command! VimdiffBootstrap :call s:diffColor()

" golang
" :Fmt などで gofmt の代わりに goimports を使う
let g:gofmt_command = 'goimports'

" Go に付属の plugin と gocode を有効にする
set rtp+=${GOROOT}/misc/vim
set rtp+=${GOPATH}/src/github.com/nsf/gocode/vim

" 保存時に :Fmt する
"au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
au FileType go compiler go
