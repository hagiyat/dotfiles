vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim", opt = true }

  require("modules/base").setup(use)
  require("modules/keybind").setup(use)
  require("modules/syntax").setup(use)
  require("modules/colorscheme").setup(use)
  require("modules/ui_expand").setup(use)
  require("modules/ui_enhance").setup(use)
  require("modules/window").setup(use)
  require("modules/lsp").setup(use)
  require("modules/completion").setup(use)
  require("modules/finder").setup(use)
  require("modules/explorer").setup(use)
  require("modules/terminal").setup(use)
  require("modules/statusline").setup(use)
  require("modules/startup").setup(use)
end)
