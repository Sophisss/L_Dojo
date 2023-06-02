-- leggi la configurazione dal file
local function readConfigFromFile(filename)
    return dofile(filename)
end

--Funzione che apre il file in modalità append e ci scrive dentro
local function writeToFile(data)
    local file_output = io.open("configuration.txt", "a")
    file_output:write(data.."\n")
    file_output:close()
end

--Per ogni cella della scacchiera, viene estratto il valore e
--inserito nella riga corrispondente.
local function printAndWriteToFile(board, N)
    local lines = {}

    for i = 1, N do
        local line = {}
        for j = 1, N do
            local value = board[i][j]
            if type(value) == "table" then
                value = "S"
            end
            table.insert(line, value)
        end
        table.insert(lines, table.concat(line, " "))
    end

    --Usato concat per unire le righe e ritorna come stringa
    local output = table.concat(lines, "\n") .. "\n"
    writeToFile(output)
end


local F = {
    readConfigFromFile = readConfigFromFile,
    printAndWriteToFile = printAndWriteToFile
}

return F