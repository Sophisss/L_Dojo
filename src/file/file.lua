-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    return dofile(filename)
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

local F = {
    readConfigFromFile = readConfigFromFile,
    print = print
}

return F