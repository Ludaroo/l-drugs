
function sql_getDrugs(    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs', {})
    return handlePromise(promise):next(function(drugs, err)
        if err then return nil, err end
        local drugList = {}
        for i = 1, #drugs do
            local drug = drugs[i]
            drugList[drug.name] = {
                id = drug.id,
                name = drug.name,
                description = drug.description,
                effect_type = drug.effect_type,
                default_effect_params = json.decode(drug.default_effect_params),
                max_duration = drug.max_duration,
                default_value = drug.default_value
            }
        end
        return drugList
    end)
end

function sql_getdrugIdByName(name)
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return handlePromise(promise):next(function(drug)
        if drug[1] then
            return drug[1].id
        else
            return false
        end
    end)
end

function sql_addDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
    local promise = MySQL.Async.execute('INSERT INTO drugs (name, description, effect_type, default_effect_params, max_duration, default_value) VALUES (@name, @description, @effect_type, @default_effect_params, @max_duration, @default_value)', {
        ['@name'] = name,
        ['@description'] = description,
        ['@effect_type'] = effect_type,
        ['@default_effect_params'] = json.encode(default_effect_params),
        ['@max_duration'] = max_duration,
        ['@default_value'] = default_value
    })
    return handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true, nil
    end)
end

function sql_removeDrug(name)
    local promise = MySQL.Async.execute('DELETE FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true, nil
    end)
end

function sql_editDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return handlePromise(promise):next(function(currentDrug, err)
        if err then return nil, err end
        if currentDrug[1] then
            local drug = currentDrug[1]
            local hasChanged = false

            if drug.description ~= description then
                hasChanged = true
            elseif drug.effect_type ~= effect_type then
                hasChanged = true
            elseif drug.default_effect_params ~= json.encode(default_effect_params) then
                hasChanged = true
            elseif drug.max_duration ~= max_duration then
                hasChanged = true
            elseif drug.default_value ~= default_value then
                hasChanged = true
            end

            if hasChanged then
                local updatePromise = MySQL.Async.execute('UPDATE drugs SET description = @description, effect_type = @effect_type, default_effect_params = @default_effect_params, max_duration = @max_duration, default_value = @default_value WHERE name = @name', {
                    ['@name'] = name,
                    ['@description'] = description,
                    ['@effect_type'] = effect_type,
                    ['@default_effect_params'] = json.encode(default_effect_params),
                    ['@max_duration'] = max_duration,
                    ['@default_value'] = default_value
                })
                return handlePromise(updatePromise):next(function(_, err)
                    if err then return nil, err end
                    return true, nil
                end)
            end
        end
        return true, nil
    end)
end