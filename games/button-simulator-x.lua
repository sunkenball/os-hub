--> Tables In Indexes Of A Table
local Buttons = {
    ["Rebirths"] = {

    },
    ["Ultra Rebirth"] = {

    },
    ["Prestige"] = {

    },
    ["Ultra Prestige"] = {

    }
}
--> Removes Unnecessary Text
local function FilterText(Text)
    local Location = Text:find("=")
    local Subbed   = Text:sub(1,Location-2)
    return Subbed
end
--> Gives Me The Correct Button
local function Fetch(Text)
    for i,v in next, game:GetService("Workspace").Buttons:GetDescendants() do
        if v:IsA("TextLabel") and v.Name == "DisplayText" then
            if v.Text:find(Text) then
                return v.Parent.Parent.Parent.Parent
            end
        end
    end
end
--> Yes
local function Touch(Part)
    for i = 0, 1 do
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.LeftFoot, Part.Touch, i)
    end
end
--> Feeding The Tables
for i,v in next, game:GetService("Workspace").Buttons:GetDescendants() do
    if v:IsA("TextLabel") and v.Name == "DisplayText" then
        if v.Text:find("Rebirth") and not v.Text:find("Ultra") then
            table.insert(Buttons.Rebirths, FilterText(v.Text))
        end
        if v.Text:find("Ultra Rebirth") and not v.Text:find("Prestige") then
            table.insert(Buttons["Ultra Rebirth"], FilterText(v.Text))
        end
        if v.Text:find("Prestige") and v.Text:find("Ultra Rebirth") then
            table.insert(Buttons["Prestige"], FilterText(v.Text))
        end
        if v.Text:find("Ultra Prestige") and not v.Text:find("Power") then
            table.insert(Buttons["Ultra Prestige"], FilterText(v.Text))
        end
    end
end
--> UI Crap
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Buton Simalt",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Buton Simalt"
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
    Name = "Press Selected Buttons",
    Flag = "Press Selected Buttons",
    CurrentValue = false,
    Callback = function(x)
        getgenv()["Press Selected Buttons"] = x
        while getgenv()["Press Selected Buttons"] == true do
            task.wait()
            for i,v in next, _G do
                local Button = Fetch(v)
                if Button ~= nil then
                    Touch(Button)
                end
            end
        end
    end
})

for i,v in next, Buttons do
    Tab:CreateDropdown({
        Name = i,
        Flag = i,
        CurrentOption = "",
        Options = v,
        Callback = function(x)
            _G[i] = x
        end
    })
end

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)

Rayfield:LoadConfiguration()
