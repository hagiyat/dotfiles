return {
  setup = function(use)
    use {
      "EdenEast/nightfox.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        local palettes = {
          nightfox = {},
          duskfox = {},
          nordfox = {
            bg1 = "#1e2430",
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
        vim.cmd([[ colorscheme nordfox ]])
      end,
    }

    use {
      "rebelot/kanagawa.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        require("kanagawa").setup {
          undercurl = true, -- enable undercurls
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          typeStyle = {},
          variablebuiltinStyle = { italic = true },
          specialReturn = true, -- special highlight for the return keyword
          specialException = true, -- special highlight for exception handling keywords
          transparent = false, -- do not set background color
          dimInactive = false, -- dim inactive window `:h hl-NormalNC`
          globalStatus = false, -- adjust window separators highlight for laststatus=3
          terminalColors = true, -- define vim.g.terminal_color_{0,17}
          colors = {
            bg = "#272727",
          },
          overrides = {},
          theme = "dark", -- Load "default" theme or the experimental "light" theme
        }
        -- vim.cmd [[ colorscheme kanagawa ]]
      end,
    }

    use {
      "ellisonleao/gruvbox.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        require("gruvbox").setup {
          undercurl = true,
          underline = true,
          bold = true,
          italic = true,
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = false, -- invert background for search, diffs, statuslines and errors
          contrast = "", -- can be "hard", "soft" or empty string
          palette_overrides = {
            dark0 = "#202020",
          },
          overrides = {},
          dim_inactive = false,
          transparent_mode = false,
        }
        -- vim.cmd [[ colorscheme gruvbox ]]
      end,
    }

    use {
      "folke/tokyonight.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        require("tokyonight").setup {
          style = "moon",
        }
      end,
      -- vim.cmd [[ colorscheme tokyonight ]]
    }
  end,
}
