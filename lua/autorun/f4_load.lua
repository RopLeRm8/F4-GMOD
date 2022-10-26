

if CLIENT then
	function DownLoad_Image(url,name)
		file.CreateDir('RopLeR/image/')
		http.Fetch(url,function(x)
			local f = file.Open( "RopLeR/image/" .. name, "wb", "DATA" )
			f:Write( x )
			f:Close()
		end)
	end

	
	DownLoad_Image("https://i.ibb.co/0QvCSZ4/discord-white-2.png","discord.png")
	
	DownLoad_Image("https://i.ibb.co/mqmzb3R/steam-white-2.png","steam.png")
	
	DownLoad_Image("https://i.ibb.co/FwX3q6Z/house-white.png","dashboard.png")
	
	DownLoad_Image("https://i.ibb.co/3csv5y9/multiple-users-silhouette-white.png","jobs.png")
	
	DownLoad_Image("https://i.ibb.co/2nNt9Xv/bomb-white.png","entities.png")
	
	DownLoad_Image("https://i.ibb.co/HGSf5Z5/axt-werkzeug-white.png","weapons.png")
	
	DownLoad_Image("https://i.ibb.co/fX3nQy9/shipment-2.png","shipments.png")
	
	DownLoad_Image("https://i.ibb.co/XsW0J18/bullets-1-white.png","ammo.png")
	
	DownLoad_Image("https://i.ibb.co/4743N9p/gesetzlicher-hammer-white.png","rules.png")
	
end	




include("ropler_f4/config/f4_config.lua") -- Loading the config

if SERVER then

AddCSLuaFile("ropler_f4/config/f4_config.lua")

for k,v in pairs(file.Find("ropler_f4/serverStuff/*.lua","LUA")) do -- loading everything that is serverside

	include("ropler_f4/serverStuff/" .. v)
end

end


for k, v in pairs(file.Find("ropler_f4/*.lua","LUA")) do -- loading everything that is ropler_f4 folder(clientside)

	if (SERVER) then
	AddCSLuaFile("ropler_f4/" .. v)
   	else
	include("ropler_f4/" .. v)
    end

end

if CLIENT then

	hook.Add("ShowSpare2","OpenF4", openMenu)

end








