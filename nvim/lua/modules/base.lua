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
      "phaazon/hop.nvim",
      requires = "which-key",
      event = "BufReadPost",
      branch = 'v2',
      config = function()
        local hop = require("hop")
        hop.setup({ keys = "etovxqpdygfblzhckisuran" })

        local directions = require("hop.hint").HintDirection
        local wk = require("which-key")
        wk.register({
          ["f"] = {
            function()
              hop.hint_char1({
                direction = directions.AFTER_CURSOR,
                current_line_only = true
              })
            end,
            "hop forward"
          },
          ["F"] = {
            function()
              hop.hint_char1({
                direction = directions.BEFORE_CURSOR,
                current_line_only = true
              })
            end,
            "hop backward"
          },
          ["t"] = {
            function()
              hop.hint_char1({
                direction = directions.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
              })
            end,
            "hop forward -1"
          },
          ["T"] = {
            function()
              hop.hint_char1({
                direction = directions.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
              })
            end,
            "hop backward +1"
          },
        },
        { remap = true, mode = "n" } )
      end
    }
  end
}
