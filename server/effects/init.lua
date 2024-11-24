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
    local effects = effects_getEffects()
    local errors = {}

    for _, effect in ipairs(effects) do
        
        if type(effect) ~= "table" then
            table.insert(errors, "An effect did not return a valid table.")
        else
          
            for key, module in pairs({client = effect.client, server = effect.server}) do
                if type(module) ~= "table" then
                    table.insert(errors, ("Effect is missing a valid '%s' table."):format(key))
                else
                   
                    local requiredMethods = {"apply", "remove", "ontick", "customtick", "start", "stop"}
                    for _, method in ipairs(requiredMethods) do
                        if type(module[method]) ~= "function" then
                            table.insert(errors, ("Effect is missing '%s.%s' function."):format(key, method))
                        end
                    end
                end
            end
        end
    end
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




