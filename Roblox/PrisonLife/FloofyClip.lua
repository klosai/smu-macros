-- @name: Floofy Clip
-- @desc: Automatically performs a Floofy Clip.
-- @author: klosai
-- @version: 1.1
-- @keybind: F2

local running = false
local shiftlockKey = getSavedValue("vk_shiftkey")

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

    holdKey("shiftlockKey")
    releaseKey("shiftlockKey")

    sleep(5)

    holdKey("C")

    sleep(32)

    freeze(true)

    sleep(250)

    releaseKey("Space")
    releaseKey("C")

    holdKey("shiftlockKey")
    releaseKey("shiftlockKey")
    
    freeze(false)

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    releaseKey("Space")
    releaseKey("shiftlockKey")
    running = false
end
