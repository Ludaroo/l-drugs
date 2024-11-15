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