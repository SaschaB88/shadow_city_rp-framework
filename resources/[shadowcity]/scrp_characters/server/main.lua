CreateThread(function()
    SCRP_Logger.info('scrp_characters started.')
end)

exports('GetActiveCharacter', function(source)
    local session = exports.scrp_player:GetSession(source)

    if not session then
        return nil
    end

    return session.character
end)

exports('GetCharacters', function(source)
    local characters = SCRP_CharacterService.getCharactersForSource(source)
    return characters
end)

exports('SelectCharacter', function(source, characterId)
    return SCRP_CharacterService.selectCharacter(source, characterId)
end)

-- Test Commands F8 Console
RegisterCommand('scrp_char_list', function(source, args)
    local target = tonumber(args[1] or source)
    if not target or target <= 0 then
        print('[SCRP][CHAR] Invalid source.')
        return
    end

    local characters, err = SCRP_CharacterService.getCharactersForSource(target)
    if not characters then
        print(('[SCRP][CHAR] List failed: %s'):format(err or 'unknown'))
        return
    end

    print(json.encode(characters, { indent = true }))
end, true)

RegisterCommand('scrp_char_create', function(source, args)
    local target = tonumber(args[1] or source)
    if not target or target <= 0 then
        print('[SCRP][CHAR] Invalid source.')
        return
    end

    local character, err = SCRP_CharacterService.createCharacter(target, {
        firstName = args[2] or 'Max',
        lastName = args[3] or 'Mustermann',
        birthDate = '2000-01-01',
        gender = 'm',
        metadata = {}
    })

    if not character then
        print(('[SCRP][CHAR] Create failed: %s'):format(err or 'unknown'))
        return
    end

    print(('[SCRP][CHAR] Created character ID %s for source %s'):format(character.id, target))
end, true)

RegisterCommand('scrp_char_select', function(source, args)
    local target = tonumber(args[1] or source)
    local characterId = tonumber(args[2])

    if not target or target <= 0 or not characterId then
        print('[SCRP][CHAR] Usage: scrp_char_select [source] [characterId]')
        return
    end

    local character, err = SCRP_CharacterService.selectCharacter(target, characterId)

    if not character then
        print(('[SCRP][CHAR] Select failed: %s'):format(err or 'unknown'))
        return
    end

    TriggerClientEvent('scrp:spawn:client:spawnDefault', target, {
        x = character.position.x,
        y = character.position.y,
        z = character.position.z,
        w = character.position.h
    })

    print(('[SCRP][CHAR] Selected character ID %s for source %s'):format(character.id, target))
end, true)