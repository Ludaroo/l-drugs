function sql_AutoInsert()
    local query2 = [[
CREATE TABLE IF NOT EXISTS `drugs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `effect_type` VARCHAR(50) NOT NULL,
    `default_effect_params` JSON,
    `max_duration` INT DEFAULT 60000,
    `default_value` FLOAT DEFAULT 0
);
    ]]
    local query1 = [[
   CREATE TABLE IF NOT EXISTS `player_tolerances` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(50) NOT NULL,
    `drug_id` INT NOT NULL,
    `tolerance_level` FLOAT DEFAULT 0,
    `last_used` DATETIME,
    FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
);
    ]]


    local query3 = [[
        CREATE TABLE IF NOT EXISTS `player_drugs` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `identifier` VARCHAR(50) NOT NULL,
            `drug_id` INT NOT NULL,
            `timer` INT DEFAULT 0,
            FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
        );
    ]]
    
    MySQL.query(query2)
    MySQL.query(query1)
    MySQL.query(query3)
    return true
end

function doesSQLTablesExist(callback)
    local query = [[
        SELECT COUNT(*) as count 
        FROM information_schema.tables 
        WHERE table_name IN ('drugs', 'player_tolerances', 'player_drugs');
    ]]
    MySQL.query(query, {}, function(result)
        if result and result[1] and result[1].count and tonumber(result[1].count) == 2 then
            callback(true)
        else
            callback(false)
        end
    end)
end

MySQL.ready(function()
    doesSQLTablesExist(function(exist)
        if exist then
            print("^2SQL setup complete. (The necessary database tables already exist)^0")
        else
            local success, err = pcall(sql_AutoInsert)
            if success then
                print("^2Database tables have been created successfully.^0")
            else
                print("^1Failed to set up the database tables. Please check the error below:^0")
                print("^1Error: " .. err .. "^0")
            end
        end
    end)
end)
