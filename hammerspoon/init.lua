local window                      = require 'hs.window'
local hotkey                      = require 'hs.hotkey'
local application                 = require 'hs.application'

-- Window Switcher
-- https://mac-ra.com/window-kirikae-hammerspoon/
window.animationDuration = 0
local switcher                    = window.switcher.new()
switcher.ui.showSelectedTitle     = false
switcher.ui.showSelectedThumbnail = false
switcher.ui.backgroundColor       = { 0.3, 0.3, 0.3, 0.5 }
hotkey.bind('cmd', 'j', 'Next window', function() switcher:next() end, nil, function() switcher:next() end)
hotkey.bind('cmd', 'k', 'Prev window', function() switcher:previous() end, nil, function() switcher:previous() end)

-- application Switcher
-- https://dev.to/rstacruz/switching-apps-slow-down-my-productivity-and-how-i-fixed-it-2anb-
hotkey.bind({ "alt", "shift" }, "b", "Google Chrome", function()
  application.launchOrFocus("Google Chrome")
end)

hotkey.bind({ "alt", "shift" }, "t", "WezTerm", function()
  application.launchOrFocus("WezTerm")
end)

hotkey.bind({ "alt", "shift" }, "f", "Finder", function()
  application.launchOrFocus("Finder")
end)


-- Window Management
-- https://martinlwx.github.io/en/how-to-manage-windows-using-hammerspoon/
local wm = function(position)
  return function() window.focusedWindow():moveToUnit(position) end
end
hotkey.bind({ 'cmd', 'shift' }, 'h', wm({ 0, 0, 0.5, 1 }))
hotkey.bind({ 'cmd', 'shift' }, 'j', wm({ 0, 0.5, 1, 0.5 }))
hotkey.bind({ 'cmd', 'shift' }, 'k', wm({ 0, 0, 1, 0.5 }))
hotkey.bind({ 'cmd', 'shift' }, 'l', wm({ 0.5, 0, 0.5, 1 }))
hotkey.bind({ 'cmd', 'shift' }, 'z', wm({ 0, 0, 1, 1 }))
