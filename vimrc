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
set hlsearch

set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%,eol:$
set wrap
set textwidth=0

set infercase
set switchbuf=useopen
set backspace=indent,eol,start

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

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" escape
noremap  <C-g> <ESC>
noremap! <C-g> <ESC>
nmap <silent> <C-g><C-g> :nohlsearch<CR>

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

function! Fcitx2en()
  let s:input_status = system("fcitx-remote")
  if s:input_status == 2
    let l:a = system("fcitx-remote -c")
  endif
endfunction

aug initvim
  autocmd!
  autocmd FileType vim,ruby,eruby,slim,php,javascript,html,zsh,markdown,yaml,terraform setlocal shiftwidth=2 tabstop=2
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
  autocmd BufWritePre * :%s/\s\+$//ge

  set ttimeoutlen=150
  autocmd InsertLeave * call Fcitx2en()
  autocmd VimEnter,Colorscheme * hi SpecialKey term=none ctermfg=242
  autocmd VimEnter,Colorscheme * hi NonText term=none ctermfg=242
  colorscheme desert
augroup END
