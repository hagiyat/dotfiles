return {
  setup = function(use)
    use {
      "williamboman/mason.nvim",
      requires = {
        { "neovim/nvim-lspconfig",             opt = true },
        { "williamboman/mason-lspconfig.nvim", opt = true },
        { "folke/which-key.nvim" },
        { "jose-elias-alvarez/null-ls.nvim",   opt = true },
        { "glepnir/lspsaga.nvim",              branch = "main", opt = true },
      },
      event = { "BufReadPre" },
      wants = {
        "nvim-lspconfig",
        "mason-lspconfig.nvim",
        "null-ls.nvim",
        "lspsaga.nvim",
        "cmp-nvim-lsp",
        "plenary.nvim",
        "trouble.nvim",
      },
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
          ui = {
            border = "rounded",
          },
        }

        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local wk = require("which-key")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local null_ls = require("null-ls")
        local trouble_nvim = require("trouble")

        -- quickfixに追加して開かずに、別のことをする
        -- ref: https://neovim.io/doc/user/lsp.html#lsp-on-list-handler
        -- local function on_list_to_qf(options)
        --   vim.fn.setqflist({}, " ", options)
        --   trouble_nvim.open("quickfix")
        -- end
        local function on_list_to_loclist(options)
          vim.fn.setloclist(0, {}, " ", options)
          trouble_nvim.open("loclist")
        end

        mason_lspconfig.setup_handlers {
          function(server_name)
            local opts = {}
            opts.on_attach = function(_, bufnr)
              wk.register({
                l = {
                  name = "+lsp",
                  a = { "<cmd>Lspsaga code_action<CR>", "code action by saga" },
                  -- d = {
                  --   function()
                  --     vim.lsp.buf.definition { on_list = on_list_to_qf }
                  --   end,
                  --   "definition",
                  -- },
                  d = {
                    "<cmd>Trouble lsp_definitions toggle<cr>",
                    "definitions",
                  },
                  -- D = {
                  --   function()
                  --     vim.lsp.buf.references(nil, { on_list = on_list_to_qf })
                  --   end,
                  --   "references",
                  -- },
                  D = {
                    "<cmd>Trouble lsp_references toggle<cr>",
                    "references",
                  },
                  -- e = { vim.lsp.diagnostic.show_line_diagnostics, "show line diagnostics" },
                  f = { vim.lsp.buf.format, "format" },
                  F = { "<cmd>Lspsaga lsp_finder<CR>", "lsp finder by saga" },
                  -- h = { vim.lsp.buf.signature_help, "signature help" },
                  -- i = {
                  --   function()
                  --     vim.lsp.buf.implementation { on_list = on_list_to_qf }
                  --   end,
                  --   "implementation",
                  -- },
                  i = {
                    "<cmd>Trouble lsp_implementations toggle<cr>",
                    "implementations",
                  },
                  o = { "<cmd>Lspsaga outline<CR>", "outline by saga" },
                  p = { "<cmd>Lspsaga peek_definition<CR>", "peek definition by saga" },
                  -- r = { vim.lsp.buf.rename, "rename" },
                  r = { "<cmd>Lspsaga rename<CR>", "rename by saga" },
                  s = {
                    function()
                      vim.lsp.buf.document_symbol { on_list = on_list_to_loclist }
                    end,
                    "document symbols",
                  },
                  -- t = {
                  --   function()
                  --     vim.lsp.buf.type_definition { on_list = on_list_to_qf }
                  --   end,
                  --   "type definition",
                  -- },
                  t = {
                    "<cmd>Trouble lsp_type_definitions toggle<cr>",
                    "type definitions",
                  },
                },
              }, { buffer = bufnr, prefix = "<space>", noremap = true, mode = "n", silent = true })
              wk.register({
                c = {
                  name = "+lsp",
                  a = { "<cmd>Lspsaga code_action<CR>", "code action by saga" },
                },
              }, { buffer = bufnr, prefix = "<space>", noremap = true, mode = "v", silent = true })
              wk.register({
                g = {
                  name = "+lsp",
                  [","] = { vim.diagnostic.goto_prev, "diagnostic prev" },
                  ["."] = { vim.diagnostic.goto_next, "diagnostic next" },
                },
              }, { buffer = bufnr, noremap = true, mode = "n" })
              wk.register({
                ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "lsp hover by saga" },
                -- ["K"] = { vim.lsp.buf.hover, "lsp hover" },
              }, { buffer = bufnr, noremap = true, mode = "n", silent = true })
            end

            opts.capabilities = cmp_nvim_lsp.default_capabilities()

            null_ls.setup {
              capabilities = opts.capabilities,
              sources = {
                null_ls.builtins.completion.vsnip,
                null_ls.builtins.formatting.stylua.with {
                  condition = function(utils)
                    return vim.fn.executable("stylua") > 0 and utils.root_has_file { ".stylua.toml", "stylua.toml" }
                  end,
                },
                null_ls.builtins.diagnostics.luacheck.with {
                  extra_args = { "--global vim" },
                },

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
                null_ls.builtins.diagnostics.eslint.with {
                  condition = function(utils)
                    return vim.fn.executable("eslint") > 0
                        and utils.root_has_file {
                          ".eslintrc.js",
                          ".eslintrc.cjs",
                          ".eslintrc.yaml",
                          ".eslintrc.yml",
                          ".eslintrc.json",
                          "package.json",
                        }
                  end,
                },
                null_ls.builtins.code_actions.eslint.with {
                  condition = function(utils)
                    return vim.fn.executable("eslint") > 0
                        and utils.root_has_file {
                          ".eslintrc.js",
                          ".eslintrc.cjs",
                          ".eslintrc.yaml",
                          ".eslintrc.yml",
                          ".eslintrc.json",
                          "package.json",
                        }
                  end,
                },

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

                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.zsh,
              },
            }

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
                    },
                  },
                },
              }
              opts = vim.tbl_deep_extend("force", luals_opts, opts)
            end

            lspconfig[server_name].setup(opts)
          end,
        }
      end,
    }
  end,
}
