fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'scrp_db'
author 'ShadowCity RP'
description 'Database wrapper for ShadowCity RP'
version '0.1.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/methods.lua',
    'server/health.lua'
}

dependency 'oxmysql'