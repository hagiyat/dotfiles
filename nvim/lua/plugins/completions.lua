return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp",         event = "InsertEnter" },
      { "hrsh7th/vim-vsnip",            event = "InsertEnter" },
      { "hrsh7th/vim-vsnip-integ",      event = "InsertEnter" },
      { "onsails/lspkind.nvim",         event = "InsertEnter" },
      { "hrsh7th/cmp-path",             event = "CmdlineEnter" },
      { "hrsh7th/cmp-buffer",           event = "InsertEnter" },
      { "hrsh7th/cmp-cmdline",          event = "CmdlineEnter" },
      { "hrsh7th/cmp-cmdline",          event = "CmdlineEnter" },
      { "kyazdani42/nvim-web-devicons", opt = true },
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local devicons = require("nvim-web-devicons")
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
        formatting = {
          format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return lspkind.cmp_format { with_text = true } (entry, vim_item)
          end,
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
}
