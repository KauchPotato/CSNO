GM.Name = "Counter-Strike: Garry Offensive"
GM.Author = "ur mom"
GM.Email = "urdad"
GM.Website = "www.pornhub.com"
include("player_class/player_default.lua")
include("teamsetup.lua")

DeriveGamemode( "sandbox" )

team.SetUp(0, "UwU" , Color(255,0,0))
team.SetUp(1, "OwO" , Color(0,0,255))

roundActive = false


allweap = {}
randomweap = {}
icon1name = ""
icon2name = ""
icon3name = ""
icon4name = ""
icon5name = ""


function timeforrandom()
    allweap = {}
    randomweap = {}
    for k, v in pairs(weapons.GetList()) do
        if !string.find(v.ClassName,"base") && !string.find(v.ClassName,"fists") && !string.find(v.ClassName,"nade") && !string.find(v.ClassName,"knife") then
            table.insert(allweap, v)
        end
        end
        for i = 1,5,1 do
            randomweap[i] = table.Random(allweap)
            print(randomweap[i].PrintName)
        end
        icon1name = randomweap[1].PrintName
        icon2name = randomweap[2].PrintName
        icon3name = randomweap[3].PrintName
        icon4name = randomweap[4].PrintName
        icon5name = randomweap[5].PrintName
end    
buyphasetrue = false