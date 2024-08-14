return {
  {
    "smoka7/hop.nvim",
    event = "BufReadPost",
    version = "*",
    dependincies = {
      "folke/which-key.nvim",
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
      quit_key = "<Esc>",
    },
    config = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      local wk = require("which-key")
      local setup_hop_line = function(_)
        wk.add {
          {
            "f",
            function()
              hop.hint_char1 {
                direction = directions.AFTER_CURSOR,
                current_line_only = true,
              }
            end,
            desc = "hop forward",
            remap = true,
          },
          {
            "F",
            function()
              hop.hint_char1 {
                direction = directions.BEFORE_CURSOR,
                current_line_only = true,
              }
            end,
            desc = "hop backward",
            remap = true,
          },
          {
            "t",
            function()
              hop.hint_char1 {
                direction = directions.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1,
              }
            end,
            desc = "hop forward -1",
            remap = true,
          },
          {
            "T",
            function()
              hop.hint_char1 {
                direction = directions.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1,
              }
            end,
            desc = "hop backward +1",
            remap = true,
          },
        }
      end
      setup_hop_line("n")
      setup_hop_line("v")

      wk.add {
        { "s", group = "hop", remap = true },
        {
          "sf",
          function()
            hop.hint_char2()
          end,
          desc = "char2",
          remap = true,
        },
        {
          "sw",
          function()
            hop.hint_words()
          end,
          desc = "words",
          remap = true,
        },
      }
    end,
  },
}
