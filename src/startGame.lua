local sempai_function = require("sempai")
local utility_function = require("utility")
local table_function = require("init")
local war_function = require("war")
local init_function = require("init")

local function printSempai (board)

    local position_sempai = sempai_function.searchSempai(board)

    for i = 1, #position_sempai do
        sempai_function.printSempai(position_sempai[i])
    end

    print("\n --------")

end

local function deleteEqualsSumSempai(sempai1, sempai2, board)
    local newBoard = init_function.clone(board)

    local deleteSempai = war_function.calculatePriority(sempai1, sempai2)

    newBoard = war_function.deleteSempai(newBoard, deleteSempai)

    return newBoard

end

local function compareSempai(board, tot_sempai, N)
    local newBoard = init_function.clone(board)
    local maxSum = 0
    local finalSempai

    for i = 1, #tot_sempai do
        local sum = war_function.sum(tot_sempai[i])

        if sum > maxSum then
            if finalSempai == nil then
                maxSum = sum
                finalSempai = tot_sempai[i]
            elseif finalSempai ~= nil then
                newBoard = war_function.deleteSempai(newBoard, finalSempai)
                maxSum = sum
                finalSempai = tot_sempai[i]
                init_function.print(newBoard, N)
                printSempai(newBoard)

            end

        elseif sum < maxSum then
            newBoard = war_function.deleteSempai(newBoard, tot_sempai[i])
            init_function.print(newBoard, N)
            printSempai(newBoard)

        elseif sum == maxSum then
            newBoard = deleteEqualsSumSempai(tot_sempai[i], finalSempai, newBoard)
            init_function.print(newBoard, N)
            printSempai(newBoard)

        end
    end

    return newBoard
end




--Funzione che fa muovere i sempai
local function moveSempai (b, N)

    -- Crea una nuova scacchiera con i sempai mossi nella direzione corrispondente
    local newBoard = table_function.clone(b) -- Copia la scacchiera

    local _, num = utility_function.getObjectList(newBoard)

    local numSempai = sempai_function.countSempai(newBoard)

    printSempai(newBoard)

    if numSempai ~= 1 then

        --Ottieni le posizioni dei sempai
        local position_sempai = sempai_function.searchSempai(newBoard)

        if num ~= 0 then

            for i=1, #position_sempai do

                local newSempai = table_function.clone(position_sempai[i])
                local sempaiX, sempaiY = newSempai.posizione.x, newSempai.posizione.y -- Ottieni le coordinate del sempai

                local direction = utility_function.playGong(newBoard, sempaiX, sempaiY)

                -- Sposta ciascun sempai nella direzione determinata
                if direction == "Nord" then
                    newBoard = sempai_function.moveNord(newBoard, sempaiX, sempaiY)
                elseif direction == "Sud" then
                    newBoard = sempai_function.moveSud(newBoard, sempaiX, sempaiY)
                elseif direction == "Est" then
                    newBoard = sempai_function.moveEst(newBoard, sempaiX, sempaiY)
                elseif direction == "Ovest" then
                    newBoard = sempai_function.moveOvest(newBoard, sempaiX, sempaiY)
                end
            end

            table_function.print(newBoard, #newBoard)

            moveSempai(newBoard, N)

        end

    else

        print("Programma terminato!")


    end

end

local START = {
    moveSempai = moveSempai
}

return START