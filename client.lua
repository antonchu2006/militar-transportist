ESX = nil
local PlayerData = {}
local job1 = false
local dinero = 2500

--(-1203.04, 4358.46)           *sitio ilegal
--vector3(-2397, 3316,32.30)    *principio

Citizen.CreateTherad(function()
    while ESX == nil do
        TriggerEvent('esx.getSharedObjet', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(vector3(-2397, 3316, 32.30), coords, true)
        if PlayerData.job ~= nil or PlayerData.job.name == "army" then
            DrawMarker(1, vector3(-2397, 3316, 32.30), 0, 0, 0, 0, 0, 0, 1.0000, 1.0000, 0.6001,0,255,123, 200, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(vector3(-2397, 3316, 32.30), GetEntityCoords(PlayerPedId(), true)) < 1 then
                drawTxt('Presiona ~g~músculo E~s~ para empezar ~r~tu trabajo', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                if IsControlJustPressed(1, 38) then
                    job1 = true
                    ESX.Game.SpawnVehicle('barracks', vector3(-2397, 3316, 32.30), function(vehicle)
                        TaskWarpPedIntroVehicle(PlayerPedId(), vehicle, -1)
                    end)
                    SetNewWaypoint(-1203.04, 4358.46)
                    ESX.ShowNotification("Ve a recoger el cargamento ilegal al punto para incautarlo")
                end
            end
        end
        if job1 == true then
            DrawMarker(1, vector3(-2196.08, 4265.6, 48.02), 0, 0, 0, 0, 0, 0, 1.0000, 1.0000, 0.6001,0,255,123, 200, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(vector3(-2196.08, 4265.6, 48.02), GetEntityCoords(PlayerPedId, true)) < 1 then 
                drawTxt('Reposta', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                local vehicleplayer = GetVehiclePedsIsIn(PlayerPedId())
                FreezeEntityPosition(vehicleplayer, true)
                Wait(3000)
                FreezeEntityPosition(vehicleplayer, false)
                SetNewWaypoint(-2342.96, 3247.31)
                ESX.ShowNotification("Deja el cargamento en la base militar")
                DrawMarker(1, vector3(-2342.96, 3247.31, 32.0), 0, 0, 0, 0, 0, 0, 1.0000, 1.0000, 0.6001,0,255,123, 200, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(vector3(-2342.96, 3247.31, 32.0), GetEntityCoords(PlayerPedId, true)) < 1 then
                    drawTxt('Deja la carga', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
                    if IsControlJustPressed(1, 38) then
                        job1 = false
                        ESX.Game.DeleteVehicle(GetVehiclePedsIsIn(PlayerPedId()))
                        TriggerServerEvent('militartransportist:setMoney', dinero)
                        ESX.ShowNotification("Felicidades, ganaste 2500€")
                    end
                end
            end
        end
    end
end)


function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow()
    SetTextOtline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end



RegisterNetEvent('esx:Player.Loaded')
AddEventHandler('esx:PlayerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end) 