RegisterNetEvent('scrp:spawn:client:spawnDefault', function(coords)
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(0) end

    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(ped, coords.w or 0.0)

    FreezeEntityPosition(ped, false)

    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    Wait(500)
    DoScreenFadeIn(1000)
end)