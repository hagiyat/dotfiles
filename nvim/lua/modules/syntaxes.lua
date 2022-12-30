return {
  setup = function(use)
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true
          },
          indent = {
            enable = true
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
            "python",
            "ruby",
            "toml",
            "tsx",
            "typescript",
            "yaml",
          },
        })
      end
    }

    use {
      "numToStr/Comment.nvim",
      event = { "BufRead" },
      config = function()
        require("Comment").setup()
      end
    }

    use({
      "kylechui/nvim-surround",
      event = { "BufRead" },
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup()
      end
    })
  end
}
