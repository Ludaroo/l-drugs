fx_version("cerulean")
game("gta5")
lua54("yes")

author("Ludaro & Emma")
version("1.0.0")

client_scripts({
<<<<<<< HEAD
	'client/init.lua',
	"client/*.lua"
=======
    "client/init.lua",
    "client/*.lua"
>>>>>>> 6738e8d3d45ebfd4600e9bb4a4da6191bda5437b
})

server_scripts({
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
})

shared_scripts({
    "shared/*.lua",
    "@ox_lib/init.lua",
    "config/*.lua"
})

ui_page({
    "html/dist/index.html",
})

dependencies {
    "ox_lib",
    "oxmysql",
    "es_extended"
}

files({
    "locales/*.json",
    "html/dist/**"
})
