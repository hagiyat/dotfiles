return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        opt = { enable = true },
      },
      "RRethy/nvim-treesitter-endwise",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "html",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "yaml",
          "terraform",
          "vim",
        },
        -- nvim-treesitter-endwise
        endwise = {
          enable = true,
        },
        -- nvim-treesitter-textsubjects
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
              ["]a"] = { query = "@assignment.rhs", desc = "Assignment rhs" },
              ["]b"] = { query = "@block.outer", desc = "Next block start" },
              ["]s"] = { query = "@statement.outer", desc = "Next statement start" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
              ["]B"] = { query = "@block.outer", desc = "Next block end" },
              ["]S"] = { query = "@statement.outer", desc = "Next statement end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
              ["[b"] = { query = "@block.outer", desc = "Prev block start" },
              ["[a"] = { query = "@assignment.lhs", desc = "Assignment lhs" },
              ["[s"] = { query = "@statement.outer", desc = "Prev statement start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
              ["[B"] = { query = "@block.outer", desc = "Prev block end" },
              ["[S"] = { query = "@statement.outer", desc = "Prev statement end" },
            },
          },
        }
      }
    end,
  },
}
