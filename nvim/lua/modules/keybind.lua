return {
  setup = function(use)
    use {
      "folke/which-key.nvim",
      module = { "which-key" },
      config = function()
        local wk = require("which-key")
        wk.setup()

        wk.register({
          w = {
            name = "+window",
            h = { "<C-w>h", "move left" },
            j = { "<C-w>j", "move down" },
            k = { "<C-w>k", "move up" },
            l = { "<C-w>l", "move right" },
            s = { ":<C-u>split<CR>", "split" },
            v = { ":<C-u>vsplit<CR>", "vsplit" },
            d = { ":<C-u>q<CR>", "delete" },
            [0] = { "<C-w>=", "size reset" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n" })

        wk.register({
          b = {
            name = "+buffer",
            n = { ":<C-u>bnext<CR>", "next" },
            p = { ":<C-u>bprevious<CR>", "previous" },
            d = { ":<C-u>bdelete<CR>", "delete" },
            a = { ":<C-u>enew<CR>", "add" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n" })

        wk.register({
          q = {
            name = "+quit",
            q = { ":<C-u>q<CR>", "quit" },
            w = { ":<C-u>wq<CR>", "with write" },
            a = { ":<C-u>qa<CR>", "quit all" },
            f = { ":<C-u>qa!<CR>", "force quit" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n" })

        -- emacs keys
        wk.register({
          ["<c-b>"] = { "<Left>", "left" },
          ["<c-f>"] = { "<Right>", "right" },
          ["<c-a>"] = { "<C-O>^", "home" },
          ["<c-e>"] = { "<End>", "end" },
          ["<c-h>"] = { "<C-g>u<C-h>", "delete forward" },
          ["<c-d>"] = { "<C-g>u<Del>", "delete" },
        }, { mode = "i" })

        wk.register({
          ["<esc><esc>"] = { ":nohlsearch<CR>", "clear highlight" },
          ["gw"] = { ":<C-u>w<CR>", "save file" },
        }, { mode = "n" })

        wk.register({
          p = {
            name = "+packer",
            S = { ":<C-u>PackerSync<CR>", "sync" },
            s = { ":<C-u>PackerStatus<CR>", "status" },
            c = { ":<C-u>PackerCompile<CR>", "compile" },
            I = { ":<C-u>PackerInstall<CR>", "install" },
            p = { ":<C-u>PackerProfile<CR>", "profile" },
            C = { ":<C-u>PackerCompile profile=true<CR>", "compile profile" },
          },
        }, { prefix = "<space>", noremap = true, mode = "n" })
      end,
    }
  end,
}
