-- @name: Crawl Clip
-- @desc: Automatically performs a Crawl Clip.
-- @author: klosai
-- @version: 1.0
-- @keybind: F1

local running = false

function onSettings()
    ui.sliderInt("crawl_delay", "Crawl Delay (us)", 5, 0, 50, 260) -- I dont really notice a difference
    ui.sliderInt("freeze_duration", "Freeze Duration (ms)", 700, 100, 1000, 260)
end

function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true

    local crawlDelay = settings.crawl_delay or 5
    local freezeDuration = settings.freeze_duration or 700

    holdKey("C")
    releaseKey("C")
    sleepMicros(crawlDelay)
    freeze(true)
    sleep(freezeDuration)
    freeze(false)

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    running = false
end
