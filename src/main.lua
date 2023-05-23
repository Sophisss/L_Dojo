local file_function = require("file")
local start_function = require("startGame")

local function playGame()
    local configContent = file_function.readConfigFromFile("config.lua")
    local board, config = file_function.initializeGame(configContent)

    start_function.moveSempai(board, config.N)


end

playGame()









