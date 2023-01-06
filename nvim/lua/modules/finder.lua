return {
  setup = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      -- cmd = { "Telescope" },
      event = { "VimEnter" },
      requires = {
        {
          "nvim-telescope/telescope-frecency.nvim",
          opt = true,
          requires = { "kkharji/sqlite.lua", opt = true },
          wants = {
            "sqlite.lua",
            "nvim-web-devicons",
          },
          config = function() end,
        },
      },
      wants = {
        "plenary.nvim",
        "nvim-web-devicons",
        "which-key.nvim",
        "telescope-frecency.nvim",
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup {
          defaults = {
            layout_strategy = "center",
            layout_config = { height = 0.4 },
            prompt_position = "top",
            sorting_strategy = "ascending",
            mappings = {
              n = {
                ["q"] = actions.close,
              },
            },
          },
          pickers = {
            commands = {
              layout_strategy = "horizontal",
              sorting_strategy = "descending",
            },
          },
          extensions = {
            frecency = {},
          },
        }
        telescope.load_extension("frecency")

        local picker = require("telescope.builtin")
        local extensions = telescope.extensions
        require("which-key").register({
          f = {
            name = "+telescope",
            f = {
              function()
                picker.find_files {
                  find_command = {
                    "fd",
                    "--follow",
                    "--hidden",
                    "--exclude=.git",
                    "--exclude=node_modules",
                    "--exclude=vendor/bundle",
                    "--type=f",
                  },
                }
              end,
              "find_files by fd",
            },
            F = { picker.find_files, "find files" },
            g = { picker.live_grep, "live grep" },
            m = {
              function()
                extensions.frecency.frecency { workspace = "CWD" }
              end,
              "frecency/cwd",
            },
            M = { extensions.frecency.frecency, "frecency/global" },
            b = { picker.buffers, "buffers" },
            c = { picker.commands, "commands" },
            C = { picker.command_history, "command histories" },
            r = { picker.resume, "resume" },
            h = { picker.help_tags, "help" },
            l = { picker.current_buffer_fuzzy_find, "lines" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n", silent = true })
      end,
    }
  end,
}
