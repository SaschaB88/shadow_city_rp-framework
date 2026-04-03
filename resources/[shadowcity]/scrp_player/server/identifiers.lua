SCRP_Identifier = {}

local function findIdentifier(source, prefix)
    local identifiers = GetPlayerIdentifiers(source)

    for _, identifier in ipairs(identifiers) do
        if identifier:sub(1, #prefix) == prefix then
            return identifier
        end
    end

    return nil
end

function SCRP_Identifier.getAll(source)
    return {
        license = findIdentifier(source, 'license:'),
        discord = findIdentifier(source, 'discord:'),
        fivem = findIdentifier(source, 'fivem:')
    }
end