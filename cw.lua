local Players = game:GetService("Players")
local AnalyticsService = game:GetService("RbxAnalyticsService")
local player = Players.LocalPlayer

local clientIdsUrl = "https://raw.githubusercontent.com/YourGitHubUsername/YourRepo/main/clientids.lua"

local WhitelistedClientIDs = {}

local success, response = pcall(function()
    return game:HttpGet(clientIdsUrl)
end)

if success and response then
    local loadSuccess, clientIds = pcall(function()
        return loadstring(response)()
    end)
    
    if loadSuccess and type(clientIds) == "table" then
        WhitelistedClientIDs = clientIds
        print("Client IDs loaded successfully: " .. #WhitelistedClientIDs .. " IDs")
    else
        print("Failed to load client IDs list")
    end
else
    print("Failed to fetch client IDs from URL")
end

local function isClientIDWhitelisted(clientID)
    for _, id in ipairs(WhitelistedClientIDs) do
        if id == clientID then
            return true
        end
    end
    return false
end

local function getClientID()
    local clientID = "Unknown"
    
    local success, result = pcall(function()
        return AnalyticsService:GetClientId()
    end)
    
    if success and result then
        clientID = result
    end
    
    return clientID
end

local function verifyClientIDWhitelist()
    local clientID = getClientID()
    return isClientIDWhitelisted(clientID), clientID
end

local function copyClientIDToClipboard()
    local clientID = getClientID()
    setclipboard(clientID)
    return clientID
end

local ClientIDWhitelist = {
    verifyWhitelist = verifyClientIDWhitelist,
    getClientID = getClientID,
    isClientIDWhitelisted = isClientIDWhitelisted,
    copyClientIDToClipboard = copyClientIDToClipboard
}

_G.ClientIDWhitelist = ClientIDWhitelist

return ClientIDWhitelist
