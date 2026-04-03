SCRP_Table = {}

function SCRP_Table.copy(tbl)
    local new = {}

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            new[k] = SCRP_Table.copy(v)
        else
            new[k] = v
        end
    end

    return new
end