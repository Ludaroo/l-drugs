
-- Get all drugs from the database
-- @return table - a table containing all the drugs
function sql_getDrugs()
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs', {})
    return init_handlePromise(promise):next(function(drugs, err)
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

-- Get the drug id by name
-- @param name - the name of the drug
-- @return int - the id of the drug
function sql_getdrugIdByName(name)
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return init_handlePromise(promise):next(function(drug)
        if drug[1] then
            return drug[1].id
        else
            return false
        end
    end)
end

-- Add a new drug to the database
-- @param  string name - the name of the drug
-- @param string description - the description of the drug
-- @param json effect_type - the effect type of the drug
-- @param json default_effect_params - the default effect parameters of the drug
-- @param int max_duration - the maximum duration of the drug
-- @param int default_value - the default value of the drug
-- @return boolean - true if the query was successful
function sql_addDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
    local promise = MySQL.Async.execute('INSERT INTO drugs (name, description, effect_type, default_effect_params, max_duration, default_value) VALUES (@name, @description, @effect_type, @default_effect_params, @max_duration, @default_value)', {
        ['@name'] = name,
        ['@description'] = description,
        ['@effect_type'] = effect_type,
        ['@default_effect_params'] = json.encode(default_effect_params),
        ['@max_duration'] = max_duration,
        ['@default_value'] = default_value
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true, nil
    end)
end

-- Remove a drug from the database
-- @param string name - the name of the drug
-- @return boolean - true if the query was successful
function sql_removeDrug(name)
    local promise = MySQL.Async.execute('DELETE FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return init_handlePromise(promise):next(function(_, err)
        if err then return nil, err end
        return true, nil
    end)
end

-- Edit a drug in the database
-- @param string name - the name of the drug
-- @param string description - the description of the drug
-- @param json effect_type - the effect type of the drug
-- @param json default_effect_params - the default effect parameters of the drug
-- @param int max_duration - the maximum duration of the drug
-- @param int default_value - the default value of the drug
-- @return boolean - true if the query was successful
function sql_editDrug(name, description, effect_type, default_effect_params, max_duration, default_value)
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return init_handlePromise(promise):next(function(currentDrug, err)
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
                return init_handlePromise(updatePromise):next(function(_, err)
                    if err then return nil, err end
                    return true, nil
                end)
            end
        end
        return true, nil
    end)
end



-- Get the drug data by name
-- @param string name - the name of the drug
-- @return table - a table containing the drug data
function sql_drug_get_data(name)

    if type(name) == "number" then 
        name = sql_getdrugNameById(name)
    end
    local promise = MySQL.Async.fetchAll('SELECT * FROM drugs WHERE name = @name', {
        ['@name'] = name
    })
    return init_handlePromise(promise):next(function(drug, err)
        if err then return nil, err end
        if drug[1] then
            return {
                id = drug[1].id,
                name = drug[1].name,
                description = drug[1].description,
                effect_type = drug[1].effect_type,
                default_effect_params = json.decode(drug[1].default_effect_params),
                max_duration = drug[1].max_duration,
                default_value = drug[1].default_value
            }
        else
            return false
        end
    end)
end