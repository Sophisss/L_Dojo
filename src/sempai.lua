local init_function = require("init")

local function moveSempai(board, x, y, dx, dy)


    --Clona la tabella
    local newBoard = init_function.clone(board)

    --Clona il sempai
    local newSempai = init_function.clone(newBoard[x][y])

    --Determina le nuove coordinate
    local newX = x + dx
    local newY = y + dy

    -- Verifica se la nuova posizione è valida e se è presente un sempai
    if newX >= 1 and newX <= 10 and newY >= 1 and newY <= 10 and
            (newBoard[newX][newY] ~= '-' and (type(newBoard[newX][newY]) ~= "table" or newBoard[newX][newY] ~= 'S')) then

        -- Aggiorna i valori del sempai in base all'elemento speciale trovato
        if newBoard[newX][newY] == 'U' then
            newSempai.umilta = newSempai.umilta + 1
        elseif newBoard[newX][newY] == 'C' then
            newSempai.coraggio = newSempai.coraggio + 1
        elseif newBoard[newX][newY] == 'R' then
            newSempai.rispetto = newSempai.rispetto + 1
        elseif newBoard[newX][newY] == 'G' then
            newSempai.gentilezza = newSempai.gentilezza + 1
        end
    end


    -- Assegna '-' alla posizione attuale del sempai
    newBoard[x][y] = '-'

    -- Sposta il sempai verso la nuova direzione se la posizione è valida
    newBoard[newX][newY] = newSempai

    -- Aggiorna posizione del sempai
    newSempai.posizione.x = newX
    newSempai.posizione.y = newY

    return newBoard

end

--Funzione che permette di muovere il sempai a nord
local function moveNord(board, x, y)
    if x > 1 then
        return moveSempai(board, x, y, -1, 0)
    end

    -- Restituisci la tabella originale se il sempai non può essere spostato verso nord
    return board
end

local function moveSud(board, x, y)
    if x < 10 then
        return moveSempai(board, x, y, 1, 0)
    end

    -- Restituisci la tabella originale se il sempai non può essere spostato verso nord
    return board
end

local function moveEst(board, x, y)

    if y < 10 then
        return moveSempai(board, x, y, 0, 1)
    end

    -- Restituisci la tabella originale se il sempai non può essere spostato verso nord
    return board

end

local function moveOvest(board, x, y)
    if y > 1 then
        return moveSempai(board, x, y, 0, -1)
    end

    -- Restituisci la tabella originale se il sempai non può essere spostato verso nord
    return board
end


-- Funzione per calcolare la somma dei valori di un Sempai
local function sum(sempai)
    return sempai.umilta + sempai.coraggio + sempai.gentilezza + sempai.rispetto
end

-- Funzione per calcolare la priorità di un Sempai in caso di parità di punteggio
local function priority(sempai)
    return (((sempai.posizione.x + sempai.posizione.y) * ((sempai.posizione.x + sempai.posizione.y) - 1)) / 2) + sempai.posizione.x - sempai.posizione.y
end


--Funzione che mi permette di calcolare il numero di sempai presenti nella scacchiera
local function countSempai(board)
    local count = 0
    local N = #board

    for i = 1, N do
        for j = 1, N do
            if board[i][j] == "S" or type(board[i][j]) == "table" then
                count = count + 1
            end
        end
    end

    return count
end


--Funzione che cerca i sempai e memorizza la loro posizione
local function searchSempai(board)
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

local function printSempai(sempai)
    print("Coraggio: " .. sempai.coraggio ..
            "\nRispetto: " .. sempai.rispetto ..
            "\nGentilezza: " .. sempai.gentilezza ..
            "\nUmilta': " .. sempai.umilta ..
            "\nPosizione: {" .. sempai.posizione.x .. "," .. sempai.posizione.y .. "}" .. "\n")
end

local S = {
    moveNord = moveNord,
    moveSud = moveSud,
    moveEst = moveEst,
    moveOvest = moveOvest,
    sum = sum,
    priority = priority,
    countSempai = countSempai,
    searchSempai = searchSempai,
    printSempai = printSempai
}

return S