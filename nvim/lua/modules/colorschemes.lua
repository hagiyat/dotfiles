return {
  setup = function(use)
    use {
      "EdenEast/nightfox.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        require("packers/colorschemes/nightfox")
      end
    }
    use {
      "rebelot/kanagawa.nvim",
      event = { "VimEnter", "ColorSchemePre" },
      opt = true,
      config = function()
        require("packers/colorschemes/kanagawa")
      end
    }
  end
}
