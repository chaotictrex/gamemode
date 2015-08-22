local ply = FindMetaTable("Player") --defined FindMetaTable player
util.AddNetworkString("database") --send msg with networkstring database(database info)

function ply:ShortSteamID() --gets steam id and replaces the front part of it with nothing then returns it
	local id = self:SteamID()
	local id = tostring(id)
	local id = string.Replace(id, "STEAM_0:0:", "")
	local id = string.Replace(id, "STEAM_0:1:", "")
	return id 
end

local oldPrint = print 
local function print(s)
	 oldPrint("database.lua" .. a)
end

function ply:databaseDefault()  --default database info when you join
	self:databaseSetValue("hunger", 100)
	self:databaseSetValue("antipoison", 100)
	local i = {}
	i["energy"] = { amount = 1 } --item energy
	i["antidote"] = { amount = 1 } --item health vial
	self:databaseSetValue("inventory", i)
end

function ply:databaseNetworkedData() --couple of database stats can be transferred through string 
	local hunger = self:databaseSetValue("hunger")
	local armor = self:databaseSetValue("antipoison")
	self:SetNWInt("hunger", hunger) --sends the data to anyone on server
	self:SetNWInt("antipoison", antipoison)

	self:KillSilent()
	self:Spawn()
end

function ply:databaseFolders()
	return "server/btoom/players/" .. self:ShortSteamID() .. "/"
end

function ply:databasePath() --takes databasefolder path and adds .txt to it
	return self:databaseFolders() .. "database.txt"
end

function ply:databaseSet(tab)
	self.database = tab 
end 

function ply:databaseGet()
	return self.database 
end

function ply:databaseCheck()
	self.database = {}
	local f = self:databaseExists()
	if f then 
		self:databaseRead()
	else
		self:databaseCreate()
	end
	self:databaseSend()
    self:databaseNetworkedData()

end

function ply:databaseSend()
	net.Start("database")
		net.WriteTable(self:databaseGet())
	net.Send(self)
end

function ply:databaseExists()
	local f = file.Exists(self:databasePath(), "DATA")
	return f 
end 

function ply:databaseRead()
	local str = file.Read(self.databasePath(), "DATA") --makes the text in the file into a table 
	self:databaseSet( util.KeyValuesToTable(str))
end

function ply:databaseSave()
	local str = util.TableToKeyValues(self.database)  --takes table of database and makes into a string to write into the .txt file 
	local f = file.Write(self:databasePath(), str)
	self:databaseSend()
end 

function ply:databaseCreate()
	self:databaseDefault()
	local b = file.CreateDir( self:databaseFolders())
	self:databaseSave()
end 

function ply:databaseDisconnect()
	self:databaseSave()
end

function ply:databaseSetValue( name, v)
	if not v then return end 

	if type(v) == "table" then 
		if name == "inventory" then 
			for k,b in pairs(v) do 
				if b.amount <- 0 then 
					v[k] = nil 
			 end 
		end 
	end 
end
local d = self:databaseGet()
d[name] = v 
self:databaseSave()
end