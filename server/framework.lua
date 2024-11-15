function framework_getPlayerIdentifier(source)
    xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getIdentifier()
end