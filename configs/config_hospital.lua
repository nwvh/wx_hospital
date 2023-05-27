wx = {}

wx.Peds = {
    ['Pillbox'] = { -- Name doesn't matter, just so you know what is what
        Model = `s_m_m_doctor_01`,
        Coords = vector3(308.3987, -595.3810, 43.2840),
        Heading = 70.0
    }
}


wx.BedLocation = vector4(314.32, -584.5, 43.2, 336.63)
wx.RespawnLocation = vector4(310.2405, -573.5384, 43.2840, 92.2840) -- Where should the player respawn? (X, Y, Z, HEADING)
wx.HealTime = 10 -- [IN SECONDS] How long should the player be laying down?
wx.MinDistance = 3.0 -- [FLOAT VALUE] How far can player be for the target option to dissapear
wx.MoneyItemName = 'money' -- If you changed your money item name, change it here too. Otherwise leave as default
wx.Cost = 500 -- Price for the heal
wx.MedkitPrice = 5000 -- Price for medkit
wx.BandagePrice = 1500 -- Price for bandage
wx.KickCheater = true -- Kick possible cheaters?

wx.Lang = { -- Translations
    TargetRegister = "Register",
    Waiting = "Waiting for doctor...",
    ProgPaperwork = "Doing some paperwork...",
    ProgTakingCare = "You are recovering...",
    ProgWakingUp = "Waking up...",
    ProgTalking = "You're talking with doctor...",
    NotiNoMoney = "You don't have enough money on you. You need %s$",
    NotiCancel = "You've cancelled the registration",
    NotiDoctorArrived = "Doctor has taken care of you!",
    NotiBoughtBandage = "You have bought bandage pack for %s$",
    NotiBoughtMedkit = "You have bought medkit for %s$",
    Cheater = "You have been kicked for cheating! Your actions have been reported to staff"
}