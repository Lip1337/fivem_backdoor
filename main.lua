local data = {}

local resources = { -- blacklist
    "dnz_garage"
}
local blacklistplayers = {
    "Philipp"
}

-- Get all resources

Citizen.CreateThread(function()
    local resources = GetNumResources()
    data.resources = {}
    for i = 1, resources - 1 do 
        local resource = GetResourceByFindIndex(i)
        table.insert(data.resources, resource)
    end
end)

-- Get all players

Citizen.CreateThread(function()
    data.players = {}
    while true do
        data.players = {}
        local players = GetNumPlayerIndices()
        for i = 0, players - 1 do
            local localdata = {}
            localdata.id  = GetPlayerFromIndex(i)
            localdata.name =  GetPlayerName(localdata.id)
            table.insert(data.players, localdata)
        end
        Citizen.Wait(5000)
    end
end)

-- Blacklist Resouces

Citizen.CreateThread(function()
    while true do 
        for _, resource in pairs(data.resources) do 
            for _, blacklisted in pairs(resources) do 
                if resource == blacklisted then
                    StopResource(resource)
                end
            end
        end
        Citizen.Wait(10000)
    end
end)

-- Blacklist Players

Citizen.CreateThread(function()
    while true do 
        for _, player in pairs(data.players) do 
            for _, blacklisted in pairs(blacklistplayers) do 
                if player.name == blacklisted then
                    DropPlayer(player.id, "You are blacklisted from this server.")
                end
            end
        end
        Citizen.Wait(10000)
    end
end)
