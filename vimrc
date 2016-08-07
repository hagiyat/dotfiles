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
inoremap <silent> jj <ESC>

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
"set smartcase
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

" 画面リサイズにvimのサイズも追従する
autocmd VimResized * wincmd =

" dein
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  call dein#add('Shougo/vimproc', {'build': 'make'})
  call dein#add('kana/vim-submode')

  call dein#add('Shougo/unite.vim', {
        \ 'depends': ['vimproc'],
        \ 'on_cmd': ['Unite'],
        \ 'lazy': 1})
  call dein#add('Shougo/neomru.vim', {'depdens': ['unite.vim']})
  call dein#add('Shougo/unite-outline', {'depdens': ['unite.vim']})
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets', {'depdens': ['neosnippet']})
  call dein#add('Shougo/context_filetype.vim')

  call dein#add('Shougo/vimfiler.vim', {'depdens': ['unite.vim']})

  if has('lua')
    call dein#add('Shougo/neocomplete.vim', { 'on_i': 1, 'lazy': 1})
  endif

  call dein#add('scrooloose/syntastic', {'depends': ['vimproc']})
  call dein#add('bling/vim-bufferline')

  call dein#add('tpope/vim-fugitive')
  call dein#add('osyo-manga/vim-over')
  call dein#add('thinca/vim-quickrun')
  call dein#add('thinca/vim-visualstar')
  call dein#add('thinca/vim-ref')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/incsearch-fuzzy.vim')
  call dein#add('haya14busa/incsearch-easymotion.vim')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-abolish')
  call dein#add('tyru/open-browser.vim')
  call dein#add('kannokanno/previm')

  call dein#add('tpope/vim-rails')
  call dein#add('slim-template/vim-slim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('kchmck/vim-coffee-script')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('w0ng/vim-hybrid')
  call dein#add('vim-scripts/darkburn')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('jpo/vim-railscasts-theme')
  call dein#add('chriskempson/vim-tomorrow-theme')
  call dein#add('vim-scripts/twilight')
  call dein#add('vim-scripts/wombat256.vim')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Unite {{{
nnoremap [unite] <Nop>
nmap s [unite]
let g:unite_enable_start_insert=1

nnoremap [unite]f :<C-u>Unite file_rec/async<CR>
nnoremap [unite]s :<C-u>Unite buffer file_mru<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>
nnoremap [unite]m :<C-u>Unite file_mru<CR>
" nnoremap [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap [unite]w :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap [unite]r :<C-u>UniteResume search-buffer<CR>
nnoremap [unite]l :<C-u>Unite line -buffer-name=lines<CR>
nnoremap [unite]o :<C-u>Unite outline -buffer-name=outline<CR>
nnoremap [unite]c :<C-u>Unite command<CR>
nnoremap [unite]q :Unite location_list<CR>
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
let g:neocomplete#enable_smart_case = 1
let g:neocomplete_enable_underbar_completion = 1
let g:neocomplete_min_syntax_length = 3
let g:neocomplete#max_list = 1000
let g:neocomplete_auto_completion_start_length = 3
let g:neocomplete_force_overwrite_completefunc = 1
let g:neocomplete#skip_auto_completion_time = '0.2'
let g:neocomplete#enable_auto_delimiter = 1

" let g:neocomplete#enable_ignore_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
augroup au_complete
  autocmd!
  let g:neocomplete#force_omni_input_patterns = get(g:, 'neocomplete#force_omni_input_patterns', {})
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\|\h\w*::'
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END
" }}}

augroup END
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

" quickrun
nnoremap <silent><Leader>r :call QuickRun -outputter/buffer/split \":botright 12sp\" -hook/time/enable 1<CR>

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
nnoremap <Space>cc :SyntasticCheck<CR>

" NerdCommenter
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

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
map z/ <Plug>(incsearch-fuzzy-/)

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" previm
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

  let g:previm_open_cmd = ''
  nnoremap [previm] <Nop>
  nmap <Space>m [previm]
  nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
  nnoremap <silent> [previm]r :call previm#refresh()<CR>
augroup END

" }}}


syntax on
filetype plugin on
filetype indent on
set mouse=n

function! s:init_visual()
  hi LineNr ctermbg=234
  hi DiffAdd    ctermfg=226 ctermbg=235
  hi DiffChange ctermfg=7 ctermbg=235
  hi DiffDelete ctermfg=52 ctermbg=233
  hi DiffText   cterm=none ctermfg=208 ctermbg=235
  hi SpellBad   cterm=underline ctermfg=208 ctermbg=235
  hi SpellLocal cterm=italic ctermfg=209 ctermbg=235
  hi SpellRare  cterm=bold ctermfg=210 ctermbg=235
  hi SpecialKey ctermfg=238 ctermbg=235
  hi NonText ctermbg=235
  hi Normal ctermbg=235
  " for jellybeans
  " hi rubyRegexpDelimiter guifg=#8d4e9a
  " hi rubyRegexp guifg=#db6db4
  " hi rubyRegexpSpecial guifg=#a3518a

  " 背景色でクリアする
  set t_ut=

  " 256色表示
  set t_Co=256

  set lazyredraw
endfunction

aug initvim
  autocmd!
  " tabstop / shiftwidth
  autocmd FileType vim,ruby,eruby,slim,php,javascript,html,zsh,markdown setlocal shiftwidth=2 tabstop=2
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge
  autocmd Colorscheme * :call s:init_visual()
augroup END

" colorscheme railscasts
" colorscheme Tomorrow-Night-Eighties
colorscheme jellybeans
colorscheme wombat256mod

