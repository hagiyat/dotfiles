" set encoding=utf-8 scriptencoding utf-8

set termguicolors
set background=dark

set number
set t_vb=
set novisualbell
" set ambiwidth=double
set expandtab
set cursorline
set clipboard=unnamedplus

set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

set autoindent
set showmatch
set matchtime=3
set smartindent
set smarttab
set ignorecase
set smartcase
" FIXME: まだ！
" set inncommand=split
set hlsearch

set list
set wrap
set textwidth=0
set listchars=tab:▸-,trail:=,extends:»,precedes:«,nbsp:%,eol:↲

set infercase
set switchbuf=useopen
set backspace=indent,eol,start

" Swapファイル,Backupファイルなど全て無効化する
set nowritebackup
set nobackup
set noswapfile

filetype indent on
filetype plugin on
set tabstop=2
set shiftwidth=2
set expandtab

" netrw
let g:netrw_liststyle=3

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" escape
noremap  <C-g> <ESC>
noremap! <C-g> <ESC>
nmap <silent> <C-g><C-g> :nohlsearch<CR>
tnoremap <silent> <C-g> <C-\><C-n>

nnoremap q <Nop>
nnoremap <Space> <Nop>

" (insert mode) emacs
inoremap <silent> <C-b> <Left>
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-a> <S-Left>
inoremap <silent> <C-e> <S-Right>
inoremap <silent> <C-h> <C-g>u<C-h>
inoremap <silent> <C-d> <C-g>u<Del>

" window
nnoremap <Space>wh <C-w>h
nnoremap <Space>wj <C-w>j
nnoremap <Space>wk <C-w>k
nnoremap <Space>wl <C-w>l
nnoremap <silent> <Space>w- :<C-u>split<CR>
nnoremap <silent> <Space>w/ :<C-u>vsplit<CR>
nnoremap <silent> <Space>wd :<C-u>q<CR>

" buffer
nnoremap <silent> <Space>bn :<C-u>bnext<CR>
nnoremap <silent> <Space>bp :<C-u>bprevious<CR>
nnoremap <silent> <Space>bd :<C-u>bdelete<CR>
nnoremap <silent> <Space>ba :<C-u>enew<CR>

" write and quit
nnoremap <Space>fs :<C-u>w<CR>
nnoremap <Space>qq :<C-u>q<CR>
nnoremap <Space>qz ZQ
nnoremap <Space>qw :<C-u>wq<CR>
nnoremap <Space>qa :<C-u>qa<CR>
nnoremap <Space>QQ :<C-u>qa!<CR>

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

  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Insertモードから抜けるとIMをOFFに
function! Fcitx2en()
  let s:input_status = system("fcitx-remote")
  if s:input_status == 2
    let l:a = system("fcitx-remote -c")
  endif
endfunction

aug initvim
  autocmd!
  " tabstop / shiftwidth
  autocmd FileType vim,ruby,eruby,slim,php,javascript,html,zsh,markdown,yaml,terraform setlocal shiftwidth=2 tabstop=2
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge

  set ttimeoutlen=150
  autocmd InsertLeave * call Fcitx2en()

  " autosave
  autocmd CursorHold,CursorHoldI,InsertLeave * silent! wall
augroup END

" tagjump keymaps
nnoremap <Space>tl :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Space>th :pop<CR>
