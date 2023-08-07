include("shared.lua")
include("buy.lua")
include("newbuymenu.lua")
include("teamsetup.lua")
include("scoreboard.lua")
include("autorun/sh_burger_init.lua")
local ply = LocalPlayer()
local allweap = {}
local randomweap = {}
-- function GM:HUDShouldDraw(name)
--     list = { "CHudWeaponSelection"}
--     for k, v in pairs(list) do
--         if(name == v) then
--             return false
--         end
--     end
--     return true
-- end
function getmoney(ply)
    local money = 9000000
    return money
end



function getweapons()
    for k, v in pairs(weapons.GetList()) do
        if !string.find(v.ClassName,"base") && !string.find(v.ClassName,"fists") && !string.find(v.ClassName,"nade") && !string.find(v.ClassName,"knife") then
        table.insert(allweap, v.ClassName)
        end
    end
    for k = 1,5,1 do
        randomweap[k] = table.Random(allweap)
    end
end



net.Receive("buy",function()
    -- if(!buyMenu) then
    --     local buyMenu = vgui.Create("DFrame")
    --     local plist = {}
    --     local nlist = {}
    --     local cname = {}
    --     buyMenu:SetSize(500, 500)
    --     buyMenu:SetPos(ScrW() / 2 - 250, ScrH() / 2 - 250)
    --     buyMenu:SetTitle("Buy Menu")
    --     buyMenu:SetVisible(true)
    --     buyMenu:SetDraggable(false)
    --     buyMenu:ShowCloseButton(true)
    --     buyMenu:MakePopup()
        
    --     local buyList = vgui.Create("DListView", buyMenu)
    --     buyList:SetPos(10, 30)
    --     buyList:SetSize(480, 460)
    --     buyList:SetMultiSelect(false)
    --     buyList:AddColumn("Item")
    --     getweapons()
    --     for k, v in pairs(randomweap) do
    --         buyList:AddLine(v)
    --     end
    --     buyList.OnRowSelected = function(self)
    --         local num, sel = self:GetSelectedLine()
    --         net.Start("bought")
    --         print(randomweap[num])
    --         net.WriteString(randomweap[num])
    --         net.SendToServer(ply)
            
    --         buyMenu:Close()
    --     end


    -- else
    --     buyMenu:Close()
    -- end

    if(!weaponshop) then
        weaponshop = vgui.Create("weaponshop")
        weaponshop:SetVisible(false)
        weaponshop:Refresh()
    end
    if(weaponshop:IsVisible()) then
        weaponshop:SetVisible(false)
        weaponshop:Refresh()
    else
        weaponshop:SetVisible(true)
        weaponshop:Refresh()
    end
end)
net.Receive("trans",function()
    if(!transgender) then
        transgender = vgui.Create("transgender_menu")
        transgender:SetVisible(false)
    end
    if(transgender:IsVisible()) then
        transgender:SetVisible(false)
    else
        transgender:SetVisible(true)
    end

end)


net.Receive("defuse",function()
    if(ply:GetNW2Entity("TFA_CSGO_DefuseTarget",NULL)) then
        net.Start("defusing")
        net.WriteEntity(ply:GetNW2Entity("TFA_CSGO_DefuseTarget"))
        net.SendToServer()
    end



end)


net.Receive("openscore",function()
    if(!scoreboard) then
        scoreboard = vgui.Create("scoreboard")
        scoreboard:SetVisible(false)
    end
    if(scoreboard:IsVisible()) then
        scoreboard:SetVisible(false)
    else
        scoreboard:SetVisible(true)
    end

end)

net.Receive("closescore",function()
    if(scoreboard) then
        scoreboard:SetVisible(false)
    end
end)
