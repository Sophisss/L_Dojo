local init_function = require("initGame.init")
local file_function = require ("file.file")
local start_function = require("startGame.start")

local function playGame()
    local configContent = file_function.readConfigFromFile("config.lua")
    local board = init_function.initializeGame(configContent)

    local success, winner = pcall(start_function.startGame, board)

    if success and winner then
        -- La partita è stata completata con successo
        return "Partita completata!"
    else
        -- Si è verificato un errore o la partita non è stata completata
        return "Si è verificato un errore durante la partita."
    end
end

print(playGame())










