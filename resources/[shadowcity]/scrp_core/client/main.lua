SCRP_Client = {}

SCRP_Client.PlayerLoaded = false
SCRP_Client.PlayerData = {}

RegisterNetEvent('scrp:core:playerLoaded', function(data)
    SCRP_Client.PlayerLoaded = true
    SCRP_Client.PlayerData = data
end)

exports('GetPlayerData', function()
    return SCRP_Client.PlayerData
end)

exports('IsPlayerLoaded', function()
    return SCRP_Client.PlayerLoaded
end)