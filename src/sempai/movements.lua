local utility_function = require("utility.utility")
local war_function = require("sempai.war")

local function moveSempai(board, x, y, dx, dy)

    --Clona la tabella
    local newBoard = utility_function.clone(board)

    --Clona il sempai
    local newSempai = utility_function.clone(newBoard[x][y])


    --Determina le nuove coordinate
    local newX = x + dx
    local newY = y + dy

    if newX >= 1 or newX <= 10 and newY >= 1 or newY <= 10 then

        if newBoard[newX][newY] ~= '-' then

            if type(newBoard[newX][newY]) ~= "table" or newBoard[newX][newY] ~= 'S' then

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

                newBoard[x][y] = '-'

                newSempai.posizione.x = newX
                newSempai.posizione.y = newY

                newBoard[newX][newY] = newSempai
            else

                local win

                newBoard, win = war_function.war(newBoard, newSempai, newBoard[newX][newY])

                if win == newSempai then

                    newBoard[x][y] = '-'

                    newSempai.posizione.x = newX
                    newSempai.posizione.y = newY

                    newBoard[newX][newY] = newSempai

                end
            end

        elseif newBoard[newX][newY] == '-' then

            -- Assegna '-' alla posizione attuale del sempai
            newBoard[x][y] = '-'

            -- Aggiorna posizione del sempai
            newSempai.posizione.x = newX
            newSempai.posizione.y = newY

            -- Sposta il sempai verso la nuova direzione se la posizione è valida
            newBoard[newX][newY] = newSempai
        end
    end
    return newBoard
end



local function printSempai(sempai)
    print("Coraggio: " .. sempai.coraggio ..
            "\nRispetto: " .. sempai.rispetto ..
            "\nGentilezza: " .. sempai.gentilezza ..
            "\nUmilta': " .. sempai.umilta ..
            "\nPosizione: {" .. sempai.posizione.x .. "," .. sempai.posizione.y .. "}" .. "\n")
end


local S = {
    moveSempai = moveSempai,
    printSempai = printSempai
}

return S