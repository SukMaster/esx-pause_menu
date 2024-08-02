ESX = exports['es_extended']:getSharedObject()

------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('chicle_pause_menu:getPlayerName', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local playerName = xPlayer.getName()
        cb(playerName)
    else
        cb('Unknown')
    end
end)

------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('chicle_pause_menu:getPlayerMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb({
            cash = xPlayer.getMoney(),
            bank = xPlayer.getAccount('bank').money
        })
    else
        cb({
            cash = 0,
            bank = 0
        })
    end
end)

------------------------------------------------------------------------------------------------
