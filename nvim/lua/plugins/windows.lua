return {
  {
    "gbrlsnchs/winpick.nvim",
    event = "BufEnter",
    dependencies = { "folke/which-key.nvim" },
    config = function()
      local winpick = require("winpick")
      winpick.setup {
        border = "double",
        filter = nil, -- doesn't ignore any window by default
        prompt = "Pick a window: ",
        format_label = winpick.defaults.format_label,
        chars = { "W", "F", "J", "D", "K", "S", "L", "A" },
      }

      require("which-key").add({
        {
          "<space>ww",
          function()
            local winid = winpick.select()
            if winid then
              vim.api.nvim_set_current_win(winid)
            end
          end,
          desc = "pick a window",
          remap = true
        },
      })
    end,
  },
  {
    "anuvyklack/windows.nvim",
    event = "BufReadPost",
    dependencies = {
      "anuvyklack/middleclass",
      "folke/which-key.nvim",
    },
    config = function()
      -- splitのtoggletermと相性が悪いので、animation無効
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 10
      -- vim.o.equalalways = false
      require("windows").setup()

      require("which-key").add({
        {
          "<space>wz",
          function()
            vim.cmd([[WindowsMaximize]])
          end,
          desc = "maximize",
          remap = true,
        },
        {
          "<space>wS",
          function()
            vim.cmd([[WindowsMaximizeHorizontally]])
          end,
          desc = "maximize horizontally",
          remap = true,
        },
        {
          "<space>wV",
          function()
            vim.cmd([[WindowsMaximizeVertically]])
          end,
          desc = "maximize vertically",
          remap = true,
        },
        {
          "<space>w=",
          function()
            vim.cmd([[WindowsEqualize]])
          end,
          desc = "equalize",
          remap = true,
        },
      })
    end,
  },
  {
    "sindrets/winshift.nvim",
    event = "BufEnter",
    dependencies = { "folke/which-key.nvim" },
    config = function()
      -- Lua
      require("winshift").setup {
        highlight_moving_win = true,
        focused_hl_group = "Visual",
        moving_win_options = {
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = true,
          win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
            ["<left>"] = "left",
            ["<down>"] = "down",
            ["<up>"] = "up",
            ["<right>"] = "right",
            ["<S-left>"] = "far_left",
            ["<S-down>"] = "far_down",
            ["<S-up>"] = "far_up",
            ["<S-right>"] = "far_right",
          },
        },
        window_picker = function()
          return require("winshift.lib").pick_window {
            picker_chars = "WFJDKSLA",
            filter_rules = {
              cur_win = true, -- Filter out the current window
              floats = true,  -- Filter out floating windows
              filetype = {},  -- List of ignored file types
              buftype = {},   -- List of ignored buftypes
              bufname = {},   -- List of vim regex patterns matching ignored buffer names
            },
            filter_func = nil,
          }
        end,
      }

      require("which-key").add({
        {
          "<space>wm",
          function()
            vim.cmd([[WinShift]])
          end,
          desc = "shift",
          remap = true
        },
      })
    end,
  }
}
