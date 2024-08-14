return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    config = function()
      local wk = require("which-key")

      wk.add {
        { "<space>w",  group = "window",   remap = false },
        { "<space>wd", ":<C-u>q<CR>",      desc = "delete",     remap = false },
        { "<space>wh", "<C-w>h",           desc = "move left",  remap = false },
        { "<space>wj", "<C-w>j",           desc = "move down",  remap = false },
        { "<space>wk", "<C-w>k",           desc = "move up",    remap = false },
        { "<space>wl", "<C-w>l",           desc = "move right", remap = false },
        { "<space>ws", ":<C-u>split<CR>",  desc = "split",      remap = false },
        { "<space>wv", ":<C-u>vsplit<CR>", desc = "vsplit",     remap = false },
        -- { "<space>w=", "<C-w>=",           desc = "size reset", remap = false },
      }

      wk.add {
        { "<space>b",  group = "buffer",      remap = false },
        { "<space>ba", ":<C-u>enew<CR>",      desc = "add",      remap = false },
        { "<space>bd", ":<C-u>bdelete<CR>",   desc = "delete",   remap = false },
        { "<space>bn", ":<C-u>bnext<CR>",     desc = "next",     remap = false },
        { "<space>bp", ":<C-u>bprevious<CR>", desc = "previous", remap = false },
      }

      wk.add {
        { "<space>q",  group = "quit",  remap = false },
        { "<space>qa", ":<C-u>qa<CR>",  desc = "quit all",   remap = false },
        { "<space>qf", ":<C-u>qa!<CR>", desc = "force quit", remap = false },
        { "<space>qq", ":<C-u>q<CR>",   desc = "quit",       remap = false },
        { "<space>qw", ":<C-u>wq<CR>",  desc = "with write", remap = false },
      }

      -- emacs keys
      wk.add {
        {
          mode = { "i" },
          { "<c-a>", "<C-O>^",      desc = "home" },
          { "<c-b>", "<Left>",      desc = "left" },
          { "<c-d>", "<C-g>u<Del>", desc = "delete" },
          { "<c-e>", "<End>",       desc = "end" },
          { "<c-f>", "<Right>",     desc = "right" },
          { "<c-h>", "<C-g>u<C-h>", desc = "delete forward" },
        },
      }

      wk.add {
        { "<esc><esc>", ":nohlsearch<CR>", desc = "clear highlight" },
        { "gw",         ":<C-u>w<CR>",     desc = "save file" },
      }

      wk.add {
        { "gY", ":<C-u>let @* = expand('%:p')<CR>", desc = "copy fullpath" },
        { "gy", ":<C-u>let @* = expand('%')<CR>",   desc = "copy relative path" },
      }
    end,
  },
}
