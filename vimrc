set encoding=utf-8
scriptencoding utf-8

" -----------------
"  vimrc
" -----------------
" 文字コード
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin

" escapeキーをマッピング
noremap! <C-j> <ESC>
noremap  <C-j> <ESC>

" leaderを , に割り当て
let mapleader = ','
noremap \  ,

"新しい行のインデントを現在行と同じにする

set autoindent
"インクリメンタルサーチを行う
set incsearch
"行番号を表示する
set number
" インデント
set shiftwidth=4
set tabstop=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
:"ファイル内の <Tab> が対応する空白の数
"カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]

" 大文字小文字を区別しない
set ignorecase
" 検索文字に大文字がある場合は大文字小文字を区別
set smartcase
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
" set matchpairs& matchpairs+=<:>

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

" 不可視文字の表示
set listchars=tab:▸-,trail:=,extends:»,precedes:«,nbsp:%,eol:↲

augroup au_initvim
  autocmd!
  " tabstop / shiftwidth
  autocmd! FileType vim,ruby,eruby,slim,php,javascript,html,zsh setlocal shiftwidth=2 tabstop=2
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge
  " 256色表示
  autocmd Colorscheme * :set t_Co=256
  " 背景色でクリアする
  autocmd Colorscheme * :set t_ut=
  " specialkeyの色設定
  autocmd Colorscheme * :highlight SpecialKey ctermfg=238

  set lazyredraw
augroup END

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

" 行末までをyank
nnoremap Y y$

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
nnoremap <Leader>u :e ++enc=utf8<CR>
nnoremap <Leader>s :e ++enc=cp932<CR>

" exモード無効
nnoremap Q <Nop>

" Neobundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
" {{{ plugins
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/vimfiler.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'scrooloose/syntastic.git'
NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload' : {
      \ 'functions' : ['neocomplete#init#disable', 'neocomplete#is_enabled', 'neocomplete#start_manual_complete'],
      \ 'commands' : ['NeoCompleteClean', 'NeoCompleteEnable', 'NeoCompleteDisable'],
      \ 'insert' : 1,
      \ }}
NeoBundle 'Shougo/neomru.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimshell.vim', { 'depends' : [ 'Shougo/vimproc.vim' ] }
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/unite-outline', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'tsukkee/unite-tag', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'szw/vim-tags'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'jaxbot/github-issues.vim'
NeoBundle 'moznion/github-commit-comment.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'koron/codic-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/caw.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'osyo-manga/vim-watchdogs', { 'depends' : [
  \   'thinca/vim-quickrun',
  \   'Shougo/vimproc.vim',
  \   'osyo-manga/shabadou.vim',
  \   'cohama/vim-hier',
  \   'dannyob/quickfixstatus'
  \ ] }
NeoBundle 'haya14busa/incsearch.vim'

NeoBundle "slim-template/vim-slim"
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'clausreinke/typescript-tools'

" color schemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/darkburn'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'adlawson/vim-sorcerer'
NeoBundle 'cocopon/iceberg.vim'
" }}} plugins
call neobundle#end()

" Unite {{{
nnoremap [unite] <Nop>
nmap s [unite]
let g:unite_enable_start_insert=1

" pry historyのUnite Source追加
augroup au_pry_history
  autocmd!
  let s:source = {
    \ "name" : "pry_histories",
    \ "description" : "pry history unite-source",
    \ "default_action" : "insert",
  \}
  function! s:source.gather_candidates(args, context)
    let histories = split(system("awk '!a[$0]++' ~/.pry_history | tail -r"), '\n')
    return map(histories, '{"word"  : v:val}')
  endfunction
  call unite#define_source(s:source)
  unlet s:source
augroup END

nnoremap [unite]f :<C-u>Unite file_rec/async<CR>
nnoremap [unite]s :<C-u>Unite buffer file_mru<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>
nnoremap [unite]m :<C-u>Unite file_mru<CR>
nnoremap [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap [unite]w :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap [unite]r :<C-u>UniteResume search-buffer<CR>
nnoremap [unite]l :<C-u>Unite line -buffer-name=lines<CR>
nnoremap [unite]o :<C-u>Unite outline -buffer-name=outline<CR>
nnoremap [unite]c :<C-u>Unite command<CR>
nnoremap [unite]h :<C-u>Unite pry_histories -buffer-name=pry-histories<CR>
let g:unite_source_rec_async_command='ag --follow --nocolor --nogroup --hidden -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''
"}}}

" vimfiler
nnoremap <Space>n :VimFilerExplorer<CR>
let g:vimfiler_tree_leaf_icon = '⁝'
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▹'
let g:vimfiler_readonly_file_icon = '⭤'
let g:vimfiler_safe_mode_by_default = 0
" c-hで倍サイズに広げる
function! s:vimfiler_width_expr()
  let w = vimfiler#get_context().winwidth
  return w == winwidth(0) ? w * 2 : w
endfunction
augroup au_vimfiler
  autocmd!
  autocmd FileType vimfiler
    \ nmap <buffer> <SID>(vimfiler_redraw_screen) <Plug>(vimfiler_redraw_screen)|
    \ nnoremap <buffer><script><expr> <C-H>
    \   <SID>vimfiler_width_expr() . "\<C-W>\|\<SID>(vimfiler_redraw_screen)"
augroup END

" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
augroup au_rubycomplete
  autocmd!
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
augroup END
" }}}

" neosnippet {{{
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
" }}}

" github-issues
" let g:github_same_window = 1

" gitv
augroup au_gitv
  autocmd!
  autocmd FileType git :setlocal foldlevel=99
augroup END

" vim-over
nnoremap <silent><Space>mm :OverCommandLine<CR>%s/
nnoremap <silent><Space>mr :OverCommandLine<CR>%s/<C-R><C-W>

" vim-tags
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -f tags -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=tags,Gemfile.lock.tags
nnoremap <Space>tt g<C-]>
nnoremap <Space>tg TagsGenerate<CR>

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

" quickrun
nnoremap <silent><Leader>r :call QuickRun -outputter/buffer/split \":botright 12sp\" -hook/time/enable 1<CR>

" vimshell
let g:vimshell_prompt_expr = 'getcwd()." ⮁ "'
nnoremap <silent><Leader>sz :VimShellInteractive --split='split \| resize 20' zsh<CR>

" watchdogs
let g:vimrubocop_config = printf('%s/.rubocop.yml', $HOME)
let g:watchdogs_check_BufWritePost_enable = 1
let g:quickrun_config = {
  \ "ruby/watchdogs_checker" : {
  \   "type" : "watchdogs_checker/rubocop"
  \ }
  \}

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

" incsearch
map / <Plug>(incsearch-forward)

" ruby
" rails用
"{{{
" vim-rails
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
let g:rails_some_option = 1

function! s:SetUpRailsSetting()
  nnoremap <buffer><Leader>r :R<CR>
  nnoremap <buffer><Leader>a :A<CR>
  nnoremap <buffer><Leader>m :Rmodel<Space>
  nnoremap <buffer><Leader>c :Rcontroller<Space>
  nnoremap <buffer><Leader>v :Rview<Space>

  " endwise
  let g:endwise_no_mappings=1

  " vimshell
  nnoremap <buffer><Leader>sc :VimShellInteractive rails console --split=""<CR>
  nnoremap <buffer><Leader>ss :VimShellInteractive rails server --split=""<CR>
  iab -r show-routes
  iab -m find-method
  iab -g --grep
  iab !r reload!
  autocmd FileType int-rails inoremap <C-r> <ESC>:<C-u>Unite pry_histories -buffer-name=pry-histories<CR>
  autocmd FileType int-rails nnoremap <C-r> :<C-u>Unite pry_histories -buffer-name=pry-histories<CR>

endfunction

" neosnipptsとの共用設定
function! s:set_snippet(type_name)
  if strlen(a:type_name)
    for type in ['controller', 'model', 'helper', 'routes', 'spec', 'slim']
      "  echomsg a:type_name. " - ". type
      if match(a:type_name, type) != -1
        let snippet_path = printf($HOME. '/.vim/snippets/rails.%s.snip', type)
        if filereadable(snippet_path)
          call neosnippet#commands#_source(snippet_path)
        else
          echomsg 'unreadable '. snippet_path
        endif
      endif
    endfor
  endif
endfunction

aug setup_rails
  autocmd!
  autocmd User Rails call s:SetUpRailsSetting()
  autocmd User Rails call s:set_snippet(rails#buffer().type_name())
  " autocmd BufEnter *.rb call s:set_snippet(rails#buffer().type_name())
aug END
"}}}


syntax on
filetype plugin on
filetype indent on
set mouse=n

" colorscheme railscasts
colorscheme Tomorrow-Night-Eighties
set background=dark
hi LineNr ctermbg=234
hi DiffAdd    ctermfg=226 ctermbg=235
hi DiffChange ctermfg=7 ctermbg=235
hi DiffDelete ctermfg=52 ctermbg=233
hi DiffText   cterm=none ctermfg=208 ctermbg=235
hi SpellBad   cterm=underline ctermfg=208 ctermbg=235
hi SpellLocal cterm=italic ctermfg=209 ctermbg=235
hi SpellRare  cterm=bold ctermfg=210 ctermbg=235
