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
        local nvim_lsp = require("lspconfig")
        local wk = require("which-key")

        mason_lspconfig.setup_handlers({ function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
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
            }, { prefix = "<space>", noremap = true, mode = "n" })
            wk.register({
              g = {
                name = "+lsp",
                [","] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "diagnostic prev" },
                ["."] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "diagnostic next" }
              }

            }, { noremap = true, mode = "n" })
            wk.register({
              ["K"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "lsp hover" },
            }, { noremap = true, mode = "n" } )
          end
          nvim_lsp[server_name].setup(opts)
        end })
      end
    }
  end
}
