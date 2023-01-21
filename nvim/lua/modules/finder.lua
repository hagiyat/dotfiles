return {
  setup = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      -- cmd = { "Telescope" },
      event = { "VimEnter" },
      requires = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
          opt = true,
        },
      },
      wants = {
        "plenary.nvim",
        "telescope-fzf-native.nvim",
        "nvim-web-devicons",
        "which-key.nvim",
        "trouble.nvim",
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")

        telescope.setup {
          defaults = {
            layout_strategy = "center",
            layout_config = { height = 0.4 },
            prompt_position = "top",
            sorting_strategy = "ascending",
            mappings = {
              n = {
                ["q"] = actions.close,
                ["<C-q>"] = trouble.open_with_trouble,
              },
              i = {
                ["<C-q>"] = trouble.open_with_trouble,
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
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
        }
        telescope.load_extension("fzf")

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
