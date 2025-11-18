return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason-lspconfig.nvim",
      "folke/which-key.nvim",
      "nvimtools/none-ls.nvim",
      "nvimdev/lspsaga.nvim",
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
        },
        definition = {
          keys = {
            edit = '<CR>',
            vsplit = 'v',
            split = 's',
            quit = 'q',
          },
        },
        ui = {
          border = "rounded",
          code_action = "💡",
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
      }

      require("outline").setup({
        symbols = {
          icons = {
            File = { icon = "📄" },
            Module = { icon = "📦" },
            Namespace = { icon = "🔰" },
            Package = { icon = "📦" },
            Class = { icon = "🔶" },
            Method = { icon = "🔷" },
            Property = { icon = "🔑" },
            Field = { icon = "🏷️" },
            Constructor = { icon = "🏗️" },
            Enum = { icon = "🔢" },
            Interface = { icon = "🔨" },
            Function = { icon = "⚙️" },
            Variable = { icon = "📌" },
            Constant = { icon = "📌" },
            String = { icon = "📝" },
            Number = { icon = "🔢" },
            Boolean = { icon = "⚖️" },
            Array = { icon = "📚" },
            Object = { icon = "🗃️" },
            Key = { icon = "🔑" },
            Null = { icon = "⛔" },
            EnumMember = { icon = "🔢" },
            Struct = { icon = "🔶" },
            Event = { icon = "🎯" },
            Operator = { icon = "➗" },
            TypeParameter = { icon = "🔠" },
          },
        },
      })

      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local wk = require("which-key")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local null_ls = require("null-ls")

      -- LSPの診断表示設定
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- null-lsの設定（handler外で一度だけ実行）
      -- none-ls.nvimでは多くのbuiltinsが削除されているため、利用可能なもののみ設定
      null_ls.setup {
        sources = {
          -- Lua
          null_ls.builtins.formatting.stylua.with {
            condition = function(utils)
              return vim.fn.executable("stylua") > 0 and utils.root_has_file { ".stylua.toml", "stylua.toml" }
            end,
          },

          -- JavaScript/TypeScript
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

          -- Python
          null_ls.builtins.formatting.black.with {
            condition = function()
              return vim.fn.executable("black") > 0
            end,
          },

          -- Ruby
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
        },
      }

      -- デフォルトのon_attach関数を定義
      local on_attach = function(client, bufnr)
        -- LSP関連のキーマッピング（which-key v3形式）
        wk.add({
          { "<space>l", group = "lsp", buffer = bufnr },
          { "<space>la", "<cmd>Lspsaga code_action<CR>", desc = "Code action", buffer = bufnr },
          { "<space>ld", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "Definitions", buffer = bufnr },
          { "<space>lD", "<cmd>Trouble lsp_references toggle<cr>", desc = "References", buffer = bufnr },
          { "<space>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format", buffer = bufnr },
          { "<space>li", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "Implementations", buffer = bufnr },
          { "<space>lo", "<cmd>Outline<CR>", desc = "Outline", buffer = bufnr },
          { "<space>ls", "<cmd>Lspsaga finder<CR>", desc = "LSP finder", buffer = bufnr },
          { "<space>lp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition", buffer = bufnr },
          { "<space>lr", "<cmd>Lspsaga rename<CR>", desc = "Rename", buffer = bufnr },
          { "<space>lt", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "Type definitions", buffer = bufnr },
          { "<space>lk", vim.diagnostic.goto_prev, desc = "Diagnostic prev", buffer = bufnr },
          { "<space>lj", vim.diagnostic.goto_next, desc = "Diagnostic next", buffer = bufnr },
        })

        -- ビジュアルモード用のキーマッピング
        wk.add({
          { "<space>l", group = "lsp", mode = "v", buffer = bufnr },
          { "<space>la", "<cmd>Lspsaga code_action<CR>", desc = "Code action", mode = "v", buffer = bufnr },
        })

        -- 診断移動用のキーマッピング
        wk.add({
          { "g,", vim.diagnostic.goto_prev, desc = "Diagnostic prev", buffer = bufnr },
          { "g.", vim.diagnostic.goto_next, desc = "Diagnostic next", buffer = bufnr },
        })

        -- ホバードキュメント用のキーマッピング
        wk.add({
          { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "LSP hover", buffer = bufnr },
        })
      end

      -- デフォルトのcapabilitiesを定義
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- mason-lspconfigのセットアップ
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",      -- Lua
          "ts_ls",       -- TypeScript/JavaScript
          "eslint",      -- ESLint (JavaScript/TypeScript linter)
          "pyright",     -- Python
          "ruff",        -- Python linter/formatter
          "yamlls",      -- YAML
          "bashls",      -- Bash/Shell
        },
      })

      -- 各LSPサーバーを個別にセットアップ
      -- lua_ls
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      -- ts_ls
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- eslint
      lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = {
          workingDirectories = { mode = "auto" },
        },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- 保存時に自動でESLintの修正を適用
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      -- pyright
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- ruff
      lspconfig.ruff.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Ruffはフォーマットとlintのみ、hover機能は無効化（pyrightに任せる）
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- yamlls
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            },
            format = {
              enable = true,
            },
          },
        },
      })

      -- bashls
      lspconfig.bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
}
