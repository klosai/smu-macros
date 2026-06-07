-- @name: Pressure Jump
-- @desc: Automatically performs a Pressure Jump.
-- @author: klosai
-- @version: 1.0
-- @keybind: Q

local running = false

function onSettings()
    ui.checkbox("use_freeze", "Use Freeze", false, 260)
    ui.sliderInt("freeze_duration", "Freeze Duration (ms)", 100, 50, 500, 260)
    ui.sliderInt("spins", "Spins", 20, 1, 100, 260)
    ui.sliderInt("spin_interval", "Spin Interval (ms)", 8, 1, 50, 260)
    ui.sliderInt("crawl_spin", "Delay Before Spin (ms)", 4, 1, 100, 260)
    ui.checkbox("flick_rl", "Right-Left Flick", false, 260)
    ui.sliderInt("flick_delay", "Flick Delay (ms)", 3, 1, 50, 260)
    ui.sliderInt("flick_amount", "Flick Amount (ms)", 180, 1, 360, 260)
    ui.separator()
    ui.checkbox("insta_crawl", "Instant Crawl", true, 260)
    ui.sliderInt("crawl_delay", "Crawl Delay (ms)", 10, 0, 100, 260)
    ui.sliderInt("held_space", "Duration of Held Space (ms)", 40, 0, 100, 260)
    ui.sliderInt("space_delay", "Delay of Held Space (ms)", 10, 0, 100, 260)
end

function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true

    local useFreeze = settings.use_freeze ~= false
    local freezeDuration = settings.freeze_duration or 100
    local spins = settings.spins or 20
    local spinDelay = settings.spin_delay or 4
    local spinInterval = settings.spin_interval or 8
    local crawlSpin = settings.crawl_spin or 0
    local flickRL = settings.flick_rl or false
    local flickDelay = settings.flick_delay or 3
    local flickAmount = settings.flick_amount or 180

    local instaCrawl = settings.insta_crawl ~= true
    local crawlDelay = settings.crawl_delay or 0
    local heldSpace = settings.held_space or 20
    local spaceDelay = settings.space_delay or 10

    if instaCrawl then
        holdKey("Space")
        holdKey("C")
        releaseKey("C")
        sleep(spaceDelay)
        sleep(heldSpace)
        releaseKey("Space")
    else
        holdKey("C")
        sleep(crawlDelay)
        releaseKey("C")
        sleep(spaceDelay)
        holdKey("Space")
        sleep(heldSpace)
        releaseKey("Space")
    end

    sleep(crawlSpin)

    if useFreeze then
        freeze(true)
        sleep(freezeDuration)
        freeze(false)
    end

    sleep(spinDelay)

    if flickRL then
        for i = 1, spins do
            moveDegrees(flickAmount, 0)
            sleep(flickDelay)
            moveDegrees(-flickAmount, 0)
            sleep(spinInterval)
        end
    else
        for i = 1, spins do
            moveDegrees(flickAmount, 0)
            sleep(spinInterval)
        end
    end

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("Space")
    releaseKey("C")
    running = false
end
