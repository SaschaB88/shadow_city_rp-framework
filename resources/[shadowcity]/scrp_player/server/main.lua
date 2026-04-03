local function loadOrCreateUser(source)
    local playerName = GetPlayerName(source)
    local identifiers = SCRP_Identifier.getAll(source)

    if not identifiers.license then
        SCRP_Logger.error(('Missing license identifier for source %s'):format(source))
        return nil, 'missing_license'
    end

    local user = SCRP_PlayerRepository.getUserByLicense(identifiers.license)

    if not user then
        local insertId = SCRP_PlayerRepository.createUser({
            license = identifiers.license,
            discord = identifiers.discord,
            fivem = identifiers.fivem,
            playerName = playerName
        })

        if not insertId then
            SCRP_Logger.error(('Failed to create user for %s (%s)'):format(playerName, source))
            return nil, 'create_failed'
        end

        user = SCRP_PlayerRepository.getUserById(insertId)
    else
        SCRP_PlayerRepository.touchUser(
            user.id,
            playerName,
            identifiers.discord,
            identifiers.fivem
        )

        user = SCRP_PlayerRepository.getUserById(user.id)
    end

    return user, nil
end

AddEventHandler('scrp:core:playerLoaded', function(source, corePlayer)
    local user, err = loadOrCreateUser(source)

    if not user then
        SCRP_Logger.error(('Failed to load user for source %s: %s'):format(source, err or 'unknown'))
        return
    end

    local session = SCRP_CreatePlayerSession(source, user)

    if corePlayer then
        corePlayer.userId = user.id
        corePlayer.license = user.license
        corePlayer.discordId = user.discord_id
        corePlayer.fivemId = user.fivem_id
    end

    TriggerEvent(SCRP_PlayerEvents.SessionLoaded, source, session, user)

    SCRP_Logger.info(('Player session loaded: %s | userId=%s'):format(
        session.playerName or ('source_' .. source),
        session.userId
    ))
end)

AddEventHandler('playerDropped', function()
    local src = source
    SCRP_RemovePlayerSession(src)
end)

exports('GetSession', function(source)
    return SCRP_GetPlayerSession(source)
end)