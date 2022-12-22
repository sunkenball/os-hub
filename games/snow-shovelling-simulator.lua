--> Variables
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LoadModule        = require(ReplicatedStorage:FindFirstChild("LoadModule"));
local Shovelling        = LoadModule("ShovelTiles")
local Database          = LoadModule("Database")
local TileMod           = LoadModule("TileSelector")

--> Options
local SelectedSnow      = "Slush"
local SelectedFarmMethod= "Shovel"

--> Functions
local GetShovel         = function()
    local Shovel        = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    local Tools         = Database.Tools
    if Tools[Shovel.Name] then
        return Shovel
    end
end
local MineSnow          = function()
    Shovelling(GetShovel(), TileMod.GetTiles())
end
local GetPatch          = function(Type) --> Type --> "Slush" or "Snow"
    local Distance      = math.huge
    local Snow          = nil
    for i,v in next, game:GetService("Workspace").Regions.Winterville.Tiles:GetChildren() do
        local Height    = v:GetAttribute("Height")
        local Typi      = v:GetAttribute("Type")
        local Mag       = (Players.LocalPlayer.Character:GetPivot().Position - v:GetPivot().Position).Magnitude
        if Height > 1 and Typi == Type then
            if Mag < Distance then
                Snow    = v
                Distance= Mag
            end
        end
    end
    return Snow
end

--> Farming Functions

local function BreakSnow()
    local Snow = GetPatch(SelectedSnow)
    Players.LocalPlayer.Character:PivotTo(Snow:GetPivot() + Vector3.new(0,5,0))
    MineSnow()
end

--> User Interface

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Snow Shovelling Simulator",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Snow Shovelling Simulator"
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
    Name = "Auto Shovel",
    CurrentValue = false,
    Flag = "Auto Shovel",
    Callback = function(x)
        getgenv()["Auto Shovel"] = x
        while getgenv()["Auto Shovel"] do
            task.wait()
            task.spawn(BreakSnow)
        end
    end
})

Tab:CreateDropdown({
    Name = "Select Snow",
    CurrentOption = "Snow",
    Flag = "Select Now",
    Options = {"Grey", "White"},
    Callback = function(x)
        SelectedSnow = (x == "Grey" and "Slush" or x == "White" and "Snow")
    end
})


loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)

Rayfield:LoadConfiguration()
