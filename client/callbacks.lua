function callback_getDrugs()
    local result = lib.callback.await('l-drugs:getDrugs', false)
    if result == nil and result[2] ~= nil then
        error("Failed to get drugs " .. result[2])
    end
    return result
end

function callback_AddDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
    local result = lib.callback.await('l-drugs:addDrug', false, name, description, effect_type, default_effect_params, max_duration, default_value)
    if result == nil and result[2] ~= nil then
        error("Failed to add drug: " .. result[2])
    end
    return result
end

function calback_removeDrug(name)
    local result = lib.callback.await('l-drugs:removeDrug', false, name)
    if result == nil and result[2] ~= nil then
        error("Failed to remove drug: " .. result[2])
    end
    return result
end

function callback_getPlayerTolerance(drugId)
    local result = lib.callback.await('l-drugs:getPlayerTolerance', false, drugId)
    if result == nil and result[2] ~= nil then
        error("Failed to get player tolerance: " .. result[2])
    end
    return result
end