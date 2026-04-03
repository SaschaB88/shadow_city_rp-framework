AddEventHandler('playerConnecting', function()
    local src = source
    local player = SCRP_RegisterPlayer(src)

    SCRP_Logger.info(('Connecting: %s (%s)'):format(player.name, src))
end)

AddEventHandler('playerJoining', function()
    local src = source
    local player = SCRP_GetPlayer(src)

    if player then
        player.loaded = true

        TriggerEvent(SCRP_Events.PlayerLoaded, src, player)
        TriggerClientEvent(SCRP_Events.PlayerLoaded, src, {
            source = player.source,
            name = player.name,
            identifiers = player.identifiers
        })

        SCRP_Logger.info(('Loaded: %s (%s)'):format(player.name, src))
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local player = SCRP_GetPlayer(src)

    if player then
        TriggerEvent(SCRP_Events.PlayerDropped, src, reason, player)
        TriggerClientEvent(SCRP_Events.PlayerDropped, src, reason)

        SCRP_Logger.warn(('Dropped: %s (%s)'):format(player.name, src))
        SCRP_RemovePlayer(src)
    end
end)