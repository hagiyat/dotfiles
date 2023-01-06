return {
  setup = function(use)
    use {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
        require("impatient").enable_profile()
      end,
    }

    use {
      "nvim-lua/plenary.nvim",
      opt = true,
    }

    use {
      "kyazdani42/nvim-web-devicons",
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
      "phaazon/mind.nvim",
      branch = "v2.2",
      cmd = { "MindOpenMain", "MindOpenProject", "MindOpenSmartProject" },
      wants = { "plenary.nvim" },
      config = function()
        require("mind").setup()
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
  end,
}
