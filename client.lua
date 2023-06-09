local QBCore = exports['qb-core']:GetCoreObject()

 local waterCoolers = {-742198632}

local IsAnimated = false

   
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if not IsAnimated then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            for i = 1, #waterCoolers do

                local watercooler = GetClosestObjectOfType(pos, 1.0, waterCoolers[i], false)
                if DoesEntityExist(watercooler) then
                    local markerCoords = GetOffsetFromEntityInWorldCoords(watercooler, 0.0, -0.97, 0.05)
                    local distance = #(pos - markerCoords)
                if distance>1 then
                    local wcoords = GetEntityCoords(watercooler)
                    
                  DrawText3Ds(wcoords.x,wcoords.y,wcoords.z+1, '~g~E~w~ - Drink Water')
                    if IsControlJustReleased(0, 38) then

                        if not IsAnimated then
                            IsAnimated = true

                            TriggerServerEvent('qb-watercooler:refillThirst')

                       
                                end
                            end
                        end
                    end
                end
            end
        end
    end)


function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
  
end

RegisterNetEvent("anim")
AddEventHandler("anim",function(t)
    if t==true then
        
        prop_name = 'prop_cs_paper_cup'

        local playerPed = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(playerPed))
        local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(playerPed, 18905)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

        RequestAnimDict('mp_player_intdrink')
          
            TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

            Citizen.Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(playerPed)
            DeleteObject(prop)
        
        elseif t==false then
            IsAnimated = false

    end
end)



