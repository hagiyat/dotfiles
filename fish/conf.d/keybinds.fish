function __register_keybind --on-event fish_prompt
  bind \cr put_history
  functions -e __register_keybind
end
