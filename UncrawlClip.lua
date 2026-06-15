-- @name: UncrawlClip
-- @desc: Automatically performs an UnCrawlClip.
-- @author: klosai
-- @version: 1.1
-- @keybind: F2

local running = false

function onSettings()
    -- Settings
end

function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true
    holdKey("Space")
    sleep(15)
    holdKey("LCtrl")
    releaseKey("LCtrl")
    sleep(5)
    holdKey("C")
    sleep(32)
    freeze(true)
    sleep(250)
    releaseKey("Space")
    releaseKey("C")
    holdKey("LCtrl")
    releaseKey("LCtrl")
    freeze(false)

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    running = false
end
