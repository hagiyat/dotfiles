local wezterm = require("wezterm")
local action = wezterm.action
local config = {}

-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = 'Tomorrow Night'
-- config.color_scheme = 'nightfox'
-- config.color_scheme = 'Afterglow'
config.color_scheme = "SpaceGray Eighties Dull"

config.font_size = 12.0

config.font = wezterm.font_with_fallback {
  { family = "JetBrainsMono Nerd Font Mono" },
  { family = "源ノ角ゴシック JP" },
  "Noto Color Emoji",
}

config.use_fancy_tab_bar = false

config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }

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
    -- pane previous
    key = "h",
    mods = "LEADER",
    action = action.ActivateTabRelative(-1),
  },
  {
    -- pane next
    key = "j",
    mods = "LEADER",
    action = action.ActivateTabRelative(1),
  },
  {
    -- rotate pane
    key = "r",
    mods = "LEADER",
    action = wezterm.action.RotatePanes("Clockwise"),
  },
  {
    -- toggle pane zoom state
    key = "z",
    mods = "LEADER",
    action = action.TogglePaneZoomState,
  },
  {
    -- open uri
    key = "u",
    mods = "LEADER",
    action = wezterm.action.QuickSelectArgs {
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
