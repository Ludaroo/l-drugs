function framework_getPlayerIdentifier(source)
    xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getIdentifier()
end

function framework_getPlayers()
    local players = ESX.GetExtendedPlayers()
    return players
end