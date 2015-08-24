local ply = FindMetaTable("Player")

local teams = {}

teams[1] = {name = "Survivors", color = Vector( .2, .2, 1.0), weapons = {"weapon_pulse"} , {"weapon_timed"} , {"weapon_fire"}}
teams[2] = {name = "Dead", color = Vector( 1.0, .2, .2), weapons = {} }
function ply:SetGameModeTeam( n )
	if not teams[n] then return end
	--if n < 0 or n > 1 then return false end
	
	self:SetTeam( n )

	--if n == 0 then 
		--self:SetPlayerColor(Vector( .2, .2, 1.0))
	--elseif n ==1 then
		--self:SetPlayerColor(Vector( 1.0, .2, .2))
	--end
	self:SetPlayerColor( teams[n].color)
	-- for loop, cycle through a table and use the values. k = 1 and k = 2 second value
	self:ply:GiveGamemodeWeapons()
	return true
end

function ply:GiveGamemodeWeapons()
	local n = self:Team()
	self:StripWeapons()
    for k, wep in pairs(teams[n].weapons) do 
    	self:Give(weapons[ math.random(#weapons)])
    end
end

function GM:DoPlayerDeath(ply)
	if ply:IsSpec() then return end
	print("Survivor" .. ply:Nick() .. ", has died.")
	ply:SetGamemodeTeam ( 2 )
end