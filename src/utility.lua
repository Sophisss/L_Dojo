local sempai_function = require("sempai")


-- Funzione per ottenere la lista degli oggetti presenti sulla scacchiera
local function getObjectList(board)
    local objects = {}
    local num_object = 0

    for i = 1, #board do
        for j = 1, #board do
            if board[i][j] == "U" or board[i][j] == "G"
                    or board[i][j] == "C" or board[i][j] == "R" then
                table.insert(objects, { i, j })
                num_object = num_object + 1
            end
        end
    end

    return objects, num_object
end

local function countObjects(board)
    local objectCount = 0

    for x = 1, #board do
        for y = 1, #board[x] do
            if type(board[x][y]) ~= "table" or board[x][y] ~= 'S' then
                if board[x][y] == 'U' or board[x][y] == 'C' or board[x][y] == 'G' or board[x][y] == 'R' then
                    objectCount = objectCount + 1
                end
            end
        end
    end

    return objectCount
end



--Funzione che calcola la distanza tra un oggetto e un sempai date le loro coordinate
local function calculateDistance(objectX, objectY, sempaiX, sempaiY)
    return math.sqrt((objectX - sempaiX) ^ 2 + (objectY - sempaiY) ^ 2)
end

local function nearestObjectFunction(objects, sempaiX, sempaiY)

    --Oggetto più vicino al sempai dato
    local nearestObjectX, nearestObjectY

    --Distanza minore
    local minValue

    for i = 1, #objects do
        --Salvo le coordinate dell'oggetto
        local objectX, objectY = table.unpack(objects[i])

        --Calcolo la distanza tra l'oggetto e il sempai
        local distance = calculateDistance(objectX, objectY, sempaiX, sempaiY)

        if minValue == nil or distance < minValue then
            minValue = distance
            nearestObjectX, nearestObjectY = objectX, objectY
        end
    end

    return nearestObjectX, nearestObjectY

end

local function minPath(startX, startY, endX, endY)
    local direction

    if startX > endX then
        direction = "Nord"
    elseif startX < endX then
        direction = "Sud"
    elseif startY > endY then
        direction = "Ovest"
    elseif startY < endY then
        direction = "Est"
    end

    return direction
end

local function playGong(board)

    --Conto il numero totale di sempai presenti
    local numSempai = sempai_function.countSempai(board)

    --Determino le posizioni di questi sempai
    local position_sempai = sempai_function.searchSempai(board)

    --Determino l'elenco degli oggetti nella scacchiera
    local objects, _ = getObjectList(board)

    local gongDirections = {}

    for i = 1, numSempai do

        -- Ottieni le coordinate del sempai
        local sempai = position_sempai[i]

        local sempaiX, sempaiY = sempai.posizione.x, sempai.posizione.y

        --Oggetto più vicino al sempai dato
        local objectX, objectY = nearestObjectFunction(objects, sempaiX, sempaiY)

        local direction = minPath(sempaiX, sempaiY, objectX, objectY)

        gongDirections[i] = direction

    end

    return gongDirections

end

local U = {
    getObjectList = getObjectList,
    countObjects = countObjects,
    calculateDistance = calculateDistance,
    nearestObjectFunction = nearestObjectFunction,
    minPath = minPath,
    playGong = playGong
}

return U
