-- @name: UncrawlClip
-- @desc: Automatically performs an UncrawlClip.
-- @author: klosai
-- @version: 1.0
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
    sleep(20)
    holdKey("C")
    sleep(40)
    freeze(true)
    sleep(600)
    releaseKey("Space")
    releaseKey("C")
    freeze(false)

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    running = false
end