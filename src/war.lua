local sempai_function = require("sempai")
local init_function = require("init")


--Funzione che rimuove un sempai dalla scacchiera
local function deleteSempai (board, sempai, N)

    local newBoard = init_function.clone(board)

    local x = sempai.posizione.x
    local y = sempai.posizione.y

    init_function.print(newBoard, N)

    newBoard[x][y] = '-'

    return newBoard

end

--Funzione che determina chi dei due sempai ha la priorità
local function calculatePriority (sempai1, sempai2)

    local priority1 = sempai_function.priority(sempai1)
    local priority2 = sempai_function.priority(sempai2)

    if priority1 > priority2 then
        return sempai2
        elseif priority1 < priority2 then
        return sempai1
    end
end


--Funzione che permette di comparare due sempai quando si trovano su due caselle vicine
local function comparison(board, sempaiToCompare, N)

    local newBoard = init_function.clone(board)

    local position_sempai = sempai_function.searchSempai(newBoard)

    for i=1, #position_sempai do
        local sempai = position_sempai[i]
        local x, y = sempai.posizione.x, sempai.posizione.y


        if (x == sempaiToCompare.posizione.x +1 and y == sempaiToCompare.posizione.y) or
                (x== sempaiToCompare.posizione.x -1 and y == sempaiToCompare.posizione.y) or
                (y == sempaiToCompare.posizione.y +1 and x == sempaiToCompare.posizione.x) or
                (y == sempaiToCompare.posizione.y -1 and x == sempaiToCompare.posizione.x) then

            local tot_point_sempai1 = sempai_function.sum(sempaiToCompare)
            local tot_point_sempai2 = sempai_function.sum(sempai)

            if tot_point_sempai1 >  tot_point_sempai2 then
                newBoard = deleteSempai(newBoard, sempai, N)
            elseif tot_point_sempai1 <  tot_point_sempai2 then
                newBoard = deleteSempai(newBoard, sempaiToCompare, N)
            elseif tot_point_sempai1 ==  tot_point_sempai2 then
                local minPrioritySempai = calculatePriority(sempaiToCompare, sempai)
                newBoard = deleteSempai(newBoard, minPrioritySempai, N)

            end
        end
    end

    return newBoard

end


local W = {
    deleteSempai = deleteSempai,
    comparison = comparison
}

return W