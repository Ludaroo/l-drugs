fx_version('cerulean')
game('gta5')
lua54('yes')

author('Ludaro & Emma')
version('1.0.0')

client_scripts({
	'client/init.lua',
	'client/**/*',
})

server_scripts({
    '@oxmysql/lib/MySQL.lua',
    'server/init.lua',
    'server/**/*'
})

shared_scripts({
    'shared/*.lua',
    '@ox_lib/init.lua',
    'config/*.lua'
})

ui_page({
    'html/dist/index.html',
})

dependencies {
    'ox_lib',
    'oxmysql',
    'es_extended'
}

files({
    'locales/*.json',
    'html/dist/**'
})
