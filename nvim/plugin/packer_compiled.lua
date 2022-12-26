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
  ["hop.nvim"] = {
    config = { "\27LJ\2\nc\0\0\4\2\4\0\b-\0\0\0009\0\0\0005\2\2\0-\3\1\0009\3\1\3=\3\3\2B\0\2\1K\0\1\0\0¿\1¿\14direction\1\0\1\22current_line_only\2\17AFTER_CURSOR\15hint_char1d\0\0\4\2\4\0\b-\0\0\0009\0\0\0005\2\2\0-\3\1\0009\3\1\3=\3\3\2B\0\2\1K\0\1\0\0¿\1¿\14direction\1\0\1\22current_line_only\2\18BEFORE_CURSOR\15hint_char1u\0\0\4\2\4\0\b-\0\0\0009\0\0\0005\2\2\0-\3\1\0009\3\1\3=\3\3\2B\0\2\1K\0\1\0\0¿\1¿\14direction\1\0\2\16hint_offset\3ˇˇˇˇ\15\22current_line_only\2\17AFTER_CURSOR\15hint_char1r\0\0\4\2\4\0\b-\0\0\0009\0\0\0005\2\2\0-\3\1\0009\3\1\3=\3\3\2B\0\2\1K\0\1\0\0¿\1¿\14direction\1\0\2\16hint_offset\3\1\22current_line_only\2\18BEFORE_CURSOR\15hint_char1€\2\1\0\b\0\22\0#6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\0\0'\3\4\0B\1\2\0029\1\5\0016\2\0\0'\4\6\0B\2\2\0029\3\a\0025\5\n\0005\6\t\0003\a\b\0>\a\1\6=\6\v\0055\6\r\0003\a\f\0>\a\1\6=\6\14\0055\6\16\0003\a\15\0>\a\1\6=\6\17\0055\6\19\0003\a\18\0>\a\1\6=\6\20\0055\6\21\0B\3\3\0012\0\0ÄK\0\1\0\1\0\2\nremap\2\tmode\6n\6T\1\3\0\0\0\20hop backward +1\0\6t\1\3\0\0\0\19hop forward -1\0\6F\1\3\0\0\0\17hop backward\0\6f\1\0\0\1\3\0\0\0\16hop forward\0\rregister\14which-key\18HintDirection\rhop.hint\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n∫\3\0\0\4\0\20\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0024\3\0\0=\3\16\2B\0\2\0016\0\17\0009\0\18\0'\2\19\0B\0\2\1K\0\1\0\27 colorscheme kanagawa \bcmd\bvim\14overrides\vcolors\1\0\1\abg\f#272727\25variablebuiltinStyle\1\0\1\vitalic\2\14typeStyle\19statementStyle\1\0\1\tbold\2\17keywordStyle\1\0\1\vitalic\2\18functionStyle\17commentStyle\1\0\1\vitalic\2\1\0\b\ntheme\tdark\19terminalColors\2\17globalStatus\1\16dimInactive\1\16transparent\1\21specialException\2\18specialReturn\2\14undercurl\2\nsetup\rkanagawa\frequire\0" },
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
    config = { "\27LJ\2\nœ\a\0\2\b\1#\0,5\2\0\0=\1\1\2-\3\0\0009\3\2\0035\5\20\0005\6\3\0005\a\4\0=\a\5\0065\a\6\0=\a\a\0065\a\b\0=\a\t\0065\a\n\0=\a\v\0065\a\f\0=\a\r\0065\a\14\0=\a\15\0065\a\16\0=\a\17\0065\a\18\0=\a\19\6=\6\21\0055\6\22\0B\3\3\1-\3\0\0009\3\2\0035\5\28\0005\6\23\0005\a\24\0=\a\25\0065\a\26\0=\a\27\6=\6\29\0055\6\30\0B\3\3\1-\3\0\0009\3\2\0035\5 \0005\6\31\0=\6!\0055\6\"\0B\3\3\1K\0\1\0\0\0\1\0\2\tmode\6n\fnoremap\2\6K\1\0\0\1\3\0\0%<Cmd>lua vim.lsp.buf.hover()<CR>\14lsp hover\1\0\2\tmode\6n\fnoremap\2\6g\1\0\0\6.\1\3\0\0,<cmd>lua vim.diagnostic.goto_next()<CR>\20diagnostic next\6,\1\3\0\0,<cmd>lua vim.diagnostic.goto_prev()<CR>\20diagnostic prev\1\0\1\tname\t+lsp\1\0\3\vprefix\f<space>\tmode\6n\fnoremap\2\6c\1\0\0\6r\1\3\0\0&<Cmd>lua vim.lsp.buf.rename()<CR>\vrename\6f\1\3\0\0&<Cmd>lua vim.lsp.buf.format()<CR>\vformat\6e\1\3\0\0<<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\26show line diagnostics\6t\1\3\0\0/<Cmd>lua vim.lsp.buf.type_definition()<CR>\20type definition\6D\1\3\0\0*<Cmd>lua vim.lsp.buf.references()<CR>\15references\6h\1\3\0\0.<Cmd>lua vim.lsp.buf.signature_help()<CR>\19signature help\6i\1\3\0\0.<Cmd>lua vim.lsp.buf.implementation()<CR>\19implementation\6d\1\3\0\0*<Cmd>lua vim.lsp.buf.definition()<CR>\15definition\1\0\1\tname\t+lsp\rregister\vbuffer\1\0\1\vsilent\2@\1\1\5\2\3\0\t4\1\0\0003\2\1\0=\2\0\1-\2\1\0008\2\0\0029\2\2\2\18\4\1\0B\2\2\1K\0\1\0\2¿\1¿\nsetup\0\14on_attachã\2\1\0\a\0\r\0\0266\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0026\1\0\0'\3\t\0B\1\2\0026\2\0\0'\4\n\0B\2\2\0029\3\v\0004\5\3\0003\6\f\0>\6\1\5B\3\2\0012\0\0ÄK\0\1\0\0\19setup_handlers\14which-key\14lspconfig\20mason-lspconfig\aui\1\0\0\nicons\1\0\0\1\0\3\20package_pending\b‚ûú\22package_installed\b‚úì\24package_uninstalled\b‚úó\nsetup\nmason\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nightfox.nvim"] = {
    config = { "\27LJ\2\nˇ\1\0\0\6\0\15\0\0235\0\0\0004\1\0\0=\1\1\0004\1\0\0=\1\2\0005\1\3\0=\1\4\0004\1\0\0=\1\5\0004\1\0\0=\1\6\0006\1\a\0'\3\1\0B\1\2\0029\1\b\0015\3\f\0005\4\n\0005\5\t\0=\5\v\4=\4\r\3=\0\14\3B\1\2\1K\0\1\0\rpalettes\foptions\1\0\0\vstyles\1\0\0\1\0\3\rkeywords\tbold\ntypes\16italic,bold\rcomments\vitalic\nsetup\frequire\14carbonfox\fterafox\fnordfox\1\0\1\bbg1\f#1e2430\fduskfox\rnightfox\1\0\0\0" },
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
    config = { "\27LJ\2\nù\b\0\0\b\0)\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2#\0005\3!\0005\4\3\0004\5\26\0005\6\5\0005\a\4\0=\a\6\6>\6\1\0055\6\b\0005\a\a\0=\a\6\6>\6\2\0055\6\t\0>\6\3\0055\6\n\0>\6\4\0055\6\v\0>\6\5\0055\6\f\0>\6\6\0055\6\r\0>\6\a\0055\6\14\0>\6\b\0055\6\15\0>\6\t\0055\6\16\0>\6\n\0055\6\17\0>\6\v\0055\6\18\0>\6\f\0055\6\19\0>\6\r\0055\6\20\0>\6\14\0055\6\21\0>\6\15\0055\6\22\0>\6\16\0055\6\23\0>\6\17\0055\6\24\0>\6\18\0055\6\25\0>\6\19\0055\6\26\0>\6\20\0055\6\27\0>\6\21\0055\6\28\0>\6\22\0055\6\29\0>\6\23\0055\6\30\0>\6\24\0055\6\31\0>\6\25\5=\5 \4=\4\"\3=\3$\0025\3&\0005\4%\0=\4'\3=\3(\2B\0\2\1K\0\1\0\factions\14open_file\1\0\0\1\0\1\17quit_on_open\2\tview\1\0\0\rmappings\1\0\0\tlist\1\0\2\bkey\ag?\vaction\16toggle_help\1\0\2\bkey\6S\vaction\16search_node\1\0\2\bkey\6E\vaction\15expand_all\1\0\2\bkey\6W\vaction\17collapse_all\1\0\2\bkey\6q\vaction\nclose\1\0\2\bkey\6F\vaction\22clear_live_filter\1\0\2\bkey\6f\vaction\16live_filter\1\0\2\bkey\6-\vaction\vdir_up\1\0\2\bkey\6Y\vaction\23copy_absolute_path\1\0\2\bkey\6y\vaction\14copy_name\1\0\2\bkey\6P\vaction\npaste\1\0\2\bkey\6C\vaction\tcopy\1\0\2\bkey\6x\vaction\bcut\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6a\vaction\vcreate\1\0\2\bkey\6R\vaction\frefresh\1\0\2\bkey\6.\vaction\20toggle_dotfiles\1\0\2\bkey\6p\vaction\fpreview\1\0\2\bkey\6h\vaction\15close_node\1\0\2\bkey\6H\vaction\16parent_node\1\0\2\bkey\6>\vaction\17next_sibling\1\0\2\bkey\6<\vaction\17prev_sibling\1\0\1\vaction\acd\1\2\0\0\n<TAB>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6l\1\0\1\16custom_only\2\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["which-key"] = {
    loaded = true,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/start/which-key",
    url = "https://github.com/which-key"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nﬁ\t\0\0\6\0@\0R6\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0019\1\3\0005\3\22\0005\4\4\0005\5\5\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\0045\5\15\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0=\5\20\0045\5\21\0>\5\0\4=\4\20\0035\4\23\0B\1\3\0019\1\3\0005\3 \0005\4\24\0005\5\25\0=\5\26\0045\5\27\0=\5\28\0045\5\29\0=\5\18\0045\5\30\0=\5\31\4=\4!\0035\4\"\0B\1\3\0019\1\3\0005\3*\0005\4#\0005\5$\0=\5%\0045\5&\0=\5\20\0045\5'\0=\5\31\0045\5(\0=\5)\4=\4%\0035\4+\0B\1\3\0019\1\3\0005\3-\0005\4,\0=\4.\0035\4/\0=\0040\0035\0041\0=\0042\0035\0043\0=\0044\0035\0045\0=\0046\0035\0047\0=\0048\0035\0049\0B\1\3\0019\1\3\0005\3;\0005\4:\0=\4<\0035\4=\0=\4>\0035\4?\0B\1\3\1K\0\1\0\1\0\1\tmode\6n\agw\1\3\0\0\16:<C-u>w<CR>\14save file\15<esc><esc>\1\0\0\1\3\0\0\20:nohlsearch<CR>\20clear highlight\1\0\1\tmode\6i\n<c-d>\1\3\0\0\16<C-g>u<Del>\vdelete\n<c-h>\1\3\0\0\16<C-g>u<C-h>\19delete forward\n<c-e>\1\3\0\0\n<End>\bend\n<c-a>\1\3\0\0\v<C-O>^\thome\n<c-f>\1\3\0\0\f<Right>\nright\n<c-b>\1\0\0\1\3\0\0\v<Left>\tleft\1\0\3\vprefix\f<space>\tmode\6n\fnoremap\2\1\0\0\6f\1\3\0\0\18:<C-u>qa!<CR>\15force quit\1\3\0\0\17:<C-u>qa<CR>\rquit all\1\3\0\0\17:<C-u>wq<CR>\15with write\6q\1\3\0\0\16:<C-u>q<CR>\tquit\1\0\1\tname\n+quit\1\0\3\vprefix\f<space>\tmode\6n\fnoremap\2\6b\1\0\0\6a\1\3\0\0\19:<C-u>enew<CR>\badd\1\3\0\0\22:<C-u>bdelete<CR>\vdelete\6p\1\3\0\0\24:<C-u>bprevious<CR>\rprevious\6n\1\3\0\0\20:<C-u>bnext<CR>\tnext\1\0\1\tname\f+buffer\1\0\3\vprefix\f<space>\tmode\6n\fnoremap\2\1\0\0\1\3\0\0\v<C-w>=\15size reset\6w\1\3\0\0\25:MaximizerToggle<CR>\20toggle miximize\6d\1\3\0\0\16:<C-u>q<CR>\vdelete\6v\1\3\0\0\21:<C-u>vsplit<CR>\vvsplit\6s\1\3\0\0\20:<C-u>split<CR>\nsplit\6l\1\3\0\0\v<C-w>l\15move right\6k\1\3\0\0\v<C-w>k\fmove up\6j\1\3\0\0\v<C-w>j\14move down\6h\1\3\0\0\v<C-w>h\14move left\1\0\1\tname\f+window\rregister\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/hagiyat/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^which%-key"] = "which-key.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nY\0\0\5\0\6\0\b6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0B\0\4\1K\0\1\0\28<Cmd>NvimTreeToggle<CR>\r<space>e\6n\bset\vkeymap\bvim\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Gina', function(cmdargs)
          require('packer.load')({'gina.vim'}, { cmd = 'Gina', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'gina.vim'}, { cmd = 'Gina' }, _G.packer_plugins)
          return vim.fn.getcompletion('Gina ', 'cmdline')
      end})
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
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'mason.nvim', 'which-key.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au ColorSchemePre * ++once lua require("packer.load")({'kanagawa.nvim', 'nightfox.nvim'}, { event = "ColorSchemePre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'kanagawa.nvim', 'nightfox.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'hop.nvim'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
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
