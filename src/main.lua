local sempai_function = require("sempai")
local table_function = require("init")
local utility_function = require("utility")
local file_function = require ("file")



--Funzione che fa muovere i sempai
local function moveSempai (b, count)
    --Ottieni le posizioni dei sempai
    local position_sempai = sempai_function.searchSempai(b)

    -- Ottieni le direzioni generate dalla funzione playGong
    local gongDirections = utility_function.playGong(b)



    -- Crea una nuova scacchiera con i sempai mossi nella direzione corrispondente
    local newBoard = table_function.clone(b) -- Copia la scacchiera

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
    table_function.print(newBoard, #b)

    if count < 4 then
        -- Richiama ricorsivamente la funzione per il prossimo movimento
        moveSempai(newBoard, count + 1)
    end
end


local function playGame()
    local configContent =file_function.readConfigFromFile("config.lua")
    local board, config = file_function.initializeGame(configContent)

    -- Stampa la configurazione iniziale
    table_function.print(board, config.N)

    -- Avvia il movimento dei sempai
    moveSempai(board, 1)

end

playGame()









