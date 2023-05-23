--Funzione che crea il sempai
local function create(x, y, u, c, g, r)
    local sempai = {
        umilta = u,
        coraggio = c,
        gentilezza = g,
        rispetto = r,
        posizione = { x = x, y = y }
    }
    return sempai
end

--Funzione che inizializza la scacchiera
local function inizialize(N)
    local board = {}
    for i = 1, N do
        board[i] = {}
        for j = 1, N do
            board[i][j] = "-"
        end
    end
    return board
end


--Funzione che serve per clonare in profondità la schacchiera
local function clone (t)
    local new_table = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            new_table[k] = clone(v)
        else
            new_table[k] = v
        end
    end
    return new_table
end


--Funzione che inserisce i simboli nella scacchiera
local function insert(D, board)

    local newBoard = clone(board)

    for symbol, position in pairs(D) do
        for i = 1, #position do
            local x, y = position[i][1], position[i][2]
            local u, c, g, r = position[i][3], position[i][4],
            position[i][5], position[i][6]

            if symbol == 'S' then
                local newSempai = create(x, y, u, c, g, r)
                newBoard[x][y] = newSempai
            else
                newBoard[x][y] = symbol
            end
        end
    end

    return newBoard

end


--Funzione che stampa la scacchiera
local function print(board, N)
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

local T = {
    create = create,
    inizialize = inizialize,
    insert = insert,
    print = print,
    clone = clone
}

return T



