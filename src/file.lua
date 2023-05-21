local table_function = require("init")


-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    return dofile(filename)
end



-- inizializza la scacchiera
local function initializeBoard(N)
    return table_function.inizialize(N)
end


-- stampa la scacchiera
local function printBoard(board, N)
    table_function.print(board, N)
end


-- inserisci i simboli nella scacchiera
local function insertSymbols(D, board)
    return table_function.insert(D, board)
end


-- inizializza il gioco
local function initializeGame(configContent)

    local board = initializeBoard(configContent.N)
    local newBoard = insertSymbols(configContent.D, board)

    printBoard(newBoard, configContent.N)

    return newBoard, configContent
end


local F = {
    readConfigFromFile = readConfigFromFile,
    initializeGame = initializeGame
}

return F