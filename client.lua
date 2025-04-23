-- client.lua

-- Cache your config and Cfx natives up front
local cfg            = config
local MAX_JUMPS      = cfg.maxJumps
local JUMP_CD        = cfg.jumpCooldown
local RESET_TIME     = cfg.resetTime
local RAGDOLL_TIME   = cfg.ragdollTime
local DEBUG          = cfg.debug

local GetGameTimer       = GetGameTimer
local PlayerPedId        = PlayerPedId
local PlayerId           = PlayerId
local IsPedOnFoot        = IsPedOnFoot
local IsControlJustPressed = IsControlJustPressed
local SetPedToRagdoll    = SetPedToRagdoll
local TriggerServerEvent = TriggerServerEvent
local GetPlayerName      = GetPlayerName

local jumpCount, lastJumpTime = 0, 0
local JUMP_CONTROL = 22 -- default GTA “jump” control

Citizen.CreateThread(function()
    while true do
        -- small wait to reduce CPU load but still catch jump inputs
        Citizen.Wait(10)

        local ped = PlayerPedId()
        -- only count a jump when the player actually presses the jump key and is on foot
        if IsPedOnFoot(ped) and IsControlJustPressed(0, JUMP_CONTROL) then
            local now = GetGameTimer()
            if now - lastJumpTime >= JUMP_CD then
                lastJumpTime = now
                jumpCount = jumpCount + 1

                if DEBUG then
                    TriggerServerEvent('Heimel_JumpLimit:debugMessage',
                        GetPlayerName(PlayerId()),
                        ("Jump #%d detected"):format(jumpCount)
                    )
                end

                if jumpCount > MAX_JUMPS then
                    SetPedToRagdoll(ped, RAGDOLL_TIME, RAGDOLL_TIME, 0, 0, 0, 0)
                    if DEBUG then
                        TriggerServerEvent('Heimel_JumpLimit:debugMessage',
                            GetPlayerName(PlayerId()),
                            "Ragdolled for exceeding max jumps."
                        )
                    end
                end
            end
        end

        -- reset count after enough idle time
        if GetGameTimer() - lastJumpTime >= RESET_TIME then
            jumpCount = 0
        end
    end
end)
