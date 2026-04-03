SCRP_CharacterRepository = {}

function SCRP_CharacterRepository.getByUserId(userId)
    return exports.scrp_db:Query([[
        SELECT
            id,
            user_id,
            first_name,
            last_name,
            birth_date,
            gender,
            cash,
            bank,
            job_name,
            job_grade,
            pos_x,
            pos_y,
            pos_z,
            pos_h,
            metadata,
            created_at,
            updated_at
        FROM characters
        WHERE user_id = ?
        ORDER BY id ASC
    ]], { userId })
end

function SCRP_CharacterRepository.getById(characterId)
    return exports.scrp_db:Single([[
        SELECT
            id,
            user_id,
            first_name,
            last_name,
            birth_date,
            gender,
            cash,
            bank,
            job_name,
            job_grade,
            pos_x,
            pos_y,
            pos_z,
            pos_h,
            metadata,
            created_at,
            updated_at
        FROM characters
        WHERE id = ?
        LIMIT 1
    ]], { characterId })
end

function SCRP_CharacterRepository.getByIdAndUserId(characterId, userId)
    return exports.scrp_db:Single([[
        SELECT
            id,
            user_id,
            first_name,
            last_name,
            birth_date,
            gender,
            cash,
            bank,
            job_name,
            job_grade,
            pos_x,
            pos_y,
            pos_z,
            pos_h,
            metadata,
            created_at,
            updated_at
        FROM characters
        WHERE id = ? AND user_id = ?
        LIMIT 1
    ]], { characterId, userId })
end

function SCRP_CharacterRepository.create(data)
    return exports.scrp_db:Insert([[
        INSERT INTO characters (
            user_id,
            first_name,
            last_name,
            birth_date,
            gender,
            cash,
            bank,
            job_name,
            job_grade,
            pos_x,
            pos_y,
            pos_z,
            pos_h,
            metadata
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]], {
        data.userId,
        data.firstName,
        data.lastName,
        data.birthDate,
        data.gender,
        data.cash,
        data.bank,
        data.jobName,
        data.jobGrade,
        data.posX,
        data.posY,
        data.posZ,
        data.posH,
        data.metadata
    })
end

function SCRP_CharacterRepository.updatePosition(characterId, pos)
    return exports.scrp_db:Update([[
        UPDATE characters
        SET pos_x = ?, pos_y = ?, pos_z = ?, pos_h = ?
        WHERE id = ?
    ]], {
        pos.x,
        pos.y,
        pos.z,
        pos.h,
        characterId
    })
end