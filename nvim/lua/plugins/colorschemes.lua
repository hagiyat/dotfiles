return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = true,
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = true,
    config = function()
      require("fluoromachine").setup {
        glow = true,
        theme = "retrowave",
        transparent = false,
      }
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    config = function()
      require("catppuccin").setup {
        color_overrides = {
          all = {},
          latte = {},
          frappe = {},
          macchiato = {},
          mocha = {
            -- base = "#202430",
            base = "#1d2432",
          },
        },
      }
    end,
  },
  {
    "miversen33/sunglasses.nvim",
    event = "UIEnter",
    config = function()
      require("sunglasses").setup {
        filter_type = "SHADE",
        filter_percent = 0.30,
      }
    end,
  },
  {
    "folke/styler.nvim",
    event = { "VimEnter", "ColorSchemePre" },
    dependencies = {
      "folke/tokyonight.nvim",
      "sho-87/kanagawa-paper.nvim",
      "AlexvZyl/nordic.nvim",
      "catppuccin/nvim",
      "maxmx03/fluoromachine.nvim",
    },
    config = function()
      local styler = require("styler")
      vim.cmd.colorscheme("tokyonight-moon")
      styler.setup {
        themes = {
          yaml = { colorscheme = "fluoromachine" },
          markdown = { colorscheme = "nordic" },
          help = { colorscheme = "kanagawa-paper" },
        },
      }
    end,
  },
}
