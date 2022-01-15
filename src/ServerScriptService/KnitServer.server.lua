local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServices(ServerStorage.Source.Services)

local function Logger(player: Player, args: {any})
    warn(player.Name, args)
    return true
end

Knit.Start({
    Middleware = {Inbound = {Logger}}
}):andThen(function()
    print("Knit started")
end):catch(warn)