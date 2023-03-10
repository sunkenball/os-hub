local Id      = game.PlaceId
local Games   = "https://os-hub.us/games/"
local ForEach = function(Table, Callback)
    assert(type(Table) == "table", "p1 isn't a table")
    assert(type(Callback) == "function", "p2 isn't a function")
    assert(Table ~= nil, "No Table Is Provided")
    assert(Callback ~= nil, "No Callback Is Provided")
    for Index,Value in next, Table do
        Callback(Index,Value)
    end
end
local Load    = function(Url, Supported)
    if not table.find(Supported, Id) then
        return
    end
    Url = Url:gsub("./games/", Games)
    loadstring(game:HttpGet(Url))()
end
local Urls    = {
    ["./games/slashing-simulator-2.lua"] = {10549069562},
    ["./games/snow-shovelling-simulator.lua"] = {1252559098},
    ["./games/button-simulator-x.lua"] = {10970958609}
}
ForEach(Urls, Load)
