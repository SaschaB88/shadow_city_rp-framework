RegisterCommand('scrp_db_test', function(source)
    if source ~= 0 then
        print('[SCRP][DB][WARN] This command can only be executed from server console.')
        return
    end

    local result = SCRP_DB.scalar('SELECT 1', {})
    print(('[SCRP][DB][INFO] Test query result: %s'):format(tostring(result)))
end, true)