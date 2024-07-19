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
          wk.add({
            {
              "f",
              function()
                hop.hint_char1 {
                  direction = directions.AFTER_CURSOR,
                  current_line_only = true,
                }
              end,
              desc = "hop forward",
              remap = true,
            },
            {
              "F",
              function()
                hop.hint_char1 {
                  direction = directions.BEFORE_CURSOR,
                  current_line_only = true,
                }
              end,
              desc = "hop backward",
              remap = true,
            },
            {
              "t",
              function()
                hop.hint_char1 {
                  direction = directions.AFTER_CURSOR,
                  current_line_only = true,
                  hint_offset = -1,
                }
              end,
              desc = "hop forward -1",
              remap = true,
            },
            {
              "T",
              function()
                hop.hint_char1 {
                  direction = directions.BEFORE_CURSOR,
                  current_line_only = true,
                  hint_offset = 1,
                }
              end,
              desc = "hop backward +1",
              remap = true,
            },
          })
        end
        setup_hop_line("n")
        setup_hop_line("v")

        wk.add({
          { "s", group = "hop", remap = true },
          {
            "sf",
            function()
              hop.hint_char2()
            end,
            desc = "char2",
            remap = true,
          },
          {
            "sw",
            function()
              hop.hint_words()
            end,
            desc = "words",
            remap = true,
          },
        })
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
        wk.add({
          {
            mode = { "n", "v" },
            { "<space>j",  group = "treesj",                      remap = true },
            { "<space>jJ", function() vim.cmd([[TSJJoin]]) end,   desc = "join",   remap = true },
            { "<space>jj", function() vim.cmd([[TSJToggle]]) end, desc = "toggle", remap = true },
            { "<space>js", function() vim.cmd([[TSJSplit]]) end,  desc = "split",  remap = true },
          },
        })
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
