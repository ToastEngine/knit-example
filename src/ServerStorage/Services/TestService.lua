local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TestService = Knit.CreateService {
    Name = "TestService";
    Client = {
        -- Server -> Client RemoteEvent
        TestSignal = Knit.CreateSignal(),
        TestSignal2 = Knit.CreateSignal()
    };
}


-- Client -> Server RemoteFunction
function TestService:Test()
    print("!")
end

function TestService.Client:TestFunction(player: Player)
    self.Server.Test()
    return player.Name
end

function TestService:KnitStart()
    -- Client -> Server RemoteEvent
    TestService.Client.TestSignal2:Connect(function(player: Player, data: StringValue)
        print("Received remote event from @"..player.Name.." - "..data)
    end)


    while task.wait(1) do
        TestService.Client.TestSignal:FireAll(tick())
    end
    print("Intialized TestService")
end


function TestService:KnitInit()
    print("Intializing TestService")
end


return TestService
