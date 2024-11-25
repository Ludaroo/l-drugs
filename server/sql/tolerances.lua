local value = lib.waitFor(function()
    if effects ~= nil then
        return effects
    end
end, "Couldn't fetch effects for timers in /server/effects/timers", 1000)

local effectTimers = {}

function effects_startTimers(source, drugId, tickInterval)
    sql_playerdrugs_getTimer(source, drugId):next(function(existingTimer, err)
        if err then return print(("Error fetching timer: %s"):format(err)) end

        sql_gettolerancedata(framework_getPlayerIdentifier(source, 0), drugId):next(function(toleranceData)
            local tolerance = toleranceData and toleranceData.tolerance_level or 0

            local timerValue = existingTimer or tickInterval
            sql_playerdrugs_setTimer(source, drugId, timerValue)

            local timer = lib.timer(timerValue, function()
                local toleranceIncrease = effects[drugId].toleranceIncrease or 0.01
                tolerance = tolerance + toleranceIncrease
                effects[drugId].server.defaultTick.action({
                    source = source,
                    tolerance = tolerance
                })

                sql_updatetolerance(framework_getPlayerIdentifier(source, 0), drugId, tolerance)

                sql_playerdrugs_addToTimer(source, drugId, -tickInterval)

                sql_playerdrugs_getTimer(source, drugId):next(function(updatedTimer)
                    if updatedTimer <= 0 then
                        effects_stopTimers(source, drugId)
                    end
                end)
            end, true)

            if not effectTimers[drugId] then effectTimers[drugId] = {} end
            effectTimers[drugId][source] = timer
            timer:play()
            print(("Started timer for drug ID '%s' on player ID %d."):format(drugId, source))
        end)
    end)
end

function effects_stopTimers(source, drugId)
    if effectTimers[drugId] and effectTimers[drugId][source] then
        effectTimers[drugId][source]:forceEnd(false)
        effectTimers[drugId][source] = nil

        sql_playerdrugs_getTimer(source, drugId):next(function(finalTimer)
            if finalTimer <= 0 then
                sql_playerdrugs_removeDrug(source, drugId)
            else
                sql_playerdrugs_setTimer(source, drugId, finalTimer)
            end
        end)

        print(("Stopped timer for drug ID '%s' on player ID %d."):format(drugId, source))
    end
end

function effects_startTimers(players)
    if not players then return end
    effects = effects_getEffects()

    for effectName, effectData in pairs(effects) do
        if effectData.server then
            for _, playerId in pairs(players) do
                effects_startTimers(playerId, effectName, effectData.server.defaultTick.interval or 1000)
            end
        end
    end
    
end

function effects_stopTimers()
    for drugId, playerTimers in pairs(effectTimers) do
        for playerId, _ in pairs(playerTimers) do
            effects_stopTimers(playerId, drugId)
        end
    end
    effectTimers = {}
end

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    local players = ESX.GetExtendedPlayers()
    effects_startTimers(players)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    effects_stopTimers()
end)
