
return {
  setup = function(use)
    use {
      "phaazon/hop.nvim",
      requires = "folke/which-key.nvim",
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

        wk.register({
          f = {
            name = "+hop",
            f = {
              function()
                hop.hint_char2()
              end,
              "char2"
            },
            w = {
              function()
                hop.hint_words()
              end,
              "words"
            },
          }
        },
        { prefix = "<space>", remap = true, mode = "n" } )
      end
    }

    use {
      "windwp/nvim-autopairs",
      event = "BufEnter",
      config = function()
        require("nvim-autopairs").setup({
          disable_filetype = { "TelescopePrompt" , "NvimTree" },
        })
      end
    }

    use {
      "declancm/maximize.nvim",
      requires = "folke/which-key.nvim",
      config = function()
        require('maximize').setup({
          default_keymaps = false
        })
        require("which-key").register(
          {
            z = {
              function()
                require('maximize').toggle()
              end,
              "toggle maximize"
            },
          },
          { prefix = "<space>", remap = true, mode = "n" }
        )
      end
    }
  end
}
