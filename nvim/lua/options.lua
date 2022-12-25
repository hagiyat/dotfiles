vim.o.termguicolors = true
vim.o.backgroud = "dark"
vim.o.number = true
vim.o.novisualbell = true
vim.o.noshowcmd = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.o.fileencodings = "utf-8,iso-2022-jp,cp932"
vim.o.autoindent = true
vim.o.showmatch = true
vim.o.matchtime = 3
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.list = true
vim.o.wrap = true
vim.o.textwidth = 0
vim.opt.listchars = {
  tab = "▸-",
  trail = "↔",
  eol = "⏎",
  extends = "→",
  precedes = "←",
  nbsp = "␣",
}
vim.opt.fillchars = {
  diff = "░",
  eob = "‣",
  fold = "░",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}
vim.o.infercase = true
vim.o.switchbuf = "useopen"
vim.o.backspace = "indent,eol,start"

-- 日本語入力のときの文字化け対応
-- vim.o.ttimeout = true
-- vim.o.ttimeoutlen = 50

-- Swapファイル,Backupファイルなど全て無効化する
vim.o.nowritebackup = true
vim.o.nobackup = true
vim.o.noswapfile = true

-- 水平分割は下に開く
vim.o.splitbelow = true
-- 垂直分割は右に開く
vim.o.splitright = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
