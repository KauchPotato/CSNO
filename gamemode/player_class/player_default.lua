DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName			= "Default Class"
PLAYER.WalkSpeed 			= 150
PLAYER.RunSpeed				= 90
PLAYER.canUseFlashlight	= false 
PLAYER.MaxHealth			= 100
PLAYER.DropWeaponOnDie = true 

function PLAYER:Loadout( pl )
    pl:Give( "weapon_physcannon" )
    pl:Give( "weapon_physgun" )
    pl:Give( "gmod_tool" )
    pl:Give( "weapon_pistol" )
    pl:Give( "weapon_crowbar" )
end
function PLAYER:SetModel()

	local cl_playermodel = self.Player:GetInfo( "cl_playermodel" )
	local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
	util.PrecacheModel( modelname )
	self.Player:SetModel( modelname )

end
function PLAYER:GetHandsModel()

	-- return { model = "models/weapons/c_arms_cstrike.mdl", skin = 1, body = "0100000" }

	local playermodel = player_manager.TranslateToPlayerModelName( self.Player:GetModel() )
	return player_manager.TranslatePlayerHands( playermodel )

end
player_manager.RegisterClass( "player_custom", PLAYER, "player_default" )