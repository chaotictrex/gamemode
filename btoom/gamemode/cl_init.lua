include ("shared.lua")

function ShouldHudDraw(name)

	for k, v in pairs{"CHudHealth", "CHudBattery" , "CHudAmmo" , "CHudSecondaryAmmo"} do 
			if name==v then 
				return false 
			end 
		end 
		hook.Add("HUDShouldDraw" , "HideHUD" , ShouldHudDraw)

		function GM:HUDPaint()

		self.BaseClass:HUDPaint()

		local p = LocalPlayer()
		local Ammo = pl:GetActiveWeapon():Clip1()
		local TotalAmmo = pl:GetAmmoCount(pl:GetActiveWeapon():GetPrimaryAmmoType())

		surface.CreateFont("Sans", 50, 300, true, false, "BAM")
		surface.SetTextColor(255,255,255,255)
		surface.SetTextPos((ScrW()/2)-(Scrw()/2.2), (ScrH/2)+(ScrH()/3))