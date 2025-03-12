local Players = game:GetService("Players")
local AnalyticsService = game:GetService("RbxAnalyticsService")
local player = Players.LocalPlayer

local WhitelistedClientIDs = {
    "CEE26742-23B4-4189-B347-07C7DA28AB31",
    "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
}

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
