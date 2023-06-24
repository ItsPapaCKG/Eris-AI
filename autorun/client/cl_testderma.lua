print("cl_testderma ran successfully!")

surface.CreateFont("unitFont", {
	font = "Roboto",
	size = 20,
	weight = 0,

})
	local scrollMax = false
	local scrollMin = false
local char = {name = "CCA:UNION-i4.011"}

local creditsTable = {
	balance = 20,
	numRecords = 4,
	penalty = {
		{
			amount = -4,
			sender = "MPF-RCT.28968",
			type = "Stupidity",
			key = 2,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = -2,
			sender = "MPF-RCT.28968",
			type = "Flirting with the CA",
			key = 4,
			date = "16/02/2021 - 14:43"
		}
	},
	rewards = {
		{
			amount = 2,
			sender = "MPF-RCT.28968",
			type = "Cohesion",
			key = 1,
			date = "16/02/2021 - 14:41"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Can Pickup",
			key = 3,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Stuff",
			key = 6,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Can Pickup",
			key = 5,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Stuff",
			key = 7,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Stuff",
			key = 8,
			date = "16/02/2021 - 14:42"
		},
		{
			amount = 4,
			sender = "MPF-RCT.28968",
			type = "Stuff",
			key = 9,
			date = "16/02/2021 - 14:42"
		}
	}
}

local trainingTable = {}
trainingTable[1] = {type = "P", done = 1}
trainingTable[2] = {type = "S", done = 0}
trainingTable[3] = {type = "M", done = 0}
trainingTable[4] = {type = "E", done = 0}
trainingTable[5] = {type = "C", done = 0}



function UnitDataAnim.OpenMenu()
	local frameColor = Color(0, 0, 0, 250)
	local buttonColor = Color(255, 255, 255)

	local trimColor = Color(0,0,80)
	local primaryColor = Color(10,10,10)
	local lightPrimary = Color(25,25,25,255)
	local logsTable = {}
	for k, v in pairs(creditsTable) do
		if (type(v) == "table") then
			for subtable, i in pairs(v) do	
				logsTable[i.key] = i
			end 
		end
	end
	

	PrintTable(logsTable)

	input.SetCursorPos(0,0)
	
	local scrw, scrh = ScrW(), ScrH()
	if (IsValid(UnitDataAnim.Menu)) then
		UnitDataAnim.Menu:Remove()
	end
	local frameW, frameH, animTime, animDelay, animEase = scrw * .5, scrh * .5, 1, 0, .1
	UnitDataAnim.Menu = vgui.Create("DFrame")
	UnitDataAnim.Menu:SetTitle("")
	UnitDataAnim.Menu:MakePopup(true)
	UnitDataAnim.Menu:SetSize(0, 0)
	local isAnimating = true
	local isPanelOpen = false
	UnitDataAnim.Menu:SetPos(-scrw, -scrh)
	UnitDataAnim.Menu:SizeTo(frameW, frameH, animTime, animDelay, animEase, function() 
		isAnimating = false
		isPanelOpen = true
	end)

	UnitDataAnim.Menu.Paint = function(me,w,h)
		surface.SetDrawColor(frameColor)
		surface.DrawRect(0,0,w,h)
	end
	UnitDataAnim.Menu:ShowCloseButton(false)
	local topBar = UnitDataAnim.Menu:Add("DPanel")
	topBar.Paint = function(me,w,h)
		surface.SetDrawColor(trimColor)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(Color(0, 0, 0, 255))
		surface.DrawRect(0,0,w,h-5)
	end	

	local closeColor = Color(255,255,255)
	local closeButton = topBar:Add("DButton")
	closeButton:SetText("")
	closeButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(190, 0, 0, 0))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("LOGOUT", "unitFont", w * .5, h * .5, closeColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	
	closeButton.Think = function(me)
		if (closeButton:IsHovered()) then
			closeColor = Color(255,255,255,100)
		else
			closeColor = Color(255,255,255,255)
		end
	end

	function closeButton:DoClick()
		isAnimating = true
		UnitDataAnim.Menu:SizeTo(0, 0, .5, animDelay, animEase, function() 
			isAnimating = false
			UnitDataAnim.Menu:Remove()
		end)
	end

	local leftParent = UnitDataAnim.Menu:Add("DPanel")
	
	leftParent.Paint = function(me,w,h)
		surface.SetDrawColor(Color(100,0,0,0))
		surface.DrawRect(0,0,w,h)
	end
	leftParent:DockMargin(0,0,0,0)
	leftParent:SetPos(0,20)

	local modelPanel = leftParent:Add("DAdjustableModelPanel")
	modelPanel:SetSize(100, 100)
	modelPanel:SetModel("models/dpfilms/metropolice/hdpolice.mdl")
	modelPanel:SetCamPos( Vector(48,2.2,61) )
	modelPanel:SetLookAng( Angle(10,-180,0) )
	modelPanel:SetPos(0,0)
	function modelPanel:LayoutEntity( Entity ) return end

	local unitReport = leftParent:Add("DPanel")
	unitReport.Paint = function(me,w,h)
		surface.SetDrawColor(trimColor)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(lightPrimary)
		surface.DrawRect(0,h*.025,w,h)
	end
	unitReport.Think = function(me,w,h)
		local mX, mY = modelPanel:GetWide(), modelPanel:GetTall()
		unitReport:SetPos(0, mY + 10)

	end

	local unitInfo = unitReport:Add("DLabel")
	unitInfo:SetFont("unitFont")
	unitInfo.Paint = function(me,w,h)
		surface.SetDrawColor(Color(0,0,0,0))
		surface.DrawRect(0,0,w,h)
	end
	unitInfo.Think = function(me)
		unitInfo:SetSize(unitReport:GetWide(), unitReport:GetTall()/3)
		unitInfo:SetPos(unitReport:GetWide()*0.05, unitReport:GetTall()*0.05)
		unitInfo:SetText(char.name.."\n"..creditsTable.balance.." credits\n".."Last Updated: \n"..logsTable[#logsTable].date)
	end

	local centerParent = UnitDataAnim.Menu:Add("DPanel")
	centerParent.Paint = function(me,w,h)
		surface.SetDrawColor(Color(255,255,255,0))
		surface.DrawRect(0,0,w,h)
	end
	local X, Y = centerParent:GetPos()

	local scrollInt = 0
	local listLogs = centerParent:Add("DIconLayout")
	listLogs.Paint = function(me,w,h)
		surface.SetDrawColor(0,100,0,0)
		surface.DrawRect(0,0,w,h)
	end
	listLogs:SetSpaceY(10)
	listLogs:SetSize(centerParent:GetWide(), centerParent:GetTall())
	listLogs:SetStretchHeight(false)

	listLogs:SetMouseInputEnabled(true)
	listLogs["hasLoaded"] = false
	listLogs.Think = function(me,w,h)

	end
	listLogs.OnMouseWheeled = function(me,d)
			if (me:IsHovered()) then
				if (scrollMax == false and d < 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMax == true and d > 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMin == false and d > 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMin == true and d < 0) then
					scrollInt = scrollInt-d*15
				end
			end
	end

	local rightParent = UnitDataAnim.Menu:Add("DPanel")
	rightParent.Paint = function(me,w,h)
		surface.SetDrawColor(Color(100,0,0,0))
		surface.DrawRect(0,0,w,h)
	end

	local buttonsPanel = rightParent:Add("DPanel")
	buttonsPanel.Paint = function(me,w,h)
		surface.SetDrawColor(lightPrimary)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(trimColor)
		surface.DrawRect(0,0,8,h)
	end	

	local buttonList = buttonsPanel:Add("DIconLayout")
	buttonList.Paint = function(me,w,h)
		surface.SetDrawColor(100,0,0,0)
		surface.DrawRect(0,0,w,h)
	end	
	buttonList:SetSpaceY(5)
	local viewHover = color_white
	local pingHover = color_white
	local reportHover = color_white
	local assignHover = color_white
	local awardsHover = color_white

	local viewButton = buttonList:Add("DButton")
	viewButton:SetText("")
	viewButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(0,0,180))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("ViewData", "unitFont", w * .5, h * .5, viewHover, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	viewButton.OwnLine = true
	viewButton.Think = function(me)
		if (viewButton:IsHovered()) then
			viewHover = Color(255,255,255,100)
		else
			viewHover = Color(255,255,255,255)
		end
	end

	local pingButton = buttonList:Add("DButton")
	pingButton:SetText("")
	pingButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(0,0,120))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("Ping Location", "unitFont", w * .5, h * .5, pingHover, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	pingButton.OwnLine = true
	pingButton.Think = function(me)
		if (pingButton:IsHovered()) then
			pingHover = Color(255,255,255,100)
		else
			pingHover = Color(255,255,255,255)
		end
	end

	local reportButton = buttonList:Add("DButton")
	reportButton:SetText("")
	reportButton.OwnLine = true
	reportButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(0,0,200))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("File a Report", "unitFont", w * .5, h * .5, reportHover, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	reportButton.Think = function(me)
		if (reportButton:IsHovered()) then
			reportHover = Color(255,255,255,100)
		else
			reportHover = Color(255,255,255,255)
		end
	end

	local assignButton = buttonList:Add("DButton")
	assignButton:SetText("")
	assignButton.OwnLine = true
	assignButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(0,40,80))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("View Assignments", "unitFont", w * .5, h * .5, assignHover, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	assignButton.Think = function(me)
		if (assignButton:IsHovered()) then
			assignHover = Color(255,255,255,100)
		else
			assignHover = Color(255,255,255,255)
		end
	end

	local awardsButton = buttonList:Add("DButton")
	awardsButton:SetText("")
	awardsButton.OwnLine = true
	awardsButton.Paint = function(me,w,h)
		surface.SetDrawColor(Color(255,191,0))
		surface.DrawRect(0,0,w,h)
		draw.SimpleText("Awards", "unitFont", w * .5, h * .5, awardsHover, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	awardsButton.Think = function(me)
		if (awardsButton:IsHovered()) then
			awardsHover = Color(0,0,0,100)
		else
			awardsHover = Color(0,0,0,255)
		end
	end

	local trainingPanel = rightParent:Add("DPanel")
	trainingPanel.Paint = function(me,w,h)
		surface.SetDrawColor(trimColor)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(lightPrimary)
		surface.DrawRect(0,h*.025,w,h)
	end
	trainingPanel["hasLoaded"] = false

	local trainingList = trainingPanel:Add("DIconLayout")
	trainingList.Paint = function(me,w,h)
--		surface.SetDrawColor(trimColor)
--		surface.DrawRect(0,0,w,h)
	end
	trainingList:SetSpaceX(3)
	trainingList.Think = function(me,w,h)
		trainingList:SetSize(trainingPanel:GetWide()*.9, trainingPanel:GetTall()*.9)
		trainingList:SetPos(trainingPanel:GetWide()*.05, (trainingPanel:GetTall() - trainingList:GetTall() )/ 2)
	end	

	for k, v in pairs(trainingTable) do
		local Entry = trainingList:Add("DPanel")
		Entry.Paint = function(me,w,h)
			local trainColor


			if (v.done == 1) then
				surface.SetDrawColor(Color(35,35,35))
				surface.DrawRect(0,0,w,h)
				surface.SetDrawColor(0, 255, 0)
				surface.DrawRect(0,0,w,h*.05)

				trainColor = color_white
			else
				surface.SetDrawColor(Color(35,35,35,100))
				surface.DrawRect(0,0,w,h)
				surface.SetDrawColor(255, 0, 0)
				surface.DrawRect(0,0,w,h*.05)

				trainColor = Color(255,255,255,100)
			end

			draw.SimpleText(v.type, "unitFont", w * .5, h * .5, trainColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		Entry.Think = function(me)
			me:SetSize(trainingList:GetWide()/5 - 2, trainingPanel:GetTall()*.8)
		end

	end

	UnitDataAnim.Menu.OnSizeChanged = function(me,w,h)
		if (isAnimating) then
			me:Center()
			centerParent:SetPos(unitReport:GetWide() + 10, Y + scrh/2)
			rightParent:SetPos(unitReport:GetWide() + 10 + centerParent:GetWide() + 10, h*0.05 + 10)
			leftParent:SetPos(0, h*0.05 + 5)
			buttonList:SetPos(buttonsPanel:GetWide()*.05, (buttonsPanel:GetTall() - buttonList:GetTall() )/2)
			trainingPanel:SetPos(0, rightParent:GetTall()/2-10 + scrh/2)
			trainingList:SetPos(trainingPanel:GetWide()*.05, (trainingPanel:GetTall() - trainingList:GetTall() )/2)
			topBar:SetPos(0,0)
			
		end
		
		local closeW = h * .15
		local closeH = h * .05		

		closeButton:SetTall(closeH)
		closeButton:SetWide(closeW)

		closeButton:SetPos(w - closeW, 0)
		leftParent:SetSize(UnitDataAnim.Menu:GetWide()/3.5, UnitDataAnim.Menu:GetTall()-10)
		centerParent:SetSize(UnitDataAnim.Menu:GetWide()/3.3 + 20,UnitDataAnim.Menu:GetTall()-10)

		modelPanel:SetSize(centerParent:GetWide(), centerParent:GetTall()/2)
		unitReport:SetSize(leftParent:GetWide(), leftParent:GetTall() - modelPanel:GetTall())
		listLogs:SetSize(centerParent:GetWide(), centerParent:GetTall())

		rightParent:SetSize(UnitDataAnim.Menu:GetWide() - (leftParent:GetWide() + centerParent:GetWide()) - 20, UnitDataAnim.Menu:GetTall() )
		trainingPanel:SetSize(rightParent:GetWide(), rightParent:GetTall()/2)
		buttonsPanel:SetSize(rightParent:GetWide(), rightParent:GetTall()/2 - 20)
		topBar:SetSize(w, h*0.05 + 5)
		buttonList:SetSize(rightParent:GetWide()*.9, buttonsPanel:GetTall() - buttonsPanel:GetTall()*0.2)
		viewButton:SetSize(buttonList:GetWide(), buttonsPanel:GetTall()/6)
		pingButton:SetSize(buttonList:GetWide(), buttonsPanel:GetTall()/6)
		reportButton:SetSize(buttonList:GetWide(), buttonsPanel:GetTall()/6)
		assignButton:SetSize(buttonList:GetWide(), buttonsPanel:GetTall()/6)
		awardsButton:SetSize(buttonList:GetWide(), buttonsPanel:GetTall()/6)
	end

	local nextX, nextY = 0, 0

	local listW, listH = listLogs:GetWide(), listLogs:GetTall()/5

	for k, v in pairs(logsTable) do
		local ListItem = listLogs:Add("DPanel")
		ListItem:SetPos(0, scrh)
		ListItem.Paint = function(self,w,h)
			surface.SetDrawColor(lightPrimary)
			surface.DrawRect(0,0,w,h)
			if (v.amount > 0) then
				surface.SetDrawColor(0,255,0)
				surface.DrawRect(0,0,w*.025,h)
			else
				surface.SetDrawColor(255,0,0)
				surface.DrawRect(0,0,w*.025,h)	
			end
		end
		ListItem["animated"] = false
		ListItem["localScale"] = 1

		ListItem.OwnLine = true
		ListItem:SetMouseInputEnabled(true)

		ListItem.OnMouseWheeled = function(me, d)
			local logX, logY = me:GetPos()
			scrollMax = tobool(logY >= (k-1)*(me:GetTall()) + (k-1)*10)
			scrollMin = tobool(logY + me:GetTall() <= listLogs:GetTall() + (k-#logsTable)*(me:GetTall()+20) - 100)		

			if (me:IsHovered()) then
				local logX, logY = me:GetPos()
				if (scrollMax == false and d < 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMax == true and d > 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMin == false and d > 0) then
					scrollInt = scrollInt-d*15
				elseif (scrollMin == true and d < 0) then
					scrollInt = scrollInt-d*15
				end

			-- tobool(logY >= (k-1)*(me:GetTall()+10))
			-- tobool(logY + me:GetTall() <= listLogs:GetTall() + (k-#logsTable)*(me:GetTall()+10))
			end
		end
		ListItem.Think = function(me,w,h)
			me:SetSize(listLogs:GetWide(), listLogs:GetTall()/5)

			local logX, logY = me:GetPos()
			local newY = logY + scrollInt

				ListItem:SetPos(logX, newY)
				listLogs:Layout()

		end

		local richText = ListItem:Add("DLabel")
		richText:SetFont("unitFont")
		richText:SetColor(Color(255,255,255))

		richText.Think = function(me,w,h)
			local lW, lH = ListItem:GetWide(), ListItem:GetTall()
			local X, Y = ListItem:GetPos()
			me:SetPos(lW*.05, 0)
			me:SetSize(lW, lH)
			me:SetText(v.amount.." Credits\n"..v.type.."\n"..v.sender.."\nDate Issued: "..v.date)
		end
		
	end
	

	UnitDataAnim.Menu.Think = function(me,w,h)
		
		if (!isAnimating) then
			--camInfo:SetText(tostring(modelPanel:GetCamPos())..", \n"..tostring(modelPanel:GetLookAng()))

		end

		if (!isAnimating and !listLogs.hasLoaded) then
			local posX, posY = centerParent:GetPos()
			centerParent:MoveTo(unitReport:GetWide() + 10, posY - scrh/2 + me:GetTall()*0.05 + 10, 0.5, 0, .2)
			listLogs.hasLoaded = true
		end

		if (!isAnimating and !trainingPanel.hasLoaded) then
			local posX, posY = trainingPanel:GetPos()
			trainingPanel:MoveTo(0, posY - scrh/2, 0.7, 0, .25)
			trainingPanel.hasLoaded = true
		end
	
	end

end


local testVal = 0
hook.Add("InputMouseApply", "testMouseWheel", function(cmd, x, y, ang)
    testVal = testVal + cmd:GetMouseWheel() * 2 --any scale number you want to use
    print(testVal)
end)

concommand.Add("unitderma", UnitDataAnim.OpenMenu)