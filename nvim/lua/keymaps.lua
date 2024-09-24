-- バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
local keymap = vim.keymap.set
local function escape_slash()
  if vim.fn.getcmdtype() == "/" then
    return "\\/"
  end
  return "/"
end

local function escape_question()
  if vim.fn.getcmdtype() == "/" then
    return "\\?"
  end
  return "?"
end

keymap("c", "/", escape_slash, { noremap = true, expr = true })
keymap("c", "?", escape_question, { noremap = true, expr = true })

keymap("n", "<C-g>", "<ESC>", { noremap = true })
keymap("n", "q", "<Nop>", { noremap = true })
keymap("n", "<Space>", "<Nop>", { noremap = true })
keymap("t", "<C-g>", "<C-\\><C-n>", { noremap = true })

keymap("n", "Y", "y$", { noremap = true })
keymap("n", "U", "<c-r>", { noremap = true })

-- ペースト結果を自動インデント
keymap("n", "p", "]p`]", { noremap = true })
keymap("n", "P", "]P`]", { noremap = true })
