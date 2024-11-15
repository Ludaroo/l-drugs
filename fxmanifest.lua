fx_version('cerulean')
game('gta5')
lua54('yes')

author('Ludaro & Emma')
version('1.0.0')

client_scripts({
	'client/init.lua',
<<<<<<< HEAD
	'client/**/*',
=======
	"client/*.lua"
>>>>>>> e9a6e6a9dc4c0ce10a1ec022043ff3162c4510a5
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
