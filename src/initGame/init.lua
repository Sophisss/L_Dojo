local utility_function = require("utility.utility")
local file_function = require("file.file")

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


--Funzione che inserisce i simboli nella scacchiera
local function insert(D, board)

    local newBoard = utility_function.clone(board)

    for symbol, position in pairs(D) do
        for  _, coords in ipairs(position) do
            local x, y, u, c, g, r = table.unpack(coords)

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


-- Funzione che inizializza il gioco
local function initializeGame(configContent)

    -- inizializza la scacchiera
    local board = inizialize(configContent.N)

    -- inserisci i simboli nella scacchiera
    local newBoard = insert(configContent.D, board)

    -- stampa la scacchiera
    file_function.printAndWriteToFile(newBoard, configContent.N)

    return newBoard
end

local T = {
    initializeGame = initializeGame
}

return T