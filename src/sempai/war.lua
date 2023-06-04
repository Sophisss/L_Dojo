local utility_function = require("utility.utility")


--Funzione che rimuove un sempai dalla scacchiera
local function deleteSempai (board, sempai)

    local newBoard = utility_function.deepCopy(board)

    local newSempai = utility_function.deepCopy(sempai)

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

    local newSempai1 = utility_function.deepCopy(sempai1)
    local newSempai2 = utility_function.deepCopy(sempai2)

    if priority1 > priority2 then
        return newSempai1
    elseif priority1 < priority2 then
        return newSempai2
    else
        return nil
    end
end

local function war (board, sempai1, sempai2)

    local newBoard = utility_function.deepCopy(board)

    local newSempai1 = utility_function.deepCopy(sempai1)
    local newSempai2 = utility_function.deepCopy(sempai2)

    if newSempai1.umilta > newSempai2.umilta then
        newSempai1.umilta = newSempai1.umilta + 1
    elseif newSempai1.umilta < newSempai2.umilta then
        newSempai2.umilta = newSempai2.umilta + 1
    end

    if newSempai1.coraggio > newSempai2.coraggio then
        newSempai1.coraggio = newSempai1.coraggio + 1
    elseif newSempai1.coraggio < newSempai2.coraggio then
        newSempai2.coraggio = newSempai2.coraggio + 1
    end

    if newSempai1.rispetto > newSempai2.rispetto then
        newSempai1.rispetto = newSempai1.rispetto + 1
    elseif newSempai1.rispetto < newSempai2.rispetto then
        newSempai2.rispetto = newSempai2.rispetto + 1
    end

    if newSempai1.gentilezza > newSempai2.gentilezza then
        newSempai1.gentilezza = newSempai1.gentilezza + 1
    elseif newSempai1.gentilezza < newSempai2.gentilezza then
        newSempai2.gentilezza = newSempai2.gentilezza + 1
    end

    local tot_point_sempai1 = sum(newSempai1)
    local tot_point_sempai2 = sum(newSempai2)

    local win

    if tot_point_sempai1 > tot_point_sempai2 then
        win = newSempai1
        newBoard = deleteSempai(newBoard, newSempai2)
    elseif tot_point_sempai1 < tot_point_sempai2 then
        win = newSempai2
        newBoard = deleteSempai(newBoard, newSempai1)
    elseif tot_point_sempai1 == tot_point_sempai2 then
        local maxPrioritySempai = calculatePriority(newSempai1, newSempai2)

        if maxPrioritySempai.posizione.x == newSempai1.posizione.x and
                maxPrioritySempai.posizione.y == newSempai1.posizione.y then
            win = newSempai1
            newBoard = deleteSempai(newBoard, newSempai2)
        elseif maxPrioritySempai.posizione.x == newSempai2.posizione.x and
                maxPrioritySempai.posizione.y == newSempai2.posizione.y then
            win = newSempai2
            newBoard = deleteSempai(newBoard, newSempai1)
        elseif maxPrioritySempai == nil then
            return newBoard
        end
    end
    return newBoard, win

end
local W = {
    war = war
}

return W