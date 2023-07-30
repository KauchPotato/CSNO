include("shared.lua")



function roundStart()
    roundActive = true
    local alive = 0
    for k, v in pairs(player.GetAll()) do
        if v:Alive() then
            alive = alive + 1
        end
    end
    if (alive >= table.Count(player.GetAll()) && table.Count(player.GetAll()) > 1) then
        for k,v in pairs(player.GetAll()) do
            if(v:Team() == 0) then
                v:SetPos(Vector(USpawnLocation[math.random(1,#USpawnLocation)]))
            elseif(v:Team() == 1) then
                v:SetPos(Vector(OSpawnLocation[math.random(1,#OSpawnLocation)]))
            end
        end
    local bombguy = team.GetPlayers(0)[math.random(1,#team.GetPlayers(0))]
    bombguy:Give("weapon_burger_cs_c4")
        notifyPlayers("Round has started!")
        roundBuy()

    end
end

function roundBuy()
    notifyPlayers("Buy Phase has started!")
    game.CleanUpMap()
    buyphasetrue = true
    timer.Create("buyphase", 15, 1, function()
            timer.Stop("buyphase")
            roundCheck()
    end)
end

function roundCheck()
    buyphasetrue = false
    notifyPlayers("Buy Phase has ended!")
    local uAlive = 0
    local oAlive = 0
    timer.Create("roundtimer",90,1,function()
        for k,v in pairs(team.GetPlayers(0))do
            if(v:Alive()) then
                roundEnd("OwO")
                timer.Stop("roundtimer")
            end
        end
    end)
    timer.Create("check", 1, 0, function()
        local uAlive = 0
        local oAlive = 0
        for k,v in pairs(team.GetPlayers(0)) do
            if(v:Alive()) then
                uAlive = uAlive + 1
            end
        end
        for k,v in pairs(team.GetPlayers(1)) do
            if(v:Alive()) then
                oAlive = oAlive + 1
            end
        end
        if (uAlive == 0) then
            timer.Stop("roundtimer")
            timer.Stop("check")
            roundEnd("OwO")
        elseif (oAlive == 0) then
            timer.Stop("roundtimer")
            timer.Stop("check")
            roundEnd("UwU")
        end
    end)

    timer.Create("bomba",1,0,function()
        for k,v in pairs(team.GetPlayers(0)) do
            for i,j in pairs(v:GetWeapons()) do
                if(j.ClassName == "weapon_burger_cs_c4") then
                    
                    for _, ent in pairs(siteAlocation) do
                        //v:ChatPrint(Vector(ent):Distance(v:GetPos()))
                        if (Vector(ent):Distance(v:GetPos()) < 350) then
                            //v:ChatPrint("You can plant the bomb here!")
                            j:SetNWBool("canplant",true)
                        else
                            j:SetNWBool("canplant",false)
                        end
                    end

                    for _, ent in pairs(siteBlocation) do
                        //v:ChatPrint(Vector(ent):Distance(v:GetPos()))
                        if (Vector(ent):Distance(v:GetPos()) < 350) then
                            //v:ChatPrint("You can plant the bomb here!")
                            j:SetNWBool("canplant",true)
                        else
                            j:SetNWBool("canplant",false)
                        end
                    end
                    end
                end
            end
        end)


end

function roundEnd(winner)
    notifyPlayers("Round has ended! " .. winner .. " has won!")

    timer.Stop("roundtimer")
    timer.Stop("check")
    if winner == "UwU" then
       team.AddScore(0,1)
    else
        team.AddScore(1,1)
    end
    PrintMessage(HUD_PRINTCENTER, "U: " .. team.GetScore(0) .. " O: " .. team.GetScore(1))
    timer.Create("clean",5,1,function()
        game.CleanUpMap()
        for k, v in pairs(player.GetAll()) do
            if(v:GetObserverTarget() != NULL) then
                if (v:Team() == 2) then
                    v:SetTeam(0)
                    v:SetUpTeam(0)
                    v:UnSpectate()
                    v:Spawn()
                end
                if (v:Team() == 3) then
                    v:SetTeam(1)
                    v:SetUpTeam(1)
                    v:UnSpectate()
                    v:Spawn()
                end
            end
            v:SetHealth(100)
            v:SetArmor(50)
            for k,v in pairs(player.GetAll()) do
                if(v:Team() == 0) then
                    v:SetPos(Vector(USpawnLocation[math.random(1,#USpawnLocation)]))
                elseif(v:Team() == 1) then
                    v:SetPos(Vector(OSpawnLocation[math.random(1,#OSpawnLocation)]))
                end
            end
        end
        for k,v in pairs(team.GetPlayers(0)) do
            for i,j in pairs(v:GetWeapons()) do
                if(j.ClassName == "weapon_burger_cs_c4") then
                    v:StripWeapon("weapon_burger_cs_c4")
                end
            end
        end
    end)
    roundActive = false
    if (team.GetScore(0) >= 13) or (team.GetScore(1) >= 13) then
        timer.Stop("roundstart")
        timer.Create("endgame", 5, 1, function()
            EndGame()
        end)
        timer.Start("endgame")
    else
        timer.Create("roundstart", 5, 1, function()
            roundStart()
        end)
        print("yay")
        timer.Start("roundstart")
    end
    if team.GetScore(0) + team.GetScore(1) == 12 then
        local UPlayers = team.GetPlayers(0)
        local OPlayers = team.GetPlayers(1)
        local UScore = team.GetScore(0)
        local OScore = team.GetScore(1)



        for k,v in pairs(UPlayers) do
            v:SetUpTeam(1)
        end

        for k,v in pairs(OPlayers) do
            v:SetUpTeam(0)
        end

        team.SetScore(0, OScore)
        team.SetScore(1, UScore)
    end
end


function notifyPlayers(msg)
    for k,v in pairs(player.GetAll()) do
        v:ChatPrint(msg)
    end
end

function GM:OnEntityCreated(ent)
    -- if (ent.ClassName == "ent_burger_cs_c4") then
    --     for k, v in pairs(player.GetAll()) do
    --         for i, j in pairs(v:GetWeapons()) do
    --             if (j.ClassName == "weapon_burger_cs_c4") then
    --                 timer.Create("testdelay",5,1,function()
    --                     v:StripWeapon("weapon_burger_cs_c4")
    --                 end)
    --                 --v:StripWeapon("weapon_burger_cs_c4")
    --             end
    --         end
    --     end
    -- end
    if (ent.ClassName == "ent_burger_cs_c4") then
        if(timer.Exists("roundtimer")) then
            timer.Stop("roundtimer")
        end
        if (timer.Exists("check")) then
            timer.Stop("check")
        end
        notifyPlayers("The bomb has been planted!")
        timer.Create("bombtimer", 45, 1, function()
            roundEnd("UwU")
            if(timer.Exists("roundtimer")) then
                timer.Stop("roundtimer")
            end
            if (timer.Exists("check")) then
                timer.Stop("check")
            end
        end)
        timer.Create("isdefusing",1,0,function()
            if ent:GetNWBool("stopboom") == true then
                timer.Stop("bombtimer")
                timer.Stop("isdefusing")
                BombDefused()
            end
        end)
        timer.Create("isCTDead", 1, 0, function()
            local uAlive = 0
            for k,v in pairs(team.GetPlayers(1)) do
                if(v:Alive()) then
                    uAlive = uAlive + 1
                end
            end
            if (uAlive == 0) then
                timer.Stop("bombtimer")
                roundEnd("UwU")
            end
        end)
    end
end


function BombPlanted()

end

-- function GM:EntityRemoved(ent)
--     print(ent.ClassName)
--     if (ent.ClassName == "ent_burger_cs_c4") then
--         if(timer.TimeLeft("bombtimer") > 0) then
--             BombDefused()
--             timer.Stop("bombtimer")
--         end
--     end
-- end


function BombDefused()
    notifyPlayers("The bomb has been defused!")
    roundEnd("OwO")
    if(timer.Exists("roundtimer")) then
        timer.Stop("roundtimer")
    end
    if (timer.Exists("check")) then
        timer.Stop("check")
    end
end
function EndGame()
    timer.Stop("roundtimer")
    timer.Stop("check")
    if team.GetScore(0) > team.GetScore(1) then
        PrintMessage(HUD_PRINTCENTER, "U win")
        timer.Stop("roundtimer")
        timer.Stop("check")
    else
        PrintMessage(HUD_PRINTCENTER, "O win")
        timer.Stop("roundtimer")
        timer.Stop("check")
    end
end