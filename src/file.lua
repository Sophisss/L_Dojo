local table_function = require("init")


-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    local file = io.open(filename, "r")
    local content = file:read("*all")
    file:close()

    return content
end


local function initializeGame(configContent)
    local config = load(configContent)()

    -- inizializzazione della scacchiera
    local board = table_function.inizialize(config.N)

    -- Popolamento della scacchiera con i simboli e assegnazione delle coordinate ai sempai
    local newBoard = table_function.insert(config.D, board)

    table_function.print(newBoard, config.N)

    return newBoard, config
end

local F = {
    readConfigFromFile = readConfigFromFile,
    initializeGame = initializeGame
}

return F