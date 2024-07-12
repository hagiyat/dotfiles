local wezterm = require("wezterm")
local action = wezterm.action
local config = {}

-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = 'Tomorrow Night'
config.color_scheme = 'nightfox'
-- config.color_scheme = 'Afterglow'
-- config.color_scheme = "SpaceGray Eighties Dull"

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
    key = "-",
    mods = "LEADER",
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    -- new pane/horizontal
    key = "\\",
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
    key = "s",
    mods = "LEADER",
    action = action.PaneSelect { mode = "SwapWithActive" },
  },
  {
    -- pane left
    key = "h",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Left",
  },
  {
    -- pane down
    key = "j",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Down",
  },
  {
    -- pane down
    key = "k",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Up",
  },
  {
    -- pane right
    key = "l",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Right",
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
}

return config
