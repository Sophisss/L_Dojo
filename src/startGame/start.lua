local utility_function = require("utility.utility")
local sempai_function = require("sempai.movements")
local file_function = require("file.file")

local function printSempai (board)

    local position_sempai = utility_function.getSempai(board)

    for i = 1, #position_sempai do
        sempai_function.printSempai(position_sempai[i])
    end
end

local function startGame (board)

    -- Copia la scacchiera
    local newBoard = utility_function.clone(board)

    local listSempai = utility_function.getSempai(newBoard)

    printSempai(newBoard)

    if #listSempai > 1 then

        for i = 1, #listSempai do

            local nearestObjectX, nearestObjectY = utility_function.nearestObjectFunction(newBoard, listSempai[i])

            local direction = utility_function.minPath(listSempai[i].posizione.x, listSempai[i].posizione.y, nearestObjectX, nearestObjectY)

            -- Sposto il sempai nella direzione determinata
            if direction == "Nord" then
                newBoard = sempai_function.moveSempai(newBoard, listSempai[i].posizione.x, listSempai[i].posizione.y, -1, 0)
            elseif direction == "Sud" then
                newBoard = sempai_function.moveSempai(newBoard, listSempai[i].posizione.x, listSempai[i].posizione.y, 1, 0)
            elseif direction == "Est" then
                newBoard = sempai_function.moveSempai(newBoard, listSempai[i].posizione.x, listSempai[i].posizione.y, 0, 1)
            elseif direction == "Ovest" then
                newBoard = sempai_function.moveSempai(newBoard, listSempai[i].posizione.x, listSempai[i].posizione.y, 0, -1)
            else
                return nil
            end
        end

        file_function.print(newBoard, #newBoard)

        return startGame(newBoard)

    elseif #listSempai == 1 then

        return true

    else
        return nil

    end
end


local START = {
    startGame = startGame
}

return START