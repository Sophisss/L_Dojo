local function printSempai(sempai)
    print("Coraggio: " .. sempai.coraggio ..
            "\nRispetto: " .. sempai.rispetto ..
            "\nGentilezza: " .. sempai.gentilezza ..
            "\nUmilta': " .. sempai.umilta ..
            "\nPosizione: {" .. sempai.posizione.x .. "," .. sempai.posizione.y .. "}" ..
            "\nSomma valori: " .. sempai.umilta + sempai.coraggio + sempai.rispetto + sempai.gentilezza .. "\n")
end

local function printConsole (board)

    for _, row in ipairs(board) do
        for _, value in ipairs(row) do
            if type(value) == "table" then
                printSempai(value)
            end
        end
    end
end


local P = {
    printConsole = printConsole
}

return P