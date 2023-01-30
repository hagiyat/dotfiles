vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = ":%s/\\s\\+$//ge",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.slim" },
  callback = function()
    vim.opt.filetype = "slim"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vim,ruby,eruby,slim,javascript,typescript,html,zsh,markdown,yaml,terraform" },
  command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  command = "setlocal shiftwidth=4 tabstop=4 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  command = "setlocal shiftwidth=4 tabstop=4 noexpandtab",
})

-- auto compile
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  desc = "run PackerCompile",
  pattern = { "plugins.lua", "modules/*.lua" },
  command = "PackerCompile",
})
