local function mergeDrugData(defaultData, customData)
    for k, v in pairs(customData) do
        if type(v) == "table" and type(defaultData[k]) == "table" then
            mergeDrugData(defaultData[k], v) -- Recursively merge nested tables
        else
            defaultData[k] = v -- Override default value
        end
    end
    return defaultData
end

Drug = {
    start = function(drugName, customData)

        -- DrugData for now is a global variable that contains all the drug data later it will be saved in database
        
        -- Fetch default drug data
        local defaultData = DrugData[drugName]
        if not defaultData then
            print("Invalid drug name:", drugName)
            return
        end

        -- Merge default and custom data
        local drugData = mergeDrugData(defaultData, customData or {})

        -- Retrieve player tolerance
        local playerTolerance = callback_getPlayerTolerance(drugName)
        local maxDuration = math.max(0, drugData.max_duration - playerTolerance * 1000)

        -- Start each effect
        for _, effectInfo in ipairs(drugData.effect_type) do
            local effectName = effectInfo.name
            local delay = effectInfo.delay or 0
            local effect = Effects[effectName]

            if effect then
                -- Merge default effect params with custom params
                local params = drugData.default_effect_params[effectName] or {}
                params.intensity = math.max(0, (params.intensity or 1) - playerTolerance * 0.01)

                -- Start effect after specified delay
                lib.timer(delay, function()
                    effect:start(params)

                    -- Stop effect after maxDuration
                    lib.timer(maxDuration, function()
                        effect:stop(params)
                    end, true)
                end, true)
            else
                print("Effect not found:", effectName)
            end
        end
    end
}
