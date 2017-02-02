function __register_keybind --on-event fish_prompt
  # keybinds
  bind \cr 'anyfff_widget put_history'
  bind \cx\cx 'anyfff_widget put_filename'
  bind \cx\cg 'anyfff_widget checkout_git_branch'
  bind \cx\cb 'anyfff_widget put_git_branch'

  # aliases
  alias cd 'anyfff_widget cdr'

  functions -e __register_keybind
end
