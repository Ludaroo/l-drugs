-- example data from database
DrugData = {
    marijuana = {
        name = "marijuana",
        effect_type = {
            { name = "speed", delay = 0 },         -- Starts immediately
            { name = "drugged", delay = 20000 }   -- Starts after 20 seconds
        },
        default_effect_params = {
            speed = { intensity = 0.2, duration = 10000 },
            drugged = { intensity = 0.5, duration = 15000 }
        },
        max_duration = 60000, -- Default max duration (60 seconds)
        default_value = 50    -- Default tolerance value
    }
}

-- Custom overrides for drug data
local customParams = {
    max_duration = 45000, -- Override max duration to 45 seconds
    default_effect_params = {
        speed = { intensity = 0.3 },
        drugged = { duration = 20000 }
    }
}

-- -- Start the drug with custom overrides
-- Drug.start("marijuana", customParams)
