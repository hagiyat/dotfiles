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

