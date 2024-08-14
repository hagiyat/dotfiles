return {
  {
    "ggandor/leap.nvim",
    event = "BufReadPost",
    dependincies = {
      "tpope/vim-repeat",
    },
    config = function()
      -- require("leap").create_default_mappings()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", function()
        require("leap.treesitter").select()
      end)
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "BufReadPost",
    dependincies = {
      "tpope/vim-repeat",
      "ggandor/leap.nvim",
    },
    config = function()
      require("flit").setup {
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        -- Repeat with the trigger key itself.
        clever_repeat = true,
        multiline = false,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {},
      }
    end,
  },
}
