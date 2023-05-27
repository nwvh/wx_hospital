
--  ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
--  ├┤ │ │││││   │ ││ ││││└─┐
--  └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘

-- Function to clear player's props
function ClearProps()
    for _,v in pairs(Props) do
      DeleteEntity(v)
    end
end

-- Function to add prop to player
function SpawnProp(prop1, bone, offset1, offset2, offset3, rotation1, rotation2, rotation3)
    local player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(player))
  
    if not HasModelLoaded(prop1) then
        while not HasModelLoaded(GetHashKey(prop1)) do
            RequestModel(GetHashKey(prop1))
            Wait(10)
          end
    end
  
    local prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, bone), offset1, offset2, offset3, rotation1, rotation2, rotation3, true, true, false, true, 1, true)
    table.insert(Props, prop)
    SetModelAsNoLongerNeeded(prop1)
end


-- If the script stops, it will clear all props to avoid them being stuck
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
      ClearProps()
    end
end)