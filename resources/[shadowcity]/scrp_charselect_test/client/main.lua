local SCRP_CharTest = {
    characters = {},
    loaded = false
}

local function printLine(msg)
    print(('[SCRP][CHARTEST] %s'):format(msg))
end

local function chatLine(msg)
    TriggerEvent('chat:addMessage', {
        color = { 0, 170, 255 },
        multiline = false,
        args = { 'SCRP', msg }
    })
end

local function requestCharacterList()
    TriggerServerEvent('scrp:characters:server:requestList')
end

local function printCharacterList(characters)
    if not characters or #characters == 0 then
        printLine('No characters found.')
        chatLine('Keine Charaktere gefunden. Nutze /charcreate Vorname Nachname')
        return
    end

    printLine('Character list:')
    chatLine(('Du hast %s Charakter(e). Siehe F8 oder Chat.'):format(#characters))

    for i = 1, #characters do
        local char = characters[i]
        local fullName = ('%s %s'):format(char.firstName, char.lastName)

        printLine(('[%s] ID=%s | %s | Cash=%s | Bank=%s | Job=%s:%s'):format(
            i,
            char.id,
            fullName,
            char.cash,
            char.bank,
            char.jobName,
            char.jobGrade
        ))

        chatLine(('[%s] ID %s - %s'):format(i, char.id, fullName))
    end
end

RegisterNetEvent('scrp:core:playerLoaded', function()
    SCRP_CharTest.loaded = true

    Wait(1000)
    requestCharacterList()
end)

RegisterNetEvent('scrp:characters:client:sendList', function(success, err, characters)
    if not success then
        printLine(('Character list failed: %s'):format(err or 'unknown'))
        chatLine(('Character-Liste fehlgeschlagen: %s'):format(err or 'unknown'))
        return
    end

    SCRP_CharTest.characters = characters or {}
    printCharacterList(SCRP_CharTest.characters)
end)

RegisterNetEvent('scrp:characters:client:selected', function(success, err, character)
    if not success then
        printLine(('Character select failed: %s'):format(err or 'unknown'))
        chatLine(('Charakter-Auswahl fehlgeschlagen: %s'):format(err or 'unknown'))
        return
    end

    local fullName = ('%s %s'):format(character.firstName, character.lastName)
    printLine(('Character selected: %s (ID %s)'):format(fullName, character.id))
    chatLine(('Charakter ausgewählt: %s (ID %s)'):format(fullName, character.id))
end)

RegisterCommand('charlist', function()
    requestCharacterList()
end, false)

RegisterCommand('charcreate', function(_, args)
    local firstName = args[1]
    local lastName = args[2]

    if not firstName or not lastName then
        chatLine('Nutzung: /charcreate Vorname Nachname')
        return
    end

    TriggerServerEvent('scrp:characters:server:create', {
        firstName = firstName,
        lastName = lastName,
        birthDate = '2000-01-01',
        gender = 'm',
        metadata = {}
    })
end, false)

RegisterCommand('charselect', function(_, args)
    local characterId = tonumber(args[1])

    if not characterId then
        chatLine('Nutzung: /charselect CharakterID')
        return
    end

    TriggerServerEvent('scrp:characters:server:select', characterId)
end, false)

RegisterCommand('charhelp', function()
    chatLine('/charlist - Charaktere laden')
    chatLine('/charcreate Vorname Nachname - Charakter erstellen')
    chatLine('/charselect ID - Charakter auswählen')
end, false)

CreateThread(function()
    Wait(2000)
    chatLine('SCRP Character Test geladen. /charhelp für Befehle')
end)