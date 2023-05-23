local table_function = require("init")


-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    return dofile(filename)
end


-- inizializza il gioco
local function initializeGame(configContent)

    -- inizializza la scacchiera
    local board = table_function.inizialize(configContent.N)

    -- inserisci i simboli nella scacchiera
    local newBoard = table_function.insert(configContent.D, board)

    -- stampa la scacchiera
    table_function.print(newBoard, configContent.N)

    return newBoard, configContent
end

local F = {
    readConfigFromFile = readConfigFromFile,
    initializeGame = initializeGame
}

return F