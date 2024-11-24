local value = lib.waitFor(function()
    if effects ~= nil then
        return effects
    end
end, "Couldn't fetch effects for timers in /server/effects/timers", 1000)

local effectTimers = {}  -- Table to store timers per effect and player

-- Function to start timers for all effects for all players
function startTimers(players)
    if players == nil then return end
    effects = effects_getEffects()
    for effectName, effectData in pairs(effects) do
        if effectData.server then
            -- Start default tick timer if defined
            if effectData.server.defaultTick and effectData.server.defaultTick.action then
                for _, playerId in pairs(players) do

                    
                    local tickTime = effectData.server.defaultTick.interval or 1000
                    local timer = lib.timer(tickTime, function()
                        effectData.server.defaultTick.action({source = playerId}) -- Pass player-specific source
                    end, true)

                    if not effectTimers[effectName] then
                        effectTimers[effectName] = {}
                    end

                    if not effectTimers[effectName].default then
                        effectTimers[effectName].default = {}
                    end

                    effectTimers[effectName].default[playerId] = timer
                    timer:play()
                    print(("Started default timer for effect '%s' on player ID %d."):format(effectName, playerId))
                end
            end

            -- Start custom tick timers if defined
            if effectData.server.customTicks then
                for customTickName, customTickData in pairs(effectData.server.customTicks) do
                    for _, playerId in pairs(players) do
                        local tickTime = customTickData.interval or 1000
                        local timer = lib.timer(tickTime, function()
                            customTickData.action({source = playerId}) -- Pass player-specific source
                        end, true)

                        if not effectTimers[effectName] then
                            effectTimers[effectName] = {}
                        end

                        if not effectTimers[effectName].custom then
                            effectTimers[effectName].custom = {}
                        end

                        if not effectTimers[effectName].custom[customTickName] then
                            effectTimers[effectName].custom[customTickName] = {}
                        end

                        effectTimers[effectName].custom[customTickName][playerId] = timer
                        timer:play()
                        print(("Started custom timer '%s' for effect '%s' on player ID %d."):format(customTickName, effectName, playerId))
                    end
                end
            end
        end
    end
end

-- Function to stop all timers for all effects and players
function stopTimers()
    for effectName, playerTimers in pairs(effectTimers) do
        -- Stop default timers
        if playerTimers.default then
            for playerId, timer in pairs(playerTimers.default) do
                timer:forceEnd(false)
                print(("Stopped default timer for effect '%s' on player ID %d."):format(effectName, playerId))
            end
            playerTimers.default = nil
        end

        -- Stop custom timers
        if playerTimers.custom then
            for customTickName, customTimers in pairs(playerTimers.custom) do
                for playerId, timer in pairs(customTimers) do
                    timer:forceEnd(false)
                    print(("Stopped custom timer '%s' for effect '%s' on player ID %d."):format(customTickName, effectName, playerId))
                end
                playerTimers.custom[customTickName] = nil
            end
            playerTimers.custom = nil
        end
        effectTimers[effectName] = nil
    end
end


