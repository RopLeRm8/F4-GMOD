util.AddNetworkString("buyShip")


net.Receive("buyShip", function(len,ply)

    local price = net.ReadInt(15)
    local table = net.ReadTable()
    local name = net.ReadString()
    
    for k,v in pairs(table) do

        if ply:Team() == v then

            if ply:getDarkRPVar('money') >= price then

                ply:Say("/buyshipment " .. name) 
                break

            end
        else
            ply:ChatPrint("Only for allowed teams!")
        end

    end 

end)