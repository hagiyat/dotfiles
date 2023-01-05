return {
  setup = function(use)
    use {
      "Shougo/ddu.vim",
      -- cmd = { "Ddu" },
      event = { "VimEnter" },
      requires = {
        { "vim-denops/denops.vim" },
        { "Shougo/ddu-ui-ff" },
        { "Shougo/ddu-kind-file" },
        { "Shougo/ddu-source-file_rec" },
        { "shun/ddu-source-rg" },
        { "Shougo/ddu-source-line" },
        { "shun/ddu-source-buffer" },
        { "matsui54/ddu-source-file_external" },
        { "kuuote/ddu-source-mr", requires = { "lambdalisue/mr.vim" } },
        { "matsui54/ddu-source-help" },
        { "Shougo/ddu-filter-matcher_substring" },
        { "Shougo/ddu-commands.vim" },
        { "folke/which-key.nvim" },
      },
      wants = {
        "denops.vim",
      },
      config = function()
        vim.fn["ddu#custom#patch_global"] {
          ui = "ff",
          uiParams = {
            ff = {
              displaySourceName = "short",
              prompt = ">",
              reversed = true,
              split = "floating",
              floatingBorder = "rounded",
              previewFloating = true,
              previewFloatingBorder = "rounded",
              filterSplitDirection = "floating",
              winCol = vim.fn.round(vim.api.nvim_get_option("columns") * 0.05),
              winWidth = vim.fn.round(vim.api.nvim_get_option("columns") * 0.9),
              winRow = vim.fn.round(vim.api.nvim_get_option("lines") * 0.5),
              -- previewHeight = vim.fn.round(vim.api.nvim_get_option('lines') * 0.3),
              -- previewHeight = 10,
              previewWidth = vim.fn.round(vim.api.nvim_get_option("columns") * 0.9),
              startFilter = true,
              autoAction = {
                name = "preview",
              },
            },
          },
          kindOptions = {
            file = {
              defaultAction = "open",
            },
          },
          sourceOptions = {
            ["_"] = {
              matchers = { "matcher_substring" },
              ignoreCase = true,
            },
            command_history = {
              defaultAction = "execute",
            },
            help = {
              defaultAction = "open",
            },
          },
          filterParams = {
            matcher_substring = {
              highlightMatched = "Title",
            },
          },
          sourceParams = {
            file_external = {
              cmd = { "fd", "--follow", "--hidden", "--exclude=.git", "--type=f" },
            },
            rg = {
              args = { "--column", "--no-heading", "--color", "never", "--json" },
            },
            directory_rec = {
              cmd = { "fd", ".", "-H", "-t", "-d" },
            },
          },
          resume = true,
        }

        local bufopts = { noremap = true, silent = true, buffer = 0 }
        local n_keymap = function(key, callback)
          vim.keymap.set("n", key, callback, bufopts)
        end
        local i_keymap = function(key, callback)
          vim.keymap.set("i", key, callback, bufopts)
        end

        local ff_action = vim.fn["ddu#ui#ff#do_action"]
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "ddu-ff" },
          callback = function()
            n_keymap("<CR>", function()
              return ff_action("itemAction")
            end)
            n_keymap("<space>", function()
              return ff_action("toggleSelectItem")
            end)
            n_keymap("<space>", function()
              return ff_action("toggleSelectItem")
            end)
            n_keymap("i", function()
              return ff_action("openFilterWindow")
            end)
            n_keymap("/", function()
              return ff_action("openFilterWindow")
            end)
            n_keymap("p", function()
              return ff_action("preview")
            end)
            n_keymap("c", function()
              return ff_action("chooseAction")
            end)
            n_keymap("e", function()
              return ff_action("itemAction", { name = "edit" })
            end)
            n_keymap("d", function()
              return ff_action("itemAction", { name = "delete" })
            end)
            n_keymap("<Esc>", function()
              return ff_action("quit")
            end)
            n_keymap("q", function()
              return ff_action("quit")
            end)
          end,
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "ddu-ff-filter" },
          callback = function()
            i_keymap("<CR>", "<Esc><Cmd>close<CR>")
            n_keymap("<CR>", "<Cmd>close<CR>")
            n_keymap("q", "<Cmd>close<CR>")
          end,
        })

        local sources = {}

        sources.find_files = function()
          vim.fn["ddu#start"] {
            sources = {
              {
                name = "file_external",
                params = { ignoredDirectories = { ".git", "node_modules", "vendor" } },
              },
            },
          }
        end

        sources.file_rec = function()
          vim.fn["ddu#start"] {
            sources = {
              {
                name = "file_rec",
                params = { ignoredDirectories = { ".git" } },
              },
            },
          }
        end

        sources.live_grep = function()
          vim.fn["ddu#start"] {
            volatile = true,
            sources = {
              { name = "rg" },
            },
          }
        end

        sources.recent_items = function()
          vim.fn["ddu#start"] {
            sources = {
              {
                name = "buffer",
              },
              {
                name = "mr",
                params = {
                  current = true,
                },
              },
            },
          }
        end

        sources.line = function()
          vim.fn["ddu#start"] {
            sources = {
              { name = "line" },
            },
          }
        end

        sources.help = function()
          vim.fn["ddu#start"] {
            sources = {
              { name = "help" },
            },
          }
        end

        require("which-key").register({
          F = {
            name = "+ddu",
            f = { sources.find_files, "find files" },
            F = { sources.file_rec, "file rec" },
            g = { sources.live_grep, "live grep" },
            r = { sources.recent_items, "recent items" },
            l = { sources.line, "lines" },
            h = { sources.help, "help" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n", silent = true })
      end,
    }

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
