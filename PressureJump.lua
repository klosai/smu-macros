-- @name: Pressure Jump
-- @desc: Automatically perform a Pressure Jump.
-- @author: klosai
-- @version: 1.0
-- @keybind: Q

local running = false

function onSettings()
    -- ui.checkbox("use_freeze", "Use Freeze", false, 260)
    ui.sliderInt("spins", "Spins", 20, 1, 100, 260)
    ui.sliderInt("spin_delay", "Spin Delay (ms)", 5, 1, 50, 260)
    ui.sliderInt("crawl_spin", "Delay Before Spin (ms)", 25, 1, 100, 260)
end

function onExecute()
    if running then
        log("Already running")
        return
    end

    running = true

    -- local useFreeze = settings.use_freeze ~= false

    local spins = settings.spins or 20
    local spinDelay = settings.spin_delay or 5
    local crawlSpin = settings.crawl_spin or 25

    holdKey("Space")
    pressKey("C")
    releaseKey("Space")

    sleep(crawlSpin)

    --[[
    if useFreeze then
        freeze(true)
        sleep(50)
        freeze(false)
    end
    ]]--

    for i = 1, spins do
        moveDegrees(180, 0)
        sleep(spinDelay)
    end

    running = false
end

function onCleanup(reason)
    freeze(false)
    releaseKey("Space")
    releaseKey("C")
    running = false
end