return {
  {
    "smoka7/hop.nvim",
    event = "BufReadPost",
    version = "*",
    dependincies = {
      "folke/which-key.nvim",
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
      quit_key = "<Esc>",
    },
    config = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      local wk = require("which-key")
      local setup_hop_line = function(_)
        wk.add {
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
        }
      end
      setup_hop_line("n")
      setup_hop_line("v")

      wk.add {
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
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependincies = { "nvim-cmp" },
    opts = {
      disable_filetype = { "TelescopePrompt" },
    },
    config = function()
      -- ref: https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "Wansmer/treesj",
    event = "BufEnter",
    dependincies = {
      "nvim-treesitter/nvim-treesitter",
      "folke/which-key.nvim",
    },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 160,
      cursor_behavior = "hold",
      notify = true,
    },
    config = function()
      local wk = require("which-key")
      wk.add {
        {
          mode = { "n", "v" },
          { "<space>j", group = "treesj", remap = true },
          {
            "<space>jJ",
            function()
              vim.cmd([[TSJJoin]])
            end,
            desc = "join",
            remap = true,
          },
          {
            "<space>jj",
            function()
              vim.cmd([[TSJToggle]])
            end,
            desc = "toggle",
            remap = true,
          },
          {
            "<space>js",
            function()
              vim.cmd([[TSJSplit]])
            end,
            desc = "split",
            remap = true,
          },
        },
      }
    end,
  },
  {
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
  },
  {
    "Pocco81/auto-save.nvim",
    event = "InsertEnter",
    config = function()
      require("auto-save").setup {
        enabled = true,
        trigger_events = { "InsertLeave", "TextChanged" },
        write_all_buffers = false,
      }
    end,
  },
}
