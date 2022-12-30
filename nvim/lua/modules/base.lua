return {
  setup = function(use)
    use {
      "lambdalisue/gina.vim",
      cmd = { "Gina" },
      opt = true
    }

    use {
      "nvim-tree/nvim-web-devicons",
      module = { "nvim-web-devicons" },
      opt = true
    }

    use {
      "ellisonleao/glow.nvim",
      cmd = { "Glow" },
      opt = true,
      config = function()
        require("glow").setup({
          border = "shadow", -- floating window border config
          style = "dark",
          pager = false,
          width_ratio = 0.9,
          height_ratio = 0.9,
        })
      end
    }

    -- TODO: startify
    -- https://github.com/glepnir/dashboard-nvim
    -- https://github.com/startup-nvim/startup.nvim
  end
}
