return {
  setup = function(use)
    use {
      "hrsh7th/nvim-cmp",
      module = { "cmp" },
      event = "InsertEnter",
      requires = {
        { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
        { "hrsh7th/vim-vsnip", event = "InsertEnter" },
        { "hrsh7th/vim-vsnip-integ", event = "InsertEnter" },
        { "hrsh7th/cmp-path", event = "CmdlineEnter" },
        { "hrsh7th/cmp-buffer", event = "InsertEnter" },
        { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup {
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          },
          mapping = cmp.mapping.preset.insert {
            ["<S-TAB>"] = cmp.mapping.select_prev_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<TAB>"] = cmp.mapping.select_next_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-y>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
          },
          experimental = {
            ghost_text = true,
          },
        }
        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
        })
      end,
    }
  end,
}
