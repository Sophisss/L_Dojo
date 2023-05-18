local T = {}

--Funzione che crea il sempai
function T.create(x,y)
    local sempai = {
        umilta = 0,
        coraggio = 0,
        gentilezza = 0,
        rispetto = 0,
        posizione = { x = x, y = y }
    }
    return sempai
end

--Funzione che inizializza la scacchiera
function T.inizialize(N)
    local board = {}
    for i = 1, N do
        board[i] = {}
        for j = 1, N do
            board[i][j] = "-"
        end
    end
    return board
end


--Funzione che inserisce i simboli nella scacchiera
function T.insert(D, board)
    for symbol, position in pairs(D) do
        for i = 1, #position do
            local x, y = position[i][1], position[i][2]

            if symbol == 'S' then
                local newSempai = T.create(x, y)
                board[x][y] = newSempai
            else
                board[x][y] = symbol
            end
        end
    end
end


--Funzione che stampa la scacchiera
function T.print(board, N)
    local filename = "output.txt"
    local file_output = io.open(filename, "a")

    for i = 1, N do
        for j = 1, N do
            local value = board[i][j]
            if type(value) == "table" then
                value = "S"
            end
            file_output:write(value .. " ")
        end
        file_output:write("\n")
    end
    file_output:write("\n")
    file_output:close()
end


--Funzione che serve per clonare in profondità la schacchiera
function T.clone (t)
    local new_table = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            new_table[k] = T.clone(v)
        else
            new_table[k] = v
        end
    end
    return new_table
end


return T



