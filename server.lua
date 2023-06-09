local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('qb-watercooler:refillThirst')
AddEventHandler('qb-watercooler:refillThirst', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

oldthirst= Player.PlayerData.metadata['thirst']
print(oldthirst)

if oldthirst<100  then
	
newThirst=oldthirst+10
print(newThirst)
TriggerClientEvent("anim",source,true)
Player.Functions.SetMetaData('thirst', newThirst)
TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], newThirst)
	    Player.Functions.Save()
elseif  oldthirst>100 or oldthirst==100 then
	print("full")
	TriggerClientEvent("anim",source,false)

end
end)
