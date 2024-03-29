local window                      = require 'hs.window'
local hotkey                      = require 'hs.hotkey'
local application                 = require 'hs.application'

local RecursiveBinder = hs.loadSpoon("RecursiveBinder") -- Load the spoon

RecursiveBinder.escapeKey = { {}, 'escape' }            -- Press escape to abort

-- singleKey is a convenience function provided in the Spoon
local singleKey = spoon.RecursiveBinder.singleKey

-- application Switcher
local applicationKeyMap = {
  [singleKey('b', 'Google Chrome')] = function() application.launchOrFocus("Google Chrome") end,
  [singleKey('t', 'WezTerm')] = function() application.launchOrFocus("WezTerm") end,
  [singleKey('f', 'Finder')] = function() application.launchOrFocus("Finder") end,
}
hotkey.bind({ 'option' }, 'a', RecursiveBinder.recursiveBind(applicationKeyMap))


-- Window Switcher
-- https://github.com/oniatsu/HotSwitch-HS
-- 2023/11現在、スクリーンセーバーが立ち上がると選択不能になってしまう
-- local hotswitchHs = require("hotswitch-hs/hotswitch-hs")
-- hotkey.bind({ "alt" }, "tab", hotswitchHs.openOrClose) -- Set a keybind you like to open HotSwitch-HS panel.
-- hotkey.bind({}, "f13", hotswitchHs.openOrClose)

-- https://mac-ra.com/window-kirikae-hammerspoon/
window.animationDuration          = 0
local switcher                    = window.switcher.new()
switcher.ui.showSelectedTitle     = false
switcher.ui.showSelectedThumbnail = false
switcher.ui.backgroundColor       = { 0.3, 0.3, 0.3, 0.5 }
hotkey.bind({ 'alt' }, 'tab', 'Next window', function() switcher:next() end, nil, function() switcher:next() end)
hotkey.bind({ 'alt', 'shift' }, 'tab', 'Prev window', function() switcher:previous() end, nil, function() switcher:previous() end)


-- Window Management
-- https://martinlwx.github.io/en/how-to-manage-windows-using-hammerspoon/
local wm = function(position)
  return function() window.focusedWindow():moveToUnit(position) end
end

local windowKeyMap = {
  [singleKey(',', 'left half')] = wm({ 0, 0, 0.5, 1 }),
  [singleKey('.', 'right half')] = wm({ 0.5, 0, 0.5, 1 }),
  [singleKey('z', 'maximize')] = wm({ 0, 0, 1, 1 }),

  [singleKey('j', 'next window')] = function() switcher:next() end,
  [singleKey('k', 'previous window')] = function() switcher:previous() end,
}
hs.hotkey.bind({ 'option' }, 'w', RecursiveBinder.recursiveBind(windowKeyMap))
