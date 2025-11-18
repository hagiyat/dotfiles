local wezterm = require("wezterm")
local action = wezterm.action
local config = {}

-- config.color_scheme = 'nightfox'
-- config.color_scheme = "Ayu Mirage"
config.color_scheme = "Tokyo Night Storm"

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.7,
}

config.font_size = 14.5

config.font = wezterm.font_with_fallback {
  -- { family = "JetBrainsMono Nerd Font Mono" },
  { family = "GeistMono Nerd Font Mono" },
  { family = "Noto Sans CJK JP" },
  "Noto Color Emoji",
}

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.audible_bell = "Disabled"
config.scrollback_lines = 100000

config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
  {
    -- new tab
    key = "a",
    mods = "LEADER",
    action = action.SpawnTab("CurrentPaneDomain"),
  },
  {
    -- new pane/vertical
    key = "s",
    mods = "LEADER",
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    -- new pane/horizontal
    key = "v",
    mods = "LEADER",
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    -- close pane
    key = "x",
    mods = "LEADER",
    action = action.CloseCurrentPane { confirm = true },
  },
  {
    -- select pane
    key = "f",
    mods = "LEADER",
    action = action.PaneSelect { mode = "SwapWithActive" },
  },
  {
    key = "h",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Right",
  },
  {
    key = 'H',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'J',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'K',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = 'L',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Right', 5 },
  },
  {
    -- rotate pane
    key = "r",
    mods = "LEADER",
    action = action.RotatePanes("Clockwise"),
  },
  {
    -- toggle pane zoom state
    key = "z",
    mods = "LEADER",
    action = action.TogglePaneZoomState,
  },
  {
    key = "t",
    mods = "LEADER",
    action = action.QuickSelect,
  },
  {
    -- open uri
    key = "u",
    mods = "LEADER",
    action = action.QuickSelectArgs {
      label = "open url",
      patterns = {
        "https?://\\S+",
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info("opening: " .. url)
        wezterm.open_with(url)
      end),
    },
  },
  {
    -- Claude Codeのプロンプト内改行用 (by /terminal-setup)
    key = "Enter",
    mods = "SHIFT",
    action = action.SendString("\x1b\r"),
  },
}

return config
