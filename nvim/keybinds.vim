" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" escape
noremap  <C-g> <ESC>
noremap! <C-g> <ESC>

nnoremap q <Nop>
nnoremap <Space> <Nop>
