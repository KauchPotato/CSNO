AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("teamsetup.lua")
AddCSLuaFile("buy.lua")
AddCSLuaFile("rounds.lua")
AddCSLuaFile("newbuymenu.lua")
AddCSLuaFile("scoreboard.lua")
AddCSLuaFile("main.lua")
AddCSLuaFile("autorun/sh_burger_init.lua")
AddCSLuaFile("player_class/player_default.lua")
include("cl_init.lua")
include("player_class/player_default.lua")
include("shared.lua")
include("teamsetup.lua")
include("buy.lua")
include("rounds.lua")
include("newbuymenu.lua")
include("scoreboard.lua")
include("main.lua")
include("autorun/sh_burger_init.lua")

pnum = 0
snum = 0
tnum = 0
gnum = 0

guns = {}
secondary = ""


USpawnLocation = {}
OSpawnLocation = {}

siteAlocation = {}
siteBlocation = {}




function GM:PlayerInitialSpawn(ply)
    -- net.Start("trans")
    -- net.Send(ply)
    ply:SetUpTeam(math.random(0,1))
end

function GM:PlayerSpawn(ply)
    --print("test")
    local playerteam = ply:Team()
    local teammates = team.GetPlayers(playerteam)
    if roundActive == true then
        if playerteam == 0 then
            ply:SetTeam(2)
        end
        if playerteam == 1 then
            ply:SetTeam(3)
        end
        ply:Spectate(OBS_MODE_IN_EYE)
        ply:SpectateEntity(teammates[0])
    else
        if playerteam == 2 then
            ply:SetUpTeam(0)
        end
        if playerteam == 3 then
            ply:SetUpTeam(1)
        end
        ply:UnSpectate()  
        player_manager.SetPlayerClass(ply, "player_default")
        ply:GiveWeapons(ply:Team())
        ply:SetupHands()
        //ply:Give("weapon_csgo_pist_usps")
        //PrintTable(weapons.GetList())
        ply:SetArmor(50)
        --print(weapons.GetStored("weapon_csgo_pist_tec9"):SetHoldType("pistol"))
    end

end
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end 
function GM:PlayerButtonDown(ply, button)
    -- if(button == KEY_1) then
    --     if(getPrimary(ply) != NULL) then
    --         ply:SelectWeapon(guns[0])
    --     end
    -- end
    --     if (button == KEY_2) then
    --         if(getSecondary(ply) != NULL) then
    --             ply:SelectWeapon(guns[1])
    --         else
                
    --         end
    --     end
    --     if (button == KEY_3) then
    --         ply:SelectWeapon("weapon_csgo_knife")
    --         ply:SelectWeapon("weapon_csgo_knife_t")
    --     end
    --     if (button == KEY_4) then
    --         if(getGrenade(ply) != NULL) then
    --             ply:SelectWeapon(getGrenade(ply))
    --         end
    --     end
    if(button == KEY_G) then
        if ply:GetActiveWeapon().HoldType == "grenade" then
            ply:DropWeapon()
            gnum = gnum - 1
        end
        if(ply:GetActiveWeapon().ClassName != "arc9_go_knife_t" ) then
            if(ply:GetActiveWeapon().ClassName != "arc9_go_knife_ct") then
                print(ply:GetActiveWeapon())
                print(pnum, snum, tnum)
                ply:DropWeapon() 
                pnum = pnum -1
            end
        end

            if pnum < 0 then
                pnum = 0
            end
            if gnum < 0 then
                gnum = 0
            end
            print(pnum, snum, tnum)
    end
    if(button == KEY_B && buyphasetrue == true) then
        net.Start("buy")
        net.Send(ply)
    end
    if(button == KEY_T) then
        net.Start("trans")
        net.Send(ply)
    end
end
function getPrimary(ply)
    for k, v in pairs(ply:GetWeapons()) do
        if (v.HoldType =="ar2" or v.HoldType == "smg") then
            return v
        end
    end
    return NULL
end
function getSecondary(ply)
    for k, v in pairs(ply:GetWeapons()) do
        if (v.HoldType == "pistol" or v.HoldType == "revolver") then
            return v
        end
    end
    return NULL 
end
function getGrenade(ply)
    local g = 0
    for k, v in pairs(ply:GetWeapons()) do
        if (v.HoldType == "grenade") then
            g = g +1
        end
    end 
    return g
end

function getNumWeapons(ply)
    local p = 0
    for k, v in pairs(ply:GetWeapons()) do
        if(v.HoldType != "grenade" or v.HoldType != "knife") then
            p = p + 1
            table.insert(guns,v)
        end
    end
    return p
end



function GM:PlayerHurt(ply)
    if(ply:Health() <= 0) then
        drop(ply)
    end
end
function drop( ply )
	if ( ply:IsValid() ) then
		-- Loop through all player weapons and drop them.
		for _, wep in ipairs( ply:GetWeapons() ) do
            if(ply:GetActiveWeapon().ClassName != "arc9_go_knife_t" ) then
                if(ply:GetActiveWeapon().ClassName != "arc9_go_knife_ct") then
                    if wep.HoldType == "grenade" then
                        gnum = gnum - 1
                    end
                    ply:DropWeapon( wep )
                    pnum = pnum - 1
                end
            end
        end
        if pnum < 0 then
            pnum = 0
        end
        if gnum < 0 then
            gnum = 0
        end
	end
    print(pnum)
end 
function GM:PlayerCanPickupWeapon(ply, weapon)
    if weapon.ClassName == "weapon_burger_cs_c4" && ply:Team(0) then return true end
    local p = getNumWeapons(ply)
    if p >= 3 then
        return false
    else
        return true
    end
    if gnum >= 4 then
        return false
    else
        ply:GiveAmmo(1, "grenade", false )
        return true
    end
end





net.Receive("bought", function(len,ply)
    local weapon = net.ReadString()
    pnum = getNumWeapons(ply)
    gnum = getGrenade(ply) 
    print(weapon.HoldType)
    if(weapon.HoldType == nil) then
        gnum = gnum + 1
        ply:ChatPrint("You bought a grenade!")
        ply:GiveAmmo(1, "grenade", false )
    else if(weapon != NULL or weapon != "knife") then
        pnum = pnum + 1
    end
    end

    ply:Give(weapon)
    
end)


net.Receive("buymenu",function(len,ply)
    net.Start("buy")
    net.Send(ply)
end)


net.Receive("transed", function(len,ply)
    local teamnum = net.ReadInt(32)
    ply:SetUpTeam(teamnum)

end)


net.Receive("spawn", function(len,ply)
    roundStart()
end)

util.AddNetworkString("buymenu")
util.AddNetworkString("buy")
util.AddNetworkString("bought")
util.AddNetworkString("trans")
util.AddNetworkString("transed")
util.AddNetworkString("spawn")
util.AddNetworkString("openscore")
util.AddNetworkString("closescore")


hook.Add("PlayerSay","CommandIdent",function(ply,text)
    text = string.lower(text)
    local mapname = game.GetMap()
    texttable = string.Explode(" ",text)
    print(tostring(texttable[1]))
    print(tostring(texttable[2]))
    if(texttable[1] == "!setspawn") then
        if(texttable[2] == nil ) then
            ply:ChatPrint("Please specify a team!")
            return
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



        print("imhere")
        if(texttable[2] == "uwu") then
            ply:ChatPrint("Setting spawn for UwU")
            table.insert(USpawnLocation,tostring(ply:GetPos()+Vector(0,0,5)))
            file.Write("CSNO/"..mapname.."/spawnsU.txt",util.TableToKeyValues(USpawnLocation))
        end

        if(texttable[2] == "owo") then
            ply:ChatPrint("Setting spawn for OwO")
            table.insert(OSpawnLocation,tostring(ply:GetPos()+Vector(0,0,5)))
            file.Write("CSNO/"..mapname.."/spawnsO.txt",util.TableToKeyValues(OSpawnLocation))
        end
    elseif(texttable[1] == "!setsite") then
        if(texttable[2] == nil) then
            ply:ChatPrint("Please specify a site!")
            return 
        end

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

        if(texttable[2] == "a") then
            ply:ChatPrint("Setting Site A")
            -- for i,10,1 do
            --     for j,10,1 do
            --         for k,10,1 do
            --             table.insert(siteAlocation,tostring(ply:GetPos()+Vector(i,j,k)))
            --             file.Write("CSNO/"..mapname.."/siteA.txt",util.TableToKeyValues(siteAlocation))
            --         end
            --     end
            -- end
            table.insert(siteAlocation,tostring(ply:GetPos()))
            file.Write("CSNO/"..mapname.."/siteA.txt",util.TableToKeyValues(siteAlocation))
        end

        if(texttable[2] == "b") then
            ply:ChatPrint("Setting Site B")
            -- for i,10,1 do
            --     for j,10,1 do
            --         for k,10,1 do
            --             table.insert(siteBlocation,tostring(ply:GetPos()+Vector(i,j,k)))
            --             file.Write("CSNO/"..mapname.."/siteB.txt",util.TableToKeyValues(siteBlocation))
            --         end
            --     end
            -- end
            table.insert(siteBlocation,tostring(ply:GetPos()))
            file.Write("CSNO/"..mapname.."/siteA.txt",util.TableToKeyValues(siteAlocation))
        end

    end
end)





function scoreboardopen(ply)
    net.Start("openscore")
    net.Send(ply)
end


function GM:ScoreboardShow(ply)
    scoreboardopen(ply)
end

function GM:ScoreboardHide(ply)
    net.Start("closescore")
    net.Send(ply)
end