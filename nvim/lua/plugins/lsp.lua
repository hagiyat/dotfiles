return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "folke/which-key.nvim",
      "nvimtools/none-ls.nvim",
      "nvimdev/lspsaga.nvim",
      "hedyhli/outline.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }

      require("lspsaga").setup {
        finder = {
          max_height = 0.6,
          default = 'tyd+ref+imp+def',
          keys = {
            toggle_or_open = '<CR>',
            vsplit = 'v',
            split = 's',
            quit = 'q',
            close = '<Esc>',
          },
        },
        definition = {
          keys = {
            edit = '<CR>',
            vsplit = 'v',
            split = 's',
            quit = 'q',
          },
        },
        ui = {
          border = "rounded",
          code_action = "💡",
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
      }

      require("outline").setup({
        symbols = {
          icons = {
            File = { icon = "📄" },
            Module = { icon = "📦" },
            Namespace = { icon = "🔰" },
            Package = { icon = "📦" },
            Class = { icon = "🔶" },
            Method = { icon = "🔷" },
            Property = { icon = "🔑" },
            Field = { icon = "🏷️" },
            Constructor = { icon = "🏗️" },
            Enum = { icon = "🔢" },
            Interface = { icon = "🔨" },
            Function = { icon = "⚙️" },
            Variable = { icon = "📌" },
            Constant = { icon = "📌" },
            String = { icon = "📝" },
            Number = { icon = "🔢" },
            Boolean = { icon = "⚖️" },
            Array = { icon = "📚" },
            Object = { icon = "🗃️" },
            Key = { icon = "🔑" },
            Null = { icon = "⛔" },
            EnumMember = { icon = "🔢" },
            Struct = { icon = "🔶" },
            Event = { icon = "🎯" },
            Operator = { icon = "➗" },
            TypeParameter = { icon = "🔠" },
          },
        },
      })

      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local wk = require("which-key")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local null_ls = require("null-ls")

      -- LSPの診断表示設定
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {
                'vim',
                'require',
              },
            },
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pyright",
        },
        automatic_enable = true,
        handlers = {
          function(server_name)
          local opts = {}
          opts.on_attach = function(client, bufnr)
            -- LSPキーマッピングの設定
            local keymap_opts = { buffer = bufnr, silent = true, noremap = true }

            -- LSP関連のキーマッピング
            wk.register({
              ["<space>l"] = { name = "+lsp" },
              ["<space>la"] = { "<cmd>Lspsaga code_action<CR>", "Code action" },
              ["<space>ld"] = { "<cmd>Trouble lsp_definitions toggle<cr>", "Definitions" },
              ["<space>lD"] = { "<cmd>Trouble lsp_references toggle<cr>", "References" },
              ["<space>lf"] = { function() vim.lsp.buf.format({ async = true }) end, "Format" },
              ["<space>li"] = { "<cmd>Trouble lsp_implementations toggle<cr>", "Implementations" },
              ["<space>lo"] = { "<cmd>Outline<CR>", "Outline" },
              ["<space>ls"] = { "<cmd>Lspsaga finder<CR>", "LSP finder" },
              ["<space>lp"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
              ["<space>lr"] = { "<cmd>Lspsaga rename<CR>", "Rename" },
              ["<space>lt"] = { "<cmd>Trouble lsp_type_definitions toggle<cr>", "Type definitions" },
              ["<space>lk"] = { vim.diagnostic.goto_prev, "Diagnostic prev" },
              ["<space>lj"] = { vim.diagnostic.goto_next, "Diagnostic next" },
            }, keymap_opts)

            -- ビジュアルモード用のキーマッピング
            wk.register({
              ["<space>l"] = { name = "+lsp" },
              ["<space>la"] = { "<cmd>Lspsaga code_action<CR>", "Code action" },
            }, { mode = "v", buffer = bufnr, silent = true, noremap = true })

            -- 診断移動用のキーマッピング
            wk.register({
              ["g,"] = { vim.diagnostic.goto_prev, "Diagnostic prev" },
              ["g."] = { vim.diagnostic.goto_next, "Diagnostic next" },
            }, keymap_opts)

            -- ホバードキュメント用のキーマッピング
            wk.register({
              ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "LSP hover" },
            }, keymap_opts)
          end

          opts.capabilities = cmp_nvim_lsp.default_capabilities()

          null_ls.setup {
            capabilities = opts.capabilities,
            sources = {
              -- Lua
              null_ls.builtins.formatting.stylua.with {
                condition = function(utils)
                  return vim.fn.executable("stylua") > 0 and utils.root_has_file { ".stylua.toml", "stylua.toml" }
                end,
              },
              null_ls.builtins.diagnostics.selene.with {
                condition = function(utils)
                  return vim.fn.executable("selene") > 0 and utils.root_has_file { ".selene.toml" }
                end,
              },

              -- JavaScript/TypeScript
              null_ls.builtins.formatting.prettier.with {
                condition = function(utils)
                  return vim.fn.executable("prettier") > 0
                      and utils.root_has_file {
                        "package.json",
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.yml",
                        ".prettierrc.yaml",
                        ".prettierrc.js",
                        ".prettierrc.cjs",
                        "prettier.config.js",
                        "prettier.config.cjs",
                        ".prettierrc.toml",
                      }
                end,
              },
              null_ls.builtins.diagnostics.eslint_d.with {
                condition = function(utils)
                  return vim.fn.executable("eslint_d") > 0
                      and utils.root_has_file {
                        ".eslintrc",
                        ".eslintrc.js",
                        ".eslintrc.cjs",
                        ".eslintrc.yaml",
                        ".eslintrc.yml",
                        ".eslintrc.json",
                      }
                end,
              },

              -- Python
              null_ls.builtins.formatting.black.with {
                condition = function()
                  return vim.fn.executable("black") > 0
                end,
              },
              null_ls.builtins.diagnostics.ruff.with {
                condition = function()
                  return vim.fn.executable("ruff") > 0
                end,
              },

              -- Ruby
              null_ls.builtins.formatting.rubocop.with {
                prefer_local = "bundle_bin",
                condition = function(utils)
                  return vim.fn.executable("rubocop") > 0 and utils.root_has_file { ".rubocop.yml" }
                end,
              },
              null_ls.builtins.diagnostics.rubocop.with {
                prefer_local = "bundle_bin",
                condition = function(utils)
                  return vim.fn.executable("rubocop") > 0 and utils.root_has_file { ".rubocop.yml" }
                end,
              },

              -- YAML/Shell
              null_ls.builtins.diagnostics.yamllint,
              null_ls.builtins.diagnostics.zsh,
            },
          }

          -- サーバー固有の設定
          if server_name == "lua_ls" then
            local luals_opts = {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                  completion = {
                    callSnippet = "Replace",
                  },
                },
              },
            }
            opts = vim.tbl_deep_extend("force", luals_opts, opts)
          elseif server_name == "tsserver" then
            local ts_opts = {
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  },
                },
                javascript = {
                  inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  },
                },
              },
            }
            opts = vim.tbl_deep_extend("force", ts_opts, opts)
          end

          lspconfig[server_name].setup(opts)
          end,
        },
      })
    end,
  }
}
