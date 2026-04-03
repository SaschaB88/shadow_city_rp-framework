fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'scrp_player'
author 'ShadowCity RP'
description 'Player identity and session management'
version '0.1.0'

shared_scripts {
    'shared/events.lua'
}

server_scripts {
    '@scrp_lib/shared/logger.lua',
    'server/identifiers.lua',
    'server/repository.lua',
    'server/sessions.lua',
    'server/main.lua'
}

dependencies {
    'scrp_lib',
    'scrp_db',
    'scrp_core'
}