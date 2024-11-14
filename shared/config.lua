config = {}
config.tick = 5000

config.drugs = {
    ["weed"] = {
        duaration = 15000
    },
    effects = {
        { type = "speed", value = 1.3}
    },
    onEffect = function()
        print("i got called :D")
    end
}