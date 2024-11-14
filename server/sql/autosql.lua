
-- This file contains all the sql functions that are used in the server side of the script

-- gets all drugs from the database
-- @return boolean - true if the query was successful
function sql_AutoInsert()
    local query = [[
   CREATE TABLE IF NOT EXISTS `player_tolerances` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` VARCHAR(50) NOT NULL,
    `drug_id` INT NOT NULL,
    `tolerance_level` FLOAT DEFAULT 0,
    `last_used` DATETIME,
    FOREIGN KEY (`drug_id`) REFERENCES `drugs`(`id`) ON DELETE CASCADE
);

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
    MySQL.Sync.execute(query, {})
    return true
end

MySQL.ready(function()
    sql_AutoInsert()
end)