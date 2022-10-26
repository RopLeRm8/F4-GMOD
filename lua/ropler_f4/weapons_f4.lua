print('weapons loaded')

local WeaponsPanel = {}
local WeaponsDesc

local CategoriesToWeapons = {}
local Weapons = {}
local CategoriesANDWeapons = {}

function WeaponsPanel:Init()
	self:SetAlpha(0)
	self:AlphaTo(255,0.2,0)
	CategoriesToWeapons = {}
	CategoriesANDWeapons = {}
	Weapons = {}
	self:SetSize(x * .531, y * .8 )
	self:SetPos(x * .19, y * .115)

	for k,v in pairs(DarkRP.getCategories()) do

			for _,o in pairs(v) do
				if o.categorises == "weapons" then
					for i,z in pairs(o) do
						if istable(z) then
						for x,c in pairs(z) do
							if istable(c) then
								table.insert(CategoriesToWeapons,c)
							end
						end
					end 	
					end
				end
			end
		
	end
PrintTable(CategoriesToWeapons)

        

	for k,v in pairs(CategoriesToWeapons) do

		CategoriesANDWeapons[v.category] = {}


	end

	for k,v in pairs(CategoriesToWeapons) do
		CategoriesANDWeapons[v.category][v.name] = {}
		table.insert(CategoriesANDWeapons[v.category][v.name],v.model)
		table.insert(CategoriesANDWeapons[v.category][v.name],v.allowed)
		table.insert(CategoriesANDWeapons[v.category][v.name],v.entity)
        table.insert(CategoriesANDWeapons[v.category][v.name],v.name)
        table.insert(CategoriesANDWeapons[v.category][v.name],v.price)

	end


	
	self.ScrollBur = vgui.Create( "DScrollPanel", self )

	self.ScrollBur:Dock( FILL )

	local initialPos = self:GetTall() * .001 

for k,v in pairs(CategoriesANDWeapons) do

	self.createcategoryman = self.ScrollBur:Add("DPanel")

	self.createcategoryman:SetPos(self:GetWide() * .001, initialPos )
	if table.Count(v) % 2 == 0 and table.Count(v) > 2 then
        self.createcategoryman.sizeman = (table.Count(v) / 2 - 0.5) * (self:GetTall() * .18) 
       else if table.Count(v) == 1 then
           self.createcategoryman.sizeman = (table.Count(v) / 2) * (self:GetTall() * .33) 
       else
           self.createcategoryman.sizeman = (table.Count(v) / 2) * (self:GetTall() * .18) 
       end
   end


	
	--print(table.KeyFromValue(CategoriesANDJobs, v))

	self.createcategoryman.category = k

    self.createcategoryman.weapons = {}

	self.createcategoryman.model = {}

	self.createcategoryman.allowed = {}

	self.createcategoryman.entity = {}

	self.createcategoryman.name = {}

	self.createcategoryman.price = {}


	for n,m in pairs(v) do

		table.insert(self.createcategoryman.weapons,n)

		table.insert(self.createcategoryman.model,m[1])

		table.insert(self.createcategoryman.allowed,m[2])

		table.insert(self.createcategoryman.entity,m[3])

		table.insert(self.createcategoryman.name,m[4])

		table.insert(self.createcategoryman.price,m[5])

	end

	self.createcategoryman:SetSize(self:GetWide() * .99, self.createcategoryman.sizeman)


	initialPos = initialPos + self:GetTall() * .01 + self.createcategoryman.sizeman

	self.createcategoryman.getDown = 0
	self.createcategoryman.getRight = 0

	self.createcategoryman.Paint = function(this,w,h)

		draw.RoundedBox(2, 0, 0, w, h, F4_Config_Custom.JobBackground)

		draw.RoundedBox(2, w * 0.01, 45, w * 0.98, h * .01, F4_Config_Custom.JobButtColor)

		draw.SimpleText(this.category,"LightFontBigger",15,0,whiteColor,TEXT_ALIGN_LEFT)

	end
	self.createcategoryman.getDown = self.createcategoryman:GetTall() * .03
	local indexDivide = 3
		for i = 1, #self.createcategoryman.weapons do

		self.CreateLabelForWeapon = vgui.Create("DPanel",self.createcategoryman)	
	--	self.CreateLabelForJob:DockMargin(0,0,50,0)
		self.CreateLabelForWeapon:SetSize(self.createcategoryman:GetWide() * .486, y * .074)

		if i % indexDivide == 0 then
			indexDivide = indexDivide + 2
			self.createcategoryman.getDown = self.createcategoryman.getDown + 90

			self.createcategoryman.getRight = self.createcategoryman:GetWide() * .006

		else if i == 1 then
			self.createcategoryman.getDown = self.createcategoryman.getDown + 50
			self.createcategoryman.getRight = self.createcategoryman:GetWide() * .006
		else
			self.createcategoryman.getRight = self.createcategoryman:GetWide() * .51
		end
		end
		self.CreateLabelForWeapon:SetPos(self.createcategoryman.getRight,self.createcategoryman.getDown)
		self.CreateLabelForWeapon.Paint = function(this,w,h)
			draw.RoundedBox(5, 0, 0, w,h, F4_Config_Custom.BetweenColor)
		end

		self.LabelOfTheWeapon = vgui.Create("DLabel", self.CreateLabelForWeapon)
		self.LabelOfTheWeapon:SetText(self.createcategoryman.weapons[i])
		self.LabelOfTheWeapon:SetSize(self.LabelOfTheWeapon:GetParent():GetWide() * .7, self.LabelOfTheWeapon:GetParent():GetTall() * .47)
		self.LabelOfTheWeapon:SetFont("MediumFont")
	    self.LabelOfTheWeapon:SetColor(whiteColor)
	    self.LabelOfTheWeapon:SetPos(self.LabelOfTheWeapon:GetParent():GetWide() * .22, 0)
	    self.LabelOfTheWeapon.Paint = function(this,w,h)
	    	draw.RoundedBox(0, 0, h * .9, utf8.len(this:GetText()) * (w* .037), h * .06, F4_Config_Custom.JobButtColor)
	    end
	   
	    self.icon = vgui.Create( "DModelPanel", self.CreateLabelForWeapon  )
        self.icon:SetSize(self.CreateLabelForWeapon:GetWide() * .15,self.CreateLabelForWeapon:GetTall() )
        self.icon:SetPos(self.CreateLabelForWeapon:GetWide() * .02,self.CreateLabelForWeapon:GetTall() * .01)
      --  if #self.createcategoryman.models[i] > 1 then
       function self.icon:LayoutEntity( Entity ) return end

    	self.icon:SetModel( self.createcategoryman.model[i])


        self.icon:SetLookAt(Vector(0,-3,2))
     --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
        self.icon:SetFOV(8)



        self.OutOfmax = vgui.Create("DPanel",self.CreateLabelForWeapon)
       
        self.OutOfmax:SetSize(self.CreateLabelForWeapon:GetWide() * .6,self.CreateLabelForWeapon:GetTall() * .33)

         self.OutOfmax:SetPos(self.CreateLabelForWeapon:GetWide() * .22,self.CreateLabelForWeapon:GetTall() * .6)

         self.OutOfmax.Paint = function(this,w,h)

         	
         	draw.RoundedBox(5, 0,0, w,h, HSVToColor(  ( CurTime() * 60 ) % 360, 1, 0.5 ))


         end




         self.SelectWeapon = vgui.Create("DButton",self.CreateLabelForWeapon)

         self.SelectWeapon:SetSize(self.CreateLabelForWeapon:GetWide() * .16,self.CreateLabelForWeapon:GetTall() * .9)

         self.SelectWeapon:SetPos(self.CreateLabelForWeapon:GetWide() * .83,self.CreateLabelForWeapon:GetTall() * .07)

         self.SelectWeapon.Paint = function(this,w,h)
              draw.RoundedBox(3,0,0,w,h,F4_Config_Custom.JobButtColor)
         end


			self.SelectWeapon.model = ( self.createcategoryman.model[i])


		self.SelectWeapon.model = self.createcategoryman.model[i]
		
		self.SelectWeapon.allowed = self.createcategoryman.allowed[i]

		self.SelectWeapon.entity = self.createcategoryman.entity[i]

		self.SelectWeapon.name = self.createcategoryman.name[i]

		self.SelectWeapon.price = self.createcategoryman.price[i]





         self.SelectWeapon:SetText(DarkRP.formatMoney(self.createcategoryman.price[i]))
         self.SelectWeapon:SetFont("BoldFontSmaller")
         self.SelectWeapon:SetColor(whiteColor)
		 
		 self.SelectWeapon.DoClick = function(this)

			if IsValid(WepDesc) then
				WepDesc:Remove()
			end

		
			WepDesc = vgui.Create("DPanel",mainMenu)
			WepDesc:SetPos(self:GetParent():GetWide() * .749, self:GetParent():GetTall() * .11)
			WepDesc:SetSize(self:GetParent():GetWide() * .227,self:GetParent():GetTall())
			WepDesc.Paint = function(zelf,w,h)
				draw.RoundedBox(0,0,0,w,h,F4_Config_Custom.tabsBackgroundColor)
			    draw.RoundedBox(0,0,0,w * .002,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .888,w ,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,0,w ,h * .005,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .888,w ,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .445,w ,h * .01,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, w * .015,h * .507,w * .97 ,h * .008,F4_Config_Custom.JobButtColor)
				draw.RoundedBox(0, 0,h * .51,w ,h * .01,F4_Config_Custom.mainColor)
			end
			ModelChosen = WepDesc:Add("DModelPanel")
			ModelChosen:SetSize(self:GetParent():GetWide() * .2,self:GetParent():GetTall() * .65 )
			ModelChosen:SetPos(self:GetParent():GetWide() * .017,self:GetParent():GetTall() * .01)

			ModelChosen:SetModel( this.model )
            ModelChosen:SetLookAt(Vector(0,0, -10))
            --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
            ModelChosen:SetFOV(25)


			local WepChosen = WepDesc:Add("DLabel")
			WepChosen:SetMultiline(true)
			WepChosen:SetText(this.name)
			WepChosen:SetFont("LightFontBigger")
			WepChosen:SetPos(WepDesc:GetWide() / 2 - utf8.len(this.name) * 4.5  ,self:GetParent():GetTall() * .42)
			WepChosen:SetSize(self:GetParent():GetWide() * .5,self:GetParent():GetTall() * .12)
			
			WepChosen:SetColor(whiteColor)

			local DescChosen = WepDesc:Add("DTextEntry")
			
			DescChosen:SetMultiline(true)
			DescChosen:SetFont("LightFont")
			DescChosen:Dock(BOTTOM)
			DescChosen:DockMargin(0,0,0,120)
			DescChosen:SetSize(self:GetParent():GetWide() * .22,self:GetParent():GetTall() * .35)
			DescChosen:SetPos(self:GetParent():GetWide() * .005 ,self:GetParent():GetTall() * .55)


			DescChosen:SetTextColor(whiteColor)
			DescChosen:SetDrawBackground(false)
			DescChosen.AllowInput = function()
			return false
			end
			
			local BuyWeapon = WepDesc:Add("DButton")
			BuyWeapon:SetFont("MediumFont")
			BuyWeapon:SetSize(self:GetParent():GetWide() * .17,self:GetParent():GetTall() * .05)
			BuyWeapon:SetPos(self:GetParent():GetWide() * .03 ,self:GetParent():GetTall() * .6 )

			BuyWeapon:SetText("Click to purchase")

			BuyWeapon.lerp = 40
			BuyWeapon.Paint = function(this,w,h)
				if not this:IsHovered() then
				surface.SetDrawColor(F4_Config_Custom.JobButtColor)
				this.lerp = 40
				else
					this.lerp = Lerp(FrameTime() * 2, this.lerp, 255)
					surface.SetDrawColor(0, this.lerp,0,255)
					
				end
				surface.DrawRect(0,0,w,h)
			end	
			BuyWeapon:SetColor(whiteColor)
			BuyWeapon.DoClick = function()
				

					net.Start("buyWeapon")
					net.WriteInt(this.price,15)
                    net.WriteTable(this.allowed)
                    net.WriteString(this.name)
					net.SendToServer()
					


			end
			
		 end

	end


end


end




function WeaponsPanel:Paint(w,h)
end


vgui.Register("weapons_panel", WeaponsPanel, "DPanel")