print("shimpents loaded")

local ShipmentsPanel = {}
local shipmentDesc

local CategoriesToShipments = {}
local Shipments = {}
local CategoriesANDShipments = {}

function ShipmentsPanel:Init()
	self:SetAlpha(0)
	self:AlphaTo(255,0.2,0)
	CategoriesToShipments = {}
	CategoriesANDShipments = {}
	Jobs = {}
	self:SetSize(x * .531, y * .8 )
	self:SetPos(x * .19, y * .115)

	for k,v in pairs(DarkRP.getCategories()) do

			for _,o in pairs(v) do
				if o.categorises == "shipments" then
					for i,z in pairs(o) do
						if istable(z) then
						for x,c in pairs(z) do
							if istable(c) then
								table.insert(CategoriesToShipments,c)
							end
						end
					end 	
					end
				end
			end
		
	end
PrintTable(CategoriesToShipments)

        

	for k,v in pairs(CategoriesToShipments) do

		CategoriesANDShipments[v.category] = {}


	end

	for k,v in pairs(CategoriesToShipments) do
		CategoriesANDShipments[v.category][v.name] = {}
		table.insert(CategoriesANDShipments[v.category][v.name],v.model)
		table.insert(CategoriesANDShipments[v.category][v.name],v.allowed)
		table.insert(CategoriesANDShipments[v.category][v.name],v.entity)
        table.insert(CategoriesANDShipments[v.category][v.name],v.name)
        table.insert(CategoriesANDShipments[v.category][v.name],v.price)

	end


	
	self.ScrollBur = vgui.Create( "DScrollPanel", self )

	self.ScrollBur:Dock( FILL )

	local initialPos = self:GetTall() * .001 

for k,v in pairs(CategoriesANDShipments) do

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

		self.CreateLabelForJob = vgui.Create("DPanel",self.createcategoryman)	
	--	self.CreateLabelForJob:DockMargin(0,0,50,0)
		self.CreateLabelForJob:SetSize(self.createcategoryman:GetWide() * .486, y * .074)

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
		self.CreateLabelForJob:SetPos(self.createcategoryman.getRight,self.createcategoryman.getDown)
		self.CreateLabelForJob.Paint = function(this,w,h)
			draw.RoundedBox(5, 0, 0, w,h, F4_Config_Custom.BetweenColor)
		end

		self.LabelOfTheJob = vgui.Create("DLabel", self.CreateLabelForJob)
		self.LabelOfTheJob:SetText(self.createcategoryman.weapons[i])
		self.LabelOfTheJob:SetSize(self.LabelOfTheJob:GetParent():GetWide() * .7, self.LabelOfTheJob:GetParent():GetTall() * .47)
		self.LabelOfTheJob:SetFont("MediumFont")
	    self.LabelOfTheJob:SetColor(whiteColor)
	    self.LabelOfTheJob:SetPos(self.LabelOfTheJob:GetParent():GetWide() * .22, 0)
	    self.LabelOfTheJob.Paint = function(this,w,h)
	    	draw.RoundedBox(0, 0, h * .9, utf8.len(this:GetText()) * (w* .037), h * .06, F4_Config_Custom.JobButtColor)
	    end
	   
	    self.icon = vgui.Create( "DModelPanel", self.CreateLabelForJob  )
        self.icon:SetSize(self.CreateLabelForJob:GetWide() * .15,self.CreateLabelForJob:GetTall() )
        self.icon:SetPos(self.CreateLabelForJob:GetWide() * .02,self.CreateLabelForJob:GetTall() * .01)
      --  if #self.createcategoryman.models[i] > 1 then
       function self.icon:LayoutEntity( Entity ) return end

    	self.icon:SetModel( self.createcategoryman.model[i])


        self.icon:SetLookAt(Vector(0,-3,2))
     --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
        self.icon:SetFOV(20)



        self.OutOfmax = vgui.Create("DPanel",self.CreateLabelForJob)
       
        self.OutOfmax:SetSize(self.CreateLabelForJob:GetWide() * .6,self.CreateLabelForJob:GetTall() * .33)

         self.OutOfmax:SetPos(self.CreateLabelForJob:GetWide() * .22,self.CreateLabelForJob:GetTall() * .6)

         self.OutOfmax.Paint = function(this,w,h)

         	
         	draw.RoundedBox(5, 0,0, w,h, HSVToColor(  ( CurTime() * 60 ) % 360, 1, 0.5 ))


         end




         self.SelectJob = vgui.Create("DButton",self.CreateLabelForJob)

         self.SelectJob:SetSize(self.CreateLabelForJob:GetWide() * .16,self.CreateLabelForJob:GetTall() * .9)

         self.SelectJob:SetPos(self.CreateLabelForJob:GetWide() * .83,self.CreateLabelForJob:GetTall() * .07)

         self.SelectJob.Paint = function(this,w,h)
              draw.RoundedBox(3,0,0,w,h,F4_Config_Custom.JobButtColor)
         end


			self.SelectJob.model = ( self.createcategoryman.model[i])


		self.SelectJob.model = self.createcategoryman.model[i]
		
		self.SelectJob.allowed = self.createcategoryman.allowed[i]

		self.SelectJob.entity = self.createcategoryman.entity[i]

		self.SelectJob.name = self.createcategoryman.name[i]

		self.SelectJob.price = self.createcategoryman.price[i]





         self.SelectJob:SetText(DarkRP.formatMoney(self.createcategoryman.price[i]))
         self.SelectJob:SetFont("BoldFontSmaller")
         self.SelectJob:SetColor(whiteColor)
		 
		 self.SelectJob.DoClick = function(this)

			if IsValid(JobDesc) then
				JobDesc:Remove()
			end

		
			JobDesc = vgui.Create("DPanel",mainMenu)
			JobDesc:SetPos(self:GetParent():GetWide() * .749, self:GetParent():GetTall() * .11)
			JobDesc:SetSize(self:GetParent():GetWide() * .227,self:GetParent():GetTall())
			JobDesc.Paint = function(zelf,w,h)
				draw.RoundedBox(0,0,0,w,h,F4_Config_Custom.tabsBackgroundColor)
			    draw.RoundedBox(0,0,0,w * .002,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .888,w ,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,0,w ,h * .005,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .888,w ,h,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, 0,h * .445,w ,h * .01,F4_Config_Custom.mainColor)
				draw.RoundedBox(0, w * .015,h * .507,w * .97 ,h * .008,F4_Config_Custom.JobButtColor)
				draw.RoundedBox(0, 0,h * .51,w ,h * .01,F4_Config_Custom.mainColor)
			end
			ModelChosen = JobDesc:Add("DModelPanel")
			ModelChosen:SetSize(self:GetParent():GetWide() * .2,self:GetParent():GetTall() * .65 )
			ModelChosen:SetPos(self:GetParent():GetWide() * .017,self:GetParent():GetTall() * .01)

			ModelChosen:SetModel( this.model )
            ModelChosen:SetLookAt(Vector(0,0, -10))
            --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
            ModelChosen:SetFOV(30)


			local JobChosen = JobDesc:Add("DLabel")
			JobChosen:SetMultiline(true)
			JobChosen:SetText(this.name)
			JobChosen:SetFont("LightFontBigger")
			JobChosen:SetPos(JobDesc:GetWide() / 2 - utf8.len(this.name) * 4.5  ,self:GetParent():GetTall() * .42)
			JobChosen:SetSize(self:GetParent():GetWide() * .5,self:GetParent():GetTall() * .12)
			
			JobChosen:SetColor(whiteColor)

			local DescChosen = JobDesc:Add("DTextEntry")
			
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
			
			local SubmitButton = JobDesc:Add("DButton")
			SubmitButton:SetFont("MediumFont")
			SubmitButton:SetSize(self:GetParent():GetWide() * .17,self:GetParent():GetTall() * .05)
			SubmitButton:SetPos(self:GetParent():GetWide() * .03 ,self:GetParent():GetTall() * .6 )

			SubmitButton:SetText("Click to purchase")

			SubmitButton.lerp = 40
			SubmitButton.Paint = function(this,w,h)
				if not this:IsHovered() then
				surface.SetDrawColor(F4_Config_Custom.JobButtColor)
				this.lerp = 40
				else
					this.lerp = Lerp(FrameTime() * 2, this.lerp, 255)
					surface.SetDrawColor(0, this.lerp,0,255)
					
				end
				surface.DrawRect(0,0,w,h)
			end	
			SubmitButton:SetColor(whiteColor)
			SubmitButton.DoClick = function()
				

					net.Start("buyShip")
					net.WriteInt(this.price,15)
                    net.WriteTable(this.allowed)
                    net.WriteString(this.name)
					net.SendToServer()
                    mainMenu:Remove()

			end
			
		 end

	end


end


end




function ShipmentsPanel:Paint(w,h)
end


vgui.Register("shipments_panel", ShipmentsPanel, "DPanel")