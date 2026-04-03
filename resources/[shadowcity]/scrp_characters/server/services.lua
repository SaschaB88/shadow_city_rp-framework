SCRP_CharacterService = {}

local function normalizeMetadata(metadata)
    if metadata == nil or metadata == '' then
        return '{}'
    end

    if type(metadata) == 'table' then
        return json.encode(metadata)
    end

    return metadata
end

local function safeCharacterView(character)
    if not character then
        return nil
    end

    return {
        id = character.id,
        userId = character.user_id,
        firstName = character.first_name,
        lastName = character.last_name,
        birthDate = character.birth_date,
        gender = character.gender,
        cash = character.cash,
        bank = character.bank,
        jobName = character.job_name,
        jobGrade = character.job_grade,
        position = {
            x = character.pos_x,
            y = character.pos_y,
            z = character.pos_z,
            h = character.pos_h
        },
        metadata = character.metadata,
        createdAt = character.created_at,
        updatedAt = character.updated_at
    }
end

function SCRP_CharacterService.getCharactersForSource(source)
    local session = exports.scrp_player:GetSession(source)

    if not session then
        return nil, 'session_not_found'
    end

    local characters = SCRP_CharacterRepository.getByUserId(session.userId)

    for i = 1, #characters do
        characters[i] = safeCharacterView(characters[i])
    end

    return characters, nil
end

function SCRP_CharacterService.createCharacter(source, payload)
    local session = exports.scrp_player:GetSession(source)

    if not session then
        return nil, 'session_not_found'
    end

    if not payload then
        return nil, 'payload_missing'
    end

    local firstName = tostring(payload.firstName or ''):gsub('^%s+', ''):gsub('%s+$', '')
    local lastName = tostring(payload.lastName or ''):gsub('^%s+', ''):gsub('%s+$', '')
    local birthDate = payload.birthDate
    local gender = payload.gender or 'unknown'

    if firstName == '' or lastName == '' then
        return nil, 'invalid_name'
    end

    local existingCharacters = SCRP_CharacterRepository.getByUserId(session.userId)
    if #existingCharacters >= 3 then
        return nil, 'character_limit_reached'
    end

    local insertId = SCRP_CharacterRepository.create({
        userId = session.userId,
        firstName = firstName,
        lastName = lastName,
        birthDate = birthDate,
        gender = gender,
        cash = SCRP_Config.StartCash,
        bank = SCRP_Config.StartBank,
        jobName = 'unemployed',
        jobGrade = 0,
        posX = SCRP_Config.DefaultSpawn.x,
        posY = SCRP_Config.DefaultSpawn.y,
        posZ = SCRP_Config.DefaultSpawn.z,
        posH = SCRP_Config.DefaultSpawn.w,
        metadata = normalizeMetadata(payload.metadata)
    })

    if not insertId then
        return nil, 'create_failed'
    end

    local character = SCRP_CharacterRepository.getById(insertId)
    if not character then
        return nil, 'character_not_found_after_create'
    end

    return safeCharacterView(character), nil
end

function SCRP_CharacterService.selectCharacter(source, characterId)
    local session = exports.scrp_player:GetSession(source)

    if not session then
        return nil, 'session_not_found'
    end

    local numericCharacterId = tonumber(characterId)
    if not numericCharacterId then
        return nil, 'invalid_character_id'
    end

    local character = SCRP_CharacterRepository.getByIdAndUserId(numericCharacterId, session.userId)
    if not character then
        return nil, 'character_not_found'
    end

    local mappedCharacter = safeCharacterView(character)

    session.characterId = mappedCharacter.id
    session.character = mappedCharacter

    return mappedCharacter, nil
end

function SCRP_CharacterService.saveCharacterPosition(source, coords)
    local session = exports.scrp_player:GetSession(source)

    if not session or not session.characterId then
        return false, 'no_active_character'
    end

    if not coords then
        return false, 'coords_missing'
    end

    local ok = SCRP_CharacterRepository.updatePosition(session.characterId, {
        x = coords.x or 0.0,
        y = coords.y or 0.0,
        z = coords.z or 0.0,
        h = coords.h or coords.w or 0.0
    })

    return ok and true or false, ok and nil or 'update_failed'
end