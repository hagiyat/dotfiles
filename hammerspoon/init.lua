local ssids = require "ssids"

local function keyCode(key, modifiers)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.timer.usleep(1000)
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

local function remapKey(modifiers, key, keyCode)
    hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
    for k, v in pairs(hs.hotkey.getHotkeys()) do
        v['_hk']:disable()
    end
end

local function enableAllHotkeys()
    for k, v in pairs(hs.hotkey.getHotkeys()) do
        v['_hk']:enable()
    end
end

local function switchIME2AlphaNum()
    -- brew install https://raw.github.com/tasuten/homebrew-myformulas/master/inputsource.rb
    -- ref. http://tasuten.hatenablog.com/entry/20120806/1344184608
    hs.execute("/usr/local/bin/inputsource com.google.inputmethod.Japanese.Roman")
end

local function handleGlobalAppEvent(name, event, app)
    if event == hs.application.watcher.activated then
        -- hs.alert.show(name)
        if hs.fnutils.contains({"Emacs", "iTerm2", "ターミナル"}, name) then
            disableAllHotkeys()
        else
            enableAllHotkeys()
        end
        -- いっそのこと毎回IMEを英数字にしてしまう
        switchIME2AlphaNum()
    end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'g', keyCode('escape'))
hs.hotkey.bind({"cmd", "ctrl"}, "w", function()
    ssid_keys = {}
    hs.inspect.inspect(ssids)
    for i,_ in pairs(ssids) do ssid_keys.insert({["text"] = i}) end

    hs.chooser.new(
        function(s) hs.fnutils.each(s, function(v) print(v) end) end
    ):choices(
        ssid_keys
    ):show()
end)


local function appListener(appName, keys)
    hs.window.filter.new(
        appName
    ):subscribe(
        hs.window.filter.windowFocused,
        function() hs.fnutils.each(keys, function(k) k:enable() end) end
    ):subscribe(
        hs.window.filter.windowUnfocused,
        function() hs.fnutils.each(keys, function(k) k:disable() end) end
    )
end

local slackKeybinds = {
    hs.hotkey.new({"ctrl", "shift"}, "p", function()
        hs.eventtap.event.newScrollEvent({0, 8}, {}):post()
    end),
    hs.hotkey.new({"ctrl", "shift"}, "n", function()
        hs.eventtap.event.newScrollEvent({0, -8}, {}):post()
    end)
}
appListener("Slack", slackKeybinds)
