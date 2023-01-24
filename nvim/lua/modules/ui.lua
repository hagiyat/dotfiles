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
      "RRethy/vim-illuminate",
      event = "BufReadPost",
      config = function()
        require("illuminate").configure {
          delay = 1000,
          filetype_denylist = {
            "alpha",
            "ddu-ff",
            "ddu-ff-filter",
            "Trouble",
          },
        }
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true, underdotted = true })
      end,
    }
    -- use {
    --   "folke/noice.nvim",
    --   event = "VimEnter",
    --   requires = {
    --     { "rcarriga/nvim-notify", opt = true },
    --   },
    --   wants = {
    --     "nui.nvim",
    --     "nvim-notify",
    --   },
    --   config = function()
    --     require("noice").setup {
    --       lsp = {
    --         override = {
    --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --           ["vim.lsp.util.stylize_markdown"] = true,
    --           ["cmp.entry.get_documentation"] = true,
    --         },
    --       },
    --       -- you can enable a preset for easier configuration
    --       presets = {
    --         bottom_search = false, -- use a classic bottom cmdline for search
    --         command_palette = true, -- position the cmdline and popupmenu together
    --         long_message_to_split = true, -- long messages will be sent to a split
    --         inc_rename = true, -- enables an input dialog for inc-rename.nvim
    --         lsp_doc_border = false, -- add a border to hover docs and signature help
    --       },
    --       views = {
    --         cmdline_popup = {
    --           position = {
    --             row = 5,
    --             col = "50%",
    --           },
    --           size = {
    --             width = 60,
    --             height = "auto",
    --           },
    --         },
    --         popupmenu = {
    --           relative = "editor",
    --           position = {
    --             row = 8,
    --             col = "50%",
    --           },
    --           size = {
    --             width = 60,
    --             height = 10,
    --           },
    --           border = {
    --             style = "rounded",
    --             padding = { 0, 1 },
    --           },
    --           win_options = {
    --             winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
    --           },
    --         },
    --       },
    --     }
    --   end,
    -- }
  end,
}
