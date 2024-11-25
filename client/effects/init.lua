effects = {}
local lastUpdateTime = 0
local refreshInterval = 5000 -- 5 seconds in milliseconds

function effects_init_getEffects()
    if GetGameTimer() - lastUpdateTime > refreshInterval then
        effects = effects_callback_getEffects()
        lastUpdateTime = GetGameTimer()
    end
    if next(effects) == nil then
        effects_init_getEffects()
    end
    return effects
end

effects_init_refreshEffects = effects_init_getEffects


effects_init_getEffects()

