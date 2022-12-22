local Players = game:GetService("Players")
local RemoteNetwork = require(game:GetService("ReplicatedStorage").Postie)
local ScriptNetwork = loadstring(game:HttpGet("https://soggy-ware.cf/Libs/Utility.lua"))().Network

local function CollectCoins()
    for i,v in next, game:GetService("Workspace").PlayerCollectables:GetChildren() do
        if v:FindFirstChild("Owner") and v:FindFirstChild("Owner").Value == Players.LocalPlayer then
            v.Position = Players.LocalPlayer.Character:GetPivot().Position
        end
    end
end

local function Swing()
    RemoteNetwork.SignalServer("ClickSlash_"..Players.LocalPlayer.UserId)
end

local function GetEggs()
    local EggsFiltered = {}
    for i,v in next, require(game:GetService("ReplicatedStorage").Market.Eggs) do
        if rawget(v, "Pets") then
            table.insert(EggsFiltered, i:gsub("_", " "))
        end
    end
    return EggsFiltered
end

local function GetSwords()
    local EggsFiltered = {}
    for i,v in next, require(game:GetService("ReplicatedStorage").Market.Eggs) do
        if rawget(v, "Swords") then
            table.insert(EggsFiltered, i:gsub("_", " "))
        end
    end
    return EggsFiltered
end

local function GetMethods()
    return {
        "Coins",
        "Gems"
    }
end

local function HatchEgg()
    ScriptNetwork:Fire("HatchEgg", unpack({
        getgenv()["Egg"],
        "Pets",
        getgenv()["Method"]
    }))
end

local function HatchSword()
    ScriptNetwork:Fire("HatchEgg", unpack({
        getgenv()["Sword"],
        "Swords",
        getgenv()["Method"]
    }))
end

local function ClaimRewards()
    for i = 0, 300*11, 300 do
        local args = {[1]="ClaimPlaytimeGift",[2]=game:GetService("HttpService"):GenerateGUID(false),[3]=i}
        ScriptNetwork:Fire("Sent", unpack(args))
    end
end

local function GetClosestMob()
    local Mob, Distance = nil, math.huge
    for i,v in next, game:GetService("Workspace").Maps:GetDescendants() do
        if v:IsA("Model") and v ~= nil and v:FindFirstChild("Stats") and v.Stats:FindFirstChild("Health") and v.Stats.Health.Value ~= 0 then
            if v.Parent.Parent.Name == "SlashableObjects" then
                local Maggy = (Players.LocalPlayer.Character:GetPivot().Position - v:GetPivot().Position).Magnitude
                if Maggy < Distance then
                    Distance = Maggy
                    Mob = v
                end
            end
        end
    end
    return Mob
end

local function KillMob()
    local Mob = GetClosestMob()
    if Mob ~= nil and Mob.Parent ~= nil then
        repeat
            task.wait()
            Players.LocalPlayer.Character:PivotTo(Mob:GetPivot() + Vector3.new(0,0,3))
            task.spawn(Swing)
        until Mob:FindFirstChild("Stats") and Mob.Stats:FindFirstChild("Health") and Mob.Stats.Health.Value == 0
    end
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Slashing Simulator 2",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Slashing Simulator 2"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})
local Tab = Window:CreateTab("Home Tab", 11600721595)

Tab:CreateSection("Information")
Tab:CreateLabel("Release")

local Tab = Window:CreateTab("Farming Tab", 11696994871)

Tab:CreateSection("Farming")

Tab:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Flag = "Auto Swing",
    Callback = function(x)
        getgenv()["Auto Swing"] = x
        while getgenv()["Auto Swing"] == true do
            task.wait(0.05)
            if getgenv()["Auto Swing"] == false then
                break
            else
                task.spawn(Swing)
            end
        end
    end
})

Tab:CreateToggle({
    Name = "Auto Kill Mobs",
    CurrentValue = false,
    Flag = "Auto Kill Mobs",
    Callback = function(x)
        getgenv()["Auto Kill Mobs"] = x
        while getgenv()["Auto Kill Mobs"] == true do
            task.wait(0.05)
            if getgenv()["Auto Kill Mobs"] == false then
                break
            else
                task.spawn(KillMob)
            end
        end
    end
})

Tab:CreateToggle({
    Name = "Auto Collect Drops",
    CurrentValue = false,
    Flag = "Auto Collect Drops",
    Callback = function(x)
        getgenv()["Auto Collect Drops"] = x
        while getgenv()["Auto Collect Drops"] == true do
            task.wait(0.05)
            if getgenv()["Auto Collect Drops"] == false then
                break
            else
                task.spawn(CollectCoins)
            end
        end
    end
})

Rayfield:LoadConfiguration()
