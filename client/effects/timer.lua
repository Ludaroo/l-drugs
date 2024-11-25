-- File: client/timers.lua

local effectTimers = {}

-- Start a client-side timer for a drug
-- @string drugId Drug ID
-- @int tickInterval Interval for the timer in milliseconds
-- @float tolerance Tolerance level of the player
-- @return void
function startClientTimer(drugId, tickInterval, tolerance)
    local effect = effects[drugId]
    if not effect or not effect.client then return end
    if effect.client.defaultTick then
        local tick = effect.client.defaultTick
        if tick.start then tick.start(tick, { tolerance = tolerance }) end
        effectTimers[drugId] = {
            defaultTick = lib.setInterval(tickInterval, function()
                if tick.action then tick.action(tick, { tolerance = tolerance }) end
            end)
        }
    end
end

-- Stop a client-side timer for a drug
-- @string drugId Drug ID
-- @return void
function stopClientTimer(drugId)
    local effect = effects[drugId]
    if not effect or not effect.client then return end
    if effectTimers[drugId] and effectTimers[drugId].defaultTick then
        lib.clearInterval(effectTimers[drugId].defaultTick)
        if effect.client.defaultTick and effect.client.defaultTick.stop then
            effect.client.defaultTick.stop(effect.client.defaultTick, {})
        end
    end
    effectTimers[drugId] = nil
end

RegisterNetEvent("l-drugs:startClientTimer", function(drugId, tickInterval, tolerance)
    startClientTimer(drugId, tickInterval, tolerance)
end)

RegisterNetEvent("l-drugs:stopClientTimer", function(drugId)
    stopClientTimer(drugId)
end)
