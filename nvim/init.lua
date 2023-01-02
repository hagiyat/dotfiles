require("options")
require("autocmds")

-- exsample init_local.lua
-- echo 'vim.g.ruby_host_prog = vim.env.HOME .. "/path/to/neovim-ruby-host"' > init_local.lua
local local_lua_path = vim.env.XDG_CONFIG_HOME .. "/nvim/lua/init_local.lua"
local stat = vim.loop.fs_stat(local_lua_path)
if stat and stat.type == "file" then
  require("init_local")
end

require("keymaps")
require("plugins")
