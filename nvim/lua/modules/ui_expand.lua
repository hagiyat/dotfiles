return {
  setup = function(use)
    use {
      "folke/trouble.nvim",
      requires = {
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
        wk.register({
          h = {
            name = "+trouble",
            h = {
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
            f = {
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
      requires = {
        "folke/which-key.nvim",
      },
      wants = { "trouble.nvim" },
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

        require("which-key").register {
          ["<space>g"] = {
            name = "+gitsigns",
          },
        }
      end,
    }

    use {
      "folke/noice.nvim",
      event = "VimEnter",
      requires = {
        { "rcarriga/nvim-notify", opt = true },
      },
      wants = {
        "nui.nvim",
        "nvim-notify",
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
    }
  end,
}
