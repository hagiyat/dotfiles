return {
  setup = function(use)
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update { with_sync = true }
        ts_update()
      end,
      requires = {
        {
          "nvim-treesitter/nvim-treesitter-context",
          after = "nvim-treesitter",
          config = function()
            require("treesitter-context").setup {
              enable = true,
            }
          end,
        },
        { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
        { "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" },
        { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
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
            "ruby",
            "toml",
            "tsx",
            "typescript",
            "yaml",
            "terraform",
            "vim",
          },
          -- nvim-treesitter-textobjects
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["as"] = "@statement.outer",
                ["is"] = "@statement.inner",
                ["ad"] = "@comment.outer",
                ["id"] = "@comment.inner",
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ["<space>a"] = "@parameter.inner",
              },
              swap_previous = {
                ["<space>A"] = "@parameter.inner",
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- add jumps to jumplist
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
            lsp_interop = {
              enable = false,
              -- peek_definition_code = {
              --   ["<space>pf"] = "@function.outer",
              --   ["<saace>pc"] = "@class.outer",
              -- },
            },
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
    }

    use {
      "slim-template/vim-slim",
      ft = "slim",
    }
  end,
}
