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

-- Funzione per calcolare la somma dei valori di un Sempai
local function sum(sempai)
    return sempai.umilta + sempai.coraggio + sempai.gentilezza + sempai.rispetto
end

-- Funzione per calcolare la priorità di un Sempai in caso di parità di punteggio
local function priority(sempai)
    return (((sempai.posizione.x + sempai.posizione.y) * ((sempai.posizione.x + sempai.posizione.y) - 1)) / 2) + sempai.posizione.x - sempai.posizione.y
end



--Funzione che determina chi dei due sempai ha la priorità
--Ritorna il sempai che ha priorità minore
local function calculatePriority (sempai1, sempai2)

    local priority1 = priority(sempai1)
    local priority2 = priority(sempai2)

    local newSempai1 = init_function.clone(sempai1)
    local newSempai2 = init_function.clone(sempai2)

    if priority1 > priority2 then
        return newSempai2
    elseif priority1 < priority2 then
        return newSempai1
    end
end

local function war (board, sempai1, sempai2)


    local newBoard = init_function.clone(board)

    local tot_point_sempai1 = sum(sempai1)
    local tot_point_sempai2 = sum(sempai2)

    if tot_point_sempai1 > tot_point_sempai2 then
        newBoard = deleteSempai(newBoard, sempai2)
    elseif tot_point_sempai1 < tot_point_sempai2 then
        newBoard = deleteSempai(newBoard, sempai1)
    elseif tot_point_sempai1 == tot_point_sempai2 then
        local minPrioritySempai = calculatePriority(sempai1, sempai2)
        newBoard = deleteSempai(newBoard, minPrioritySempai)
    end

    return newBoard

end


local W = {
    deleteSempai = deleteSempai,
    calculatePriority = calculatePriority,
    war = war,
    sum = sum,
    priority = priority
}

return W