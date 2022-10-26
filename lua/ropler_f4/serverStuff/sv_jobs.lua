util.AddNetworkString("switchJob")

local delay = 0

net.Receive("switchJob", function(len,ply)
	
	plyJob = ply:Team()
	local jobWanted = net.ReadInt(5)
	local toVote = net.ReadBool()
	local maxPpl = net.ReadInt(4)
	local currPpl = net.ReadInt(5)
	modelChosen = net.ReadString()
	if currPpl != maxPpl then
	if plyJob != jobWanted and not toVote then
		ply:changeTeam(jobWanted,false,false)
	else if plyJob != jobWanted and toVote then
		if CurTime() > delay + 30 then
		delay = CurTime()
		local results = DarkRP.createVote("Should " .. ply:Nick() .. " be " .. team.GetName(jobWanted) .. "?", "customVote", ply, 30, function() 	end, {}, function() end)
		timer.Simple(30,function()
			if results.yea > results.nay then
				ply:changeTeam(jobWanted,false,false)
				ply:SetModel(modelChosen)
			end	-- if in timer end 
		end) -- timer end
	end -- first if end
	end -- second if end
end -- timer check end

end -- max check end

end)


hook.Add("OnPlayerChangedTeam","HelloMan",function(ply)
	
	ply:Respawn()
	ply:SetModel(modelChosen)
	
	print(ply:GetModel())

end)