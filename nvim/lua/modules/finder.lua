return {
  setup = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      -- cmd = { "Telescope" },
      event = { "VimEnter" },
      wants = {
        "plenary.nvim",
        "nvim-web-devicons",
        "which-key.nvim",
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
              layout_config = { width = 0.7 },
              -- layout_strategy = "horizontal",
              -- sorting_strategy = "descending",
            },
          },
        }

        local picker = require("telescope.builtin")
        -- local extensions = telescope.extensions
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
            G = { picker.grep_string, "grep string" },
            m = {
              function()
                picker.oldfiles { only_cwd = true }
              end,
              "oldfiles/cwd",
            },
            M = { picker.oldfiles, "oldfiles/global" },
            b = { picker.buffers, "buffers" },
            c = { picker.command_history, "command histories" },
            C = {
              function()
                picker.commands { show_buf_command = false }
              end,
              "commands",
            },
            r = { picker.resume, "resume" },
            h = { picker.help_tags, "help" },
            l = { picker.treesitter, "treesitter" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n", silent = true })
      end,
    }
  end,
}
