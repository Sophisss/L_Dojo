local sempai_function = require("sempai")
local U = {}


function U.playGong(board)
    local directions = {"Nord", "Sud", "Est", "Ovest"}
    local numSempai = sempai_function.countSempai(board)
    local gongDirections = {}

    -- Genera una direzione casuale per ogni sempai
    for i = 1, numSempai do
        local randomIndex = math.random(1, #directions)
        gongDirections[i] = directions[randomIndex]
    end

    return gongDirections
end



return U