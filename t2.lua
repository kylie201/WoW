local L34 = {
    1825621146, 2556084505, 4677863378, 5733662243, 2357809043,
    991462561, 2548498873, 1302801990, 3306471810, 4500267085,
    6006375260, 4575355250, 3678793516, 441617255, 2598132688,
    7106835619, 3849092255, 4896016959, 1935561886
}

local function iV(u)
    for _, v in ipairs(L34) do
        if v == u then
            return true
        end
    end
    return false
end

local function gHWID()
    local US = game:GetService("UserInputService")
    return tostring(US.TouchEnabled) .. tostring(US.KeyboardEnabled) .. tostring(US.MouseEnabled) .. tostring(US.GamepadEnabled)
end

local function sH(text)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local s = text:gsub('.', function(x)
        local r, n = '', x:byte()
        for i = 8,1,-1 do
            r = r .. (n % 2^i - n % 2^(i-1) > 0 and '1' or '0')
        end
        return r
    end) .. '0000'
    s = s:gsub('%d%d%d?%d?%d?%d?', function(x)
        if #x < 6 then return '' end
        local c = 0
        for i = 1,6 do
            c = c + (x:sub(i,i)=='1' and 2^(6-i) or 0)
        end
        return b:sub(c+1, c+1)
    end) .. ({ '', '==', '=' })[#text % 3+1]
    return s
end

local uid = game.Players.LocalPlayer.UserId
if iV(uid) then
    local hwid = gHWID()
    local comb = tostring(uid) .. hwid
    return sH(comb)
else
    return nil
end
