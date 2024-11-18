return {
  {
    "Wansmer/treesj",
    event = "BufEnter",
    dependincies = {
      "nvim-treesitter/nvim-treesitter",
      "folke/which-key.nvim",
    },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 160,
      cursor_behavior = "hold",
      notify = true,
    },
    config = function()
      local wk = require("which-key")
      local treesj = require("treesj")
      wk.add {
        {
          mode = { "n", "v" },
          { "<space>j", group = "treesj", remap = true },
          {
            "<space>jJ",
            function ()
              treesj.join()
            end,
            desc = "join",
            remap = true,
          },
          {
            "<space>jj",
            function ()
              treesj.toggle()
            end,
            desc = "toggle",
            remap = true,
          },
          {
            "<space>jS",
            function ()
              treesj.split()
            end,
            desc = "split",
            remap = true,
          },
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependincies = { "nvim-cmp" },
    opts = {
      disable_filetype = { "TelescopePrompt" },
    },
    config = function()
      -- ref: https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "monaqa/dial.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  },
}
