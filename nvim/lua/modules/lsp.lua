return {
  setup = function(use)
    use {
      "williamboman/mason.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason-lspconfig.nvim" },
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

        mason_lspconfig.setup_handlers({ function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
            vim.keymap.set('n', '<space>cd', '<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
            vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
            vim.keymap.set('n', '<space>ci', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
            vim.keymap.set('n', '<space>ch', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
            vim.keymap.set('n', '<space>cD', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
            vim.keymap.set('n', '<space>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufopts)
            vim.keymap.set('n', '<space>ce', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', bufopts)
            vim.keymap.set('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', bufopts)
            vim.keymap.set('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', bufopts)
            vim.keymap.set('n', '<space>cf', vim.lsp.buf.format, bufopts)
            vim.keymap.set('n', '<space>cn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
          end
          nvim_lsp[server_name].setup(opts)
        end })
      end
    }
  end
}
