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
        {
          "Shougo/ddu-ui-filer",
          requires = {
            "Shougo/ddu-source-file",
            "ryota2357/ddu-column-icon_filename",
          },
        },
        { "Shougo/ddu-filter-matcher_substring" },
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

        local filter_action = vim.fn["ddu#ui#filer#do_action"]
        local buf_keymap = function(key, callback)
          vim.api.nvim_buf_set_keymap(0, "n", key, "", {
            silent = true,
            noremap = true,
            callback = callback,
          })
        end
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "ddu-filer" },
          callback = function()
            buf_keymap("<CR>", function()
              if vim.fn["ddu#ui#filer#is_tree"]() then
                -- filter_action('expandItem', { mode = 'toggle' })
                filter_action("itemAction", { name = "narrow" })
              else
                filter_action("itemAction", { mode = "open" })
              end
            end)
            buf_keymap("<ESC>", function()
              filter_action("quit")
            end)
            buf_keymap("q", function()
              filter_action("quit")
            end)
            buf_keymap("o", function()
              filter_action("expandItem", { mode = "toggle" })
            end)
            buf_keymap(".", function()
              -- FIXME
              local result = vim.api.nvim_exec(
                [[
                function! s:ToggleHidden()
                  let current = ddu#custom#get_current(b:ddu_ui_name)
                  let source_options = get(current, 'sourceOptions', {})
                  let source_options_file = get(source_options, 'file', {})
                  let matchers = get(source_options_file, 'matchers', [])
                  return empty(matchers) ? ['matcher_hidden'] : []
                endfunction
                call s:ToggleHidden()
              ]] ,
                true
              )
              filter_action("updateOptions", {
                sourceOptions = {
                  file = {
                    matchers = result,
                  },
                },
              })
            end)
            buf_keymap("N", function()
              filter_action("itemAction", { name = "newFile" })
            end)
            buf_keymap("gN", function()
              filter_action("itemAction", { name = "newDirectory" })
            end)
            buf_keymap("c", function()
              filter_action("itemAction", { name = "copy" })
            end)
            buf_keymap("p", function()
              filter_action("itemAction", { name = "paste" })
            end)
            buf_keymap("r", function()
              filter_action("itemAction", { name = "rename" })
            end)
            buf_keymap("d", function()
              filter_action("itemAction", { name = "delete" })
            end)
            buf_keymap("gC", function()
              filter_action("itemAction", { name = "change_vim_cwd" })
            end)
            buf_keymap("l", function()
              if vim.fn["ddu#ui#filer#is_tree"]() then
                filter_action("itemAction", { name = "narrow" })
              else
                filter_action("itemAction", { mode = "open" })
              end
            end)
            buf_keymap("h", function()
              filter_action("itemAction", { name = "narrow", params = { path = ".." } })
            end)
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
          f = {
            name = "+ddu",
            f = { sources.find_files, "find files" },
            F = { sources.file_rec, "file rec" },
            g = { sources.live_grep, "live grep" },
            r = { sources.recent_items, "recent items" },
            l = { sources.line, "lines" },
            h = { sources.help, "help" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n", silent = true })

        vim.fn["ddu#custom#patch_local"]("filer", {
          ui = "filer",
          sources = {
            {
              name = "file",
              params = {},
            },
          },
          sourceOptions = {
            ["_"] = {
              columns = { "icon_filename" },
            },
          },
          uiOptions = {
            filer = {
              toggle = true,
            },
          },
          actionOptions = {
            narrow = { quit = false },
          },
          uiParams = {
            filer = {
              split = "vertical",
              splitDirection = "topleft",
              winWidth = vim.fn.round(vim.api.nvim_get_option("columns") * 0.3),
              sort = "none",
              sortTreeFirst = true,
              search = vim.fn.expand("%:p"),
            },
          },
          columnParams = {
            icon_filename = {
              defaultIcon = {
                icon = "",
              },
              useLinkIcon = "grayout",
            },
          },
          kindOptions = {
            file = {
              defaultAction = "open",
            },
          },
        })

        local filer = function()
          vim.fn["ddu#start"] {
            name = "filer",
          }
        end

        require("which-key").register({
          f = {
            e = { filer, "file explorer" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n", silent = true })
      end,
    }
  end,
}
