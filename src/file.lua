local table_function = require("init")

local F = {}


-- leggi la configurazione dal file
function F.readConfigFromFile(filename)
    local file = io.open(filename, "r")
    local content = file:read("*all")
    file:close()

    return content
end


function F. initializeGame(configContent)
    local config = load(configContent)()

    -- inizializzazione della scacchiera
    local board = table_function.inizialize(config.N)

    -- Popolamento della scacchiera con i simboli e assegnazione delle coordinate ai sempai
    table_function.insert(config.D, board)

    return board, config
end



return F