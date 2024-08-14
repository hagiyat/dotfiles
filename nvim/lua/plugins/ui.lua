return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "folke/which-key.nvim",
    },
    event = "VimEnter",
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
        action_keys = {
          jump = { "<tab>" },
          jump_close = { "<cr>", "o" },
        },
        auto_jump = { "lsp_definitions" },
      }

      local wk = require("which-key")
      wk.add {
        { "<space>h",  group = "trouble",                              remap = false },
        { "<space>hd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "document diagnostics",  remap = false },
        { "<space>hf", "<cmd>TroubleToggle quickfix<cr>",              desc = "quickfix",              remap = false },
        { "<space>hh", "<cmd>TroubleToggle<cr>",                       desc = "all",                   remap = false },
        { "<space>hl", "<cmd>TroubleToggle loclist<cr>",               desc = "loclist",               remap = false },
        { "<space>hw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace diagnostics", remap = false },
        { "gR",        "<cmd>TroubleToggle lsp_references<cr>",        desc = "lsp references",        remap = false },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "folke/which-key.nvim",
      "folke/trouble.nvim",
    },
    event = "BufReadPost",
    config = function()
      require("gitsigns").setup {
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        trouble = true,
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map("n", "<space>gj", "&diff ? '<space>gj' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
          map("n", "<space>gk", "&diff ? '<space>gk' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

          -- Actions
          map("n", "<space>gs", ":Gitsigns stage_hunk<CR>")
          map("v", "<space>gs", ":Gitsigns stage_hunk<CR>")
          map("n", "<space>gr", ":Gitsigns reset_hunk<CR>")
          map("v", "<space>gr", ":Gitsigns reset_hunk<CR>")
          map("n", "<space>gS", "<cmd>Gitsigns stage_buffer<CR>")
          map("n", "<space>gu", "<cmd>Gitsigns undo_stage_hunk<CR>")
          map("n", "<space>gR", "<cmd>Gitsigns reset_buffer<CR>")
          map("n", "<space>gp", "<cmd>Gitsigns preview_hunk<CR>")
          map("n", "<space>gb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
          map("n", "<space>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>")
          -- map("n", "<space>gd", "<cmd>Gitsigns diffthis<CR>")
          map("n", "<space>gD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
          map("n", "<space>gd", "<cmd>Gitsigns toggle_deleted<CR>")
          map("n", "<space>gl", '<cmd>lua require"gitsigns".setloclist(0, 0)<CR>')
          map("n", "<space>gf", '<cmd>lua require"gitsigns".setqflist("all")<CR>')

          -- Text object
          map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
          map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      }

      require("which-key").add {
        { "<space>g", group = "gitsigns" },
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup {
        lsp = {
          progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30,
            view = "mini",
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = false,
        },
        messages = {
          enabled = true,
          view = "mini",
          view_error = "mini",
          view_warn = "mini",
          view_history = "messages",
          view_search = "virtualtext",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
          kind_icons = {},
        },
        views = {
          cmdline_popup = {
            position = {
              row = 5,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      }
    end,
  },
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
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufEnter",
    config = function()
      require("hlslens").setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
}
