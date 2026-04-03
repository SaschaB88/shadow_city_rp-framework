local function ensureReady()
    if not SCRP_DB.Ready then
        error('[SCRP][DB] Database layer is not ready yet.')
    end
end

function SCRP_DB.scalar(query, params)
    ensureReady()
    return MySQL.scalar.await(query, params or {})
end

function SCRP_DB.single(query, params)
    ensureReady()
    return MySQL.single.await(query, params or {})
end

function SCRP_DB.query(query, params)
    ensureReady()
    return MySQL.query.await(query, params or {})
end

function SCRP_DB.insert(query, params)
    ensureReady()
    return MySQL.insert.await(query, params or {})
end

function SCRP_DB.update(query, params)
    ensureReady()
    return MySQL.update.await(query, params or {})
end

function SCRP_DB.rawExecute(query, params)
    ensureReady()
    return MySQL.rawExecute.await(query, params or {})
end

function SCRP_DB.transaction(queries)
    ensureReady()
    return MySQL.transaction.await(queries)
end

-- Exports for other resources
exports('Scalar', function(query, params)
    return SCRP_DB.scalar(query, params)
end)

exports('Single', function(query, params)
    return SCRP_DB.single(query, params)
end)

exports('Query', function(query, params)
    return SCRP_DB.query(query, params)
end)

exports('Insert', function(query, params)
    return SCRP_DB.insert(query, params)
end)

exports('Update', function(query, params)
    return SCRP_DB.update(query, params)
end)

exports('RawExecute', function(query, params)
    return SCRP_DB.rawExecute(query, params)
end)

exports('Transaction', function(queries)
    return SCRP_DB.transaction(queries)
end)