Props = {} -- Table for player props

-- OX Lib callback to get player's money
lib.callback('ox_inventory:getItemCount', false, function(count)
    return count
end, wx.MoneyItemName)


-- ┌┬┐┌─┐┬┌┐┌  ┌─┐┬  ┬┌─┐┌┐┌┌┬┐
-- │││├─┤││││  ├┤ └┐┌┘├┤ │││ │ 
-- ┴ ┴┴ ┴┴┘└┘  └─┘ └┘ └─┘┘└┘ ┴ 

RegisterNetEvent('wx_hospital:medicals',function ()
    TaskStartScenarioInPlace(doctor,'PROP_HUMAN_STAND_IMPATIENT',0,true)

    lib.progressBar({
        duration = 3500,
        label = wx.Lang.ProgTalking,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'missfbi3_party_d',
            clip = 'stand_talk_loop_a_male2'
        },
    })

    lib.registerContext({
        id = 'wx_hospital:buyMedicals',
        title = 'Medical Store',
        options = {
            {
                title = "Medikit",
                icon = "fas fa-plus",
                arrow = false,
                event = "wx_hospital:buyMedkit",
                metadata = {'1x Medikit for more serious injuries'}
            },
            {
                title = "Bandage Pack (5x)",
                icon = "fas fa-bandage",
                arrow = false,
                event = "wx_hospital:buyBandages",
                metadata = {'Pack of five bandages for smaller injuries'}
            }
        }
    })
    lib.showContext('wx_hospital:buyMedicals')
    Citizen.Wait(5000)
    ClearPedTasks(doctor)

end)

RegisterNetEvent('wx_hospital:main',function()
    if lib.callback.await('ox_inventory:getItemCount', false, wx.MoneyItemName) >= wx.Cost then -- Check player's money
        TriggerEvent('ox_inventory:disarm', PlayerId(), true) -- Disarm player
        SpawnProp("prop_pencil_01", 58866, 0.11, -0.02, 0.001, -100.0, 0.0, 0.0) -- Add prop to player (couldn't make it work with ox_lib progressbar)
        SpawnProp("p_amb_clipboard_01", 18905, 0.09, 0.12, 0.06, -101.0, 0.0, 0.0) -- Add prop to player (couldn't make it work with ox_lib progressbar)
        if lib.progressBar({
            duration = 7000,
            label = wx.Lang.ProgPaperwork,
            useWhileDead = true,
            canCancel = true,
            disable = {
                car = true,
                combat = true,
                move = true
            },
            anim = {
                dict = 'amb@medic@standing@timeofdeath@enter',
                clip = 'enter'
            },
        }) then
            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 2.0, 1.0, 2000, 16,0,false,false,false)
            Citizen.Wait(2000)
            ClearProps()

            TaskStartScenarioInPlace(PlayerPedId(),'CODE_HUMAN_CROSS_ROAD_WAIT',0,true)
            lib.progressBar({
                duration = 10000,
                label = wx.Lang.Waiting,
                useWhileDead = true,
                canCancel = false,
                disable = {
                    car = true,
                    combat = true,
                    move = true
                },
            })
            ClearPedTasks(PlayerPedId())
            lib.notify({
                title = 'Hospital',
                description = wx.Lang.NotiDoctorArrived,
                type = 'success'
            })
        
            TriggerServerEvent('wx_hospital:pay', wx.Cost)
            DoScreenFadeOut(500)
            ClearProps()
            SetTimeout(500, function()
                SetEntityCoords(PlayerPedId(), wx.BedLocation.x, wx.BedLocation.y, wx.BedLocation.z, 1,0,0,1)
                SetEntityHeading(PlayerPedId(), wx.BedLocation[4])
                TaskPlayAnim(PlayerPedId(),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 80000, 1, 120, false, false, false)
                DoScreenFadeIn(500)
                lib.progressBar({
                    duration = wx.HealTime*1000,
                    label = wx.Lang.ProgTakingCare,
                    useWhileDead = true,
                    canCancel = false,
                    disable = {
                        car = true,
                        combat = true,
                        move = true
                    },       
                })
                lib.progressBar({
                    duration = 2500,
                    label = wx.Lang.ProgWakingUp,
                    useWhileDead = true,
                    canCancel = false,
                    disable = {
                        car = true,
                        combat = true,
                        move = true
                    },
                })
                SetEntityHealth(PlayerPedId(), 200)
                DoScreenFadeOut(600)
                SetTimeout(500, function()
                    SetEntityCoords(PlayerPedId(), wx.RespawnLocation.x,wx.RespawnLocation.y,wx.RespawnLocation.z, 1,0,0,1)
                    SetEntityHeading(PlayerPedId(), wx.RespawnLocation[4])
                    SetTimeout(1000, function()
                        DoScreenFadeIn(1000)
                        ClearProps()
                    end)
                end)
            end)
        else
            ClearProps()
            lib.notify({
                title = 'Hospital',
                description = wx.Lang.NotiCancel,
                type = 'error'
            })
        end
    else
        lib.notify({
            title = 'Hospital',
            description = wx.Lang.NotiNoMoney:format(wx.Cost),
            type = 'error'
        })
    end
end)