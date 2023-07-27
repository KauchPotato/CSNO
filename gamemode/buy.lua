--draw a buy menu for the player
--shows buttons of all guns with prices
include("teamsetup.lua")
local PANEL = {
    Init = function(self)
        self:SetSize(1000,700)
        self:Center()
        self:SetVisible(true)
        self:MakePopup()

        local x,y = self:GetSize()
        local ply = FindMetaTable("Player")

        local Closebutton = vgui.Create("DButton",self)
        Closebutton:SetText("close")
        Closebutton:SetSize(50,30)
        Closebutton:SetPos(x-50,0)
        Closebutton.DoClick = function()
            self:SetVisible(false)
            end

        local TButton = vgui.Create("DButton",self)
        TButton:SetText("UwU")
        TButton:SetSize(50,30)
        TButton:SetPos(x-250,y-350)
        TButton.DoClick = function()
            net.Start("transed")
            net.WriteUInt(0,32)
            net.SendToServer()
            end

        local CTButton = vgui.Create("DButton",self)
        CTButton:SetText("OwO")
        CTButton:SetSize(50,30)
        CTButton:SetPos(x-750,y-350)
        CTButton.DoClick = function()
            net.Start("transed")
            net.WriteUInt(1,32)
            net.SendToServer()
            end

        local TestSpawn = vgui.Create("DButton",self)
        TestSpawn:SetText("TestRound")
        TestSpawn:SetSize(50,30)
        TestSpawn:SetPos(x-500,y-350)
        TestSpawn.DoClick = function()
            net.Start("spawn")
            net.SendToServer()
            end

        local buyButton = vgui.Create("DButton",self)
        buyButton:SetText("buymenu")
        buyButton:SetSize(50,30)
        buyButton:SetPos(x-500,y-300)
        buyButton.DoClick = function()
            self:SetVisible(false)
            net.Start("buymenu")
            net.SendToServer()
            end
            
    end,

    Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(2,2,w-4,h-4)
    end
}
vgui.Register("transgender_menu",PANEL)