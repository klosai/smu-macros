-- @name: Crawl Clip
-- @desc: Automatically performs a Crawl Clip.
-- @author: klosai
-- @version: 1.0
-- @keybind: F1

local running = false

-- function onSettings()
-- end

function onExecute()
    if running then log("Already running") return end

    running = true

    holdKey("C")
    releaseKey("C")
    sleepMicros(10)
    freeze(true)
    sleep(800)
    freeze(false)

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    running = false
end