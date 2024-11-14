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
