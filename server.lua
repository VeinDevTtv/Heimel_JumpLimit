-- server.lua

local DEBUG = config.debug

RegisterServerEvent('Heimel_JumpLimit:debugMessage')
AddEventHandler('Heimel_JumpLimit:debugMessage', function(playerName, msg)
    if DEBUG then
        print(("[%s] %s"):format(playerName, msg))
    end
end)
