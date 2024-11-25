local resourceName = GetCurrentResourceName()
local resourcePath = GetResourcePath(resourceName)

local function getLuaFiles(folder)
    local luaFiles = {}
    local path = resourcePath .. "/" .. folder
    local p = io.popen('ls "' .. path .. '"') -- Unix-based systems

    if p then
        for file in p:lines() do
            if file:match("%.lua$") then
                local name = file:gsub("%.lua$", "")
                table.insert(luaFiles, name)
            end
        end
        p:close()
    end

    return luaFiles
end

function effects_getEffects()
    local effects = {}
    local files = getLuaFiles("shared/effects")
    for _, file in ipairs(files) do
        local effectPath = "shared/effects/" .. file
        local effect = lib.load(effectPath)
        table.insert(effects, effect)
    end
    return effects
end

function effects_validateEffects()
    local effects = effects_getEffects()  -- Fetch all effects
    local errors = {}  -- Store validation errors

    for _, effect in ipairs(effects) do
        -- Ensure the effect is a valid table
        if type(effect) ~= "table" then
            table.insert(errors, "An effect did not return a valid table.")
        else
            -- Validate both client and server tables
            for key, module in pairs({client = effect.client, server = effect.server}) do
                if type(module) ~= "table" then
                    table.insert(errors, ("Effect is missing a valid '%s' table."):format(key))
                else
                    -- Validate required fields and structures
                    if not module.name or type(module.name) ~= "string" then
                        table.insert(errors, ("Effect '%s' is missing a valid 'name' property."):format(key))
                    end
                    if not module.description or type(module.description) ~= "string" then
                        table.insert(errors, ("Effect '%s' is missing a valid 'description' property."):format(key))
                    end

                    -- Validate defaultTick structure
                    if module.defaultTick then
                        if type(module.defaultTick.interval) ~= "number" then
                            table.insert(errors, ("Effect '%s' defaultTick is missing a valid 'interval' property."):format(key))
                        end
                        for _, tickMethod in ipairs({"start", "stop", "action"}) do
                            if type(module.defaultTick[tickMethod]) ~= "function" then
                                table.insert(errors, ("Effect '%s' defaultTick is missing a valid '%s' method."):format(key, tickMethod))
                            end
                        end
                    else
                        table.insert(errors, ("Effect '%s' is missing a 'defaultTick' definition."):format(key))
                    end

                    -- Validate customTicks structure
                    if module.customTicks then
                        for tickName, tickData in pairs(module.customTicks) do
                            if type(tickData.interval) ~= "number" then
                                table.insert(errors, ("Effect '%s' customTick '%s' is missing a valid 'interval' property."):format(key, tickName))
                            end
                            for _, tickMethod in ipairs({"start", "stop", "action"}) do
                                if type(tickData[tickMethod]) ~= "function" then
                                    table.insert(errors, ("Effect '%s' customTick '%s' is missing a valid '%s' method."):format(key, tickName, tickMethod))
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Print validation results
    if #errors == 0 then
        print("^2All effects validated successfully.^0")
    else
        print("^1Validation failed for the following effects:^0")
        for _, errorMsg in ipairs(errors) do
            print("^1" .. errorMsg .. "^0")
        end
    end
end

-- Call the function to validate all effects
effects_validateEffects()

-- TODO: add system to let client call to server instead of client getting the call for performance

-- TODO: add system to add effects from different resources if needed,
-- for example, if you have a resource that adds a new effect, you can add it to the effects table here. (maybe export?)

-- INIT

effects = {}
function effects_init_getEffects(refresh)
    if refresh or next(effects) == nil then
        effects = effects_getEffects()
    end
    return effects
end

effects_init_refreshEffects = effects_init_getEffects(true)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        effects_init_getEffects()
        effects_startTimers(framework_getPlayers())
    end
  end)
  