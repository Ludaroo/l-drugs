function handlePromise(promise)
    return promise:next(function(result)
        return result
    end, function(err)
        print("SQL Error: " .. err)
        return nil, err
    end)
end