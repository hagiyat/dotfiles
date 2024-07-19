return {
  setup = function(use)
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.4",
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
        local trouble = require("trouble")

        -- local trouble = require("trouble.providers.telescope")
        -- ↑ではなく自前定義なのは、公式だと一度開いたら終わりなところを
        -- quickfixに残しておきたいから
        local function open_with_trouble(prompt_bufnr)
          actions.send_to_qflist(prompt_bufnr)
          trouble.open("quickfix")
        end

        telescope.setup {
          defaults = {
            layout_strategy = "center",
            layout_config = { height = 0.4 },
            prompt_position = "top",
            sorting_strategy = "ascending",
            mappings = {
              n = {
                ["q"] = actions.close,
                ["<esc>"] = actions.close,
                ["<C-q>"] = open_with_trouble,
              },
              i = {
                ["<C-u>"] = false,
                ["<C-q>"] = open_with_trouble,
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
              fuzzy = true,                   -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true,    -- override the file sorter
              case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
        }
        telescope.load_extension("fzf")

        local picker = require("telescope.builtin")
        -- local extensions = telescope.extensions

        require("which-key").add({
          { "<space>f", group = "telescope", remap = false },
          {
            "<space>ff",
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
            desc = "find_files by fd",
            remap = false,
          },
          {
            "<space>fF",
            picker.find_files,
            desc = "find files",
            remap = false,
          },
          {
            "<space>fg",
            picker.live_grep,
            desc = "live grep",
            remap = false,
          },
          {
            "<space>fG",
            picker.grep_string,
            desc = "grep string",
            remap = false,
          },
          {
            "<space>fm",
            function()
              picker.oldfiles { only_cwd = true }
            end,
            desc = "oldfiles/cwd",
            remap = false,
          },
          {
            "<space>fM",
            picker.oldfiles,
            desc = "oldfiles/global",
            remap = false,
          },
          {
            "<space>fb",
            picker.buffers,
            desc = "buffers",
            remap = false,
          },
          {
            "<space>fc",
            picker.command_history,
            desc = "command histories",
            remap = false,
          },
          {
            "<space>fC",
            function()
              picker.commands { show_buf_command = false }
            end,
            desc = "commands",
            remap = false,
          },
          {
            "<space>fh",
            picker.help_tags,
            desc = "help",
            remap = false,
          },
          {
            "<space>fl",
            picker.treesitter,
            desc = "treesitter",
            remap = false,
          },
          {
            "<space>fr",
            picker.resume,
            desc = "resume",
            remap = false,
          },
        })
      end,
    }

    use {
      "rgroli/other.nvim",
      -- cmd = { "Other", "OtherSplit", "OtherVSplit", "OtherClear" },
      event = { "BufEnter" },
      wants = {
        "which-key.nvim",
      },
      config = function()
        local rails_controller_patterns = {
          { target = "/spec/controllers/%1_spec.rb", context = "spec" },
          { target = "/spec/requests/%1_spec.rb",    context = "spec" },
          { target = "/spec/factories/%1.rb",        context = "factories", transformer = "singularize" },
          { target = "/app/models/%1.rb",            context = "models",    transformer = "singularize" },
          { target = "/app/views/%1/**/*.html.*",    context = "view" },
        }
        require("other-nvim").setup {
          mappings = {
            {
              pattern = "/app/models/(.*).rb",
              target = {
                { target = "/spec/models/%1_spec.rb",              context = "spec" },
                { target = "/spec/factories/%1.rb",                context = "factories",  transformer = "pluralize" },
                { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
                { target = "/app/views/%1/**/*.html.*",            context = "view",       transformer = "pluralize" },
              },
            },
            {
              pattern = "/spec/models/(.*)_spec.rb",
              target = {
                { target = "/app/models/%1.rb", context = "models" },
              },
            },
            {
              pattern = "/spec/factories/(.*).rb",
              target = {
                { target = "/app/models/%1.rb",       context = "models", transformer = "singularize" },
                { target = "/spec/models/%1_spec.rb", context = "spec",   transformer = "singularize" },
              },
            },
            {
              pattern = "/app/services/(.*).rb",
              target = {
                { target = "/spec/services/%1_spec.rb", context = "spec" },
              },
            },
            {
              pattern = "/spec/services/(.*)_spec.rb",
              target = {
                { target = "/app/services/%1.rb", context = "services" },
              },
            },
            {
              pattern = "/app/controllers/.*/(.*)_controller.rb",
              target = rails_controller_patterns,
            },
            {
              pattern = "/app/controllers/(.*)_controller.rb",
              target = rails_controller_patterns,
            },
            {
              pattern = "/app/views/(.*)/.*.html.*",
              target = {
                { target = "/spec/factories/%1.rb",                context = "factories",  transformer = "singularize" },
                { target = "/app/models/%1.rb",                    context = "models",     transformer = "singularize" },
                { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
              },
            },
            {
              pattern = "/lib/(.*).rb",
              target = {
                { target = "/spec/%1_spec.rb", context = "spec" },
              },
            },
            {
              pattern = "/spec/(.*)_spec.rb",
              target = {
                { target = "/lib/%1.rb", context = "lib" },
              },
            },
          },
        }

        local wk = require("which-key")
        wk.add({
          { "<space>o",  group = "other",        remap = false },
          { "<space>oc", "<cmd>OtherClear<cr>",  desc = "clear",  remap = false },
          { "<space>oo", "<cmd>Other<cr>",       desc = "other",  remap = false },
          { "<space>os", "<cmd>OtherSplit<cr>",  desc = "split",  remap = false },
          { "<space>ov", "<cmd>OtherVSplit<cr>", desc = "vsplit", remap = false },
        })
      end,
    }
  end,
}
