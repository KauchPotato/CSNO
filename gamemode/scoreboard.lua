local PANEL = {
    Init = function(self)
        self:SetSize(1000, 700)
        self:Center()
        self:SetVisible(true)
        self:MakePopup()

        UPlyList = vgui.Create("DListView", self)
        UPlyList:SetPos(10, 30)
        UPlyList:SetSize(200, 660)
        UPlyList:SetMultiSelect(false)


        OPLyList = vgui.Create("DListView", self)
        OPlyList:SetPos(10, 90)
        OPlyList:SetSize(200, 660)
        OPlyList:SetMultiSelect(false)


        for k, v in pairs(team.GetPlayers(0)) do
            UPlyList:AddLine(v:Nick(),v:Frags(),v:Deaths(),v:Ping())
        end

        for k, v in pairs(team.GetPlayers(1)) do
            OPlyList:AddLine(v:Nick(),v:Frags(),v:Deaths(),v:Ping())
        end

        UPlyList:AddColumn("Name")
        UPlyList:AddColumn("Kills")
        UPlyList:AddColumn("Deaths")
        UPlyList:AddColumn("Ping")

        OPlyList:AddColumn("Name")
        OPlyList:AddColumn("Kills")
        OPlyList:AddColumn("Deaths")
        OPlyList:AddColumn("Ping")
    end,

    Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(2,2,w-4,h-4)
    end




}
vgui.Register("scoreboard_menu", PANEL)