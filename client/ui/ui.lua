uishown = false
RegisterCommand("showIndex", function(source, args, rawcommand)
    SetNuiFocus(not uishown, uishown)
    SetNuiFocusKeepInput(not uishown)
    SendNUIMessage({
        type = "index",
    })
end)

RegisterCommand("SwitchSites", function(source, args, rawcommand)
    SendNUIMessage({
        switch = true,
    })
end)

RegisterNUICallback('ToggleUI', function(data, cb)
    -- Toggle the UI visibility

    
    -- Acknowledge the callback without returning any data
    cb(nil)
end)

RegisterNUICallback('getDrugs', function(data, cb)
    cb(json.encode(Drugs))
end)