local sempai_function = require("sempai")
local U = {}


function U.nearestObject(objects, sempaiX, sempaiY)

    --Oggetto più vicino al sempai dato
    local nearestObjectX, nearestObjectY

    --Distanza minore
    local minValue

    for i=1, #objects do
        --Salvo le coordinate dell'oggetto
        local objectX, objectY = table.unpack(objects[i])

        --Calcolo la distanza tra l'oggetto e il sempai
        local distance = U.calculateDistance(objectX, objectY, sempaiX, sempaiY)

        if minValue == nil or distance < minValue then
            minValue = distance
            local nearestObject = objects[i]
            nearestObjectX, nearestObjectY = table.unpack(nearestObject)
        end
    end

    return nearestObjectX, nearestObjectY

end



function U.playGong(board)

    --Conto il numero totale di sempai presenti
    local numSempai = sempai_function.countSempai(board)

    --Determino le posizioni di questi sempai
    local position_sempai= sempai_function.searchSempai(board)

    --Determino l'elenco degli oggetti nella scacchiera
    local objects,_ = U.getObjectList(board)


    local gongDirections = {}


    for i=1, numSempai do

        -- Ottieni le coordinate del sempai
        local sempaiX, sempaiY = table.unpack(position_sempai[i])
        print("Sempai"..sempaiX..","..sempaiY)

        --Oggetto più vicino al sempai dato
        local objectX, objectY = U.nearestObject(objects, sempaiX, sempaiY)
        print("Oggetto"..objectX..","..objectY)

        local direction = U.minPath(sempaiX, sempaiY, objectX, objectY)

        gongDirections[i] = direction

        end

    return gongDirections

end


function U.minPath(startX, startY, endX, endY)
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



-- Funzione per ottenere la lista degli oggetti presenti sulla scacchiera
function U.getObjectList(board)
    local objects = {}
    local num_object = 0

    for i = 1, #board do
        for j = 1, #board do
            if board[i][j] == "U" or board[i][j] == "G"
                    or board[i][j] == "C" or board[i][j] == "R" then
                table.insert(objects, {i,j})
                num_object = num_object +1
            end
        end
    end

    return objects, num_object
end



--Funzione che calcola la distanza tra un oggetto e un sempai date le loro coordinate
function U.calculateDistance(objectX, objectY, sempaiX, sempaiY)
    return math.sqrt((objectX - sempaiX) ^ 2 + (objectY - sempaiY) ^ 2)
end


return U
