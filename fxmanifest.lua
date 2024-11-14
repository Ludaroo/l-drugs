fx_version("cerulean")
game("gta5")
lua54("yes")

author("Ludaro & Emma")
version("1.0.0")

client_scripts({
	'client/init.lua'
	"client/*.lua",
})

server_scripts({
	"@oxmysql/lib/MySQL.lua",
	"server/*.lua",
})

shared_scripts({
	"shared/*.lua",
	"@ox_lib/init.lua",
	"config/*.lua"
})

ui_page({
	"html/dist/index.html",
})

<<<<<<< HEAD
dependencies {(
	'ox_lib',
	'oxmysql',
	'es_extended'
)}
=======
dependencies {
	'ox_lib',
	'oxmysql',
	'es_extended'
}
>>>>>>> e54a84f5e9a7543ce04dc1db41a18627b69238c2

files({
	'locales/*.json'
	"html/dist/**",
})
