local sempai_function = require("sempai")
local utility_function = require("utility")
local table_function = require("init")
local war_function = require("war")
local init_function = require("init")


local function deleteEqualsSumSempai(sempai1, sempai2, board, N)
    local newBoard = init_function.clone(board)

    local deleteSempai = war_function.calculatePriority(sempai1, sempai2)

     newBoard = war_function.deleteSempai(newBoard, deleteSempai, N)

    return newBoard

end



local function compareSempai(board, tot_sempai, N)
    local newBoard = init_function.clone(board)
    local maxSum = 0
    local finalSempai


    for i = 1, #tot_sempai do
        local sum = sempai_function.sum(tot_sempai[i])

        if sum > maxSum then
            maxSum = sum
            finalSempai = tot_sempai[i]
        elseif sum < maxSum then
            newBoard = war_function.deleteSempai(newBoard, tot_sempai[i], N)
            elseif sum == maxSum then
            newBoard = deleteEqualsSumSempai(tot_sempai[i], finalSempai, newBoard, N)
        end
    end

    return newBoard
end



local function endGame(board, N)

    local newBoard = init_function.clone(board)

    local tot_sempai = sempai_function.searchSempai(newBoard)

    if #tot_sempai == 1 then

        print("Programma terminato")

    elseif #tot_sempai > 1 then

        newBoard = compareSempai(newBoard, tot_sempai, N)
        endGame(newBoard, N)

    else
        print("Errore")

    end

    return newBoard

end


local function printSempai (board)

    local position_sempai = sempai_function.searchSempai(board)

    for i=1, #position_sempai do
        sempai_function.printSempai(position_sempai[i])
    end

end




--Funzione che fa muovere i sempai
local function moveSempai (b, N)

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
            local sempaiX, sempaiY = newSempai.posizione.x, newSempai.posizione.y -- Ottieni le coordinate del sempai
            print(sempaiX, sempaiY)

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
        end

        table_function.print(newBoard, #newBoard)
        printSempai(newBoard)

        newBoard = war_function.comparison(newBoard)

        moveSempai(newBoard, N)

    else

        newBoard = endGame(newBoard, N)
        init_function.print(newBoard, N)
        printSempai(newBoard)

    end

end

local START = {
    moveSempai = moveSempai
}

return START