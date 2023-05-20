local sempai_function = require("sempai")
local utility_function = require("utility")
local table_function = require("init")
local war_function = require("war")

--Funzione che fa muovere i sempai
local function moveSempai (b, count, N)

    -- Crea una nuova scacchiera con i sempai mossi nella direzione corrispondente
    local newBoard = table_function.clone(b) -- Copia la scacchiera

    local num = utility_function.countObjects(newBoard)

    if num > 0 then

        --Ottieni le posizioni dei sempai
        local position_sempai = sempai_function.searchSempai(b)

        -- Ottieni le direzioni generate dalla funzione playGong
        local gongDirections = utility_function.playGong(b)


        for i, direction in ipairs(gongDirections) do
            local newSempai = table_function.clone(position_sempai[i])
            local sempai = newSempai
            local sempaiX, sempaiY = sempai.posizione.x, sempai.posizione.y -- Ottieni le coordinate del sempai

            -- Sposta ciascun sempai nella direzione determinata
            if direction == "Nord" then
                newBoard, newSempai = sempai_function.moveNord(newBoard, sempaiX, sempaiY)
            elseif direction == "Sud" then
                newBoard, newSempai = sempai_function.moveSud(newBoard, sempaiX, sempaiY)
            elseif direction == "Est" then
                newBoard, newSempai = sempai_function.moveEst(newBoard, sempaiX, sempaiY)
            elseif direction == "Ovest" then
                newBoard, newSempai = sempai_function.moveOvest(newBoard, sempaiX, sempaiY)
            end

            newBoard = war_function.comparison(newBoard, newSempai, N)

        end

        -- Stampa la nuova configurazione della scacchiera nel file
        table_function.print(newBoard, #b)
        moveSempai(newBoard, count + 1, N)

    else

        print("Programma terminato")
    end
end


local START = {
    moveSempai = moveSempai
}

return START