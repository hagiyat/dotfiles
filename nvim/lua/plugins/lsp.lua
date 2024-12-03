return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "folke/which-key.nvim",
      "nvimtools/none-ls.nvim",
      "glepnir/lspsaga.nvim",
      "hedyhli/outline.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }

      require("lspsaga").setup {
        finder = {
          max_height = 0.6,
          default = 'tyd+ref+imp+def',
          keys = {
            toggle_or_open = '<CR>',
            vsplit = 'v',
            split = 's',
            quit = 'q',
            close = '<Esc>',
          },
          methods = {
            tyd = 'textDocument/typeDefinition',
          }
        },
        ui = {
          border = "rounded",
        },
      }

      require("outline").setup({})

      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local wk = require("which-key")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local null_ls = require("null-ls")
      local trouble_nvim = require("trouble")

      -- quickfixに追加して開かずに、別のことをする
      -- ref: https://neovim.io/doc/user/lsp.html#lsp-on-list-handler
      -- local function on_list_to_qf(options)
      --   vim.fn.setqflist({}, " ", options)
      --   trouble_nvim.open("quickfix")
      -- end
      local function on_list_to_loclist(options)
        vim.fn.setloclist(0, {}, " ", options)
        trouble_nvim.open("loclist")
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            wk.add({
              { "<space>l",  group = "lsp",                                 remap = false },
              { "<space>la", "<cmd>Lspsaga code_action<CR>",                desc = "code action by saga", remap = false },
              { "<space>ld", "<cmd>Trouble lsp_definitions toggle<cr>",     desc = "definitions",         remap = false },
              { "<space>lD", "<cmd>Trouble lsp_references toggle<cr>",      desc = "references",          remap = false },
              { "<space>lf", vim.lsp.buf.format,                            desc = "format",              remap = false },
              { "<space>li", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "implementations",     remap = false },
              { "<space>lo", "<cmd>Outline<CR>",                            desc = "outline",             remap = false },
              { "<space>ls", "<cmd>Lspsaga finder<CR>",                     desc = "lsp finder by saga",  remap = false },
              {
                "<space>lp",
                "<cmd>Lspsaga peek_definition<CR>",
                desc = "peek definition by saga",
                remap = false
              },
              { "<space>lr", "<cmd>Lspsaga rename<CR>",                      desc = "rename by saga",   remap = false },
              { "<space>lt", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "type definitions", remap = false },
              { "<space>lk", vim.diagnostic.goto_prev,                       desc = "diagnostic prev" },
              { "<space>lj", vim.diagnostic.goto_next,                       desc = "diagnostic next" },
            })
            wk.add({

              { "<space>l",  group = "lsp",                  mode = "v",                   remap = false },
              { "<space>la", "<cmd>Lspsaga code_action<CR>", desc = "code action by saga", mode = "v",   remap = false },
            })
            wk.add({
              { "g,", vim.diagnostic.goto_prev, desc = "diagnostic prev", remap = false },
              { "g.", vim.diagnostic.goto_next, desc = "diagnostic next", remap = false },
            })
            wk.add({
              { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "lsp hover by saga", remap = false },
            })
          end

          opts.capabilities = cmp_nvim_lsp.default_capabilities()

          null_ls.setup {
            capabilities = opts.capabilities,
            sources = {
              null_ls.builtins.completion.vsnip,
              null_ls.builtins.formatting.stylua.with {
                condition = function(utils)
                  return vim.fn.executable("stylua") > 0 and utils.root_has_file { ".stylua.toml", "stylua.toml" }
                end,
              },
              null_ls.builtins.diagnostics.selene.with {
                extra_args = { "--global vim" },
              },

              null_ls.builtins.formatting.prettier.with {
                condition = function(utils)
                  return vim.fn.executable("prettier") > 0
                      and utils.root_has_file {
                        "package.json",
                        ".prettierrc",
                        ".prettierrc.json",
                        ".prettierrc.yml",
                        ".prettierrc.yaml",
                        ".prettierrc.js",
                        ".prettierrc.cjs",
                        "prettier.config.js",
                        "prettier.config.cjs",
                        ".prettierrc.toml",
                      }
                end,
              },

              null_ls.builtins.formatting.black.with {
                condition = function()
                  return vim.fn.executable("black") > 0
                end,
              },

              null_ls.builtins.formatting.rubocop.with {
                prefer_local = "bundle_bin",
                condition = function(utils)
                  return vim.fn.executable("rubocop") > 0 and utils.root_has_file { ".rubocop.yml" }
                end,
              },
              null_ls.builtins.diagnostics.rubocop.with {
                prefer_local = "bundle_bin",
                condition = function(utils)
                  return vim.fn.executable("rubocop") > 0 and utils.root_has_file { ".rubocop.yml" }
                end,
              },

              null_ls.builtins.diagnostics.yamllint,
              null_ls.builtins.diagnostics.zsh,
            },
          }

          if server_name == "lua_ls" then
            local luals_opts = {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            }
            opts = vim.tbl_deep_extend("force", luals_opts, opts)
          end

          lspconfig[server_name].setup(opts)
        end,
      }
    end,
  }
}
