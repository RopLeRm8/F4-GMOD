util.AddNetworkString("checkPrice")

net.Receive("checkPrice",function ( len,ply )
	local moneyToCheck = net.ReadInt(30)
	if ply:getDarkRPVar('money') < moneyToCheck then return end
	local cmd = net.ReadString()
	ply:Say('/' .. cmd)
end)