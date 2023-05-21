local table_function = require("init")


-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    local file = io.open(filename, "r")
    local content = file:read("*all")
    file:close()

    return content
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
    local config = load(configContent)()

    local board = initializeBoard(config.N)
    local newBoard = insertSymbols(config.D, board)

    printBoard(newBoard, config.N)

    return newBoard, config
end


local F = {
    readConfigFromFile = readConfigFromFile,
    initializeGame = initializeGame
}

return F