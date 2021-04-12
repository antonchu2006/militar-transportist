ESX = nil
TriggerEvent('esx:getSharedObjet', function(obj) ESX = obj end)

RegisterServerEvent('militartransportist:setMoney', function(cantidad)
    local user = ESX.GetPlayerFromId(source)
    user.addMoney(cantidad)
end)