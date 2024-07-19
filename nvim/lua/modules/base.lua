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
      "echasnovski/mini.icons",
      module = { "mini.icons" },
      opt = true,
    }

    use {
      -- wants from neotree and noice
      "MunifTanjim/nui.nvim",
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
  end,
}
