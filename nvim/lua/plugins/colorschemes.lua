return {
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      local palettes = {
        nightfox = {
          -- bg1 = "#192330",     -- Default bg
          bg1 = "#242830", -- Default bg
        },
        duskfox = {},
        nordfox = {
          -- bg0 = "#232831", -- Dark bg (status line and float)
          -- bg1 = "#2e3440", -- Default bg
          -- bg2 = "#39404f", -- Lighter bg (colorcolm folds)
          -- bg3 = "#444c5e", -- Lighter bg (cursor line)
          -- bg0 = "#131821",
          bg1 = "#2a2d31", -- Default bg
          bg3 = "#2d3136", -- Lighter bg (cursor line)
        },
        terafox = {},
        carbonfox = {},
      }
      require("nightfox").setup {
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        palettes = palettes,
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup {
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true,    -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false,     -- do not set background color
        dimInactive = false,     -- dim inactive window `:h hl-NormalNC`
        globalStatus = false,    -- adjust window separators highlight for laststatus=3
        terminalColors = true,   -- define vim.g.terminal_color_{0,17}
        colors = {
          theme = {
            dragon = {
              bg = "#272727",
            },
          },
        },
        -- overrides = function(colors)
        --   return {}
        -- end,
        theme = "wave",
      }
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        style = 'cool'
      })
    end
  },
  {
    "ribru17/bamboo.nvim",
    lazy = true,
  },
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = true,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          all = {},
          latte = {},
          frappe = {},
          macchiato = {},
          mocha = {
            base = "#202430",
          },
        }
      })
    end
  },
  {
    "miversen33/sunglasses.nvim",
    event = "UIEnter",
    config = function()
      require("sunglasses").setup({
        filter_type = "SHADE",
        filter_percent = 0.30,
      })
    end,
  },
  {
    "folke/styler.nvim",
    event = { "VimEnter", "ColorSchemePre" },
    dependencies = {
      -- "EdenEast/nightfox.nvim",
      "folke/tokyonight.nvim",
      -- "rebelot/kanagawa.nvim",
      "ribru17/bamboo.nvim",
      "sho-87/kanagawa-paper.nvim",
      "AlexvZyl/nordic.nvim",
      "catppuccin/nvim",
      "olimorris/onedarkpro.nvim",
    },
    config = function()
      local styler = require("styler")
      vim.cmd.colorscheme("catppuccin-mocha")
      styler.setup {
        themes = {
          yaml = { colorscheme = "tokyonight-moon" },
          markdown = { colorscheme = "nordic" },
          help = { colorscheme = "kanagawa-paper" },
        },
      }
    end,
  },
}
