RegisterNetEvent(SCRP_CharacterEvents.ListRequested, function()
    local src = source

    local characters, err = SCRP_CharacterService.getCharactersForSource(src)

    if not characters then
        SCRP_Logger.error(('Character list failed for source %s: %s'):format(src, err or 'unknown'))
        TriggerClientEvent(SCRP_CharacterEvents.SendList, src, false, err, {})
        return
    end

    TriggerClientEvent(SCRP_CharacterEvents.SendList, src, true, nil, characters)
end)

RegisterNetEvent(SCRP_CharacterEvents.CreateRequested, function(payload)
    local src = source

    local character, err = SCRP_CharacterService.createCharacter(src, payload)

    if not character then
        SCRP_Logger.error(('Character create failed for source %s: %s'):format(src, err or 'unknown'))
        TriggerClientEvent(SCRP_CharacterEvents.SendList, src, false, err, {})
        return
    end

    local characters, listErr = SCRP_CharacterService.getCharactersForSource(src)

    if not characters then
        SCRP_Logger.error(('Character reload after create failed for source %s: %s'):format(src, listErr or 'unknown'))
        TriggerClientEvent(SCRP_CharacterEvents.SendList, src, false, listErr, {})
        return
    end

    TriggerClientEvent(SCRP_CharacterEvents.SendList, src, true, nil, characters)
end)

RegisterNetEvent(SCRP_CharacterEvents.SelectRequested, function(characterId)
    local src = source

    local character, err = SCRP_CharacterService.selectCharacter(src, characterId)

    if not character then
        SCRP_Logger.error(('Character select failed for source %s: %s'):format(src, err or 'unknown'))
        TriggerClientEvent(SCRP_CharacterEvents.CharacterSelected, src, false, err, nil)
        return
    end

    TriggerClientEvent(SCRP_CharacterEvents.CharacterSelected, src, true, nil, character)
    TriggerClientEvent('scrp:spawn:client:spawnDefault', src, {
        x = character.position.x,
        y = character.position.y,
        z = character.position.z,
        w = character.position.h
    })
end)