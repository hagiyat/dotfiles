function __register_keybind --on-event fish_prompt
  bind \cr put_history_widget
  bind \cx\cx insert_filename_widget
  bind \cx\cg checkout_git_branch_widget
  bind \cx\cb insert_git_branch_widget

  functions -e __register_keybind
end
