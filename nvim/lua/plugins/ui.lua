return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
        { "<space>h",  group = "trouble",                                            remap = false },
        { "<space>hd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "buffer diagnostics",    remap = false },
        { "<space>hw", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "workspace diagnostics", remap = false },
        { "<space>hs", "<cmd>Trouble symbols toggle win.position=bottom<cr>",        desc = "symbols",               remap = false },
        { "<space>hl", "<cmd>Trouble loclist toggle<cr>",                            desc = "loclist",               remap = false },
        { "<space>hf", "<cmd>Trouble qflist toggle<cr>",                             desc = "quickfix",              remap = false },
        { "gR",        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "lsp references",        remap = false },
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
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          style = "#445464",
          duration = 50,
          delay = 100,
        },
        indent = {
          enable = false,
          style = "#223333",
          chars = {
            "│",
          },
        },
        line_num = {
          enable = false,
        },
        blank = {
          enable = false,
        },
      }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "folke/which-key.nvim",
    },
    config = function()
      require("which-key").add {
        { "<space>m",  group = "markdown" },
        { "<space>mm", "<cmd>RenderMarkdown toggle<CR>",   desc = "toggle" },
        { "<space>me", "<cmd>RenderMarkdown expand<CR>",   desc = "expand" },
        { "<space>mc", "<cmd>RenderMarkdown contract<CR>", desc = "contract" },
      }
    end,
  },
}
