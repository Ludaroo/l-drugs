-- uishown = false
-- RegisterCommand("showIndex", function(source, args, rawcommand)
--     SetNuiFocus(not uishown, uishown)
--     SetNuiFocusKeepInput(not uishown)
--     SendNUIMessage({
--         type = "index",
--     })
-- end)

-- RegisterCommand("SwitchSites", function(source, args, rawcommand)
--     SendNUIMessage({
--         switch = true,
--     })
-- end)

function ui_ToggleUI()
    SetNuiFocus(not uishown, uishown)
    SetNuiFocusKeepInput(not uishown)
    uishown = not uishown
    SendNUIMessage({
        type = "index",
    })
end

RegisterNUICallback('ToggleUI', function(data, cb)
    -- Toggle the UI visibility
    ui_ToggleUI()
    
    -- Acknowledge the callback without returning any data
    cb(nil)
end)

RegisterNUICallback('getDrugs', function(data, cb)
    cb(json.encode(callback_getDrugs()))
end)

RegisterNUICallback('addDrug', function(data, cb)
    cb(json.encode(callback_AddDrug(data.name, data.description, data.effect_type, data.default_effect_params, data.max_duration, data.default_value)))
end)

RegisterNUICallback('removeDrug', function(data, cb)
    cb(json.encode(calback_removeDrug(data.name)))
end)

RegisterNUICallback('getPlayerTolerance', function(data, cb)
    cb(json.encode(callback_getPlayerTolerance(data.drugId)))
end)

RegisterNUICallback('getPlayerToleranceAll', function(data, cb)
    cb(json.encode(callback_getPlayerToleranceAll()))
end)

RegisterNUICallback('updatePlayerTolerance', function(data, cb)
    cb(json.encode(callback_updatePlayerTolerance(data.drugId, data.tolerance)))
end)

RegisterNUICallback('getEffects', function(data, cb)
    EffectsTable = {}
    for k,v in pairs(Effects) do
        EffectsTable[k] = {
            name = v.name,
            description = v.description,
            ticktime = v.ticktime,
        }
    end
    cb(json.encode(EffectsTable))
end)

