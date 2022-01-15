local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local TestController = Knit.CreateController { Name = "TestController" }


function TestController:KnitStart()
    local TestService = Knit.GetService("TestService")

    -- Client -> Server RemoteFunction
    TestService:TestFunction():andThen(function(returnData)
        print(returnData)
    end):catch(warn)

    -- Server -> Client RemoteEvent
    TestService.TestSignal:Connect(function(returnData)
        print("Server time: "..returnData)
        TestService.TestSignal2:Fire("ACK")
    end)

    print("Initialized TestController")
end


function TestController:KnitInit()
    print("Initializing TestController")
end


return TestController
