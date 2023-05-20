local init_function = require("init")

local function moveSempai(board, x, y, dx, dy)

    --Clona il sempai
    local newSempai = init_function.clone(board[x][y])

    --Determina le nuove coordinate
    local newX = x + dx
    local newY = y + dy

    -- Verifica se la nuova posizione è valida e se è presente un sempai
    if newX >= 1 and newX <= 10 and newY >= 1 and newY <= 10 and
            (board[newX][newY] ~= '-' and (type(board[newX][newY]) ~= "table" or board[newX][newY] ~= 'S')) then

        -- Aggiorna i valori del sempai in base all'elemento speciale trovato
        if board[newX][newY] == 'U' then
            newSempai.umilta = newSempai.umilta + 1
        elseif board[newX][newY] == 'C' then
            newSempai.coraggio = newSempai.coraggio + 1
        elseif board[newX][newY] == 'R' then
            newSempai.rispetto = newSempai.rispetto + 1
        elseif board[newX][newY] == 'G' then
            newSempai.gentilezza = newSempai.gentilezza + 1
        end
    end

    --Clona la tabella
    local newBoard = init_function.clone(board)

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
    return ((sempai.posizione[1] + sempai.posizione[2]) * (sempai.posizione[1] + sempai.posizione[2] - 1) / 2) + sempai.posizione[1] - sempai.posizione[2]
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
    local sempaiCoordinates = {}  -- Tabella per memorizzare le coordinate dei sempai

    -- Trova le coordinate dei sempai
    for i = 1, #board do
        for j = 1, #board[i] do
            if type(board[i][j]) == "table" or board[i][j] == "S" then
                table.insert(sempaiCoordinates, { i, j })
            end
        end
    end
    return sempaiCoordinates
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