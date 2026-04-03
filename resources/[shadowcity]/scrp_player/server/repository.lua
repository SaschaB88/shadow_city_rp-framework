SCRP_PlayerRepository = {}

function SCRP_PlayerRepository.getUserByLicense(license)
    return exports.scrp_db:Single([[
        SELECT id, license, discord_id, fivem_id, last_known_name, created_at, last_seen_at
        FROM users
        WHERE license = ?
        LIMIT 1
    ]], { license })
end

function SCRP_PlayerRepository.createUser(data)
    return exports.scrp_db:Insert([[
        INSERT INTO users (license, discord_id, fivem_id, last_known_name, last_seen_at)
        VALUES (?, ?, ?, ?, NOW())
    ]], {
        data.license,
        data.discord,
        data.fivem,
        data.playerName
    })
end

function SCRP_PlayerRepository.touchUser(userId, playerName, discordId, fivemId)
    return exports.scrp_db:Update([[
        UPDATE users
        SET last_known_name = ?, discord_id = ?, fivem_id = ?, last_seen_at = NOW()
        WHERE id = ?
    ]], {
        playerName,
        discordId,
        fivemId,
        userId
    })
end

function SCRP_PlayerRepository.getUserById(userId)
    return exports.scrp_db:Single([[
        SELECT id, license, discord_id, fivem_id, last_known_name, created_at, last_seen_at
        FROM users
        WHERE id = ?
        LIMIT 1
    ]], { userId })
end