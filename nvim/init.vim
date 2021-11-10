"                      _      "
"   ___  ___ ___ _  __(_)_ _  "
"  / _ \/ -_) _ \ |/ / /  ` \ "
" /_//_/\__/\___/___/_/_/_/_/ "
"                             "
set termguicolors
set background=dark
set number
set t_vb=
set novisualbell
set noshowcmd
" set ambiwidth=double
set cursorline
set clipboard=unnamedplus

set fileencodings=utf-8,iso-2022-jp,cp932

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

" 日本語入力のときの文字化け対応
set ttimeout
set ttimeoutlen=50

" Swapファイル,Backupファイルなど全て無効化する
set nowritebackup
set nobackup
set noswapfile

filetype indent on
filetype plugin on
set tabstop=2
set shiftwidth=2
set expandtab

" 水平分割は下に開く
set splitbelow

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" netrw
let g:netrw_liststyle=3

" import keybinds
runtime! keybinds.vim

" dein
runtime! dein.vim

aug initvim
  autocmd!
  " tabstop / shiftwidth
  autocmd FileType vim,ruby,eruby,slim,javascript,html,zsh,markdown,yaml,terraform setlocal shiftwidth=2 tabstop=2
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
  autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge

  " autosave
  autocmd CursorHold,CursorHoldI,InsertLeave * silent! wall

  " transparent
  set pumblend=10

  " terminal color
  let g:terminal_color_0  = '#171b1c'
  let g:terminal_color_1  = '#cc0000'
  let g:terminal_color_2  = '#4e9a06'
  let g:terminal_color_3  = '#c4a000'
  let g:terminal_color_4  = '#3465a4'
  let g:terminal_color_5  = '#75507b'
  let g:terminal_color_6  = '#0b939b'
  let g:terminal_color_7  = '#d3d7cf'
  let g:terminal_color_8  = '#555753'
  let g:terminal_color_9  = '#ef2929'
  let g:terminal_color_10 = '#8ae234'
  let g:terminal_color_11 = '#fce94f'
  let g:terminal_color_12 = '#729fcf'
  let g:terminal_color_13 = '#ad7fa8'
  let g:terminal_color_14 = '#00f5e9'
  let g:terminal_color_15 = '#eeeeec'
augroup END

