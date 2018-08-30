require "nag"

function moveWindow(key, dx, dy) 
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, key, function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.x = f.x + dx
    f.y = f.y + dy
    win:setFrame(f, 0)
  end)
end

moveWindow("up", 0, -10)
moveWindow("down", 0, 10)
moveWindow("left", -10, 0)
moveWindow("right", 10, 0)

wifiWatcher = nil
function ssidChanged()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        wifiMenu:setTitle(wifiName)
    else 
        wifiMenu:setTitle("Wifi OFF")
    end
end

wifiMenu = hs.menubar.newWithPriority(1000)
ssidChanged()

wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()

-- quick jump to important applications
hs.grid.setMargins({0, 0})
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'J', function () hs.application.launchOrFocus("Intellij IDEA") end)
-- even though the app is named iTerm2, iterm is the correct name
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'K', function () hs.application.launchOrFocus("iTerm") end)

-- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
  hs.notify.new({title="Hammerspoon config reloaded", informativeText="Manually via keyboard shortcut"}):send()
end)


