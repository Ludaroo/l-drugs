-- File: shared/effects/drugged.lua

local drugged = {
    client = {
        name = 'drugged',
        label = locale("drugged"),
        description = locale('drugged_description'),
        defaultTick = {
            interval = 1000,  -- Interval in milliseconds
            start = function(self, params)
                print("Client-side default tick started for 'drugged' effect.")
                -- Additional start logic here
            end,
            stop = function(self, params)
                print("Client-side default tick stopped for 'drugged' effect.")
                -- Additional stop logic here
            end,
            action = function(self, params)
                -- Code to execute on each default tick
                -- For example, apply visual effects or modify player stats
            end
        },
        customTicks = {
            -- Define custom tick functions with their intervals
            hallucination = {
                interval = 5000,  -- Interval in milliseconds
                start = function(self, params)
                    print("Client-side hallucination effect started.")
                    -- Start hallucination visuals
                end,
                stop = function(self, params)
                    print("Client-side hallucination effect stopped.")
                    -- Stop hallucination visuals
                end,
                action = function(self, params)
                    -- Code to execute on each hallucination tick
                    -- For example, randomize screen effects
                end
            }
            -- Add more custom ticks as needed
        },
        negativeEffects = {
            schizophrenia = {
                interval = 1000,  -- Interval in milliseconds
                duration = 30000, -- Duration in milliseconds
                start = function(self, params)
                    print("Client-side schizophrenia effect started.")
                    -- Start schizophrenia visuals
                end,
                stop = function(self, params)
                    print("Client-side schizophrenia effect stopped.")
                    -- Stop schizophrenia visuals
                end,
                action = function(self, params)
                    -- Code to execute on each schizophrenia tick
                    -- For example, apply random audio cues
                end
            }
            -- Add more negative effects as needed
        },
        apply = function(self, params)
            print("Applying client-side 'drugged' effect.")
            -- Apply the effect (e.g., modify player stats)
        end,
        remove = function(self, params)
            print("Removing client-side 'drugged' effect.")
            -- Remove the effect (e.g., reset player stats)
        end,
        start = function(self, params)
            print("Starting client-side 'drugged' effect.")
            -- Initialize effect (e.g., start timers)
        end,
        stop = function(self, params)
            print("Stopping client-side 'drugged' effect.")
            -- Clean up effect (e.g., stop timers)
        end
    },
    server = {
        name = 'drugged',
        description = locale('drugged_description'),
        toleranceIncrease = 0.02,  -- Tolerance increase per tick
        defaultTick = {
            interval = 1000,  -- Interval in milliseconds
            start = function(self, params)
                print("Server-side default tick started for 'drugged' effect.")
                -- Additional start logic here
            end,
            stop = function(self, params)
                print("Server-side default tick stopped for 'drugged' effect.")
                -- Additional stop logic here
            end,
            action = function(self, params)
                print(("Server-side default tick action for 'drugged' effect. Source: %d, Tolerance: %.2f"):format(params.source, params.tolerance))
                -- Code to execute on each default tick
                -- For example, increase player tolerance
            end
        },
        customTicks = {
            -- Define custom tick functions with their intervals
            addiction = {
                interval = 60000,  -- Interval in milliseconds
                start = function(self, params)
                    print("Server-side addiction effect started.")
                    -- Start addiction tracking
                end,
                stop = function(self, params)
                    print("Server-side addiction effect stopped.")
                    -- Stop addiction tracking
                end,
                action = function(self, params)
                    -- Code to execute on each addiction tick
                    -- For example, increase addiction level
                end
            }
            -- Add more custom ticks as needed
        },
        negativeEffects = {
            overdose = {
                interval = 1000,  -- Interval in milliseconds
                duration = 60000, -- Duration in milliseconds
                start = function(self, params)
                    print("Server-side overdose effect started.")
                    -- Start overdose handling
                end,
                stop = function(self, params)
                    print("Server-side overdose effect stopped.")
                    -- Stop overdose handling
                end,
                action = function(self, params)
                    -- Code to execute on each overdose tick
                    -- For example, apply health damage
                end
            }
            -- Add more negative effects as needed
        },
        apply = function(self, params)
            print("Applying server-side 'drugged' effect.")
            -- Apply the effect (e.g., log usage, modify stats)
        end,
        remove = function(self, params)
            print("Removing server-side 'drugged' effect.")
            -- Remove the effect (e.g., reset stats, clear logs)
        end,
        start = function(self, params)
            print("Starting server-side 'drugged' effect.")
            -- Initialize effect (e.g., start timers)
        end,
        stop = function(self, params)
            print("Stopping server-side 'drugged' effect.")
            -- Clean up effect (e.g., stop timers)
        end
    }
}

return drugged
