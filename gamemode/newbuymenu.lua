include("shared.lua")


local PANEL = {
    
    Init = function(self)
        self:SetSize(1000, 700)
        self:Center()
        self:SetVisible(true)
        self:MakePopup()  
            
        local x,y = self:GetSize()
        timeforrandom()
        icon1 = vgui.Create("ContentIcon",self)
        icon1:SetPos(x - 500 , y - 250)
        icon1:SetName(icon1name)
        icon1.DoClick = function()
            net.Start("bought")
            net.WriteString(randomweap[1].ClassName)
            net.SendToServer()
            self:SetVisible(false)
            timeforrandom()
            changename()
        end
        
        icon2 = vgui.Create("ContentIcon",self)
        icon2:SetPos(x - 250 , y - 250)
        icon2:SetName(icon2name)
        icon2.DoClick = function()
            net.Start("bought")
            net.WriteString(randomweap[2].ClassName)
            net.SendToServer()
            self:SetVisible(false)
            timeforrandom()
            changename()
        end

        icon3 = vgui.Create("ContentIcon",self)
        icon3:SetPos(x - 500 , y - 500)
        icon3:SetName(icon3name)
        icon3.DoClick = function()
            net.Start("bought")
            net.WriteString(randomweap[3].ClassName)
            net.SendToServer()
            self:SetVisible(false)
            timeforrandom()
            changename()
        end

        icon4 = vgui.Create("ContentIcon",self)
        icon4:SetPos(x - 250 , y - 500)
        icon4:SetName(icon4name)
        icon4.DoClick = function()
            net.Start("bought")
            net.WriteString(randomweap[4].ClassName)
            net.SendToServer()
            self:SetVisible(false)
            timeforrandom()
            changename()
        end

        icon5 = vgui.Create("ContentIcon",self)
        icon5:SetPos(x - 750 , y - 250)
        icon5:SetName(icon5name)
        icon5.DoClick = function()
            net.Start("bought")
            net.WriteString(randomweap[5].ClassName)
            net.SendToServer()
            self:SetVisible(false)
            timeforrandom()
            changename()
        end

        local Closebutton = vgui.Create("DButton",self)
        Closebutton:SetText("close")
        Closebutton:SetSize(50,30)
        Closebutton:SetPos(x-50,0)
        Closebutton.DoClick = function()
            self:SetVisible(false)
        end
    end,
    Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(2,2,w-4,h-4)
    end

}

function changename()
    icon1:SetName(icon1name)
    icon2:SetName(icon2name)
    icon3:SetName(icon3name)
    icon4:SetName(icon4name)
    icon5:SetName(icon5name)
end

vgui.Register("weaponshop",PANEL)
