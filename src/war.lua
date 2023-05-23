local sempai_function = require("sempai")
local init_function = require("init")


--Funzione che rimuove un sempai dalla scacchiera
local function deleteSempai (board, sempai)

    local newBoard = init_function.clone(board)

    local newSempai = init_function.clone(sempai)

    local x = newSempai.posizione.x
    local y = newSempai.posizione.y

    newBoard[x][y] = '-'

    return newBoard

end

--Funzione che determina chi dei due sempai ha la priorità
local function calculatePriority (sempai1, sempai2)

    local priority1 = sempai_function.priority(sempai1)
    local priority2 = sempai_function.priority(sempai2)

    local newSempai1 = init_function.clone(sempai1)
    local newSempai2 = init_function.clone(sempai2)

    if priority1 > priority2 then
        return newSempai2
    elseif priority1 < priority2 then
        return newSempai1
    end
end


--Funzione che permette di comparare due sempai quando si trovano su due caselle vicine
local function comparison(board)

    local newBoard = init_function.clone(board)

    local position_sempai = sempai_function.searchSempai(newBoard)

    for i = 1, #position_sempai do
        for j = 2, #position_sempai do
            local sempai1 = position_sempai[i]
            local x, y = sempai1.posizione.x, sempai1.posizione.y

            local sempai2 = position_sempai[j]
            local x2, y2 = sempai2.posizione.x, sempai2.posizione.y

            if (x == x2 + 1 and y == y2) or
                    (x == x2 - 1 and y == y2) or
                    (y == y2 + 1 and x == x2) or
                    (y == y2 - 1 and x == x2) then

                local tot_point_sempai1 = sempai_function.sum(sempai1)
                local tot_point_sempai2 = sempai_function.sum(sempai2)

                if tot_point_sempai1 > tot_point_sempai2 then
                    newBoard = deleteSempai(newBoard, sempai2)
                elseif tot_point_sempai1 < tot_point_sempai2 then
                    newBoard = deleteSempai(newBoard, sempai1)
                elseif tot_point_sempai1 == tot_point_sempai2 then
                    local minPrioritySempai = calculatePriority(sempai1, sempai2)
                    newBoard = deleteSempai(newBoard, minPrioritySempai)
                end
            end
        end
    end

    return newBoard

end

local W = {
    deleteSempai = deleteSempai,
    calculatePriority = calculatePriority,
    comparison = comparison
}

return W