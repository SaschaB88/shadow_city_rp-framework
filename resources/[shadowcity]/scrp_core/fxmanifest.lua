fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'scrp_core'
author 'ShadowCity RP'
description 'Core system'
version '0.1.0'

shared_scripts {
    'shared/events.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@scrp_lib/shared/logger.lua',
    'server/main.lua',
    'server/players.lua',
    'server/events.lua'
}

dependency 'scrp_lib'