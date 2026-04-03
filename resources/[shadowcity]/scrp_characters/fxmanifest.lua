fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'scrp_characters'
author 'ShadowCity RP'
description 'Character management for ShadowCity RP'
version '0.1.0'

shared_scripts {
    'shared/events.lua'
}

server_scripts {
    '@scrp_lib/shared/logger.lua',
    'server/repository.lua',
    'server/services.lua',
    'server/callbacks.lua',
    'server/main.lua'
}

dependencies {
    'scrp_lib',
    'scrp_db',
    'scrp_player',
    'scrp_core'
}