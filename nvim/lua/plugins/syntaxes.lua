return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        opt = { enable = true },
      },
      "RRethy/nvim-treesitter-endwise",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "html",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "yaml",
          "terraform",
          "vim",
        },
        -- nvim-treesitter-endwise
        endwise = {
          enable = true,
        },
        -- nvim-treesitter-textsubjects
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
      }
    end,
  },
}
