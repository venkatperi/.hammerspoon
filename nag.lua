-- nag window remover 

tv = hs.appfinder.appFromName("Flexiglass")
tvWatcher = nil

function applicationWindowWatcher(element, event, watcher, userData)
    if (event == hs.uielement.watcher.windowCreated) then
        print(element:title())

        if (element:title() == 'Flexiglass Trial') then
            print('Closing nag window...')
            element:focus()
            element:close()
		end -- title check

	end -- windowCreated event
end -- applicationWindowWatcher

-- Conditional added to handle when Flexiglass is launched before HS
if (tv ~= nil) then
    tvWatcher = tv:newWatcher(applicationWindowWatcher)
    tvWatcher:start({hs.uielement.watcher.windowCreated})
    print('Init - Flexiglass Trial nag window closer...')
end -- conditional

-- Event Handler: Application Watcher
-- Purpose:
--	If TeamViewer closes/terminates
-- 		1) Stop the tvWatcher event listener
-- 		2) Set the related variables to nil
-- 		3) Tell the console		
--	If TeamViewer opens/launches
-- 		1) Set tv variable
-- 		2) Create & Start event listener / application window watcher
-- 		3) Tell the console

function applicationWatcher(appName, eventType, appObject)
    if ((appName == "Flexiglass") and (eventType == hs.application.watcher.terminated) and (tv ~= nil) and (hs.appfinder.appFromName("Flexiglass") == nil)) then
        tvWatcher:stop()
        tvWatcher = nil
        tv = nil
        print('Clearing TV Watcher')
		
    elseif ((appName == "Flexiglass") and (eventType == hs.application.watcher.launched) and (tv == nil)) then
		tv = appObject
    tvWatcher = tv:newWatcher(applicationWindowWatcher)
    tvWatcher:start({hs.uielement.watcher.windowCreated, hs.uielement.watcher.windowMoved})
    print('Creating TV Watcher - Launch')
	end	-- conditional
	
end -- applicationWatcher

local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

