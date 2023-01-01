return {
  setup = function(use)
    use {
      "lambdalisue/gina.vim",
      cmd = { "Gina" },
      opt = true,
    }

    use {
      "nvim-lua/plenary.nvim",
      opt = true,
    }

    use {
      "vim-denops/denops.vim",
      module = { "denops" },
    }

    use {
      "nvim-tree/nvim-web-devicons",
      module = { "nvim-web-devicons" },
      opt = true,
    }

    use {
      "ellisonleao/glow.nvim",
      cmd = { "Glow" },
      opt = true,
      config = function()
        require("glow").setup {
          border = "shadow", -- floating window border config
          style = "dark",
          pager = false,
          width_ratio = 0.9,
          height_ratio = 0.9,
        }
      end,
    }

    use {
      "akinsho/toggleterm.nvim",
      event = { "VimEnter" },
      requires = { "folke/which-key.nvim" },
      config = function()
        require("toggleterm").setup {
          size = math.floor(vim.o.lines / 3),
          open_mapping = false,
          direction = "float",
          float_opts = {
            border = "curved",
          },
          winbar = { enabled = false },
        }

        local Terminal = require("toggleterm.terminal").Terminal
        local split_term = Terminal:new {
          direction = "horizontal",
          hidden = true,
        }
        function ToggleSplitTerminal()
          split_term:toggle()
        end

        require("which-key").register({
          t = {
            name = "+terminal",
            t = { "<cmd>ToggleTerm<cr>", "terminal" },
            s = { ToggleSplitTerminal, "split" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n" })
      end,
    }

    -- TODO: startify
    -- https://github.com/glepnir/dashboard-nvim
    -- https://github.com/startup-nvim/startup.nvim
  end,
}
