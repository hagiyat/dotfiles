-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/hagiyat/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/hagiyat/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/hagiyat/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/hagiyat/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/hagiyat/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["gina.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/gina.vim",
    url = "https://github.com/lambdalisue/gina.vim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"packers/colorschemes/kanagawa\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["nightfox.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"packers/colorschemes/nightfox\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { "\27LJ\2\n\b\0\0\b\0)\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2#\0005\3!\0005\4\3\0004\5\26\0005\6\5\0005\a\4\0=\a\6\6>\6\1\0055\6\b\0005\a\a\0=\a\6\6>\6\2\0055\6\t\0>\6\3\0055\6\n\0>\6\4\0055\6\v\0>\6\5\0055\6\f\0>\6\6\0055\6\r\0>\6\a\0055\6\14\0>\6\b\0055\6\15\0>\6\t\0055\6\16\0>\6\n\0055\6\17\0>\6\v\0055\6\18\0>\6\f\0055\6\19\0>\6\r\0055\6\20\0>\6\14\0055\6\21\0>\6\15\0055\6\22\0>\6\16\0055\6\23\0>\6\17\0055\6\24\0>\6\18\0055\6\25\0>\6\19\0055\6\26\0>\6\20\0055\6\27\0>\6\21\0055\6\28\0>\6\22\0055\6\29\0>\6\23\0055\6\30\0>\6\24\0055\6\31\0>\6\25\5=\5 \4=\4\"\3=\3$\0025\3&\0005\4%\0=\4'\3=\3(\2B\0\2\1K\0\1\0\factions\14open_file\1\0\0\1\0\1\17quit_on_open\2\tview\1\0\0\rmappings\1\0\0\tlist\1\0\2\bkey\ag?\vaction\16toggle_help\1\0\2\bkey\6S\vaction\16search_node\1\0\2\bkey\6E\vaction\15expand_all\1\0\2\bkey\6W\vaction\17collapse_all\1\0\2\bkey\6q\vaction\nclose\1\0\2\bkey\6F\vaction\22clear_live_filter\1\0\2\bkey\6f\vaction\16live_filter\1\0\2\bkey\6-\vaction\vdir_up\1\0\2\bkey\6Y\vaction\23copy_absolute_path\1\0\2\bkey\6y\vaction\14copy_name\1\0\2\bkey\6P\vaction\npaste\1\0\2\bkey\6C\vaction\tcopy\1\0\2\bkey\6x\vaction\bcut\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6a\vaction\vcreate\1\0\2\bkey\6R\vaction\frefresh\1\0\2\bkey\6.\vaction\20toggle_dotfiles\1\0\2\bkey\6p\vaction\fpreview\1\0\2\bkey\6h\vaction\15close_node\1\0\2\bkey\6H\vaction\16parent_node\1\0\2\bkey\6>\vaction\17next_sibling\1\0\2\bkey\6<\vaction\17prev_sibling\1\0\1\vaction\acd\1\2\0\0\n<TAB>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6l\1\0\1\16custom_only\2\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nY\0\0\5\0\6\0\b6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\28<Cmd>NvimTreeToggle<CR>\r<space>e\6n\bset\vkeymap\bvim\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'NvimTreeToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle' }, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeToggle ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au ColorSchemePre * ++once lua require("packer.load")({'kanagawa.nvim', 'nightfox.nvim'}, { event = "ColorSchemePre *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'gina.vim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'kanagawa.nvim', 'nightfox.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
