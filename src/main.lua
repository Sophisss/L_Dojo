local table_function = require("init")
local file_function = require ("file")
local start_function = require("startGame")


local function playGame()
    local configContent =file_function.readConfigFromFile("config.lua")
    local board, config = file_function.initializeGame(configContent)

    -- Stampa la configurazione iniziale
    table_function.print(board, config.N)

    -- Avvia il movimento dei sempai
    start_function.moveSempai(board, 1, config.N)

end

playGame()









