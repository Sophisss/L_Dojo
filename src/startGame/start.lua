local utility_function = require("utility.utility")
local sempai_function = require("sempai.movements")
local file_function = require("file.file")

local function printSempai (board)

    for _, row in ipairs(board) do
        for _, value in ipairs(row) do
            if type(value) == "table" then
                sempai_function.printSempai(value)
            end
        end
    end
end

local function moveAllSempaiTowardsNearestObject(board)
    local newBoard = utility_function.deepCopy(board)
    local sempaiList = utility_function.getSempai(newBoard)
    local objectList = utility_function.getObjectList(newBoard)

    for _, sempai in pairs(sempaiList) do
        local nearestObject = utility_function.findNearestObject(sempai, objectList)
        local direction

        if nearestObject ~= nil then
            direction = utility_function.minPath(sempai.x, sempai.y, nearestObject.x, nearestObject.y)
        else
            nearestObject = utility_function.findNearestObject(sempai, sempaiList)
            direction = utility_function.minPath(sempai.x, sempai.y, nearestObject.x, nearestObject.y)
        end

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
        sempaiList = utility_function.getSempai(newBoard)
    end

    return newBoard
end

local function startGame(board)
    local newBoard = utility_function.deepCopy(board)
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