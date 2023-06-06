local utility_function = require("utility.utility")
local war_function = require("sempai.war")

local function moveSempai(board, x, y, dx, dy)

    --Clona la tabella
    local newBoard = utility_function.deepCopy(board)

    --Clona il sempai
    local newSempai = utility_function.deepCopy(newBoard[x][y])

    --Determina le nuove coordinate
    local newX = x + dx
    local newY = y + dy

    if newX >= 1 or newX <= 10 and newY >= 1 or newY <= 10 then

        if newBoard[newX][newY] ~= '-' then

            -- Aggiorna i valori del sempai in base all'elemento speciale trovato
            if newBoard[newX][newY] == 'U' then
                newSempai.umilta = newSempai.umilta + 1
            elseif newBoard[newX][newY] == 'C' then
                newSempai.coraggio = newSempai.coraggio + 1
            elseif newBoard[newX][newY] == 'R' then
                newSempai.rispetto = newSempai.rispetto + 1
            elseif newBoard[newX][newY] == 'G' then
                newSempai.gentilezza = newSempai.gentilezza + 1
            else
                --Clono il sempai trovato
                local otherSempai = utility_function.deepCopy(newBoard[newX][newY])

                --Guerra tra i due sempai
                newBoard, newSempai = war_function.war(newBoard, newSempai, otherSempai)

                if newSempai == nil then
                    return newBoard
                end
            end
            newBoard[x][y] = '-'

            newSempai.posizione.x = newX
            newSempai.posizione.y = newY

            newBoard[newX][newY] = newSempai

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

local M = {
    moveSempai = moveSempai
}

return M