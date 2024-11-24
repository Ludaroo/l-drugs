-- File: shared/effects/drugged.lua

local drugged = {
    client = {
        name = 'drugged',
        label = locale("drugged")
        description = locale('drugged_description'),
        defaultTick = {
            interval = 1000,  -- Default tick interval in milliseconds
            start = function(self, params)
                -- Code to execute when the default tick starts
                print("Client-side default tick started for 'drugged' effect.")
            end,
            stop = function(self, params)
                -- Code to execute when the default tick stops
                print("Client-side default tick stopped for 'drugged' effect.")
            end,
            action = function(self, params)
                -- Code to execute on each default tick
            end
        },
        customTicks = {
            -- Define custom tick functions with their intervals
            customTick1 = {
                interval = 500,  -- Interval in milliseconds
                start = function(self, params)
                    -- Code to execute when customTick1 starts
                end,
                stop = function(self, params)
                    -- Code to execute when customTick1 stops
                end,
                action = function(self, params)
                    -- Code to execute on each customTick1
                end
            },
            customTick2 = {
                interval = 2000,  -- Interval in milliseconds
                start = function(self, params)
                    -- Code to execute when customTick2 starts
                end,
                stop = function(self, params)
                    -- Code to execute when customTick2 stops
                end,
                action = function(self, params)
                    -- Code to execute on each customTick2
                end
            }
            -- Add more custom ticks as needed
        },
        apply = function(self, params)
            -- Code to apply the 'drugged' effect
        end,
        remove = function(self, params)
            -- Code to remove the 'drugged' effect
        end,
        start = function(self, params)
          
        end,
        stop = function(self, params)
            -- Stop default tick timer
            if self.defaultTick and self.defaultTick.stop then
                self.defaultTick:stop(params)
            end
            -- Stop custom tick timers
            if self.customTicks then

            end
            print("Client-side 'drugged' effect stopped.")
        end
    },
    server = {
        name = 'drugged',
        description = locale('drugged_description'),
        defaultTick = {
            interval = 1000,  -- Default tick interval in milliseconds
            start = function(self, params)
                -- Code to execute when the default tick starts
                print("Server-side default tick started for 'drugged' effect.")
            end,
            stop = function(self, params)
                -- Code to execute when the default tick stops
                print("Server-side default tick stopped for 'drugged' effect.")
            end,
            action = function(self, params)
                -- Code to execute on each default tick
                print("Server-side default tick action for 'drugged' effect.")
            end
        },
        customTicks = {
            -- Define custom tick functions with their intervals
            customTick1 = {
                interval = 500,  -- Interval in milliseconds
                start = function(self, params)
                    -- Code to execute when customTick1 starts
                end,
                stop = function(self, params)
                    -- Code to execute when customTick1 stops
                end,
                action = function(self, params)
                    -- Code to execute on each customTick1
                end
            },
            customTick2 = {
                interval = 2000,  -- Interval in milliseconds
                start = function(self, params)
                    -- Code to execute when customTick2 starts
                end,
                stop = function(self, params)
                    -- Code to execute when customTick2 stops
                end,
                action = function(self, params)
                    -- Code to execute on each customTick2
                end
            }
            -- Add more custom ticks as needed
        },
        apply = function(self, params)
            -- Code to apply the 'drugged' effect
        end,
        remove = function(self, params)
            -- Code to remove the 'drugged' effect
        end,
        start = function(self, params)
            
        end,
        stop = function(self, params)
         
        end
    }
}

return drugged
