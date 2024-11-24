effects  = {}
function effects_init_getEffects()
    effects = effects_callback_getEffects()
end

effects_init_refreshEffects = effects_init_getEffects

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        effects_init_getEffects()
    end
  end)
  