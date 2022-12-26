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
    commands = { "Gina" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/gina.vim",
    url = "https://github.com/lambdalisue/gina.vim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\nº\3\0\0\4\0\20\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0024\3\0\0=\3\16\2B\0\2\0016\0\17\0009\0\18\0'\2\19\0B\0\2\1K\0\1\0\27 colorscheme kanagawa \bcmd\bvim\14overrides\vcolors\1\0\1\abg\f#272727\25variablebuiltinStyle\1\0\1\vitalic\2\14typeStyle\19statementStyle\1\0\1\tbold\2\17keywordStyle\1\0\1\vitalic\2\18functionStyle\17commentStyle\1\0\1\vitalic\2\1\0\b\19terminalColors\2\17globalStatus\1\16dimInactive\1\16transparent\1\21specialException\2\18specialReturn\2\14undercurl\2\ntheme\tdark\nsetup\rkanagawa\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n§\a\0\2\t\0\30\0^5\2\0\0=\1\1\0026\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\6\0'\a\a\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\b\0'\a\t\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\n\0'\a\v\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\f\0'\a\r\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\14\0'\a\15\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\16\0'\a\17\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\18\0'\a\19\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\20\0'\a\21\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\22\0'\a\23\0\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\24\0006\a\2\0009\a\25\a9\a\26\a9\a\27\a\18\b\2\0B\3\5\0016\3\2\0009\3\3\0039\3\4\3'\5\5\0'\6\28\0'\a\29\0\18\b\2\0B\3\5\1K\0\1\0&<cmd>lua vim.lsp.buf.rename()<CR>\14<space>cn\vformat\bbuf\blsp\14<space>cf0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\ag]0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\ag[<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\14<space>ce/<cmd>lua vim.lsp.buf.type_definition()<CR>\14<space>ct*<cmd>lua vim.lsp.buf.references()<CR>\14<space>cD.<cmd>lua vim.lsp.buf.signature_help()<CR>\14<space>ch.<cmd>lua vim.lsp.buf.implementation()<CR>\14<space>ci%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\14<space>cd\6n\bset\vkeymap\bvim\vbuffer\1\0\1\vsilent\2>\1\1\5\1\3\0\t4\1\0\0003\2\1\0=\2\0\1-\2\0\0008\2\0\0029\2\2\2\18\4\1\0B\2\2\1K\0\1\0\1À\nsetup\0\14on_attachõ\1\1\0\6\0\f\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0026\1\0\0'\3\t\0B\1\2\0029\2\n\0004\4\3\0003\5\v\0>\5\1\4B\2\2\0012\0\0€K\0\1\0\0\19setup_handlers\14lspconfig\20mason-lspconfig\aui\1\0\0\nicons\1\0\0\1\0\3\22package_installed\bâœ“\24package_uninstalled\bâœ—\20package_pending\bâžœ\nsetup\nmason\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nightfox.nvim"] = {
    config = { "\27LJ\2\nÿ\1\0\0\6\0\15\0\0235\0\0\0004\1\0\0=\1\1\0004\1\0\0=\1\2\0005\1\3\0=\1\4\0004\1\0\0=\1\5\0004\1\0\0=\1\6\0006\1\a\0'\3\1\0B\1\2\0029\1\b\0015\3\f\0005\4\n\0005\5\t\0=\5\v\4=\4\r\3=\0\14\3B\1\2\1K\0\1\0\rpalettes\foptions\1\0\0\vstyles\1\0\0\1\0\3\ntypes\16italic,bold\rkeywords\tbold\rcomments\vitalic\nsetup\frequire\14carbonfox\fterafox\fnordfox\1\0\1\bbg1\f#1e2430\fduskfox\rnightfox\1\0\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { "\27LJ\2\n\b\0\0\b\0)\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2#\0005\3!\0005\4\3\0004\5\26\0005\6\5\0005\a\4\0=\a\6\6>\6\1\0055\6\b\0005\a\a\0=\a\6\6>\6\2\0055\6\t\0>\6\3\0055\6\n\0>\6\4\0055\6\v\0>\6\5\0055\6\f\0>\6\6\0055\6\r\0>\6\a\0055\6\14\0>\6\b\0055\6\15\0>\6\t\0055\6\16\0>\6\n\0055\6\17\0>\6\v\0055\6\18\0>\6\f\0055\6\19\0>\6\r\0055\6\20\0>\6\14\0055\6\21\0>\6\15\0055\6\22\0>\6\16\0055\6\23\0>\6\17\0055\6\24\0>\6\18\0055\6\25\0>\6\19\0055\6\26\0>\6\20\0055\6\27\0>\6\21\0055\6\28\0>\6\22\0055\6\29\0>\6\23\0055\6\30\0>\6\24\0055\6\31\0>\6\25\5=\5 \4=\4\"\3=\3$\0025\3&\0005\4%\0=\4'\3=\3(\2B\0\2\1K\0\1\0\factions\14open_file\1\0\0\1\0\1\17quit_on_open\2\tview\1\0\0\rmappings\1\0\0\tlist\1\0\2\vaction\16toggle_help\bkey\ag?\1\0\2\vaction\16search_node\bkey\6S\1\0\2\vaction\15expand_all\bkey\6E\1\0\2\vaction\17collapse_all\bkey\6W\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\22clear_live_filter\bkey\6F\1\0\2\vaction\16live_filter\bkey\6f\1\0\2\vaction\vdir_up\bkey\6-\1\0\2\vaction\23copy_absolute_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6P\1\0\2\vaction\tcopy\bkey\6C\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\vrename\bkey\6r\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\20toggle_dotfiles\bkey\6.\1\0\2\vaction\fpreview\bkey\6p\1\0\2\vaction\15close_node\bkey\6h\1\0\2\vaction\16parent_node\bkey\6H\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\1\vaction\acd\1\2\0\0\n<TAB>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6l\1\0\1\16custom_only\2\nsetup\14nvim-tree\frequire\0" },
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
pcall(vim.api.nvim_create_user_command, 'Gina', function(cmdargs)
          require('packer.load')({'gina.vim'}, { cmd = 'Gina', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'gina.vim'}, { cmd = 'Gina' }, _G.packer_plugins)
          return vim.fn.getcompletion('Gina ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'nightfox.nvim', 'kanagawa.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au ColorSchemePre * ++once lua require("packer.load")({'nightfox.nvim', 'kanagawa.nvim'}, { event = "ColorSchemePre *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'mason.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
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
