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

local function playGong(board, sempaiX, sempaiY)


    --Determino l'elenco degli oggetti nella scacchiera
    local objects, _ = getObjectList(board)

    local direction


    --Oggetto più vicino al sempai dato
    local objectX, objectY = nearestObjectFunction(objects, sempaiX, sempaiY)

    local move = minPath(sempaiX, sempaiY, objectX, objectY)

    direction = move

    return direction

end

local U = {
    getObjectList = getObjectList,
    calculateDistance = calculateDistance,
    nearestObjectFunction = nearestObjectFunction,
    minPath = minPath,
    playGong = playGong
}

return U
