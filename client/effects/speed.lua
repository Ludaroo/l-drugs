Drugs.Speed = {
    Name = locale('speed'),
    Tick = 1000,
    Max = 90000
    DefaultValue = 0,
    onTick = function(player, effect)
        SetRunSprintMultiplierForPlayer(PlayerId(), effect.Value)
    end,
}