function sql_playerdrugs_getDrugsFromPlayer(source)
    local promise = MySQL.Async.fetchAll('SELECT * FROM player_drugs WHERE identifier = @identifier', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0)
    })
    return init_handlePromise(promise):next(function(drugs, err)
        if err then return nil, err end
        return drugs
    end)
end

function sql_playerdrugs_setTimer(source, drugId, timer)
    local promise = MySQL.Async.execute('UPDATE player_drugs SET timer = @timer WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@timer'] = timer,
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true
    end)
end

function sql_playerdrugs_getTimer(source, drugId)
    local promise = MySQL.Async.fetchAll('SELECT timer FROM player_drugs WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(timer, err)
        if err then return nil, err end
        if timer[1] then
            return timer[1].timer
        end
        return 0
    end)
end

function sql_playerdrugs_addDrug(source, drugId)
    local promise = MySQL.Async.execute('INSERT INTO player_drugs (identifier, drug_id) VALUES (@identifier, @drug_id)', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true
    end)
end

function sql_playerdrugs_removeDrug(source, drugId)
    local promise = MySQL.Async.execute('DELETE FROM player_drugs WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true
    end)
end

function sql_playerdrugs_removeAllDrugs(source)
    local promise = MySQL.Async.execute('DELETE FROM player_drugs WHERE identifier = @identifier', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0)
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true
    end)
end

function sql_playerdrugs_getDrug(source, drugId)
    local promise = MySQL.Async.fetchAll('SELECT * FROM player_drugs WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(drug, err)
        if err then return nil, err end
        return drug
    end)
end


function sql_playerdrugs_doesDrugExist(source, drugId)
    local promise = MySQL.Async.fetchAll('SELECT * FROM player_drugs WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(drug, err)
        if err then return nil, err end
        if drug[1] then
            return true
        end
        return false
    end)
end


functgion sql_playerdrugs_addToTimer(source, drugId, time)
    local promise = MySQL.Async.fetchAll('SELECT timer FROM player_drugs WHERE identifier = @identifier AND drug_id = @drug_id', {
        ['@identifier'] = framework_getPlayerIdentifier(source, 0),
        ['@drug_id'] = drugId
    })
    return init_handlePromise(promise):next(function(timer, err)
        if err then return nil, err end
        if timer[1] then
            local newTime = timer[1].timer + time
            local promise = MySQL.Async.execute('UPDATE player_drugs SET timer = @timer WHERE identifier = @identifier AND drug_id = @drug_id', {
                ['@timer'] = newTime,
                ['@identifier'] = framework_getPlayerIdentifier(source, 0),
                ['@drug_id'] = drugId
            })
            return init_handlePromise(promise):next(function(_, err)
                if err then return nil, err end
                return true
            end)
        end
        return false
    end)
end