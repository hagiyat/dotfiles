function __register_keybind --on-event fish_prompt
  bind \cr put_history
  bind \cx\cx insert_filename
  bind \cx\cg checkout_git_branch
  bind \cx\cb insert_git_branch

  functions -e __register_keybind
end
