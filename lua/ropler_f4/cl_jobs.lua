print('jobs loaded')

local JobsPanel = {}
local JobDesc

local CategoriesToJobs = {}
local Jobs = {}
local CategoriesANDJobs = {}

function JobsPanel:Init()
	self:SetAlpha(0)
	self:AlphaTo(255,0.2,0)
	CategoriesToJobs = {}
	CategoriesANDJobs = {}
	Jobs = {}
	self:SetSize(x * .531, y )
	self:SetPos(x * .19, y * .115)

	for k,v in pairs(DarkRP.getCategories()) do

			for _,o in pairs(v) do
				if o.categorises == "jobs" then
					for i,z in pairs(o) do
						if istable(z) then
						for x,c in pairs(z) do
							if istable(c) then
								table.insert(CategoriesToJobs,c)
							end
						end
					end 	
					end
				end
			end
		
	end



	for k,v in pairs(CategoriesToJobs) do

		CategoriesANDJobs[v.category] = {}


	end

	for k,v in pairs(CategoriesToJobs) do
		CategoriesANDJobs[v.category][v.name] = {}
		table.insert(CategoriesANDJobs[v.category][v.name],v.model)
		table.insert(CategoriesANDJobs[v.category][v.name],v.description)
		table.insert(CategoriesANDJobs[v.category][v.name],v.vote)
		table.insert(CategoriesANDJobs[v.category][v.name],v.salary)
		table.insert(CategoriesANDJobs[v.category][v.name],v.team)
		table.insert(CategoriesANDJobs[v.category][v.name],v.max)
		table.insert(CategoriesANDJobs[v.category][v.name],v.weapons)
	end


	
	self.ScrollBur = vgui.Create( "DScrollPanel", self )

	self.ScrollBur:Dock( FILL )

	local initialPos = self:GetTall() * .001 

for k,v in pairs(CategoriesANDJobs) do

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

	self.createcategoryman.jobs = {}

	self.createcategoryman.models = {}

	self.createcategoryman.desc = {}

	self.createcategoryman.vote = {}

	self.createcategoryman.salary = {}

	self.createcategoryman.team = {}

	self.createcategoryman.max = {}

	self.createcategoryman.weapons = {}

	for n,m in pairs(v) do

		table.insert(self.createcategoryman.jobs,n)

		table.insert(self.createcategoryman.models,m[1])

		table.insert(self.createcategoryman.desc,m[2])

		table.insert(self.createcategoryman.vote,m[3])

		table.insert(self.createcategoryman.salary,m[4])

		table.insert(self.createcategoryman.team,m[5])

		table.insert(self.createcategoryman.max,m[6])

		table.insert(self.createcategoryman.weapons, m[7])

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
		for i = 1, #self.createcategoryman.jobs do

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
		self.LabelOfTheJob:SetText(self.createcategoryman.jobs[i])
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
       if istable(self.createcategoryman.models[i]) then
        self.icon:SetModel( self.createcategoryman.models[i][1] )
    else
    	self.icon:SetModel( self.createcategoryman.models[i])
    end
    	local headpos =  self.icon.Entity:GetBonePosition(self.icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        self.icon:SetLookAt(Vector(-150,25,80))
        self.icon:SetCamPos(headpos-Vector(-23,4,0))   
        self.icon:SetFOV(30)
       self.icon.Entity:SetEyeTarget(headpos-Vector(-15, 0, 0))



        self.OutOfmax = vgui.Create("DPanel",self.CreateLabelForJob)
       
        self.OutOfmax:SetSize(self.CreateLabelForJob:GetWide() * .6,self.CreateLabelForJob:GetTall() * .33)

         self.OutOfmax:SetPos(self.CreateLabelForJob:GetWide() * .22,self.CreateLabelForJob:GetTall() * .6)



         self.OutOfmax.Paint = function(this,w,h)

         	

         	draw.RoundedBox(5, 0,0, w,h, F4_Config_Custom.secondaryColor)

         end

         self.OutOfMaxPaint = self.OutOfmax:Add("DPanel")
         self.OutOfMaxPaint:SetSize((#team.GetPlayers(self.createcategoryman.team[i]) / self.createcategoryman.max[i]) * self.OutOfmax:GetWide(),self.OutOfmax:GetTall())
     	 self.OutOfMaxPaint:SetPos(0,0)

     	 self.OutOfMaxPaint.Paint = function(this,w,h)

     	 draw.RoundedBox(5,0,0,w,h,F4_Config_Custom.JobButtColor)

     	 end


         self.CountMax = vgui.Create("DLabel",self.OutOfmax)
         if self.createcategoryman.max[i] != 0 then
         self.CountMax:SetText(#team.GetPlayers(self.createcategoryman.team[i]) .. "/" .. self.createcategoryman.max[i])
     else
     	 self.CountMax:SetText(#team.GetPlayers(self.createcategoryman.team[i]) .. "/∞")
     end

         self.CountMax:SetFont("MediumFontSmaller")

         self.CountMax:SetPos(x * 0.065, 0)

         self.CountMax:SetColor(whiteColor)


         self.SelectJob = vgui.Create("DButton",self.CreateLabelForJob)

         self.SelectJob:SetSize(self.CreateLabelForJob:GetWide() * .16,self.CreateLabelForJob:GetTall() * .9)

         self.SelectJob:SetPos(self.CreateLabelForJob:GetWide() * .83,self.CreateLabelForJob:GetTall() * .07)

         self.SelectJob.Paint = function(this,w,h)
              draw.RoundedBox(3,0,0,w,h,F4_Config_Custom.JobButtColor)
         end

		 if istable(self.createcategoryman.models[i]) then
			self.SelectJob.model = ( self.createcategoryman.models[i][1] )
		else
			self.SelectJob.model = ( self.createcategoryman.models[i])
		end

		self.SelectJob.desc = self.createcategoryman.desc[i]
		
		self.SelectJob.job = self.createcategoryman.jobs[i]

		self.SelectJob.weapons = self.createcategoryman.weapons[i]

		self.SelectJob.votable = self.createcategoryman.vote[i]

		self.SelectJob.team = self.createcategoryman.team[i]

		self.SelectJob.max = self.createcategoryman.max[i]

		self.SelectJob.modelsList = self.createcategoryman.models[i]


		self.SelectJob.CheckIfTable = istable(self.createcategoryman.models[i])

         self.SelectJob:SetText(DarkRP.formatMoney(self.createcategoryman.salary[i]))
         self.SelectJob:SetFont("BoldFontSmaller")
         self.SelectJob:SetColor(whiteColor)
		 
		 self.SelectJob.DoClick = function(this)

			if IsValid(JobDesc) then
				JobDesc:Remove()
			end
			this.sahakol = {}
			this.sahakol[1] = this.desc
			this.sahakolInd = 2
			
			for k,v in pairs(this.weapons) do
			if k == 1 then
				this.sahakol[this.sahakolInd] = "\n\nWeapons:\n" .. v 
			else
			this.sahakol[this.sahakolInd] = "\n" .. v 
			end
			this.sahakolInd = this.sahakolInd + 1
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
			ModelChosen:SetPos(self:GetParent():GetWide() * .047,self:GetParent():GetTall() * .01)

			local chosenAnim = table.Random({"pose_standing_02","pose_standing_04"})

			function ModelChosen:LayoutEntity(ent)     

				ent:SetSequence(ent:LookupSequence(chosenAnim))
	   
				ModelChosen:RunAnimation()      

				return 
	   
			   end

			ModelChosen:SetModel( this.model )
			ModelChosen:SetLookAt(Vector(-500,0 , -350))
			ModelChosen:SetCamPos(headpos-Vector(-50,0,0))   
			ModelChosen:SetFOV(45)

			if this.CheckIfTable then
			local ButtonRight = vgui.Create("DButton",JobDesc)
			ButtonRight:SetPos(JobDesc:GetWide() * .8, 5)
			ButtonRight:SetColor(whiteColor)
			ButtonRight:SetText("NEXT")
			ButtonRight:SetFont("MediumFont")
			ButtonRight:SetSize(JobDesc:GetWide() * .2,JobDesc:GetTall() * .05)
			ButtonRight.Paint = function(this,w,h)

				surface.SetDrawColor(F4_Config_Custom.JobButtColor)
				surface.DrawRect(0,0,w,h)

			end
			
			ButtonRight.DoClick = function()

				local modelExploded = string.Explode("/", ModelChosen:GetModel())
				PrintTable(modelExploded)
				if modelExploded[4] then
				if string.StartWith(modelExploded[4], "female") then
					modelExploded[3] = modelExploded[3]:gsub("^%l", string.upper)
					modelExploded[4] = modelExploded[4]:gsub("^%l", string.upper)
				end
			end
				if modelExploded then
				result = table.concat( modelExploded, "/" )
				else
				result =  ModelChosen:GetModel()
				end

				
				if istable(this.modelsList) then
				if this.modelsList[table.KeyFromValue( this.modelsList, result ) + 1] != nil and table.KeyFromValue( this.modelsList, result) - 1 then
				ModelChosen:SetModel(this.modelsList[table.KeyFromValue( this.modelsList, result ) + 1] )
				end
			end

			end


			local ButtonLeft = vgui.Create("DButton",JobDesc)
			ButtonLeft:SetPos(JobDesc:GetWide() * .01, 5)
			ButtonLeft:SetColor(whiteColor)
			ButtonLeft:SetText("PREV")
			ButtonLeft:SetFont("MediumFont")
			ButtonLeft:SetSize(JobDesc:GetWide() * .2,JobDesc:GetTall() * .05)
			ButtonLeft.Paint = function(this,w,h)

				surface.SetDrawColor(F4_Config_Custom.JobButtColor)
				surface.DrawRect(0,0,w,h)

			end
			ButtonLeft.DoClick = function()
				
				local modelExploded = string.Explode("/", ModelChosen:GetModel())
				if modelExploded[4] then
				if string.StartWith(modelExploded[4], "female") then
					modelExploded[3] = modelExploded[3]:gsub("^%l", string.upper)
					modelExploded[4] = modelExploded[4]:gsub("^%l", string.upper)
				end
			end
				local result = table.concat( modelExploded, "/" )
				
				if istable(this.modelsList) then
				if this.modelsList[table.KeyFromValue( this.modelsList, result ) - 1] != nil and table.KeyFromValue( this.modelsList, result) - 1 then
				ModelChosen:SetModel(this.modelsList[table.KeyFromValue( this.modelsList, result ) - 1] )
				end
			end

			end



		end

			local JobChosen = JobDesc:Add("DLabel")
			JobChosen:SetMultiline(true)
			JobChosen:SetText(this.job)
			JobChosen:SetFont("LightFontBigger")
			JobChosen:SetPos(JobDesc:GetWide() / 2 - utf8.len(this.job) * 4.5  ,self:GetParent():GetTall() * .42)
			JobChosen:SetSize(self:GetParent():GetWide() * .5,self:GetParent():GetTall() * .12)
			
			JobChosen:SetColor(whiteColor)

			local DescChosen = JobDesc:Add("DTextEntry")
			
			DescChosen:SetMultiline(true)
			DescChosen:SetFont("LightFont")
			DescChosen:Dock(BOTTOM)
			DescChosen:DockMargin(0,0,0,x * .065)
			DescChosen:SetSize(self:GetParent():GetWide() * .22,self:GetParent():GetTall() * .35)
			DescChosen:SetPos(self:GetParent():GetWide() * .005 ,self:GetParent():GetTall() * .55)
			if #this.sahakol > 1 then
			DescChosen:SetValue(table.concat(this.sahakol, ' '))
			else
				DescChosen:SetValue(this.sahakol[1])
			end

			DescChosen:SetTextColor(whiteColor)
			DescChosen:SetDrawBackground(false)
			DescChosen.AllowInput = function()
			return false
			end
			DescChosen:SetVerticalScrollbarEnabled( true )
			local SubmitButton = JobDesc:Add("DButton")
			SubmitButton:SetFont("MediumFont")
			SubmitButton:SetSize(self:GetParent():GetWide() * .17,self:GetParent():GetTall() * .05)
			SubmitButton:SetPos(self:GetParent():GetWide() * .03 ,self:GetParent():GetTall() * .2 )
			if this.votable then
				SubmitButton:SetText("Create vote")
			else
				SubmitButton:SetText("Choose this job")
			end
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
				
				if LocalPlayer():Team() != this.team then
					net.Start("switchJob")
					net.WriteInt(this.team,5)
					net.WriteBool(this.votable)
					net.WriteInt(this.max,4)
					net.WriteInt(#team.GetPlayers(this.team),5)
					net.WriteString(ModelChosen:GetModel())
					net.SendToServer()
					mainMenu:Remove()
				end
			end
			
		 end

	end


end


end




function JobsPanel:Paint(w,h)
end


vgui.Register("jobs_panel", JobsPanel, "DPanel")