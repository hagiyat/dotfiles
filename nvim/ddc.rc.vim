if v:false
  call ddc#custom#patch_global('ui', 'native')
  call ddc#custom#patch_global('completionMenu', 'pum.vim')

  inoremap <silent><expr> <TAB>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<TAB>' : ddc#manual_complete()
  inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
  inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
  inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

  call pum#set_option('setline_insert', v:true)
else
  call ddc#custom#patch_global('completionMenu', 'native')
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? '<C-n>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<TAB>' : ddc#manual_complete()
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

call ddc#custom#patch_global('sources', ['nvim-lsp', 'buffer', 'around', 'vsnip', 'file', 'dictionary'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_remove_overlap', 'converter_truncate', 'converter_fuzzy'],
      \   'ignoreCase': v:true,
      \ },
      \ 'around': {'mark': 'A'},
      \ 'dictionary': {'maxCandidates': 6, 'mark': 'D', 'minAutoCompleteLength': 3},
      \ 'necovim': {'mark': 'neco', 'maxCandidates': 6},
      \ 'nvim-lsp': {'mark': 'lsp', 'forceCompletionPattern': "\\.|:\\s*|->", 'ignoreCase': v:true},
      \ 'buffer': {'mark': 'B', 'maxCandidates': 10, 'ignoreCase': v:true},
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
      \ },
      \ 'vsnip': {'dup': v:true},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ 'buffer': {'forceCollect': v:true, 'fromAltBuf': v:true},
      \ 'dictionary': {'smartCase': v:true, 'showMenu': v:false},
      \ })
call ddc#custom#patch_global('filterParams', {
      \ 'converter_truncate': {'maxAbbrWidth': 60, 'maxInfo': 500, 'ellipsis': '...'},
      \ 'converter_fuzzy': {'hlGroup': 'Title'},
      \ })

call ddc#custom#patch_global('specialBufferCompletion', v:true)
call ddc#custom#patch_filetype(
      \ ['denite-filter', 'TelescopePrompt'], 'specialBufferCompletion', v:false
      \ )

call ddc#custom#patch_filetype(['vim', 'toml'], {
      \ 'sources': ['necovim', 'buffer', 'around', 'vsnip', 'file', 'dictionary'],
      \ })
" include @ for snippet
call ddc#custom#patch_filetype(
      \ ['tex'], 'keywordPattern', '[a-zA-Z0-9_@]*'
      \ )
call ddc#custom#patch_filetype(['zsh'], 'sourceOptions', {
      \ 'zsh': {'mark': 'Z'},
      \ })

call ddc#enable()
