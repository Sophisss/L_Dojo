local utility_function = require("utility.utility")


--Funzione che rimuove un sempai dalla scacchiera
local function deleteSempai (board, sempai)

    local newBoard = utility_function.clone(board)

    local newSempai = utility_function.clone(sempai)

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
--Ritorna il sempai che ha priorità maggiore
local function calculatePriority (sempai1, sempai2)

    local priority1 = priority(sempai1)
    local priority2 = priority(sempai2)

    local newSempai1 = utility_function.clone(sempai1)
    local newSempai2 = utility_function.clone(sempai2)

    if priority1 > priority2 then
        return newSempai1
    elseif priority1 < priority2 then
        return newSempai2
    else
        return nil
    end
end

local function war (board, sempai1, sempai2)

    local newBoard = utility_function.clone(board)

    local newSempai1 = utility_function.clone(sempai1)
    local newSempai2 = utility_function.clone(sempai2)

    local tot_point_sempai1 = sum(newSempai1)
    local tot_point_sempai2 = sum(newSempai2)

    local win

    if tot_point_sempai1 > tot_point_sempai2 then
        win = newSempai1
        newBoard = deleteSempai(newBoard, sempai2)
    elseif tot_point_sempai1 < tot_point_sempai2 then
        win = newSempai2
        newBoard = deleteSempai(newBoard, sempai1)
    elseif tot_point_sempai1 == tot_point_sempai2 then
        local maxPrioritySempai = calculatePriority(sempai1, sempai2)

        if maxPrioritySempai == newSempai1 then
            win = newSempai1
            newBoard = deleteSempai(newBoard, newSempai2)
        elseif maxPrioritySempai == newSempai2 then
            win = newSempai2
            newBoard = deleteSempai(newBoard, newSempai1)
        else
            win = nil
        end

        return newBoard, win
    end

end local W = {
    war = war
}

return W