-- ESX = exports["es_extended"]:getSharedObject()


-- for drug_name, drugConfig in pairs(config.drugs) do
--     ESX.RegisterUsableItem(drug_name, function(playerId)
--     local xPlayer = ESX.GetPlayerFromId(playerId)
--     xPlayer.removeInventoryItem(drugName, 1)
    
--     TriggerClientEvent("l-drugs:useDrug", playerId, drugName)
--     end)
-- end