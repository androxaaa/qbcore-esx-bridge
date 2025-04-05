fx_version 'cerulean'
game 'gta5'

author 'androxaaa // uirp.org'
description 'Allows QB-Core scripts to work with es_extended (ESX)'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_script 'shared.lua'

-- This ensures the esx resource is loaded first
dependencies {
    'es_extended'
}
