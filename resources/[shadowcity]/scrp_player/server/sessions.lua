SCRP_PlayerSessions = {}

function SCRP_CreatePlayerSession(source, user)
    local session = {
        source = source,
        userId = user.id,
        license = user.license,
        discordId = user.discord_id,
        fivemId = user.fivem_id,
        playerName = user.last_known_name,
        loadedAt = os.time(),
        characterId = nil,
        character = nil
    }

    SCRP_PlayerSessions[source] = session
    return session
end

function SCRP_GetPlayerSession(source)
    return SCRP_PlayerSessions[source]
end

function SCRP_RemovePlayerSession(source)
    SCRP_PlayerSessions[source] = nil
end