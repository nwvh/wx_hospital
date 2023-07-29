Citizen.CreateThread(function ()
    for k,v in pairs(wx.Peds) do
        RequestModel(v.Model)
        while not HasModelLoaded(v.model) then Citizen.Wait(10) end
        doctor = CreatePed(0,v.Model,v.Coords.x-0.21,v.Coords.y,v.Coords.z-1,v.Heading,false,true)
        FreezeEntityPosition(doctor, true)
        SetEntityInvincible(doctor,true)
        SetBlockingOfNonTemporaryEvents(doctor,true)
        TaskStartScenarioInPlace(doctor,'PROP_HUMAN_BUM_SHOPPING_CART',0,true)
        local options = {
            {
                name = 'wx_hospital:register',
                event = 'wx_hospital:main',
                distance = wx.MinDistance,
                icon = 'fa-solid fa-briefcase-medical',
                label = wx.Lang.TargetRegister,
            },
            {
                name = 'wx_hospital:buyMedicals',
                event = 'wx_hospital:medicals',
                distance = wx.MinDistance,
                icon = 'fa-solid fa-briefcase-medical',
                label = 'Buy Medicals',
            },
        }
        exports.ox_target:addModel(v.Model, options)
    end
end)
