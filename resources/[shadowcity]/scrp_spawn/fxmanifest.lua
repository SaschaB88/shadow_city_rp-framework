fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'scrp_spawn'
author 'ShadowCity RP'
description 'Spawn system'
version '0.1.0'

shared_scripts {
    '@scrp_config/shared/config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'scrp_config',
    'scrp_core'
}