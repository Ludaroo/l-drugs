lib.callback.register('l-drugs:getDrugs', function(source)
    return sql_getDrugs()
end)

lib.callback.register('l-drugs:addDrug', function(source, name, description, effect_type, default_effect_params, max_duration, default_value)
    return sql_addDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
end)


lib.callback.register('l-drugs:editDrug', function(source, name, description, effect_type, default_effect_params, max_duration, default_value)
    return sql_editDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
end)


lib.callback.register('l-drugs:removeDrug', function(source, name)
    return sql_removeDrug(name)
end)

lib.callback.register('l-drugs:getPlayerTolerance', function(source, drugId)
    local playerIdentifier = framework_getPlayerIdentifier(source)
    if type(drugId) == 'string' then
        return sql_getdrugIdByName(drugId):next(function(drugId)
            return sql_getPlayerTolerance(playerIdentifier, drugId)
        end)
    end
    return sql_getPlayerTolerance(playerIdentifier, drugId)
end)

lib.callback.register('l-drugs:getPlayerToleranceAll', function(source)
    local playerIdentifier = framework_getPlayerIdentifier(source)
    return sql_getPlayerToleranceAll(playerIdentifier)
end)

lib.callback.register('l-drugs:updatePlayerTolerance', function(source, drugId, tolerance)
    local playerIdentifier = framework_getPlayerIdentifier(source)
    if type(drugId) == 'string' then
        return sql_getdrugIdByName(drugId):next(function(id)
            return sql_updatePlayerTolerance(playerIdentifier, id, tolerance)
        end)
    else
        return sql_updatePlayerTolerance(playerIdentifier, drugId, tolerance)
    end
end)

lib.callback.register('l-drugs:getPlayerTolerance', function(source, drugId)
    local playerIdentifier = framework_getPlayerIdentifier(source)
    if type(drugId) == 'string' then
        return sql_getdrugIdByName(drugId):next(function(drugId)
            return sql_getPlayerTolerance(playerIdentifier, drugId)
        end)
    end
    return sql_getPlayerTolerance(playerIdentifier, drugId)
end)

lib.callback.register('l-drugs:getPlayerToleranceAll', function(source)
    local playerIdentifier = framework_getPlayerIdentifier(source)
    return sql_getPlayerToleranceAll(playerIdentifier)
end)

lib.callback.register('l-drugs:getDrugData', function(source, drugId)
    return sql_drug_get_data(drugId)
end)