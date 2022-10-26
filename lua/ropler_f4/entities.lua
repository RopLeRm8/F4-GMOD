print('jobs loaded')

local EntitiesPanel = {}

local CategoriesToEntities = {}
local Entities = {}
local CategoriesANDEntities = {}

function EntitiesPanel:Init()
	self:SetAlpha(0)
	self:AlphaTo(255,0.2,0)
	CategoriesToEntities = {}
	CategoriesANDEntities = {}
	self:SetSize(x * .531, y )
	self:SetPos(x * .19, y * .115)

	for k,v in pairs(DarkRP.getCategories()) do

			for _,o in pairs(v) do
				if o.categorises == "entities" then
					for i,z in pairs(o) do
						if istable(z) then
						for x,c in pairs(z) do
							if istable(c) then
								table.insert(CategoriesToEntities,c)
							end
						end
					end 	
					end
				end
			end
		
	end


	for k,v in pairs(CategoriesToEntities) do

		CategoriesANDEntities[v.category] = {}


	end

	for k,v in pairs(CategoriesToEntities) do
		CategoriesANDEntities[v.category][v.name] = {}
		table.insert(CategoriesANDEntities[v.category][v.name],v.cmd)
		table.insert(CategoriesANDEntities[v.category][v.name],v.model)
		table.insert(CategoriesANDEntities[v.category][v.name],v.max)
		table.insert(CategoriesANDEntities[v.category][v.name],v.name)
		table.insert(CategoriesANDEntities[v.category][v.name],v.price)

	end


	
	self.ScrollBur = vgui.Create( "DScrollPanel", self )

	self.ScrollBur:Dock( FILL )

	local initialPos = self:GetTall() * .001 

for k,v in pairs(CategoriesANDEntities) do

	self.createcategoryman = self.ScrollBur:Add("DPanel")

	self.createcategoryman:SetPos(self:GetWide() * .001, initialPos )
	
	if table.Count(v) % 2 == 0 and table.Count(v) > 2 then
		self.createcategoryman.sizeman = (table.Count(v) / 2 - 0.5) * (y * .16) 
	   else if table.Count(v) == 1 then
		   self.createcategoryman.sizeman = (table.Count(v) / 2) * (y * .33) 
	   else
		   self.createcategoryman.sizeman = (table.Count(v) / 2) * (y * .16) 
	   end
   end


	
	--print(table.KeyFromValue(CategoriesANDJobs, v))

	self.createcategoryman.category = k

	self.createcategoryman.ents = {}

	self.createcategoryman.cmd = {}

	self.createcategoryman.model = {}

	self.createcategoryman.max = {}

	self.createcategoryman.name = {}

	self.createcategoryman.price = {}

	for n,m in pairs(v) do

		table.insert(self.createcategoryman.ents,n)

		table.insert(self.createcategoryman.cmd,m[1])

		table.insert(self.createcategoryman.model,m[2])

		table.insert(self.createcategoryman.max,m[3])

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
		for i = 1, #self.createcategoryman.ents do

		self.CreateLabelForEntity = vgui.Create("DPanel",self.createcategoryman)	
	--	self.CreateLabelForJob:DockMargin(0,0,50,0)
		self.CreateLabelForEntity:SetSize(self.createcategoryman:GetWide() * .486, y * .074)

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
		self.CreateLabelForEntity:SetPos(self.createcategoryman.getRight,self.createcategoryman.getDown)
		self.CreateLabelForEntity.Paint = function(this,w,h)
			draw.RoundedBox(5, 0, 0, w,h, F4_Config_Custom.BetweenColor)
		end

		self.LabelOfTheEntity = vgui.Create("DLabel", self.CreateLabelForEntity)
		self.LabelOfTheEntity:SetText(self.createcategoryman.ents[i])
		self.LabelOfTheEntity:SetSize(self.LabelOfTheEntity:GetParent():GetWide() * .7, self.LabelOfTheEntity:GetParent():GetTall() * .47)
		self.LabelOfTheEntity:SetFont("MediumFont")
	    self.LabelOfTheEntity:SetColor(whiteColor)
	    self.LabelOfTheEntity:SetPos(self.LabelOfTheEntity:GetParent():GetWide() * .22, 0)
	    self.LabelOfTheEntity.Paint = function(this,w,h)
	    	draw.RoundedBox(0, 0, h * .9, utf8.len(this:GetText()) * (w* .037), h * .06, F4_Config_Custom.JobButtColor)
	    end
	   
	    self.icon = vgui.Create( "DModelPanel", self.CreateLabelForEntity  )
        self.icon:SetSize(self.CreateLabelForEntity:GetWide() * .15,self.CreateLabelForEntity:GetTall() )
        self.icon:SetPos(self.CreateLabelForEntity:GetWide() * .02,self.CreateLabelForEntity:GetTall() * .01)
      --  if #self.createcategoryman.models[i] > 1 then
       function self.icon:LayoutEntity( Entity ) return end

    	self.icon:SetModel( self.createcategoryman.model[i])
  
		


        self.icon:SetLookAt(Vector(0,-3,9))
     --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
        self.icon:SetFOV(40)



        self.OutOfmax = vgui.Create("DPanel",self.CreateLabelForEntity)
       
        self.OutOfmax:SetSize(self.CreateLabelForEntity:GetWide() * .6,self.CreateLabelForEntity:GetTall() * .33)

         self.OutOfmax:SetPos(self.CreateLabelForEntity:GetWide() * .22,self.CreateLabelForEntity:GetTall() * .6)



         self.OutOfmax.Paint = function(this,w,h)

         	

         	draw.RoundedBox(5, 0,0, w,h, F4_Config_Custom.secondaryColor)

         end


         self.CountMax = vgui.Create("DLabel",self.OutOfmax)

     	 self.CountMax:SetText("Limit: " ..self.createcategoryman.max[i])
  

         self.CountMax:SetFont("MediumFontSmaller")

         self.CountMax:SetPos(x * 0.061, 2)

         self.CountMax:SetColor(whiteColor)



         self.SelectEntity = vgui.Create("DButton",self.CreateLabelForEntity)

         self.SelectEntity:SetSize(self.CreateLabelForEntity:GetWide() * .16,self.CreateLabelForEntity:GetTall() * .9)

         self.SelectEntity:SetPos(self.CreateLabelForEntity:GetWide() * .83,self.CreateLabelForEntity:GetTall() * .07)

         self.SelectEntity.Paint = function(this,w,h)
              draw.RoundedBox(3,0,0,w,h,F4_Config_Custom.JobButtColor)
         end


			self.SelectEntity.model = ( self.createcategoryman.model[i])
		

		self.SelectEntity.cmd = self.createcategoryman.cmd[i]
		
		self.SelectEntity.model = self.createcategoryman.model[i]

		self.SelectEntity.max = self.createcategoryman.max[i]

		self.SelectEntity.name = self.createcategoryman.name[i]

		self.SelectEntity.price = self.createcategoryman.price[i]



         self.SelectEntity:SetText(self.createcategoryman.price[i])
         self.SelectEntity:SetFont("BoldFontSmaller")
         self.SelectEntity:SetColor(whiteColor)
		 
		 self.SelectEntity.DoClick = function(this)

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
			ModelChosen:SetSize(self:GetParent():GetWide() * .14,self:GetParent():GetTall() * .65 )
			ModelChosen:SetPos(self:GetParent():GetWide() * .0415,self:GetParent():GetTall() * .01)
			ModelChosen:SetModel(this.model)

			   ModelChosen:SetLookAt(Vector(0,-3,-40))
			   --   self.icon:SetCamPos(self:GetModel():OBBCenter())   
			   ModelChosen:SetFOV(40)

	
			local EntityChosen = JobDesc:Add("DLabel")
			EntityChosen:SetMultiline(true)
			EntityChosen:SetText(this.name)
			EntityChosen:SetFont("LightFontBigger")
			EntityChosen:SetPos(JobDesc:GetWide() / 2 - utf8.len(this.name) * 4.5  ,self:GetParent():GetTall() * .42)
			EntityChosen:SetSize(self:GetParent():GetWide() * .5,self:GetParent():GetTall() * .12)
			
			EntityChosen:SetColor(whiteColor)

			local DescChosen = JobDesc:Add("DTextEntry")
			
			DescChosen:SetMultiline(true)
			DescChosen:SetFont("LightFont")
			DescChosen:Dock(BOTTOM)
			DescChosen:DockMargin(0,0,0,x * .065)
			DescChosen:SetSize(self:GetParent():GetWide() * .22,self:GetParent():GetTall() * .35)
			DescChosen:SetPos(self:GetParent():GetWide() * .005 ,self:GetParent():GetTall() * .55)

			DescChosen:SetTextColor(whiteColor)
			DescChosen:SetDrawBackground(false)
			DescChosen.AllowInput = function()
			return false
			end
	
			local BuyButton = JobDesc:Add("DButton")
			BuyButton:SetFont("MediumFont")
			BuyButton:SetSize(self:GetParent():GetWide() * .17,self:GetParent():GetTall() * .05)
			BuyButton:SetPos(self:GetParent():GetWide() * .03 ,self:GetParent():GetTall() * .6 )

			BuyButton:SetText("Click to buy")
	
			BuyButton.lerp = 40
			BuyButton.Paint = function(this,w,h)
				if not this:IsHovered() then
				surface.SetDrawColor(F4_Config_Custom.JobButtColor)
				this.lerp = 40
				else
					this.lerp = Lerp(FrameTime() * 2, this.lerp, 255)
					surface.SetDrawColor(0, this.lerp,0,255)
					
				end
				surface.DrawRect(0,0,w,h)
			end	
			BuyButton:SetColor(whiteColor)
			BuyButton.DoClick = function()
				
					net.Start("checkPrice")
					net.WriteInt(this.price,30)
					net.WriteString(this.cmd)
					net.SendToServer()
					mainMenu:Remove()
					
			end
			
		 end

	end


end


end




function EntitiesPanel:Paint(w,h)
end


vgui.Register("entities_panel", EntitiesPanel, "DPanel")