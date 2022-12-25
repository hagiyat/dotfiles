return {
  setup = function(use)
    use {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      cmd = { "NvimTreeToggle" },
      setup = function()
        vim.keymap.set("n", "<space>e",  [[<Cmd>NvimTreeToggle<CR>]])
      end,
      config = function()
        require("nvim-tree").setup()
      end
    }
  end
}
