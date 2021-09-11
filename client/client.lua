
    local resources
    local enableac = false
    local firstSpawn = true
    
if Aspect.Noclip.Enabled then
    Citizen.CreateThread(function()
        Citizen.Wait(2500) -- Wait 10 seconds
        while true do
            Citizen.Wait(2500)
            local ped = PlayerPedId()
            local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
            local still = IsPedStill(ped)
            local vel = GetEntitySpeed(ped)
            local ped = PlayerPedId()
            Wait(3000) -- wait 3 seconds and check again

            local newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
            local newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
            if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
                TriggerServerEvent("VAC:NoClip", "[Aspect-AC]: " .. Aspect.banmessages.noclip);
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Wait(2500)
        local ped = NetworkIsInSpectatorMode()
        if ped == 1 then
            TriggerServerEvent("VAC:SpectateTrigger", "[Aspect-AC]: " .. Aspect.banmessages.spectate);

        end
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
        if Aspect.AntiWeapons then
			for _,theWeapon in ipairs(Aspect.BlacklistedWeapons) do
				Wait(2500)
				if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
					RemoveAllPedWeapons(PlayerPedId(),false)
                    TriggerServerEvent("VAC:WeaponFlag", "[Aspect-AC]: " .. Aspect.banmessages.BlacklistedWeapon);
				end
			end
		end
	end
end)


if Aspect.PlayerProtection then
    Citizen.CreateThread(function()
        while true do
            local cj = GetPlayerPed(-1)
            SetExplosiveAmmoThisFrame(cj, 0)
            SetExplosiveMeleeThisFrame(cj, 0)
            SetFireAmmoThisFrame(cj, 0)
            SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
            Citizen.Wait(2500)
        end
    end)
end



Citizen.CreateThread(function()
	while true do
		Wait(2500)
			if IsPedJumping(PlayerPedId()) then
				local firstCoord = GetEntityCoords(GetPlayerPed(-1))
				while IsPedJumping(PlayerPedId()) do
					Wait(2500)
				end
				local secondCoord = GetEntityCoords(GetPlayerPed(-1))
				local jumplength = GetDistanceBetweenCoords(firstCoord, secondCoord, false)
				if jumplength > 10.0 then
                    TriggerServerEvent("VAC:Superjump", "[Aspect-AC]: " .. Aspect.banmessages.Superjump);
				end
			end
		end
	end
)

    local isInvincible = false
    local isAdmin = false
    
    Citizen.CreateThread(function()
        while true do
            isInvincible = GetPlayerInvincible(PlayerId())
            isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
            Citizen.Wait(500)
        end
    end)



if Aspect.ThermalVision then
    Citizen.CreateThread(function ()
        Citizen.Wait(2500)
            if GetUsingseethrough(true) then
                TriggerServerEvent("VAC:ThermalVision", "[Aspect-AC]: " .. Aspect.banmessages.ThermalVision);
            end
        end)
    end
    if Aspect.AntiNightVision then
        Citizen.CreateThread(function ()
            while true do
                Citizen.Wait(2500)
                if GetUsingnightvision(true) then
                    TriggerServerEvent("VAC:AntiNightVision", "[Aspect-AC]: " .. Aspect.banmessages.AntiNightVision);
                end
            end
        end)
    end
    if Aspect.AntiInvisble then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2500)
                local ped = GetPlayerPed(-1)
                if GetGameTimer() - 120000  > 0 then
                if not IsEntityVisible(ped) then
                    SetEntityVisible(ped, 1, 0)
                        if isSpawn then
                            TriggerServerEvent("VAC:AntiInvisble", "[Aspect-AC]: " .. Aspect.banmessages.invisible);
                        end
                    end
                end
             end
        end)
    end
    if Aspect.AntiSpeedHack then
        Citizen.CreateThread(function()
      while true do
         Citizen.Wait(2500)
         local ped = GetPlayerPed(-1)
         local speed = GetEntitySpeed(ped)
         local inveh = IsPedInAnyVehicle(ped, false)
         local ragdoll = IsPedRagdoll(ped)
         local jumping = IsPedJumping(ped)
         local falling = IsPedFalling(ped)
               if not inveh then
                    if not ragdoll then
                       if not falling then
                             if not jumping then
                                 if speed > Aspect.MaxSpeed then
                                    TriggerServerEvent("VAC:Speed", "[Aspect-AC]: " .. Aspect.banmessages.pedspeed);
                                end
                             end
                         end
                     end
                  end
              end
         end)
     end


if Aspect.AntiBlips then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2500)
            local playerblips = 0
            local playersonline = GetActivePlayers()
            for i = 1, #playersonline do
                local id = playersonline[i]
                local blipped = GetPlayerPed(id)
                if blipped ~= PlayerPedId(-1) then
                    local blipped = GetBlipFromEntity(blipped)
                    if not DoesBlipExist(blipped) then
                    else
                        playerblips = playerblips+1
                    end
                end
            end
            if playerblips > 0 then
                local src = source
                TriggerServerEvent("VAC:AntiPlayerBlips", "[Aspect-AC]: " .. Aspect.banmessages.PlayerBlips);
            end
        end
    end)
end

if Aspect.AntiKey then
    Citizen.CreateThread(function()
            while true do
                    Wait(2500)
                    local blacklistedKeys = Aspect.BlacklistKeys;
                    for i = 1, #blacklistedKeys do
                            local keyCombo = blacklistedKeys[i][1];
                            local keyStr = blacklistedKeys[i][2];
                            if #keyCombo == 1 then
                                    local key1 = keyCombo[1];
                                    if IsDisabledControlJustReleased(0, key1) then
                           local src = source
                           TriggerServerEvent("VAC:BlacklistedKeys", "[Aspect-AC]: " .. Aspect.banmessages.BlacklistedKeys);
                        end
                            elseif #keyCombo == 2 then
                                    local key1 = keyCombo[1];
                                    local key2 = keyCombo[2];
                                    if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) then
                           local src = source
                           TriggerServerEvent("VAC:BlacklistedKeys", "[Aspect-AC]: " .. Aspect.banmessages.BlacklistedKeys);
                        end
                            elseif #keyCombo == 3 then
                                    local key1 = keyCombo[1];
                                    local key2 = keyCombo[2];
                                    local key3 = keyCombo[3];
                                    if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and
                                    IsDisabledControlPressed(0, key3) then
                           local src = source
                           TriggerServerEvent("VAC:BlacklistedKeys", "[Aspect-AC]: " .. Aspect.banmessages.BlacklistedKeys);
                        end
                            elseif #keyCombo == 4 then
                                    local key1 = keyCombo[1];
                                    local key2 = keyCombo[2];
                                    local key3 = keyCombo[3];
                                    local key4 = keyCombo[4];
                                    if IsDisabledControlPressed(0, key1) and IsDisabledControlPressed(0, key2) and
                                    IsDisabledControlPressed(0, key3) and IsDisabledControlPressed(0, key4) then
                           local src = source
                           TriggerServerEvent("VAC:BlacklistedKeys", "[Aspect-AC]: " .. Aspect.banmessages.BlacklistedKeys);
                        end
                            end
                    end
            end
    end)
   end


   Citizen.CreateThread(function()
    while Aspect.AntiVehicleModifiers do
        Citizen.Wait(2500)
        local _ped = PlayerPedId()
        local _sleep = true
        if IsPedInAnyVehicle(_ped, false) then
            _sleep = false
            local _vehiclein = GetVehiclePedIsIn(_ped, 0)
            if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
                TriggerServerEvent("VAC:VehicleModifier", "[Aspect-AC]: " .. Aspect.banmessages.VehicleModifier);
            end
            if IsVehicleDamaged(_vehiclein) then
                if GetEntityHealth(_vehiclein) >= GetEntityMaxHealth(_vehiclein) then
                    TriggerServerEvent("VAC:VehicleModifier", reason)
                end
            end
            SetEntityInvincible(_vehiclein, false)
            if GetVehicleCheatPowerIncrease(_vehiclein) > 1.0 then
                TriggerServerEvent("VAC:VehicleModifier", "[Aspect-AC]: " .. Aspect.banmessages.VehicleModifier);
            end
            if not GetVehicleTyresCanBurst(_vehiclein) then
                TriggerServerEvent("VAC:VehicleModifier", "[Aspect-AC]: " .. Aspect.banmessages.VehicleModifier);
            end
            if GetVehicleTopSpeedModifier(_vehiclein) > -1.0 then
                TriggerServerEvent("VAC:VehicleModifier", "[Aspect-AC]: " .. Aspect.banmessages.VehicleModifier);
            end
            SetVehicleTyresCanBurst(_vehiclein, true)
            if Aspect.AntiVDM then
                N_0x4757f00bc6323cfe(-1553120962, 0.0)
            end
            end
        end
    end
)

if Aspect.AntiGiveArmour then
    local _armour = GetPedArmour(_ped)
    if _armour > 101 then
        TriggerServerEvent("VAC:AntiGiveArmour", reason)
        end
    end

    if Aspect.AntiResourceStartandStop then
        AddEventHandler("onResourceStop", function(res)
            if res == GetCurrentResourceName() then
                TriggerServerEvent("VAC:resourcestopandstart", "[Aspect-AC]: " .. Aspect.banmessages.resourcestop);
                Citizen.Wait(100)
                CancelEvent()
            else
                TriggerServerEvent("VAC:resourcestopandstart", "[Aspect-AC]: " .. Aspect.banmessages.resourcestop);
                Citizen.Wait(100)
                CancelEvent()
            end
        end)

        AddEventHandler("onClientResourceStop", function(res)
            if res == GetCurrentResourceName() then
                TriggerServerEvent("VAC:resourcestopandstart", "[Aspect-AC]: " .. Aspect.banmessages.resourcestop);
                Citizen.Wait(100)
                CancelEvent()
            else
                TriggerServerEvent("VAC:resourcestopandstart", "[Aspect-AC]: " .. Aspect.banmessages.resourcestop);
                Citizen.Wait(100)
                CancelEvent()
            end
        end)
    end


    if Aspect.AntiGodmode then
        Citizen.CreateThread(function()
            while true do
                local ped = PlayerPedId()
                local player = PlayerId()
                if isInvincible then
                    Citizen.Wait(3000)
                    TriggerServerEvent("VAC:AntiGodMode", "[Aspect-AC]: " .. Aspect.banmessages.godmode);
                    FreezeEntityPosition(ped, true)
                    DisablePlayerFiring(player, true) -- true/false - doesn't seem to do anything different, still disables every frame
                    if isInVeh then
                        FreezeEntityPosition(GetVehiclePedIsIn(ped, false), true)
                        TriggerServerEvent("VAC:AntiGodMode", "[Aspect-AC]: " .. Aspect.banmessages.godmode);
                    end
                else
                    FreezeEntityPosition(ped, false)
                    if isInVeh then
                        FreezeEntityPosition(GetVehiclePedIsIn(ped, false), false)
                        TriggerServerEvent("VAC:AntiGodMode", "[Aspect-AC]: " .. Aspect.banmessages.godmode);
                    end 
                end
                Citizen.Wait(3000)
            end
        end)
    end