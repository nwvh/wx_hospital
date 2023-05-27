fx_version "cerulean"
description "NPC Doctor for your FiveM server"
game "gta5"
lua54 "yes"

client_scripts {
    'configs/*.lua',
    'client/*.lua'
}
server_scripts {'configs/config_webhook.lua','server/*.lua'}

shared_scripts {'configs/*.lua','@ox_lib/init.lua'}