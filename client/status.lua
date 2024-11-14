
-- local activeEffects = {}


-- function addeffects(drug)
--     for _, effect in pairs(config.drugs[drug].effects) do
--         if effect.type == "speed" then
--             SetRunSprintMultiplierForPlayer(PlayerId(), effect.value)
--         end
--     end

--     if config.drugs[drug].onEffect then
--         config.drugs[drug].onEffect()
--     end
-- end


-- function removeeffects(drug)
--     if config.drugs[drug] then
--         if config.drugs[drug].effect then
--             for _, effect in pairs(config.drugs[drug].effects) do
--                 if effect.type == "speed" then
--                     SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
--                 end
--             end
--         end
--     end
-- end

-- RegisterNetEvent("l-drugs:useDrug")
-- AddEventHandler("l-drugs:useDrug", function(drug)
--     if config.drugs[drug] then
--         addeffects(drug)
--         table.insert(activeEffects, {drug = drug, endTime = GetGameTimer() + config.drugs[drug].duaration})
--     end
-- end)

-- CreateThread(function()
--     while true do
--         local time = GetGameTimer()

--         for i = #activeEffects, 1, -1 do
--             local effect = activeEffects[i]

--             if time >= effect.endTime then
--                 removeeffects(effect.drug)
--                 table.remove(activeEffects, i)
--             end
--         end

--         Wait(config.tick)
--     end
-- end)


