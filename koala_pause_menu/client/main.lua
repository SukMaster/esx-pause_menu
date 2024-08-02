ESX = exports['es_extended']:getSharedObject()

local PlayerName = nil
local cashAmount = 0
local bankAmount = 0

------------------------------------------------------------------------------------------------

AddEventHandler('esx:playerLoaded', function(playerData)
    ESX.TriggerServerCallback('chicle_pause_menu:getPlayerName', function(cb)
        PlayerName = cb
    end)
    
    ESX.GetPlayerData(function(playerData)
        cashAmount = playerData.money['cash']
        bankAmount = playerData.money['bank']
    end)
end)

------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    local isPauseMenu = false

    while true do
        Citizen.Wait(0)

        if IsPauseMenuActive() then
            if not isPauseMenu then
                isPauseMenu = true
                ESX.GetPlayerData(function(playerData)
                    cashAmount = playerData.money['cash']
                    bankAmount = playerData.money['bank']
                end)

                if PlayerName == nil then
                    ESX.TriggerServerCallback('chicle_pause_menu:getPlayerName', function(cb)
                        PlayerName = cb
                    end)
                end
            end

              -- Space for the subtitle
              BeginScaleformMovieMethodOnFrontendHeader("SHIFT_CORONA_DESC")
              PushScaleformMovieFunctionParameterBool(true)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunction()

              -- The title text
              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADER_TITLE")
              PushScaleformMovieFunctionParameterString(Config.title)
              PushScaleformMovieFunctionParameterBool(true)

              -- The subtitle text
              PushScaleformMovieFunctionParameterString(Config.subtitle)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunctionVoid()

              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
              PushScaleformMovieFunctionParameterString(PlayerName)
              PushScaleformMovieFunctionParameterString((Config.cash_text):format(cashAmount))
              PushScaleformMovieFunctionParameterString((Config.bank_text):format(bankAmount))
              ScaleformMovieMethodAddParamBool(false)
              ScaleformMovieMethodAddParamBool(isScripted)
              EndScaleformMovieMethod() 
              
        else
            if isPauseMenu then
                isPauseMenu = false
            end
        end
    
    end

end)
