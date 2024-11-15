EffectTimers = {}

function EffectTimers:startTimers(effect, params)
    if effect.apply and not effect.applyTimer then
        effect.applyTimer = lib.timer(effect.ticktime, function()
            effect:apply(params)
        end, true)
    end

    if effect.ontick and not effect.ontickTimer then
        effect.ontickTimer = lib.timer(effect.ticktime, function()
            effect:ontick(params)
        end, true)
    end

    if effect.customtick and not effect.customtickTimer then
        effect.customtickTimer = lib.timer(effect.customticktime, function()
            effect:customtick(params)
        end, true)
    end
end

function EffectTimers:stopTimers(effect, params)
    if effect.applyTimer then
        effect.applyTimer:forceEnd(false)
        effect.applyTimer = nil
    end

    if effect.ontickTimer then
        effect.ontickTimer:forceEnd(false)
        effect.ontickTimer = nil
    end

    if effect.customtickTimer then
        effect.customtickTimer:forceEnd(false)
        effect.customtickTimer = nil
    end

    if effect.remove then
        effect:remove(params)
    end
end
