return {
  setup = function(use)
    use {
      "lambdalisue/gina.vim",
      event = { "BufEnter" },
      opt = true
    }

    use {
      "nvim-tree/nvim-web-devicons",
      opt = true
    }
  end
}
