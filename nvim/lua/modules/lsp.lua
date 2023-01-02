return {
  setup = function(use)
    use {
      "williamboman/mason.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason-lspconfig.nvim" },
        { "folke/which-key.nvim" },
        { "jose-elias-alvarez/null-ls.nvim" },
      },
      event = { "BufReadPre" },
      wants = {
        "cmp-nvim-lsp",
        "plenary.nvim",
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

        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local wk = require("which-key")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local null_ls = require("null-ls")

        -- quickfixに追加して開かずに、別のことをする
        -- ref: https://github.com/neovim/neovim/pull/19213
        local function on_list(options)
          vim.fn.setqflist({}, " ", options)
          -- FIXME: trouble.nvimがあろうとなかろうとおかまいなしなので、要修正
          vim.api.nvim_command("TroubleToggle quickfix")
        end

        mason_lspconfig.setup_handlers {
          function(server_name)
            local opts = {}
            opts.on_attach = function(_, bufnr)
              wk.register({
                c = {
                  name = "+lsp",
                  d = {
                    function()
                      vim.lsp.buf.definition { on_list = on_list }
                    end,
                    "definition",
                  },
                  i = {
                    function()
                      vim.lsp.buf.implementation { on_list = on_list }
                    end,
                    "implementation",
                  },
                  h = { vim.lsp.buf.signature_help, "signature help" },
                  D = {
                    function()
                      vim.lsp.buf.references(nil, { on_list = on_list })
                    end,
                    "references",
                  },
                  t = {
                    function()
                      vim.lsp.buf.type_definition { on_list = on_list }
                    end,
                    "type definition",
                  },
                  e = { vim.lsp.diagnostic.show_line_diagnostics, "show line diagnostics" },
                  f = { vim.lsp.buf.format, "format" },
                  r = { vim.lsp.buf.rename, "rename" },
                  s = {
                    function()
                      vim.lsp.buf.document_symbol { on_list = on_list }
                    end,
                    "document symbols",
                  },
                },
              }, { buffer = bufnr, prefix = "<space>", noremap = true, mode = "n" })
              wk.register({
                g = {
                  name = "+lsp",
                  [","] = { vim.diagnostic.goto_prev, "diagnostic prev" },
                  ["."] = { vim.diagnostic.goto_next, "diagnostic next" },
                },
              }, { buffer = bufnr, noremap = true, mode = "n" })
              wk.register({
                ["K"] = { vim.lsp.buf.hover, "lsp hover" },
              }, { buffer = bufnr, noremap = true, mode = "n" })
            end

            opts.capabilities = cmp_nvim_lsp.default_capabilities()

            null_ls.setup {
              capabilities = opts.capabilities,
              sources = {
                null_ls.builtins.formatting.stylua.with {
                  condition = function(utils)
                    return utils.root_has_file { ".stylua.toml" }
                  end,
                },
                null_ls.builtins.diagnostics.luacheck.with {
                  extra_args = { "--global vim" },
                },

                null_ls.builtins.formatting.prettier.with {
                  condition = function(utils)
                    return utils.root_has_file { ".prettierrc.json" }
                  end,
                },
                null_ls.builtins.diagnostics.eslint.with {
                  condition = function(utils)
                    return utils.root_has_file { ".eslintrc.yml" }
                  end,
                },

                null_ls.builtins.formatting.rubocop.with {
                  prefer_local = "bundle_bin",
                  condition = function(utils)
                    return utils.root_has_file { ".rubocop.yml" }
                  end,
                },
                null_ls.builtins.diagnostics.rubocop.with {
                  prefer_local = "bundle_bin",
                  condition = function(utils)
                    return utils.root_has_file { ".rubocop.yml" }
                  end,
                },

                null_ls.builtins.diagnostics.yamllint,
              },
            }

            if server_name == "sumneko_lua" then
              local sumneko_opts = {
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
              opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
            end

            lspconfig[server_name].setup(opts)
          end,
        }
      end,
    }
  end,
}
