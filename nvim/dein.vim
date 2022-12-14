let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein#install_github_api_token = $GITHUB_API_TOKEN

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
  call dein#load_toml(g:rc_dir.'/dein_statusline.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_keybinds.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir.'/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml(g:rc_dir.'/dein_completion.toml', {'lazy': 1})
  call dein#load_toml(g:rc_dir.'/dein_lsp.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
