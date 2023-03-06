return {
  setup = function(use)
    use {
      "EdenEast/nightfox.nvim",
      opt = true,
      config = function()
        local Shade = require("nightfox.lib.shade")
        local palettes = {
          nightfox = {},
          duskfox = {},
          nordfox = {
            bg0 = "#131821",
            bg1 = "#1e2430", -- Default bg
            bg3 = "#343c4e", -- Lighter bg (cursor line)
          },
          terafox = {},
          carbonfox = {
            -- nordfox customize
            black = Shade.new("#2b3242", "#364770", "#252a35"),
            red = Shade.new("#af515a", "#c05f69", "#b53e46"),
            green = Shade.new("#93ae7c", "#a1c186", "#7a9862"),
            yellow = Shade.new("#dbbb7b", "#e0c389", "#c9a253"),
            blue = Shade.new("#7191b1", "#7c9fc2", "#567a9b"),
            magenta = Shade.new("#a47e9d", "#b885af", "#8d6485"),
            cyan = Shade.new("#78b0c0", "#83bccc", "#5997aa"),
            white = Shade.new("#d5d9e0", "#d7dce4", "#abb3c4"),
            orange = Shade.new("#b9725b", "#c88069", "#a45940"),
            pink = Shade.new("#af78ac", "#c082be", "#995c95"),

            comment = "#50627a",

            bg0 = "#1b2029",
            bg1 = "#262c38",
            bg2 = "#39404f",
            bg3 = "#313847",
            bg4 = "#525d75",

            fg0 = "#b7bdc9",
            fg1 = "#bdbebf",
            fg2 = "#9ba1ab",
            fg3 = "#6e7178",

            sel0 = "#2e3a4b",
            sel1 = "#3f5064",
          },
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
    }

    use {
      "rebelot/kanagawa.nvim",
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
            theme = {
              dragon = {
                bg = "#272727",
              },
            },
          },
          -- overrides = function(colors)
          --   return {}
          -- end,
          theme = "dragon",
        }
      end,
    }

    use {
      "AlexvZyl/nordic.nvim",
      opt = true,
      config = function()
        require("nordic").setup {}
      end,
    }

    use {
      "kyazdani42/blue-moon",
      opt = true,
    }

    use {
      "sam4llis/nvim-tundra",
      opt = true,
      config = function()
        require("nvim-tundra").setup {
          transparent_background = false,
          dim_inactive_windows = {
            enabled = false,
            color = nil,
          },
        }
      end,
    }

    use {
      "folke/styler.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      wants = {
        "nightfox.nvim",
        "kanagawa.nvim",
        -- "catppuccin",
        -- "blue-moon",
        "nordic.nvim",
        "nvim-tundra",
      },
      config = function()
        local styler = require("styler")

        -- ref: https://blog.atusy.net/2022/12/17/styler-nvim-active-win/
        local default_colorscheme = "nordfox"
        -- local default_colorscheme = "tundra"
        -- local default_colorscheme = "kanagawa"
        local inactive_colorscheme = "nordic"
        -- local inactive_colorscheme = "carbonfox"

        vim.cmd("colorscheme " .. default_colorscheme)

        local function inactivate(win)
          if not vim.api.nvim_win_is_valid(win) then
            return
          end
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            return
          end

          if (vim.w[win].theme or {}).colorscheme ~= inactive_colorscheme then
            styler.set_theme(win, { colorscheme = inactive_colorscheme })
          end
        end

        vim.api.nvim_create_autocmd({ "WinLeave", "WinNew" }, {
          group = vim.api.nvim_create_augroup("styler-nvim-custom", {}),
          callback = function(_)
            local win_event = vim.api.nvim_get_current_win()
            vim.schedule(function()
              local win_pre = vim.fn.win_getid(vim.fn.winnr("#"))
              local win_cursor = vim.api.nvim_get_current_win()

              if (vim.w[win_cursor].theme or {}).colorscheme then
                styler.clear(win_cursor)
              end

              if win_pre ~= 0 and win_pre ~= win_cursor then
                inactivate(win_pre)
              end

              if win_event ~= win_cursor then
                inactivate(win_event)
              end
            end)
          end,
        })

        styler.setup {
          themes = {
            markdown = { colorscheme = "kanagawa" },
            help = { colorscheme = "kanagawa" },
          },
        }
      end,
    }
  end,
}
