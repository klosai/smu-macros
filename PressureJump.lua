-- @name: Pressure Jump
-- @desc: Automatically performs a Pressure Jump.
-- @author: klosai
-- @version: 1.2
-- @keybind: Q

-- Main Functions
local function loadPreset(preset)
    for key, value in pairs(preset) do
        settings[key] = value
    end
end

-- Variables
local running = false
local presets = {}

presets.default = {
    use_freeze = false,
    freeze_after = false,
    freeze_duration = 100,
    freeze_delay = 0,

    spins = 20,
    spin_interval = 8,
    crawl_spin = 4,

    flick_rl = false,
    flick_delay = 3,
    flick_amount = 180,

    insta_crawl = true,
    crawl_delay = 10,

    held_space = 40,
    space_delay = 10
}

presets.freeze = {
    use_freeze = true,
    freeze_after = false,
    freeze_duration = 100,
    freeze_delay = 0,

    spins = 20,
    spin_interval = 8,
    crawl_spin = 4,

    flick_rl = false,
    flick_delay = 3,
    flick_amount = 180,

    insta_crawl = true,
    crawl_delay = 10,

    held_space = 20,
    space_delay = 10
}

-- Settings
function onSettings()
    ui.separator(10)

    ui.checkbox("show_info", "Show Information", false, 260)

    if settings.show_info then
        ui.dynamicTextbox("github", "GitHub Repository", "https://github.com/klosai/smu-macros", 360, 30)
        ui.separator(10)
    end

    ui.checkbox("presets", "Show Presets", false, 260)

    if settings.presets then
        if ui.button("load_default", "Default (Consistent)", 260) then
            loadPreset(presets.default)
        end

        if ui.button("load_freeze", "Freeze (Powerful)", 260) then
            loadPreset(presets.freeze)
        end

        ui.separator(10)
    end

    ui.checkbox("advanced", "Show Advanced Settings", false, 260)

    ui.separator(20)

    if settings.advanced then
        ui.checkbox("use_freeze", "Use Freeze", false, 260)

        if settings.use_freeze then
            ui.checkbox("freeze_after", "Freeze After Spin", false, 260)
            ui.sliderInt("freeze_duration", "Freeze Duration (ms)", 100, 10, 500, 260)
            ui.sliderInt("freeze_delay", "Freeze Delay (ms)", 0, 0, 500, 260)
            ui.separator(10)
        end
    end

    ui.sliderInt("spins", "Spins", 20, 0, 100, 260)
    ui.sliderInt("spin_interval", "Spin Interval (ms)", 8, 1, 50, 260)
    ui.sliderInt("crawl_spin", "Delay Before Spin (ms)", 4, 1, 100, 260)

    if settings.advanced then
        ui.checkbox("flick_rl", "Right-Left Flick", false, 260)

        if settings.flick_rl then
            ui.sliderInt("flick_delay", "Flick Delay (ms)", 3, 1, 50, 260)
            ui.separator(10)
        end

        ui.sliderInt("flick_amount", "Flick Amount (Degrees)", 180, 1, 360, 260)
    end

    ui.separator()

    ui.checkbox("insta_crawl", "Instant Crawl", true, 260)

    if settings.insta_crawl ~= true then
        ui.sliderInt("crawl_delay", "Crawl Delay (ms)", 10, 0, 100, 260)
        ui.separator(10)
    end

    if settings.advanced then
        ui.sliderInt("held_space", "Duration of Held Space (ms)", 40, 0, 100, 260)
    end

    ui.sliderInt("space_delay", "Delay of Held Space (ms)", 10, 0, 100, 260)
end

-- Functions
local function doFreeze(delay, duration)
    sleep(delay)
    freeze(true)
    sleep(duration)
    freeze(false)
end

-- Execute
function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true

    local useFreeze = settings.use_freeze or false
    local runFreezeAfter = settings.freeze_after or false
    local freezeDuration = settings.freeze_duration or 100
    local freezeDelay = settings.freeze_delay or 0

    local spins = settings.spins or 20
    local spinDelay = 4
    local spinInterval = settings.spin_interval or 8
    local crawlSpin = settings.crawl_spin or 0

    local flickRL = settings.flick_rl or false
    local flickDelay = settings.flick_delay or 3
    local flickAmount = settings.flick_amount or 180

    local instaCrawl = settings.insta_crawl ~= true
    local crawlDelay = settings.crawl_delay or 0
    local heldSpace = settings.held_space or 40
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

    throwIfCancelled()

    sleep(crawlSpin)

    if useFreeze and not runFreezeAfter then
        doFreeze(freezeDelay, freezeDuration)
    end

    sleep(spinDelay)

    throwIfCancelled()

    for i = 1, spins do
        moveDegrees(flickAmount, 0)

        if flickRL then
            sleep(flickDelay)
            moveDegrees(-flickAmount, 0)
        end

        sleep(spinInterval)

        throwIfCancelled()
    end

    if useFreeze and runFreezeAfter then
        doFreeze(freezeDelay, freezeDuration)
    end

    sleep(spinDelay)

    running = false
end

-- Cleanup
function onCleanup(reason)
    freeze(false)
    releaseKey("Space")
    releaseKey("C")
    running = false
end