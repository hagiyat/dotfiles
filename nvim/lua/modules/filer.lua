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
        require("nvim-tree").setup({
          view = {
            mappings = {
              custom_only = true,
              list = {
                { key = { "<CR>", "l" }, action = "edit" },
                { key = { "<TAB>" },     action = "cd" },
                { key = "<",             action = "prev_sibling" },
                { key = ">",             action = "next_sibling" },
                { key = "H",             action = "parent_node" },
                { key = "h",             action = "close_node" },
                { key = "p",             action = "preview" },
                { key = ".",             action = "toggle_dotfiles" },
                { key = "R",             action = "refresh" },
                { key = "a",             action = "create" },
                { key = "d",             action = "remove" },
                { key = "r",             action = "rename" },
                { key = "x",             action = "cut" },
                { key = "C",             action = "copy" },
                { key = "P",             action = "paste" },
                { key = "y",             action = "copy_name" },
                { key = "Y",             action = "copy_absolute_path" },
                { key = "-",             action = "dir_up" },
                { key = "f",             action = "live_filter" },
                { key = "F",             action = "clear_live_filter" },
                { key = "q",             action = "close" },
                { key = "W",             action = "collapse_all" },
                { key = "E",             action = "expand_all" },
                { key = "S",             action = "search_node" },
                { key = "g?",            action = "toggle_help" },
              }
            }
          },
          actions = {
            open_file = {
              quit_on_open = true
            }
          }
        })
      end
    }
  end
}
