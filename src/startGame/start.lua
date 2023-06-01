local utility_function = require("utility.utility")
local sempai_function = require("sempai.movements")
local file_function = require("file.file")

local function printSempai (board)
    for i = 1, #board do
        for j = 1, #board do

            if type(board[i][j]) == "table" then
                sempai_function.printSempai(board[i][j])
            end
        end
    end
end


local function moveAllSempaiTowardsNearestObject(board)
    -- Copia la scacchiera
    local newBoard = utility_function.clone(board)
    local sempaiList = utility_function.getSempai(newBoard)
    local objectList = utility_function.getObjectList(newBoard)

    if #objectList == 0 then
        for _, sempai in pairs(sempaiList) do
            local nearestSempai = utility_function.findNearestObject(sempai, sempaiList)

            local direction = utility_function.minPath(sempai.x, sempai.y, nearestSempai.x, nearestSempai.y)

            -- Sposto il sempai nella direzione determinata
            if direction == "Nord" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, -1, 0)
            elseif direction == "Sud" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 1, 0)
            elseif direction == "Est" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 0, 1)
            elseif direction == "Ovest" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 0, -1)
            end

            sempaiList = utility_function.getSempai(newBoard)
        end

    elseif #objectList > 0 then
        for _, sempai in pairs(sempaiList) do
            local nearestObject = utility_function.findNearestObject(sempai, objectList)
            if nearestObject == nil then
                return newBoard
            end

            local direction = utility_function.minPath(sempai.x, sempai.y, nearestObject.x, nearestObject.y)

            -- Sposto il sempai nella direzione determinata
            if direction == "Nord" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, -1, 0)
            elseif direction == "Sud" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 1, 0)
            elseif direction == "Est" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 0, 1)
            elseif direction == "Ovest" then
                newBoard = sempai_function.moveSempai(newBoard, sempai.x, sempai.y, 0, -1)
            end
            objectList = utility_function.getObjectList(newBoard)
        end
    end

    return newBoard
end

local function startGame(board)
    local function recursiveStartGame(b)
        local newBoard = utility_function.clone(b)
        local listSempai = utility_function.getSempai(newBoard)

        if #listSempai > 1 then
            printSempai(newBoard)
            print("\n--------------")
            newBoard = moveAllSempaiTowardsNearestObject(newBoard)
            file_function.printAndWriteToFile(newBoard, #newBoard)
            return recursiveStartGame(newBoard)

        elseif #listSempai == 1 then
            printSempai(newBoard)
            print("\n--------------")
            return true
        else
            return nil
        end
    end

    return recursiveStartGame(board)
end

local START = {
    startGame = startGame
}

return START