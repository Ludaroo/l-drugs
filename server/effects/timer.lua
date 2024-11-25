-- File: server/timers.lua

local effectTimers = {}

-- Start a timer for a specific drug and player
-- @int source Player ID
-- @int drugId Drug ID
-- @int tickInterval Interval for the timer in milliseconds
-- @return void
function startTimer(source, drugId, tickInterval)
    sql_playerdrugs_doesDrugExist(source, drugId):next(function(exists, err)
        if err or not exists then return end
        sql_gettolerancedata(framework_getPlayerIdentifier(source, 0), drugId):next(function(toleranceData)
            local tolerance = toleranceData and toleranceData.tolerance_level or 0
            if effectTimers[drugId] and effectTimers[drugId][source] then
                local currentTimer = effectTimers[drugId][source]
                local currentTimeLeft = currentTimer:getTimeLeft("ms") or 0
                local newTime = currentTimeLeft + tickInterval
                currentTimer:setTime(newTime)
                sql_playerdrugs_addToTimer(source, drugId, tickInterval)
                TriggerClientEvent("l-drugs:startClientTimer", source, drugId, tickInterval, tolerance)
                return
            end
            local timerValue = tickInterval
            sql_playerdrugs_getTimer(source, drugId):next(function(existingTimer)
                if existingTimer then
                    timerValue = existingTimer
                else
                    sql_playerdrugs_setTimer(source, drugId, timerValue)
                end
                TriggerClientEvent("l-drugs:startClientTimer", source, drugId, timerValue, tolerance)
                if not effectTimers[drugId] then effectTimers[drugId] = {} end
                effectTimers[drugId][source] = { timerValue = timerValue }
            end)
        end)
    end)
end

-- Stop a timer for a specific drug and player
-- @int source Player ID
-- @int drugId Drug ID
-- @return void
function stopTimer(source, drugId)
    if effectTimers[drugId] and effectTimers[drugId][source] then
        TriggerClientEvent("l-drugs:stopClientTimer", source, drugId)
        effectTimers[drugId][source] = nil
        sql_playerdrugs_getTimer(source, drugId):next(function(finalTimer)
            if finalTimer <= 0 then
                sql_playerdrugs_removeDrug(source, drugId)
            else
                sql_playerdrugs_setTimer(source, drugId, finalTimer)
            end
        end)
    end
end

-- Start all timers for a player
-- @int source Player ID
-- @return void
function startTimersForPlayer(source)
    sql_playerdrugs_getDrugsFromPlayer(source):next(function(drugs, err)
        if err or not drugs then return end
        for _, drug in ipairs(drugs) do
            startTimer(source, drug.drug_id, effects[drug.drug_id].server.defaultTick.interval or 1000)
        end
    end)
end

-- Start timers for all players
-- @table players List of Player IDs
-- @return void
function startTimers(players)
    if not players then return end
    effects = effects_getEffects()
    for _, playerId in pairs(players) do
        if ESX.GetPlayerFromId(playerId) then
            startTimersForPlayer(playerId)
        end
    end
end

-- Stop all timers for all players
-- @return void
function stopTimers()
    for drugId, playerTimers in pairs(effectTimers) do
        for playerId, _ in pairs(playerTimers) do
            stopTimer(playerId, drugId)
        end
    end
    effectTimers = {}
end

-- Allow a player to take a drug
-- @int source Player ID
-- @int drugId Drug ID
-- @int tickInterval Interval for the timer in milliseconds
-- @return void
function takeDrug(source, drugId, tickInterval)
    sql_playerdrugs_doesDrugExist(source, drugId):next(function(exists, err)
        if err then return end
        if not exists then
            sql_playerdrugs_addDrug(source, drugId):next(function(success, err)
                if success then
                    startTimer(source, drugId, tickInterval)
                end
            end)
        else
            startTimer(source, drugId, tickInterval)
        end
    end)
end

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    local players = GetPlayers()
    startTimers(players)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    stopTimers()
end)

AddEventHandler("esx:playerLoaded", function(playerId)
    startTimersForPlayer(playerId)
end)

AddEventHandler("esx:playerDropped", function(playerId)
    for drugId, _ in pairs(effectTimers) do
        stopTimer(playerId, drugId)
    end
end)
