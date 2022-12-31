vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.visualbell = false
vim.opt.showcmd = false
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencodings = "utf-8,iso-2022-jp,cp932"
vim.opt.autoindent = true
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.list = true
vim.opt.wrap = true
vim.opt.textwidth = 0
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
vim.opt.infercase = true
vim.opt.switchbuf = "useopen"
vim.opt.backspace = "indent,eol,start"

-- 日本語入力のときの文字化け対応
-- vim.opt.ttimeout = true
-- vim.opt.ttimeoutlen = 50

-- Swapファイル,Backupファイルなど全て無効化する
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.swapfile = false

-- 水平分割は下に開く
vim.opt.splitbelow = true
-- 垂直分割は右に開く
vim.opt.splitright = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
