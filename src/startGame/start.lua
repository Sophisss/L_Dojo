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

    for _, sempai in pairs(sempaiList) do
        local nearestObject = utility_function.findNearestObject(sempai, objectList)

        -- Verifica se ci sono oggetti nella tabella
        if nearestObject ~= nil then
            local direction = utility_function.minPath(sempai.x, sempai.y, nearestObject.x, nearestObject.y)

            -- Sposta il sempai verso l'oggetto
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
        else
            -- Sposta il sempai verso gli altri sempai
            nearestObject = utility_function.findNearestObject(sempai, sempaiList)

            local direction = utility_function.minPath(sempai.x, sempai.y, nearestObject.x, nearestObject.y)

            -- Sposta il sempai verso l'altro sempai
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
    end

    return newBoard
end

local function startGame(board)
    local newBoard = utility_function.clone(board)
    local listSempai = utility_function.getSempai(newBoard)
    local finalResult

    if #listSempai > 1 then
        printSempai(newBoard)
        print("\n--------------")

        newBoard = moveAllSempaiTowardsNearestObject(newBoard)
        file_function.printAndWriteToFile(newBoard, #newBoard)

        finalResult = startGame(newBoard)

    elseif #listSempai == 1 then
        printSempai(newBoard)
        print("\n--------------")
        finalResult = true
    else
        return nil
    end

    return finalResult
end

local START = {
    startGame = startGame
}

return START