return {
  setup = function(use)
    use {
      "phaazon/hop.nvim",
      event = "BufReadPost",
      branch = "v2",
      wants = { "which-key.nvim" },
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

    use {
      "Wansmer/treesj",
      event = "BufEnter",
      wants = { "nvim-treesitter", "which-key.nvim" },
      config = function()
        require("treesj").setup {
          use_default_keymaps = false,
          check_syntax_error = true,
          max_join_length = 160,
          cursor_behavior = "hold",
          notify = true,
        }
        local wk = require("which-key")
        wk.register({
          j = {
            name = "+treesj",
            j = {
              function()
                vim.cmd([[TSJToggle]])
              end,
              "toggle",
            },
            s = {
              function()
                vim.cmd([[TSJSplit]])
              end,
              "split",
            },
            J = {
              function()
                vim.cmd([[TSJJoin]])
              end,
              "join",
            },
          },
        }, { prefix = "<space>", remap = true, mode = { "n", "v" } })
      end,
    }

    use {
      "gbrlsnchs/winpick.nvim",
      event = "BufEnter",
      wants = { "which-key.nvim" },
      config = function()
        local winpick = require("winpick")
        winpick.setup {
          border = "double",
          filter = nil, -- doesn't ignore any window by default
          prompt = "Pick a window: ",
          format_label = winpick.defaults.format_label,
          chars = { "W", "F", "J", "D", "K", "S", "L", "A" },
        }

        require("which-key").register({
          w = {
            w = {
              function()
                local winid = winpick.select()
                if winid then
                  vim.api.nvim_set_current_win(winid)
                end
              end,
              "pick a window",
            },
          },
        }, { prefix = "<space>", remap = true, mode = "n" })
      end,
    }

    use {
      "declancm/maximize.nvim",
      wants = { "which-key.nvim" },
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
      "RRethy/vim-illuminate",
      event = "BufReadPost",
      config = function()
        require("illuminate").configure {
          delay = 1000,
          filetype_denylist = {
            "alpha",
            "Trouble",
          },
        }
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true, underdotted = true })
      end,
    }

    use {
      "Pocco81/auto-save.nvim",
      event = "InsertEnter",
      config = function()
        require("auto-save").setup {
          enabled = true,
          trigger_events = { "InsertLeave", "TextChanged" },
          write_all_buffers = false,
        }
      end,
    }
  end,
}
