vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  require("modules/base").setup(use)
  require("modules/syntaxes").setup(use)
  require("modules/colorschemes").setup(use)
  require("modules/completion").setup(use)
  require("modules/filer").setup(use)
  require("modules/finder").setup(use)
  require("modules/lsp").setup(use)
  require("modules/keybinds").setup(use)
end)
