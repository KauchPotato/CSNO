local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
        name = "UwU",
        Color = Vector(1,0,0),
        weapons = {"arc9_go_knife_t","arc9_go_glock"}
}
teams[1] = {
            name = "OwO",
            Color = Vector(0,0,1),
            weapons = {"arc9_go_knife_ct","arc9_go_usp"}
        }

function ply:SetUpTeam(n)
    if (not teams[n]) then return end
    self:StripWeapons()
    self:SetTeam(n)
    self:SetPlayerColor(teams[n].Color)
    self:SetHealth(100)
    self:SetArmor(0)
    self:SetMaxSpeed(300)
    self:SetWalkSpeed(200)
    self:SetRunSpeed(300)
    self:SetJumpPower(220)
    self:SetModel(player_manager.TranslatePlayerModel(self:GetInfo("cl_playermodel")))
    self:GiveWeapons(n)
    self:SetNWInt("money", 800)
    
end
function ply:GiveWeapons(n)
    for k,v in pairs(teams[n].weapons) do
        self:Give(v)
    end
end