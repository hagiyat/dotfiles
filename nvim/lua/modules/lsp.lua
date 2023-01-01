return {
  setup = function(use)
    use {
      "williamboman/mason.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason-lspconfig.nvim" },
        { "folke/which-key.nvim" },
      },
      event = { "BufReadPre" },
      wants = { "cmp-nvim-lsp" },
      config = function()
        require('mason').setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            }
          }
        })
        local mason_lspconfig = require('mason-lspconfig')
        local lspconfig = require("lspconfig")

        mason_lspconfig.setup_handlers({
          function(server_name)
            local opts= {}
            opts.on_attach = function(_, bufnr)
              local wk = require("which-key")
              wk.register({
                c = {
                  name = "+lsp",
                  d = { vim.lsp.buf.definition, "definition" },
                  i = { vim.lsp.buf.implementation, "implementation" },
                  h = { vim.lsp.buf.signature_help, "signature help" },
                  D = { vim.lsp.buf.references, "references" },
                  t = { vim.lsp.buf.type_definition, "type definition" },
                  e = { vim.lsp.diagnostic.show_line_diagnostics, "show line diagnostics" },
                  f = { vim.lsp.buf.format, "format" },
                  r = { vim.lsp.buf.rename, "rename" },
                }
              }, { buffer = bufnr, prefix = "<space>", noremap = true, mode = "n" })
              wk.register({
                g = {
                  name = "+lsp",
                  [","] = { vim.diagnostic.goto_prev, "diagnostic prev" },
                  ["."] = { vim.diagnostic.goto_next, "diagnostic next" }
                }

              }, { buffer = bufnr, noremap = true, mode = "n" })
              wk.register({
                ["K"] = { vim.lsp.buf.hover, "lsp hover" },
              }, { buffer = bufnr, noremap = true, mode = "n" } )
            end

            opts.capabilities = require('cmp_nvim_lsp').default_capabilities()

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
          end
        })
      end
    }
  end
}
