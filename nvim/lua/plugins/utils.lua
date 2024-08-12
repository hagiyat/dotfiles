return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
  },
  {
    -- wants from neotree and noice
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    lazy = true,
    opts = {
      border = "shadow",     -- floating window border config
      style = "dark",
      pager = false,
      width_ratio = 0.9,
      height_ratio = 0.9,
    },
  },
}
