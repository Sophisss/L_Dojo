--Funzione che serve per clonare in profondità la scacchiera
local function clone (t)
    local new_table = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            new_table[k] = clone(v)
        else
            new_table[k] = v
        end
    end
    return new_table
end


--Funzione che calcola la distanza tra un oggetto e un sempai date le loro coordinate
local function calculateDistance(objectX, objectY, sempaiX, sempaiY)
    return math.sqrt((objectX - sempaiX) ^ 2 + (objectY - sempaiY) ^ 2)
end


local function getObjectList(board)
    local objects = {}

    for i = 1, #board do
        for j = 1, #board do
            if board[i][j] == "U" or board[i][j] == "G"
                    or board[i][j] == "C" or board[i][j] == "R" then
                table.insert(objects, {x= i, y= j })
            end
        end
    end

    return objects
end


--Funzione per ottenere i sempai presenti sulla scacchiera
local function getSempai(board)
    local sempaiList = {}

    -- Trova i sempai nella tabella
    for i = 1, #board do
        for j = 1, #board[i] do
            if type(board[i][j]) == "table" or board[i][j] == "S" then
                table.insert(sempaiList, board[i][j])
            end
        end
    end

    return sempaiList
end


local function nearestObjectFunction(board, sempai)

    local newBoard = clone(board)

    local newSempai = clone(sempai)

    local objects  = getObjectList(newBoard)

    local listSempai = getSempai(newBoard)

    --Oggetto più vicino al sempai dato
    local nearestObjectX, nearestObjectY = nil, nil

    --Distanza minore
    local minValue = math.hug


    if #objects > 0 then

        for i=1, #objects do

            --Calcolo la distanza tra l'oggetto e il sempai
            local distance = calculateDistance(objects[i].x, objects[i].y ,newSempai.posizione.x, newSempai.posizione.y)

            if minValue == nil or distance < minValue then
                minValue = distance
                nearestObjectX, nearestObjectY = objects[i].x, objects[i].y
            end
        end

    elseif #objects == 0 then



        for i = 1, #listSempai do

            --Calcolo la distanza tra l'oggetto e il sempai
            local distance = calculateDistance(listSempai[i].posizione.x, listSempai[i].posizione.y ,newSempai.posizione.x, newSempai.posizione.y)

            if minValue == nil or distance < minValue then
                minValue = distance
                nearestObjectX, nearestObjectY = listSempai[i].posizione.x, listSempai[i].posizione.y
            end

        end

    else

        return nil
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

local U = {
    clone = clone,
    getSempai = getSempai,
    nearestObjectFunction = nearestObjectFunction,
    minPath = minPath

}

return U