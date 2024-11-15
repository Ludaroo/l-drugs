Effects['speed'] = {
    ticktime = 1000,
    description = locale('speed_description'),
    customticktime = 10, -- applies on customtick
    apply = function(self, params)
        -- Code to apply the 'drugged' effect
    end,

    remove = function(self, params)
        -- Code to remove the 'drugged' effect
    end,

    ontick = function(self, params)
        -- Code to execute on each tick for 'drugged'
    end,

    customtick = function(self, params)
        -- Code to execute on each custom tick for 'drugged'
    end,

    start = function(self, params)
        EffectTimers:startTimers(self, params)
    end,

    stop = function(self, params)
        EffectTimers:stopTimers(self, params)
    end
},
}

