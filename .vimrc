" -----------------
"  vimrc
" -----------------
" 文字コード
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin

" escapeキーをマッピング
imap <c-j> <esc>

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
set shiftwidth=2
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
:"ファイル内の <Tab> が対応する空白の数
set tabstop=2
"カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]

" 基本2にしたので一旦コメントアウト
" autocmd! FileType vim,ruby,eruby,php,javascript,html,zsh setlocal shiftwidth=2 tabstop=2

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
"set virtualedit=all
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
set clipboard+=autoselect,unnamed

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" 256色表示
autocmd Colorscheme * :set t_Co=256

" 背景色でクリアする
autocmd Colorscheme * :set t_ut=

" 不可視文字の表示
set listchars=tab:▸-,trail:=,extends:»,precedes:«,nbsp:%,eol:↲
autocmd Colorscheme * :highlight SpecialKey ctermfg=238

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n','g')<CR><CR>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 移動系
noremap <Space>h  ^
noremap <Space>l  $

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" バッファ操作
nnoremap <Space>bp :bprevious<CR>
nnoremap <Space>bn :bnext<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <F3> :bprevious<CR>
nnoremap <F4> :bnext<CR>
nnoremap <F10> :bdelete<CR>

" QuickFix
map <C-n> :cn<CR>
map <C-p> :cp<CR>
map <C-c> :cclose<CR>
" map <C-o> :copen<CR>

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" 文字コード変換
nnoremap <leader>u :e ++enc=utf8<CR>
nnoremap <leader>s :e ++enc=cp932<CR>

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

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" {{{ plugins
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky.git'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'scrooloose/syntastic.git'
NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload' : {
      \ 'functions' : ['neocomplete#init#disable', 'neocomplete#is_enabled', 'neocomplete#start_manual_complete'],
      \ 'commands' : ['NeoCompleteClean', 'NeoCompleteEnable', 'NeoCompleteDisable'],
      \ 'insert' : 1,
      \ }}
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'rking/ag.vim'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'jaxbot/github-issues.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'koron/codic-vim'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/caw.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle "slim-template/vim-slim"

" color schemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/darkburn'
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
" }}} plugins
call neobundle#end()

" ctrlp
set wildignore+=*/tmp/*,/tmp/*,*.so,*.swp,*.zip,*.pyc,tags,*/vendor/*,*/.git/*,/private/var/folders/*,/var/folders/*,/dev/fd/,*/stdin,GPATH,GTAGS,GRTAGS
"let g:ctrlp_mruf_exclude = '/dev/fd/\|.git\|fugitive'
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

" vimfiler
nnoremap <Space>n :VimFilerExplorer<CR>
let g:vimfiler_safe_mode_by_default = 0

" syntastic
let g:syntastic_auto_loc_list = 1
"let g:syntastic_javascript_checker = 'jshint'

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

" neosnippet
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
let g:neosnippet#snippets_directory='~/.vim/snippets'

" github-issues
let g:github_same_window = 1

" gitv
autocmd FileType git :setlocal foldlevel=99

" vim-over
nnoremap <silent><space>m :OverCommandLine<CR>%s/

" tagbar
nnoremap <silent><space>t :TagbarToggle<CR>
let g:tagbar_type_ruby = {
      \ 'kinds' : [
      \ 'm:modules',
      \ 'c:classes',
      \ 'd:describes',
      \ 'C:contexts',
      \ 'f:methods',
      \ 'F:singleton methods'
      \ ]
      \ }
" NeoBundle 'vim-scripts/tagbar-phpctags', {
"   \   'build' : {
"   \     'others' : 'chmod +x bin/phpctags',
"   \   },
"   \ }

" gtags
nnoremap <Space>gg :Gtags<CR>
nnoremap <Space>gr :Gtags -r<CR>
nnoremap <Space>gs :Gtags -s<CR>

" quickrun
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

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
set laststatus=2
let g:airline_theme='badwolf'
"let g:airline_theme='serene'
"let g:airline_theme='simple'
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" ruby
" rails用
"{{{
" vim-rails
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Leader>r :R<CR>
  nnoremap <buffer><Leader>a :A<CR>
  nnoremap <buffer><Leader>m :Rmodel<Space>
  nnoremap <buffer><Leader>c :Rcontroller<Space>
  nnoremap <buffer><Leader>v :Rview<Space>
  " nnoremap <buffer><Leader>p :Rpreview<CR>
endfunction

aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
  au!
aug END

" endwise
let g:endwise_no_mappings=1

" matchitを有効化
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

" neosnipptsとの共用設定
function! s:set_snippet(type_name)
  if strlen(a:type_name)
    " echo rails#buffer().type_name()
    let snippet_path = printf($HOME. "/.vim/snippets/rails.%s.snip", a:type_name)
    if filereadable(snippet_path)
      call neosnippet#commands#_source(snippet_path)
    endif
  " else
  "   call neosnippet#commands#_source($HOME. "/.vim/snippets/ruby.snip")
  endif
endfunction

augroup rails_snippet_switch
  autocmd!
    autocmd BufEnter *.rb call s:set_snippet(rails#buffer().type_name())
augroup END

set tags=tags,Gemfile.lock.tags
"}}}


syntax on
filetype plugin on
filetype indent on
set mouse=n

colorscheme railscasts
set background=dark
hi LineNr ctermbg=234
hi DiffAdd    ctermfg=226 ctermbg=235
hi DiffChange ctermfg=7 ctermbg=235
hi DiffDelete ctermfg=52 ctermbg=233
hi DiffText   cterm=none ctermfg=208 ctermbg=235
