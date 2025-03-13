local function h(s)
    local r = ""
    for i = 1, #s do
        r = r .. string.char(string.byte(s, i) ~ 42)
    end
    return r
end

local WhitelistedClientIDs = {
    h("suu~|zwv~?~#rw?w$y)?r#w|?{|s|tq~$qr#\""),
    h("$|\"q}z|#?%rq?w\"\"#?qxw$?stq$y}\"$}~{zt"),
    h("tuq#wzqt?us}#?w\"y%?{#\"y)?q{ww?\"y~$?o|s|"),
    h("y)y$r$\"?v{tw?%#\"~w$){\"yw#?\"w{z?#\"|%z"),
    h("t|y{|z}t?w{#t?z{~#?y\"zw?yx~w?~$~t?~~r"),
    h("}o)w{o~?y)~%?}$y~~?o$~~?z$|\"?w~}%?wyr"),
    h("c\"r%zt\"?y$%?\"y)?z~%?z}r?zw%?}%%?}w|"),
    h("c\"||w{t?z|{?%|z{?c)$r?cy$$?{\"?~wo?w|%"),
    h("y%r|r$?${$?|tz{?w{r}?yo{?y{\")?y\"\"$|\""),
    h("e\"$z~wo?or~z?wzzw?c$w%?~$|$?rt~z?w{|w"),
    h("l|)w~~r?$oy?%o~|?{{~$?\")|y%?{|w?zw$r"),
    h("d|wt~t\"?\"#\"~|?%o$z?\"}$%?\"~%~?|w~}zw"),
    h("}~t~\"w$?{|#\"?z{~#?yo?zt~%o?~$\"tw?~\"$|c"),
    h("ee*w$|$?$%w%?zwc{?~{~{?%$z{?r|o{?~{$c{"),
    h("c\"z~|zw?t$z\"?t$z\"?%c{t?c#\"\"?#~)o?#$c\""),
    h("l|)w~~r?$oy?%o~|?{{~$?\")|y%?{|w?zw$r"),
    h("d{|\"|zw?$o)|?%z}%?%$~%?c~{z\"?z\"r$?%%$|"),
    h("\"}{\"%$z?{tw?t\"~%z?yz~w?yz~r?c#\"%?e%\"o"),
    h("dwy%e{~~?~|wo?wzz|?yz~{?yztw?\"}~~?%etz"),
    h("ee\"c|~%?%e\"t?|\"$r?zr$|?%z~\"%|?wo~z?\"c|w"),
    h("rzoww?$#\"w?$~#\"?%o*r?~czw?|#tw{?\"\"zrw")
}

local function formatID(id)
    return id:gsub("[^%w]", ""):upper()
end

local function isClientIDWhitelisted(clientID)
    local formattedID = formatID(clientID)
    local obfuscatedID = h(formattedID)
    
    for _, id in ipairs(WhitelistedClientIDs) do
        if id == obfuscatedID then
            return true
        end
    end
    
    return false
end

return WhitelistedClientIDs
