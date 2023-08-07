GM.Name = "Counter-Strike: Garry Offensive"
GM.Author = "ur mom"
GM.Email = "urdad"
GM.Website = "www.pornhub.com"
include("player_class/player_default.lua")
include("teamsetup.lua")

DeriveGamemode( "sandbox" )

team.SetUp(0, "UwU" , Color(255,0,0))
team.SetUp(1, "OwO" , Color(0,0,255))
team.SetUp(2, "USpectator" , Color(255,255,255))
team.SetUp(3, "OSpectator" , Color(255,255,255))


function GM:Initialize()
    local firerate = 0
    local wdamage = 0
    local total = 0
    print("start")
    for k,v in pairs(weapons.GetList()) do
        print(v.ClassName)
        wdamage = 0
        firerate = 0
        total = 0
        if(!string.find(v.ClassName,"base") && !string.find(v.ClassName,"fists") && !string.find(v.ClassName,"nade") && !string.find(v.ClassName,"knife") && !string.find(v.ClassName,"template")) then
            
            if v.Primary.Delay then
                firerate = v.Primary.Delay
            end
            if v.RPM then
                firerate = 60 / v.RPM
            end
            if v.Primary.Damage then
                wdamage = v.Primary.Damage
            else
                if v.DamageMax then
                    wdamage = v.DamageMax
                end
                if v.Bullet then
                    PrintTable(v.Bullet.Damage)
                    wdamage = v.Bullet.Damage[1]
                end
            end
            print(v.PrintName)
            print(wdamage)
            print(firerate)
            total = wdamage
            if total > 0 && total < 30 then
                table.insert(cat1, v)
            else
                if total > 30 && total < 35 then
                    table.insert(cat2, v)
                else
                    if total > 35 && total < 40 then
                        table.insert(cat3, v)
                    else
                        if total > 40 && total < 50 then
                            table.insert(cat4, v)
                        else
                            if total > 50 && total < 999 then
                                table.insert(cat5, v)
                            end
                        end
                    end
                end
            end
        end
    end

    for k,v in pairs(cat1) do
        print(v.ClassName)
    end


    local mapname = game.GetMap()

    if(!file.Exists("CSNO","DATA")) then
        file.CreateDir("CSNO")
    end
    if(!file.Exists("CSNO/"..mapname,"DATA")) then
        file.CreateDir("CSNO/"..mapname)
    else
        if(!file.Exists("CSNO/"..mapname.."/siteA.txt","DATA")) then
            file.Write("CSNO/"..mapname.."/siteA.txt",util.TableToKeyValues(siteAlocation))
        else
            siteAlocation = util.KeyValuesToTable(file.Read("CSNO/"..mapname.."/siteA.txt","DATA","DATA"))
        end

        if(!file.Exists("CSNO/"..mapname.."/siteB.txt","DATA")) then
            file.Write("CSNO/"..mapname.."/siteB.txt",util.TableToKeyValues(siteBlocation))
        else
            siteBlocation = util.KeyValuesToTable(file.Read("CSNO/"..mapname.."/siteB.txt","DATA"))
        end
    end

    if(!file.Exists("CSNO","DATA")) then
        file.CreateDir("CSNO")
    end
    if(!file.Exists("CSNO/"..mapname,"DATA")) then
        file.CreateDir("CSNO/"..mapname)
    else
        if(!file.Exists("CSNO/"..mapname.."/spawnsU.txt","DATA")) then
            file.Write("CSNO/"..mapname.."/spawnsU.txt",util.TableToKeyValues(USpawnLocation))
        else
            USpawnLocation = util.KeyValuesToTable(file.Read("CSNO/"..mapname.."/spawnsU.txt","DATA","DATA"))
        end

        if(!file.Exists("CSNO/"..mapname.."/spawnsO.txt","DATA")) then
            file.Write("CSNO/"..mapname.."/spawnsO.txt",util.TableToKeyValues(OSpawnLocation))
        else
            OSpawnLocation = util.KeyValuesToTable(file.Read("CSNO/"..mapname.."/spawnsO.txt","DATA"))
        end
    end
    PrintTable(siteAlocation)
end


hook.Add("PlayerDeath", "moneything", function(ply,weap,attacker)
    if(ply != attacker) then
        local val = attacker:GetNWInt("money")
        if(table.HasValue(cat1,weap)) then
            attacker:SetNWInt("money", 300)
        end
        if(table.HasValue(cat2,weap)) then
            attacker:SetNWInt("money", 600)
        end
        if(table.HasValue(cat3,weap)) then
            attacker:SetNWInt("money", 300)
        end
        if(table.HasValue(cat4,weap)) then
            attacker:SetNWInt("money", 300)
        end
        if(table.HasValue(cat5,weap)) then
            attacker:SetNWInt("money", 100)
        end
        attacker:ChatPrint("You killed "..ply:Nick().." and got $"..attacker:GetNWInt("money").."!"..val)
    end
end)


cat1 = {}
cat2 = {}
cat3 = {}
cat4 = {}
cat5 = {}




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
function random1()
     r1 = table.Random(cat1)
    icon1name = r1.PrintName
    randomweap[1] = r1
end
function random2()
     r2 = table.Random(cat2)
    icon2name = r2.PrintName
    randomweap[2] = r2
end
function random3()
     r3 = table.Random(cat3)
    icon3name = r3.PrintName
    randomweap[3] = r3
end
function random4()
     r4 = table.Random(cat4)
    icon4name = r4.PrintName
    randomweap[4] = r4
end
function random5()
     r5 = table.Random(cat5)
    icon5name = r5.PrintName
    randomweap[5] = r5
end

buyphasetrue = false