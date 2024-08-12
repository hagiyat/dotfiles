return {
  {
    "akinsho/toggleterm.nvim",
    event = "VimEnter",
    requires = { "folke/which-key.nvim" },
    config = function()
      require("toggleterm").setup {
        start_in_insert = true,
        shade_terminals = true,
        shading_factor = 1,
        size = vim.o.lines * 0.3,
        on_open = function()
          vim.wo.spell = false
        end,
      }

      local Terminal = require("toggleterm.terminal").Terminal
      local float_term = Terminal:new {
        size = math.floor(vim.o.lines / 3),
        open_mapping = false,
        direction = "float",
        float_opts = {
          border = "curved",
        },
        winbar = { enabled = false },
        hidden = true,
      }
      local horizontal_term = Terminal:new {
        direction = "horizontal",
      }
      FloatTerminalToggle = function()
        float_term:toggle()
      end
      HorizontalTerminalToggle = function()
        float_term:close()
        horizontal_term:toggle()
      end

      require("which-key").add({
        { "<space>t",  group = "terminal",       remap = false },
        { "<space>ts", HorizontalTerminalToggle, desc = "split", remap = false },
        { "<space>tt", FloatTerminalToggle,      desc = "float", remap = false },
      })
    end,
  }
}
