-- handles promise results
function handlePromise(promise)
    return promise:next(function(result)
        return result
    end, function(err)
        print("SQL Error: " .. err)
        return nil, err
    end)
end

-- gets tolerancedata for a player with a specific drugid
-- @param identifier - the player's identifier
-- @param drugid - the id of the drug
function sql_gettolerancedata(identifier, drugid)
    if type(drugid) == 'string' then
        drugid = sql_getdrugIdByName(drugid)
    end
    if not drugid or not identifier then 
        return nil, "Invalid drugid or identifier"
    end
    local promise = MySQL.Async.fetchAll('SELECT * FROM player_tolerances WHERE player_id = @player_id AND drug_id = @drug_id', {
        ['@player_id'] = identifier,
        ['@drug_id'] = drugid
    })
    local data, err = handlePromise(promise)
    if err then
        return nil, err
    end
    if data[1] then
        return data[1]
    else
        return false
    end
end

-- gets the tolerancedata for a player with all drugs
-- @param identifier - the player's identifier
function sql_gettolerancedataall(identifier)
    local promise = MySQL.Async.fetchAll('SELECT * FROM player_tolerances WHERE player_id = @player_id', {
        ['@player_id'] = identifier
    })
    local data, err = handlePromise(promise)
    if err then
        return nil, err
    end
    return data
end

-- updates the tolerance level for a player with a specific drugid
-- @param identifier - the player's identifier
-- @param drugid - the id of the drug
-- @param tolerance - the new tolerance level
function sql_updatetolerance(identifier, drugid, tolerance)
    if type(drugid) == 'string' then
        drugid = sql_getdrugIdByName(drugid)
    end
    if not drugid or not identifier then 
        return nil, "Invalid drugid or identifier"
    end
    local promise = MySQL.Async.execute('UPDATE player_tolerances SET tolerance_level = @tolerance WHERE player_id = @player_id AND drug_id = @drug_id', {
        ['@player_id'] = identifier,
        ['@drug_id'] = drugid,
        ['@tolerance'] = tolerance
    })
    local result, err = handlePromise(promise)
    if err then
        return nil, err
    end
    return true
end

-- updates the last used time for a player with a specific drugid
-- @param identifier - the player's identifier
-- @param drugid - the id of the drug
function sql_updatelastused(identifier, drugid)
    if type(drugid) == 'string' then
        drugid = sql_getdrugIdByName(drugid)
    end
    if not drugid or not identifier then 
        return nil, "Invalid drugid or identifier"
    end
    local promise = MySQL.Async.execute('UPDATE player_tolerances SET last_used = CURRENT_TIMESTAMP WHERE player_id = @player_id AND drug_id = @drug_id', {
        ['@player_id'] = identifier,
        ['@drug_id'] = drugid
    })
    local result, err = handlePromise(promise)
    if err then
        return nil, err
    end
    return true
end

-- inserts a new tolerance level for a player with a specific drugid
-- @param identifier - the player's identifier
-- @param drugid - the id of the drug
-- @param tolerance - the new tolerance level
function sql_inserttolerance(identifier, drugid, tolerance)
    if type(drugid) == 'string' then
        drugid = sql_getdrugIdByName(drugid)
    end
    if not drugid or not identifier then 
        return nil, "Invalid drugid or identifier"
    end
    local promise = MySQL.Async.execute('INSERT INTO player_tolerances (player_id, drug_id, tolerance_level, last_used) VALUES (@player_id, @drug_id, @tolerance, CURRENT_TIMESTAMP)', {
        ['@player_id'] = identifier,
        ['@drug_id'] = drugid,
        ['@tolerance'] = tolerance
    })
    local result, err = handlePromise(promise)
    if err then
        return nil, err
    end
    return true
end