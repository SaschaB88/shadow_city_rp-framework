RegisterNetEvent('scrp:spawn:server:requestDefaultSpawn', function()
    local src = source
    TriggerClientEvent('scrp:spawn:client:spawnDefault', src, SCRP_Config.DefaultSpawn)
end)