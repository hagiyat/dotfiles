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
            "python",
            "ruby",
            "toml",
            "tsx",
            "typescript",
            "yaml",
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
              enable = true,
              peek_definition_code = {
                ["<space>pf"] = "@function.outer",
                ["<saace>pc"] = "@class.outer",
              },
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
      "numToStr/Comment.nvim",
      event = { "BufEnter" },
      config = function()
        require("Comment").setup()
      end,
    }

    use {
      "kylechui/nvim-surround",
      event = { "BufEnter" },
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup()
      end,
    }

    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      wants = { "nvim-cmp" },
      config = function()
        require("nvim-autopairs").setup {
          disable_filetype = { "ddu-ff", "ddu-ff-filter", "ddu-ff-filer" },
        }

        -- ref: https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    }
  end,
}
