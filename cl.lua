local function obfuscate(str)
    local result = ""
    for i = #str, 1, -1 do
        local char = string.sub(str, i, i)
        local byte = string.byte(char)
        local shifted = string.char((byte + 7) % 256)
        result = result .. shifted
    end
    return result
end

local function deobfuscate(str)
    local result = ""
    for i = #str, 1, -1 do
        local char = string.sub(str, i, i)
        local byte = string.byte(char)
        local shifted = string.char((byte - 7 + 256) % 256)
        result = result .. shifted
    end
    return result
end

-- Obfuscated client IDs
local ObfuscatedIDs = {
    --Brandon
    "26IH(H9IJMK4=UV4=?@P4UVI4YXKJJL(LLJ",
    "k:7-p,l>hp2RRUX4hko(4(hi\056k9>>h9>>",
    --Pase
    
    --Kitkat
    "4*j>??7mljw4\\\\]1=UVP4:=-p4kh?7=hlk",
    "j\\UXVP4m67mW4k\\]\\4q\\]1=s(hi(i>?@",
    --Emperor11
    "hjio>:oj(jjm4kiu=4imq14:;iw4k=m76>:k",
    "l:;>2lPjiu=4>==q4=6?@4j6?@+=@@ioUV\\",
    "mlkk>kU[YPq4l:=U4jmn4k2ot4UVKJJoYXK",
    --Grooda
    "k>k\\jw(hh>h4hhhn4(>?(4\\?>l4j?k*4;(h",
    "k=@?j@=UV<K4hmn*4(lui4\\ul(4j@=UV<K=@",
    "Umj\\j=\\67(4?UVT4h4mh4l6784j\\]\\mo>o>",
    --Raul
    "=j>@===>hio4jh>h4>*4p,4hi>j6?@+==j6",
    "?jj4*l\\UVS4:;iu4UVVV4>6?>4*lmmUU^PJ",
    --Manny
    "VUjljw:6:64iipU4hk=?4VUJN>6jljw:6",
    --Demon
    "6=o?*\\6?@lm\\4YUV=4hi>w4=<hi+w\\jkk",
    --Dino
    ":ll>liw>pf14>iUV4\\4;(4k2ot4lijwlj>U",
    --Brayan
    "=j>@===>hio4jh>h4>*4p,4hi>j6?@+==j6",
    "\\j:@AOYXZ=4?mko4@?h4=>6<4o6owj>67j",
    "\\I67U?*[SXK4jo\\Y4h]\\m4UVV[VYUKJh(6",
    "om]\\jhlm\\6?4lkm*4=o\\]4?kim4jhlm67j\\",
    --Gato
    "j4>itw\\lt6=U4?6UV4mhio4\\\\]1=\\\\4*k\\",
    --MCL_Brayan
    "U6=h4o=@hro4w\\]Y4w\\]Y4l:;>4kwr:Umj*"
}

local function isWhitelisted(clientID)
    for _, encryptedID in ipairs(ObfuscatedIDs) do
        if clientID == deobfuscate(encryptedID) then
            return true
        end
    end
    return false
end

local WhitelistedClientIDs = {}
for i, obfuscatedID in ipairs(ObfuscatedIDs) do
    WhitelistedClientIDs[i] = deobfuscate(obfuscatedID)
end

WhitelistedClientIDs._verify = isWhitelisted

return WhitelistedClientIDs
