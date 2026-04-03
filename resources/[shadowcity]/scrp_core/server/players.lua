SCRP_Players = {}

function SCRP_RegisterPlayer(source)
    SCRP_Players[source] = {
        source = source,
        name = GetPlayerName(source),
        identifiers = GetPlayerIdentifiers(source),
        loaded = false
    }

    return SCRP_Players[source]
end

function SCRP_GetPlayer(source)
    return SCRP_Players[source]
end

function SCRP_RemovePlayer(source)
    SCRP_Players[source] = nil
end