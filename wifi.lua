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

print('Starting wifi watcher')
wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()
