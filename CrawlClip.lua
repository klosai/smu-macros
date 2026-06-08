-- @name: Crawl Clip
-- @desc: Automatically performs a Crawl Clip.
-- @author: klosai
-- @version: 1.0
-- @keybind: F1

local running = false

function onSettings()
    ui.checkbox("no_delay", "No Delay", false, 260)
    ui.sliderInt("crawl_delay", "Crawl Delay (ms)", 1, 1, 50, 260)
    ui.sliderInt("freeze_duration", "Freeze Duration (ms)", 700, 100, 1000, 260)
end

function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true
    
    local noDelay = settings.no_delay or false
    local crawlDelay = settings.crawl_delay or 1
    local freezeDuration = settings.freeze_duration or 700

    if not instantFreeze then
        holdKey("C")
        releaseKey("C")
        if noDelay ~= false then
            sleep(crawlDelay)
        end
        freeze(true)
        sleep(freezeDuration)
        freeze(false)
    end

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("C")
    running = false
end
