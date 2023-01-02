return {
  setup = function(use)
    use {
      "phaazon/hop.nvim",
      requires = "folke/which-key.nvim",
      event = "BufReadPost",
      branch = "v2",
      config = function()
        local hop = require("hop")
        hop.setup {
          keys = "etovxqpdygfblzhckisuran",
          quit_key = "<Esc>",
        }

        local directions = require("hop.hint").HintDirection
        local wk = require("which-key")
        local setup_hop_line = function(mode)
          wk.register({
            ["f"] = {
              function()
                hop.hint_char1 {
                  direction = directions.AFTER_CURSOR,
                  current_line_only = true,
                }
              end,
              "hop forward",
            },
            ["F"] = {
              function()
                hop.hint_char1 {
                  direction = directions.BEFORE_CURSOR,
                  current_line_only = true,
                }
              end,
              "hop backward",
            },
            ["t"] = {
              function()
                hop.hint_char1 {
                  direction = directions.AFTER_CURSOR,
                  current_line_only = true,
                  hint_offset = -1,
                }
              end,
              "hop forward -1",
            },
            ["T"] = {
              function()
                hop.hint_char1 {
                  direction = directions.BEFORE_CURSOR,
                  current_line_only = true,
                  hint_offset = 1,
                }
              end,
              "hop backward +1",
            },
          }, { remap = true, mode = mode })
        end
        setup_hop_line("n")
        setup_hop_line("v")

        wk.register({
          s = {
            name = "+hop",
            f = {
              function()
                hop.hint_char2()
              end,
              "char2",
            },
            w = {
              function()
                hop.hint_words()
              end,
              "words",
            },
          },
        }, { remap = true, mode = "n" })
      end,
    }

    use {
      "declancm/maximize.nvim",
      requires = "folke/which-key.nvim",
      event = "BufReadPost",
      config = function()
        require("maximize").setup {
          default_keymaps = false,
        }
        require("which-key").register({
          w = {
            z = {
              function()
                require("maximize").toggle()
              end,
              "toggle maximize",
            },
          },
        }, { prefix = "<space>", remap = true, mode = "n" })
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "folke/which-key.nvim",
      },
      event = "BufReadPost",
      config = function()
        require("trouble").setup {
          auto_close = true,
          signs = {
            error = "",
            warn = "",
            information = "",
            hint = "",
            other = "",
          },
          auto_jump = { "lsp_definitions" },
        }

        local wk = require("which-key")
        wk.register({
          x = {
            x = {
              "<cmd>TroubleToggle<cr>",
              "all",
            },
            w = {
              "<cmd>TroubleToggle workspace_diagnostics<cr>",
              "workspace diagnostics",
            },
            d = {
              "<cmd>TroubleToggle document_diagnostics<cr>",
              "document diagnostics",
            },
            l = {
              "<cmd>TroubleToggle loclist<cr>",
              "loclist",
            },
            q = {
              "<cmd>TroubleToggle quickfix<cr>",
              "quickfix",
            },
          },
        }, { prefix = "<space>", noremap = true, silent = true, mode = "n" })

        wk.register({
          R = {
            "<cmd>TroubleToggle lsp_references<cr>",
            "lsp references",
          },
        }, { prefix = "g", noremap = true, silent = true, mode = "n" })
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPost",
      config = function()
        require("gitsigns").setup {}
      end,
    }
  end,
}
