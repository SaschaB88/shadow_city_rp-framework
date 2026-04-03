SCRP_Logger = {}

function SCRP_Logger.info(msg)
    print(('[SCRP][INFO] %s'):format(msg))
end

function SCRP_Logger.warn(msg)
    print(('[SCRP][WARN] %s'):format(msg))
end

function SCRP_Logger.error(msg)
    print(('[SCRP][ERROR] %s'):format(msg))
end