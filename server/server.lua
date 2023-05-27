RegisterServerEvent('wx_hospital:pay',function(price)
    exports.ox_inventory:RemoveItem(source, wx.MoneyItemName, price)
end)


RegisterServerEvent('wx_hospital:buyBandages',function(amount)
    if amount > 5 then
        if wx.KickCheater then
            DropPlayer(source,wx.Lang.Cheater)
        end
        TriggerServerEvent('wx_hospital:Cheater', GetPlayerName(PlayerId()),amount)
    end
    if exports.ox_inventory:CanCarryItem(source, 'bandage', amount) then
        exports.ox_inventory:AddItem(source, 'bandage', amount)
    end
end)


RegisterServerEvent('wx_hospital:buyMedkit',function(amount)
    if amount > 1 then
        if wx.KickCheater then
            DropPlayer(source,wx.Lang.Cheater)
        end
        TriggerServerEvent('wx_hospital:Cheater', GetPlayerName(PlayerId()),amount)
    end
    if exports.ox_inventory:CanCarryItem(source, 'medikit', amount) then
        exports.ox_inventory:AddItem(source, 'medikit', amount)
    end
end)


RegisterServerEvent('wx_hospital:Cheater',function(player,distance)
    local steam = "Unavailable"
    local license = "Unavailable"
    local discord = "Unavailable"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    local embed = {
        {
            ["color"] = 15548997,
            ["title"] = 'POSSIBLE CHEATER',
            ["description"] = 'Player ** ['..source..'] '..player..'** has bought medicals with distance of **'..distance..'** from the ped!\n\nSteam ID: '..steam..'\nLicense: '..license..'\nDiscord: '..discord,
            ["footer"] = {
                ["text"] = "🛡️ WX HOSPITAL | github.com/nwvh/wx_hospital 🛡️"
            }
        }
    }
    PerformHttpRequest(Webhook.Cheater, function(err, text, headers) end, "POST",json.encode({username = "🛡️ WX ANTICHEAT 🛡️",embeds = embed,avatar_url = "https://cdn.discordapp.com/attachments/1093994717512994936/1096436023791190026/standard8.gif"}),{["Content-Type"] = "application/json"})
end)


RegisterServerEvent('wx_hospital:Cheater2',function(player,amount)
    local steam = "Unavailable"
    local license = "Unavailable"
    local discord = "Unavailable"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    local embed = {
        {
            ["color"] = 15548997,
            ["title"] = 'POSSIBLE CHEATER',
            ["description"] = 'Player ** ['..source..'] '..player..'** has bought **'..amount..'** medicals (Maximum is 5)\n\nSteam ID: '..steam..'\nLicense: '..license..'\nDiscord: '..discord,
            ["footer"] = {
                ["text"] = "🛡️ WX HOSPITAL | github.com/nwvh/wx_hospital 🛡️"
            }
        }
    }
    PerformHttpRequest(Webhook.Cheater, function(err, text, headers) end, "POST",json.encode({username = "🛡️ WX ANTICHEAT 🛡️",embeds = embed,avatar_url = "https://cdn.discordapp.com/attachments/1093994717512994936/1096436023791190026/standard8.gif"}),{["Content-Type"] = "application/json"})
end)
