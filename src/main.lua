local sempai_function = require("sempai")
local table_function = require("init")
local utility_function = require("utility")

-- leggi la configurazione dal file
local file = io.open("config.lua", "r")
local content = file:read("*all")
file:close()

-- converte la stringa letta dal file in una tabella Lua -- rivedi
local config = load(content)()

-- inizializzazione della scacchiera
local board = table_function.inizialize(config.N)

-- Popolamento della scacchiera con i simboli e assegnazione delle coordinate ai sempai
table_function.insert(config.D, board)

-- Stampa la configurazione iniziale
table_function.print(board, config.N)


--Funzione che fa muovere i sempai
local function moveSempai (board, count)
    --Ottieni le posizioni dei sempai
    local position_sempai = sempai_function.searchSempai(board)

    -- Ottieni le direzioni generate dalla funzione playGong
    local gongDirections = utility_function.playGong(board)


    -- Crea una nuova scacchiera con i sempai mossi nella direzione corrispondente
    local newBoard = board

    for i, direction in ipairs(gongDirections) do
        local sempaiX, sempaiY = table.unpack(position_sempai[i]) -- Ottieni le coordinate del sempai

        -- Sposta ciascun sempai nella direzione determinata
        if direction == "Nord" then
            newBoard, _ = sempai_function.moveNord(newBoard, sempaiX, sempaiY)
        elseif direction == "Sud" then
            newBoard,_ = sempai_function.moveSud(newBoard, sempaiX, sempaiY)
        elseif direction == "Est" then
            newBoard, _ = sempai_function.moveEst(newBoard, sempaiX, sempaiY)
        elseif direction == "Ovest" then
            newBoard,_ = sempai_function.moveOvest(newBoard, sempaiX, sempaiY)
        end
    end

    -- Stampa la nuova configurazione della scacchiera nel file
    table_function.print(newBoard, config.N)

    if count < 4 then
        -- Richiama ricorsivamente la funzione per il prossimo movimento
        moveSempai(newBoard, count + 1)
    end
end


-- Avvia il movimento dei sempai
moveSempai(board, 1)







