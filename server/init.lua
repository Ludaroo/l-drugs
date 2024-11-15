

if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end

lib.locale()

SetConvar("setr ox:locale", Config.Locale)

function init_handlePromise(promise)
    return promise:next(function(result)
        return result
    end, function(err)
        print("SQL Error: " .. err)
        return nil, err
    end)
end