
print("Main loaded")
x,y = ScrW(),ScrH()
local currPanel
whiteColor = color_white

local PANEL = {}

PANEL.UIBackgroundsCached = {}

	
local DiscordPhoto = Material("data/ropler/image/discord.png","noclamp smooth")

local SteamPhoto = Material("data/ropler/image/steam.png","noclamp smooth")

local dashBoardPhoto = Material("data/ropler/image/dashboard.png","noclamp smooth")

local jobsPhoto = Material("data/ropler/image/jobs.png","noclamp smooth")

local entitiesPhoto = Material("data/ropler/image/entities.png","noclamp smooth")

local weaponsPhoto = Material("data/ropler/image/weapons.png","noclamp smooth")

local shipmentsPhoto = Material("data/ropler/image/shipments.png","noclamp smooth")

local ammoPhoto = Material("data/ropler/image/ammo.png","noclamp smooth")

local rulesPhoto = Material("data/ropler/image/rules.png","noclamp smooth")

local AvatarCircle = {};

AccessorFunc(AvatarCircle, "vertices", "Vertices", FORCE_NUMBER) -- so you can call panel:SetVertices and panel:GetRotation
AccessorFunc(AvatarCircle, "rotation", "Rotation", FORCE_NUMBER) -- so you can call panel:SetRotation and panel:GetRotation

function AvatarCircle:Init()
  self.rotation = 20;
  self.vertices = 40;
  self.avatar = vgui.Create("AvatarImage", self);
  self.avatar:SetPaintedManually(true);
end

function AvatarCircle:CalculatePoly(w, h)
  local poly = {};

  local x = w/2;
  local y = h/2;
  local radius = h/2;

  table.insert(poly, { x = x, y = y });

  for i = 0, self.vertices do
    local a = math.rad((i / self.vertices) * -360) + self.rotation;
    table.insert(poly, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius })
  end
  local a = math.rad(0)
  table.insert(poly, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius })
  self.data = poly;
end

function AvatarCircle:PerformLayout()
  self.avatar:SetSize(self:GetWide(), self:GetTall());
  self:CalculatePoly(self:GetWide(), self:GetTall());
end

function AvatarCircle:SetPlayer(ply, size)
  self.avatar:SetPlayer(ply, size);
end

function AvatarCircle:DrawPoly( w, h )
  if (!self.data) then
    self:CalculatePoly(w, h);
  end

  surface.DrawPoly(self.data);
end

function AvatarCircle:Paint(w, h)
  render.ClearStencil();
  render.SetStencilEnable(true);

  render.SetStencilWriteMask(1);
  render.SetStencilTestMask(1);

  render.SetStencilFailOperation(STENCILOPERATION_REPLACE);
  render.SetStencilPassOperation(STENCILOPERATION_ZERO);
  render.SetStencilZFailOperation(STENCILOPERATION_ZERO);
  render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER);
  render.SetStencilReferenceValue(1);

  draw.NoTexture();
  surface.SetDrawColor(color_white);
  self:DrawPoly(w, h);

  render.SetStencilFailOperation(STENCILOPERATION_ZERO);
  render.SetStencilPassOperation(STENCILOPERATION_REPLACE);
  render.SetStencilZFailOperation(STENCILOPERATION_ZERO);
  render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL);
  render.SetStencilReferenceValue(1);

  self.avatar:PaintManual();

  render.SetStencilEnable(false);
  render.ClearStencil();
end
vgui.Register("EnhancedAvatarImage", AvatarCircle);
-----


local mat_white = Material("vgui/white")

function draw.SimpleLinearGradient(x, y, w, h, startColor, endColor, horizontal)
	draw.LinearGradient(x, y, w, h, { {offset = 0, color = startColor}, {offset = 1, color = endColor} }, horizontal)
end


function draw.LinearGradient(x, y, w, h, stops, horizontal)
	if #stops == 0 then
		return
	elseif #stops == 1 then
		surface.SetDrawColor(stops[1].color)
		surface.DrawRect(x, y, w, h)
		return
	end

	table.SortByMember(stops, "offset", true)

	render.SetMaterial(mat_white)
	mesh.Begin(MATERIAL_QUADS, #stops - 1)
	for i = 1, #stops - 1 do
		local offset1 = math.Clamp(stops[i].offset, 0, 1)
		local offset2 = math.Clamp(stops[i + 1].offset, 0, 1)
		if offset1 == offset2 then continue end

		local deltaX1, deltaY1, deltaX2, deltaY2

		local color1 = stops[i].color
		local color2 = stops[i + 1].color

		local r1, g1, b1, a1 = color1.r, color1.g, color1.b, color1.a
		local r2, g2, b2, a2
		local r3, g3, b3, a3 = color2.r, color2.g, color2.b, color2.a
		local r4, g4, b4, a4

		if horizontal then
			r2, g2, b2, a2 = r3, g3, b3, a3
			r4, g4, b4, a4 = r1, g1, b1, a1
			deltaX1 = offset1 * w
			deltaY1 = 0
			deltaX2 = offset2 * w
			deltaY2 = h
		else
			r2, g2, b2, a2 = r1, g1, b1, a1
			r4, g4, b4, a4 = r3, g3, b3, a3
			deltaX1 = 0
			deltaY1 = offset1 * h
			deltaX2 = w
			deltaY2 = offset2 * h
		end

		mesh.Color(r1, g1, b1, a1)
		mesh.Position(Vector(x + deltaX1, y + deltaY1))
		mesh.AdvanceVertex()

		mesh.Color(r2, g2, b2, a2)
		mesh.Position(Vector(x + deltaX2, y + deltaY1))
		mesh.AdvanceVertex()

		mesh.Color(r3, g3, b3, a3)
		mesh.Position(Vector(x + deltaX2, y + deltaY2))
		mesh.AdvanceVertex()

		mesh.Color(r4, g4, b4, a4)
		mesh.Position(Vector(x + deltaX1, y + deltaY2))
		mesh.AdvanceVertex()
	end
	mesh.End()
end



local Button = {}

Button[1] = {
	name = "DASHBOARD",
	color = F4_Config_Custom.JobButtColor,
	photo = dashBoardPhoto,
	enabled = true,
	clicked = false
}
Button[2] = {
	name = "JOBS",
	color = F4_Config_Custom.secondaryColor,
	photo = jobsPhoto,
	enabled = true,
	panelToAppear = "jobs_panel",
	clicked = false
}
Button[3] = {
	name = "ENTITIES",
	color = F4_Config_Custom.secondaryColor,
	photo = entitiesPhoto,
	enabled = true,
	panelToAppear = "entities_panel",
	clicked = false
}
Button[4] = {
	name = "WEAPONS",
	color = F4_Config_Custom.secondaryColor,
	photo = weaponsPhoto,
	enabled = true,
	panelToAppear = "weapons_panel",
	clicked = false
}
Button[5] = {
	name = "SHIPMENTS",
	color = F4_Config_Custom.secondaryColor,
	photo = shipmentsPhoto,
	enabled = true,
	panelToAppear = "shipments_panel",
	clicked = false
}
Button[6] = {
	name = "AMMO",
	color = F4_Config_Custom.secondaryColor,
	photo = ammoPhoto,
	enabled = true,
	clicked = false
}
Button[7] = {
	name = "RULES",
	color = F4_Config_Custom.secondaryColor,
	photo = rulesPhoto,
	enabled = true,
	clicked = false
}


	surface.CreateFont( "BoldFont", {
	font = F4_Config_Custom.BoldFont,
	size = ScreenScale(38) ,
	weight = 700,
	extended = true
    })

	surface.CreateFont( "BoldFontSmaller", {
	font = F4_Config_Custom.BoldFont,
	size = ScreenScale(10),
	weight = 700,
	extended = true
    })

	surface.CreateFont( "LightFont", {
	font = F4_Config_Custom.LightFont,
	size = ScreenScale(10),
	weight = 200,
	extended = true
	})

	surface.CreateFont( "LightFontSmaller", {
		font = F4_Config_Custom.LightFont,
		size = ScreenScale(9),
		weight = 200,
		extended = true
	})


	surface.CreateFont( "LightFontBigger", {
	font = F4_Config_Custom.LightFont,
	size = ScreenScale(14),
	weight = 500,
	extended = true
	})


	surface.CreateFont( "MediumFont", {
	font = F4_Config_Custom.MediumFont,
	size = ScreenScale(12),
	weight = 600,
	extended = true
	})
	surface.CreateFont( "MediumFontSmaller", {
	font = F4_Config_Custom.MediumFont,
	size = ScreenScale(10),
	weight = 600,
	extended = true
	})




function PANEL:Paint(w,h)

	if F4_Config_Custom.ToBlur then
		Derma_DrawBackgroundBlur(self, self.startTime)
	 end

	draw.RoundedBox(0, 0, 0, w, h, F4_Config_Custom.mainColor) -- the color of the panel itself

	draw.RoundedBox(0, w * .0095, h * .235, w * .17, h * .005, F4_Config_Custom.avatarColor)  -- creating a line under player's info(pink)

	draw.RoundedBox(0, w * .002, h * .10999, w * .003, h * .16 , F4_Config_Custom.secondaryColor) -- creating a gray line on the left of the player's info(gray)

	draw.RoundedBox(0, w * .185, h * .10999, w * .003, h * .133 , color_black) -- creating a black line on the right of the player's info(black)

	draw.RoundedBox(0, w * .002, h * .27, w * .186, h * .48 , F4_Config_Custom.tabsBackgroundColor) -- background for the tabs selection(kinda black/gray)

	draw.RoundedBox(0, w * .002, h * .78, w * .19, h * .005, F4_Config_Custom.avatarColor) -- the pink line to close the discord and steam buttons

	draw.RoundedBox(0, w * .185, h * .78, w * .003, h * .22, color_black) -- same, but black 

  draw.SimpleLinearGradient(	w * .20755, h * .132, w * .01, h * .891 ,F4_Config_Custom.tabsBackgroundColor, F4_Config_Custom.BetweenColor, false ) -- gradient line
  if IsValid(currPanel) and (currPanel != "dashboard_panel" or currPanel != "rules_panel") then
		draw.RoundedBox(0, w * .197, h * .108, w * .78, h * .002 , F4_Config_Custom.JobButtColor ) -- line above the cude(red)
		draw.RoundedBox(0, w * .978, h * .10999, w * .008, h * .891 , F4_Config_Custom.secondaryColor) -- drawing a line in the right corner(gray)
	end

	draw.RoundedBox(0, w * .197, h * .10999, w * .55, h * .891 , F4_Config_Custom.tabsBackgroundColor ) -- the behind stuff cube(gray)


end

function PANEL:Init()
  currPanel = nil
	self:SetAlpha(0)
	self:AlphaTo(255,0.2,0)
	self:MakePopup() 
	self.startTime = SysTime()
	self:SetSize(x * .96, y * .96)
	self:SetPos(x * .02, y * .023)
	-- self.MainMenu = vgui.Create("DFrame",self)
	-- self.MainMenu:SetSize(x * .7, y * .7)

	self.CloseButton = vgui.Create("DButton",self)
	self.CloseButton:SetSize(self:GetWide() * .04,self:GetTall() * .05)
	self.CloseButton:SetPos(self:GetWide() * .94, self:GetTall() * .02 )
	self.CloseButton:SetText("✕")
	self.CloseButton:SetFont("LightFont")
	self.CloseButton:SetColor(whiteColor)
	self.CloseButton.DoClick = function(this)
		self:AlphaTo(0, 0.2,  0, function()
			self:Remove()
		end)
		
	end
	self.CloseButton.Paint = function(this,w,h)

		if this:IsHovered() then
			this:SetColor(F4_Config_Custom.JobButtColor)
		else
			this:SetColor(whiteColor)
		end


	end

	self.ServerName = vgui.Create("DLabel", self)
	self.ServerName:SetFont("BoldFont")
	self.ServerName:SetSize(self:GetWide() * .2,self:GetTall() * .1)
	self.ServerName:SetPos(self:GetWide() * .015, self:GetTall() * .001)
	self.ServerName:SetText(GetHostName())
	self.ServerName:SetColor(whiteColor)

	self.AvatarDesign = vgui.Create("DPanel",self)
	self.AvatarDesign.Paint = function(this,w,h)
	    draw.RoundedBox(5, 0, 0,w,h, F4_Config_Custom.avatarColor)


		draw.SimpleTextOutlined(LocalPlayer():Nick(), "MediumFont",  w * .3, h * .2, whiteColor,  TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP,0.5,color_black)
		draw.SimpleTextOutlined(team.GetName(LocalPlayer():Team()), "MediumFont",  w * .3, h * .45, team.GetColor(LocalPlayer():Team()),  TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP,0.5,color_black)
	end
	self.AvatarDesign:SetSize(self:GetWide() * .18, self:GetTall() * .12)
	self.AvatarDesign:SetPos(self:GetWide() * .005, self:GetTall() * .11)




	local AvatarImage = self.AvatarDesign:Add("EnhancedAvatarImage")
	

	AvatarImage:SetSize(self.AvatarDesign:GetWide() * .18, self.AvatarDesign:GetTall() * .48)

	AvatarImage:SetPos(self.AvatarDesign:GetWide() * .08, self.AvatarDesign:GetTall() * .28)
	AvatarImage:SetPlayer(LocalPlayer(), 128)


	local movedown = self:GetTall() * .275

	for k,v in pairs(Button) do
		if v["enabled"] then
		self.ButtonforMain = vgui.Create("DButton",self)
		self.ButtonforMain:SetPos(self:GetWide() * .002,movedown)
		self.ButtonforMain:SetText("")
		self.ButtonforMain.id = k
		self.ButtonforMain:SetSize(self:GetWide() * .181, self:GetTall() * .06)
		self.ButtonforMain.panel = v["panelToAppear"]
		self.ButtonforMain.Paint = function(this,w,h)	
		draw.RoundedBox(3, 0, 0,w,h, v["color"])

		surface.SetMaterial(v["photo"])
		surface.SetDrawColor(whiteColor)
		surface.DrawTexturedRect(w * .03, h * .25, w * .12, h * .6)
		if Button[this.id]["clicked"] then
		draw.SimpleText(v["name"], "LightFontBigger", w * .22, h * .17, F4_Config_Custom.JobButtColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

		draw.SimpleText(">", "LightFontBigger", w * .86, h * .12, F4_Config_Custom.JobButtColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		else

			 draw.SimpleText(v["name"], "LightFontBigger", w * .22, h * .17, whiteColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

		     draw.SimpleText(">", "LightFontBigger", w * .86, h * .12, whiteColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
	    end
	end

		movedown = movedown + self:GetTall() * .068

		self.ButtonforMain.DoClick = function(this)

			if IsValid(self:GetChildren()[14]) then
			self:GetChildren()[14]:Remove()
			end

		if IsValid(currPanel) then 
			currPanel:Remove()
		end
		

		for i = 1, 7 do
			Button[i]["clicked"] = false
		end
		if Button[this.id]["name"] != "DASHBOARD" then
		Button[this.id]["clicked"] = true
		end

		
		currPanel = vgui.Create(this.panel,self)

		end
	end
	end


	self.DiscordButton = vgui.Create("DButton",self)
--	self.DiscordButton.Paint = nil
	self.DiscordButton:SetText("")
	self.DiscordButton:SetSize(self:GetWide() * .15, self:GetTall() * .07)
	self.DiscordButton:SetPos(self:GetWide() * .012, self:GetTall() * .81)
	self.DiscordButton.lerp = 255
	self.DiscordButton.Paint = function(this,w,h)
		surface.SetMaterial(DiscordPhoto)
		surface.SetDrawColor(whiteColor)
		surface.DrawTexturedRect(0,0, w * .3, h)

		if this:IsHovered() then

			this.lerp = Lerp(FrameTime() * 10, this.lerp, 0)	
		else
			this.lerp = Lerp(FrameTime() * 10, this.lerp, 255)
		end
		
		draw.SimpleText("Discord", "LightFontBigger", w * .4,  0, Color(255,this.lerp,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	draw.SimpleText("Join our Dicsord", "LightFont", w * .4,  h * .5, Color(255,this.lerp,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	end

	self.DiscordButton.DoClick = function()
		gui.OpenURL(F4_Config_Custom.DiscordLink)
	end
	self.SteamButton = vgui.Create("DButton",self)
--	self.DiscordButton.Paint = nil
	self.SteamButton:SetText("")
	self.SteamButton:SetSize(self:GetWide() * .15	, self:GetTall() * .065)
	self.SteamButton:SetPos(self:GetWide() * .012, self:GetTall() * .9)
	self.SteamButton.lerp = 255
	
	self.SteamButton.Paint = function(this,w,h)
		surface.SetMaterial(SteamPhoto)
		surface.SetDrawColor(whiteColor)
		surface.DrawTexturedRect(0,0, w * .29, h)

		if this:IsHovered() then

			this.lerp = Lerp(FrameTime() * 10, this.lerp, 0)	
		else
			this.lerp = Lerp(FrameTime() * 10, this.lerp, 255)
		end

		draw.SimpleText("Steam Group", "LightFontBigger", w * .4,  0, Color(255,this.lerp,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		draw.SimpleText("Join our group", "LightFont", w * .4,  h * .5, Color(255,this.lerp,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	self.SteamButton.DoClick = function()
		gui.OpenURL(F4_Config_Custom.SteamLink)
	end

end


hook.Add("OnScreenSizeChanged","Opa",function()
	x, y = ScrW(), ScrH()
end)





function openMenu()

	if IsValid(mainMenu) then
		mainMenu:Remove()
	end
	
    mainMenu = vgui.Create("main_menu")
    
end

function PANEL:OnRemove()
		for i = 1, 7 do
			Button[i]["clicked"] = false
		end

end

function PANEL:OnKeyCodePressed(button)

	if button == 95 then
		mainMenu:Remove()
	end

end

vgui.Register("main_menu", PANEL, "DPanel")

