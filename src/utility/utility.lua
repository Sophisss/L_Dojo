--Funzione che serve per clonare in profondità la scacchiera
local function deepCopy(orig)
    local new_table

    if type(orig) == 'table' then
        new_table = {}

        for k, v in pairs(orig) do
            new_table[deepCopy(k)] = deepCopy(v)
        end
    else
        new_table = orig
    end

    return new_table
end


--Funzione che calcola la distanza tra un oggetto e un sempai date le loro coordinate
local function calculateDistance(objectX, objectY, sempaiX, sempaiY)
    return math.sqrt((objectX - sempaiX) ^ 2 + (objectY - sempaiY) ^ 2)
end

local function getObjectList(board)
    local objects = {}

    for i, row in ipairs(board) do
        for j, value in ipairs(row) do
            if value == "U" or value == "G" or value == "C" or value == "R" then
                table.insert(objects, { x = i, y = j })
            end
        end
    end

    return objects
end


--Funzione per ottenere i sempai presenti sulla scacchiera
local function getSempai(board)
    local sempaiList = {}

    -- Trova i sempai nella tabella
    for i, row in ipairs(board) do
        for j, value in ipairs(row)do
            if type(value) == "table" or value == "S" then
                table.insert(sempaiList, { x = i, y = j })
            end
        end
    end

    return sempaiList
end


-- Funzione per determinare l'oggetto più vicino a un sempai
local function findNearestObject(sempai, objects)
    local nearestObject
    local minDistance = math.huge

    for _, object in ipairs(objects) do
        local other = object

        local dist = calculateDistance(other.x, other.y, sempai.x, sempai.y)
        if dist > 0 then
            if dist < minDistance then
                minDistance = dist
                nearestObject = other
            end
        elseif dist == 0 then
            minDistance = minDistance
            nearestObject = nearestObject
        else
            return nil
        end
    end

    return nearestObject
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
    deepCopy = deepCopy,
    getSempai = getSempai,
    getObjectList = getObjectList,
    findNearestObject = findNearestObject,
    minPath = minPath
}

return U