local init_function = require("init")
local S = {}

--Funzione che permette di muovere il sempai a nord
function S.moveNord(board, x, y)
    if x > 1 then
        --Clona il sempai
        local newSempai = init_function.clone(board[x][y])

        if board[x - 1][y] ~= '-' and (type(board[x - 1][y]) ~= "table" or board[x - 1][y] ~= 'S') then
            if board[x - 1][y] == 'U' then
                newSempai.umilta = newSempai.umilta + 1
            elseif board[x - 1][y] == 'C' then
                newSempai.coraggio = newSempai.coraggio + 1
            elseif board[x - 1][y] == 'R' then
                newSempai.rispetto = newSempai.rispetto + 1
            elseif board[x - 1][y] == 'G' then
                newSempai.gentilezza = newSempai.gentilezza + 1
            end
        end

        --Clona la tabella
        local newBoard = init_function.clone(board)

        -- Assegna '-' alla posizione attuale del sempai
        newBoard[x][y] = '-'

        -- Sposta il sempai verso nord se la posizione è valida
        if x - 1 >= 1 then
            newBoard[x - 1][y] = newSempai

            -- Aggiorna posizione del sempai
            newSempai.posizione.x = x - 1

            return newBoard, newSempai
        end
    end

    -- Restituisci la tabella originale se il sempai non può essere spostato verso nord
    return board, board[x][y]
end

function S.moveSud(board, x, y)
    if x < 10 then

        local newSempai = init_function.clone(board[x][y])

        if board[x + 1][y] ~= '-' and (type(board[x + 1][y]) ~= "table" or board[x + 1][y] ~= 'S') then
            if board[x + 1][y] == 'U' then
                newSempai.umilta = newSempai.umilta + 1
            elseif board[x + 1][y] == 'C' then
                newSempai.coraggio = newSempai.coraggio + 1
            elseif board[x + 1][y] == 'R' then
                newSempai.rispetto = newSempai.rispetto + 1
            elseif board[x + 1][y] == 'G' then
                newSempai.gentilezza = newSempai.gentilezza + 1
            end
        end

        local newBoard = init_function.clone(board)

        newBoard[x][y] = '-'

        if x + 1 <= 10 then
            newBoard[x + 1][y] = newSempai

            newSempai.posizione.x = x + 1

            return newBoard, newSempai
        end
    end

    return board, board[x][y]
end

function S.moveEst(board, x, y)

    if y < 10 then

        local newSempai = init_function.clone(board[x][y])

        if board[x][y + 1] ~= '-' and (type(board[x][y + 1]) ~= "table" or board[x][y + 1] ~= 'S') then
            if board[x][y + 1] == 'U' then
                newSempai.umilta = newSempai.umilta + 1
            elseif board[x][y + 1] == 'C' then
                newSempai.coraggio = newSempai.coraggio + 1
            elseif board[x][y + 1] == 'R' then
                newSempai.rispetto = newSempai.rispetto + 1
            elseif board[x][y + 1] == 'G' then
                newSempai.gentilezza = newSempai.gentilezza + 1
            end
        end

        local newBoard = init_function.clone(board)

        newBoard[x][y] = '-'

        if y + 1 <= 10 then
            newBoard[x][y + 1] = newSempai

            newSempai.posizione.y = y + 1

            return newBoard, newSempai
        end
    end

    return board, board[x][y]

end

function S.moveOvest(board, x, y)

    if y > 1 then

        local newSempai = init_function.clone(board[x][y])

        if board[x][y - 1] ~= '-' and (type(board[x][y - 1]) ~= "table" or board[x][y - 1] ~= 'S') then
            if board[x][y - 1] == 'U' then
                newSempai.umilta = newSempai.umilta + 1
            elseif board[x][y - 1] == 'C' then
                newSempai.coraggio = newSempai.coraggio + 1
            elseif board[x][y - 1] == 'R' then
                newSempai.rispetto = newSempai.rispetto + 1
            elseif board[x][y - 1] == 'G' then
                newSempai.gentilezza = newSempai.gentilezza + 1
            end
        end

        local newBoard = init_function.clone(board)

        newBoard[x][y] = '-'

        if y - 1 >= 1 then
            newBoard[x][y - 1] = newSempai

            newSempai.posizione.y = y - 1

            return newBoard, newSempai
        end
    end

    return board, board[x][y]

end


-- Funzione per calcolare la somma dei valori di un Sempai
function S.sum(sempai)
    return sempai.umilta + sempai.coraggio + sempai.gentilezza + sempai.rispetto
end

-- Funzione per calcolare la priorità di un Sempai in caso di parità di punteggio
function S.priority(sempai)
    return ((sempai.posizione[1] + sempai.posizione[2]) * (sempai.posizione[1] + sempai.posizione[2] - 1) / 2) + sempai.posizione[1] - sempai.posizione[2]
end


--Funzione che mi permette di calcolare il numero di sempai presenti nella scacchiera
function S.countSempai(board)
    local count = 0
    local N = #board

    for i = 1, N do
        for j = 1, N do
            if board[i][j] == "S" or type(board[i][j])== "table" then
                count = count + 1
            end
        end
    end

    return count
end


--Funzione che cerca i sempai e memorizza la loro posizione
function S.searchSempai(board)
    local sempaiCoordinates = {}  -- Tabella per memorizzare le coordinate dei sempai

    -- Trova le coordinate dei sempai
    for i = 1, #board do
        for j = 1, #board[i] do
            if type(board[i][j]) == "table" or board[i][j] == "S" then
                table.insert(sempaiCoordinates, {i, j})
            end
        end
    end
    return sempaiCoordinates
end


function S.print(sempai)
    print("Coraggio: " .. sempai.coraggio ..
            "\nRispetto: " .. sempai.rispetto ..
            "\nGentilezza: " .. sempai.gentilezza ..
            "\nUmilta': " .. sempai.umilta ..
            "\nPosizione: {" .. sempai.posizione.x .. "," .. sempai.posizione.y .. "}" .. "\n")
end

return S