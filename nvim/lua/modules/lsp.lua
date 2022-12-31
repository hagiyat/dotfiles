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
                  d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "definition" },
                  i = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "implementation" },
                  h = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "signature help" },
                  D = { "<Cmd>lua vim.lsp.buf.references()<CR>", "references" },
                  t = { "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition" },
                  e = { "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "show line diagnostics" },
                  f = { "<Cmd>lua vim.lsp.buf.format()<CR>", "format" },
                  r = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
                }
              }, { buffer = bufnr, prefix = "<space>", noremap = true, mode = "n" })
              wk.register({
                g = {
                  name = "+lsp",
                  [","] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "diagnostic prev" },
                  ["."] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "diagnostic next" }
                }

              }, { buffer = bufnr, noremap = true, mode = "n" })
              wk.register({
                ["K"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "lsp hover" },
              }, { buffer = bufnr, noremap = true, mode = "n" } )
            end
            -- opts.capabilities = require('cmp_nvim_lsp').update_capabilities(
            --   vim.lsp.protocol.make_client_capabilities()
            -- )

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
