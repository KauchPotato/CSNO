include("rounds.lua")
include("shared.lua")
include("teamsetup.lua")

function StartGame()
    team.SetScore(0, 0)
    team.SetScore(1, 0)
    
    roundStart()
    timer.Create("testround", 1, 0, function()
        roundStart()
        if roundActive == false then
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
    
    
            if team.GetScore(0) == 13 then 
                EndGame()
            end
            if team.GetScore(1) == 13 then 
                EndGame()
            end
            print("I made it here")
        end
    end)
    timer.Create("checkroundend",1,0,function()
    if roundActive == false then
        timer.Stop("testround")
        timer.Start("testround")
    end

    end)

end

function EndGame()
    timer.Stop("testround")
    timer.Stop("checkroundend")
    if team.GetScore(0) > team.GetScore(1) then
        PrintMessage(HUD_PRINTTALK, "U win")
        timer.Stop("testround")
        timer.Stop("checkroundend")
    else
        PrintMessage(HUD_PRINTTALK, "O win")
        timer.Stop("testround")
        timer.Stop("checkroundend")
    end
end