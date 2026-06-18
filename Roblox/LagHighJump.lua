-- @name: LagHighJump
-- @desc: Automatically performs a Lag High Jump.
-- @author: klosai
-- @version: 1.0
-- @keybind: F6

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

    moveDegrees(-35, 0)
    
    sleep(15)

    holdKey(shiftlockKey)
    releaseKey(shiftlockKey)

    sleep(10)

    holdKey("RMB")

    sleep(1)

    moveDegrees(35+180, 0)

    sleep(10)

    releaseKey("RMB")

    sleep(100)

    holdKey("Space")

    sleep(345)

    holdKey("W")
    
    sleep(193)

    freeze(true)

    sleep(500)

    freeze(false)

    holdKey(shiftlockKey)
    releaseKey(shiftlockKey)
    
    sleep(260)

    sleep(50)

    moveDegrees(45, 0)
    sleep(10)
    moveDegrees(-45, 0)

    sleep(170)
    releaseKey("Space")
    sleep(100)

    releaseKey("W")

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("Space")
    releaseKey("W")
    releaseKey("RMB")
    releaseKey(shiftlockKey)
    running = false
end