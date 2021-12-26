set novisualbell
set noshowcmd
" set cursorline
set clipboard=unnamedplus
set hlsearch
set splitbelow

nmap <silent> <ESC><ESC> :nohlsearch<CR>

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
nnoremap <silent> <Space>ws :<C-u>split<CR>
nnoremap <silent> <Space>wv :<C-u>vsplit<CR>
nnoremap <silent> <Space>wd :<C-u>q<CR>
nnoremap <Space>w0 <C-w>=

" buffer
nnoremap <silent> <Space>bn :<C-u>bnext<CR>
nnoremap <silent> <Space>bp :<C-u>bprevious<CR>
nnoremap <silent> <Space>bd :<C-u>bdelete<CR>
nnoremap <silent> <Space>ba :<C-u>enew<CR>

" write and quit
nnoremap <Space>gw :<C-u>w<CR>
nnoremap <Space>qq :<C-u>q<CR>
nnoremap <Space>qw :<C-u>wq<CR>
nnoremap <Space>qa :<C-u>qa<CR>
nnoremap <Space>qf :<C-u>qa!<CR>
