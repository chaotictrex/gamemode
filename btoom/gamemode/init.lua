AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

function GM:PlayerConnect(name, ip)
	print("Survivor:" .. name .. ", has joined the game.")
end

function GM:PlayerInitialSpawn(ply)
	print("Survivor:" .. ply:Nick() .. ", has spawned.")
	
	ply:SetGamemodeTeam( 1 )
end

function GM:PlayerSpawn( ply )
	ply:SetModel("models/player/group01/male_07.mdl")
	ply:GiveGamemodeWeapons()
end

function GM:PlayerAuthed(ply,steamID,uniqueID)
	print("Survivor:" .. ply:Nick() .. ", has gotten authed.")
end

