RegisterNetEvent('wx_hospital:buyMedkit',function ()
    if lib.callback.await('ox_inventory:getItemCount', false, wx.MoneyItemName) >= wx.MedkitPrice then -- Check player's money
        lib.progressBar({
            duration = 2000,
            label = 'Buying Medkit...',
            useWhileDead = true,
            canCancel = true,
            disable = {
                car = true,
                combat = true,
                move = true
            },
        })
        TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 2.0, 1.0, 2000, 16,0,false,false,false)
        Citizen.Wait(1000)
        TriggerServerEvent('wx_hospital:pay',wx.MedkitPrice)
        -- Citizen.Wait(1200)
        TaskPlayAnim(doctor, 'mp_common', 'givetake1_a', 2.0, 1.0, 2000, 16,0,false,false,false)
        Citizen.Wait(3000)
        TriggerServerEvent('wx_hospital:buyMedkit', 1)
        lib.notify({
            title = 'Hospital',
            description = wx.Lang.NotiBoughtMedkit:format(wx.MedkitPrice),
            type = 'success'
        })
    else
        lib.notify({
            title = 'Hospital',
            description = wx.Lang.NotiNoMoney:format(wx.MedkitPrice),
            type = 'error'
        })
    end
end)

RegisterNetEvent('wx_hospital:buyBandages',function ()
    local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(doctor))
    if dist <= wx.MinDistance+5 then
    if lib.callback.await('ox_inventory:getItemCount', false, wx.MoneyItemName) >= wx.BandagePrice then -- Check player's money
        lib.progressBar({
            duration = 2000,
            label = 'Buying Bandages...',
            useWhileDead = true,
            canCancel = true,
            disable = {
                car = true,
                combat = true,
                move = true
            },
        })
        TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 2.0, 1.0, 2000, 16,0,false,false,false)
        Citizen.Wait(1000)
        TriggerServerEvent('wx_hospital:pay',wx.BandagePrice)
        -- Citizen.Wait(1200)
        TaskPlayAnim(doctor, 'mp_common', 'givetake1_a', 2.0, 1.0, 2000, 16,0,false,false,false)
        Citizen.Wait(3000)
        TriggerServerEvent('wx_hospital:buyBandages', 5)
        lib.notify({
            title = 'Hospital',
            description = wx.Lang.NotiBoughtBandage:format(wx.BandagePrice),
            type = 'success'
        })
    else
        lib.notify({
            title = 'Hospital',
            description = wx.Lang.NotiNoMoney:format(wx.BandagePrice),
            type = 'error'
        })
    end
else
    if wx.KickCheater then
        DropPlayer(source, wx.Lang.Cheater)
    end
    TriggerServerEvent('wx_hospital:Cheater', GetPlayerName(PlayerId()),dist)
end
end)