function effects_callback_getEffects()
    return lib.callback.await("l-drugs:getEffects", false)
end