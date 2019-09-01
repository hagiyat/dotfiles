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

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" netrw
let g:netrw_liststyle=3

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" escape
noremap  <C-g> <ESC>
noremap! <C-g> <ESC>
nmap <silent> <C-g><C-g> :nohlsearch<CR>
nmap <silent> <ESC><ESC> :nohlsearch<CR>
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

" window(+vim-maximizer)
nnoremap <Space>wh <C-w>h
nnoremap <Space>wj <C-w>j
nnoremap <Space>wk <C-w>k
nnoremap <Space>wl <C-w>l
nnoremap <silent> <Space>w- :<C-u>split<CR>
nnoremap <silent> <Space>w/ :<C-u>vsplit<CR>
nnoremap <silent> <Space>wd :<C-u>q<CR>
nnoremap <Space>w0 <C-w>=

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
let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('$XDG_CONFIG_HOME/nvim/')

  " cache
  call dein#load_toml(g:rc_dir.'/dein_base.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_colors.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_filer.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_syntax.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_lsp.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_statusline.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_lazy.toml', {'lazy': 1})

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

  autocmd InsertLeave,FocusGained,FocusLost * call Fcitx2en()

  " autosave
  autocmd CursorHold,CursorHoldI,InsertLeave * silent! wall

  " terminal color
  let g:terminal_color_0  = '#2e3436'
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

" tagjump keymaps
nnoremap <Space>tl :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Space>th :pop<CR>
