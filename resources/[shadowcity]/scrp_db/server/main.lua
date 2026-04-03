SCRP_DB = {}
SCRP_DB.Ready = false

CreateThread(function()
    Wait(500)

    local state = GetResourceState('oxmysql')

    if state ~= 'started' then
        print(('[SCRP][DB][ERROR] oxmysql state is "%s", expected "started".'):format(state))
        return
    end

    SCRP_DB.Ready = true
    print('[SCRP][DB][INFO] scrp_db started.')
end)