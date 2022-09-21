-- Open the Dev Console (F9) to read information about the GUI --

print("\nSuper Power Training Simulator LuckyGui Created by LuckyMMB @ V3rmillion.net\nDiscord https://discord.gg/GKzJnUC\nLast updated 5th December 2018")
print("\nThe Y Key activates Panic Mode and teleports you to the Safe Zone. This can be changed to another key.")
print("\nUse the OnDeath Return button to respawn you and return to your previous position\nwhen you are killed. Great for farming BT in zones as soon as you\ncan take 1 hit and survive (eg. 6Bil in 100Bil+ BT Taining Area).")
print("\nOnce your Fist, Body and Psychic stats are higher you will not be able to Auto\nFarm more than one skill at a time as you need to be near the\nlocation you are farming at.")

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local root = char.HumanoidRootPart
local Plrs = game:GetService("Players")
local MyPlr = Plrs.LocalPlayer
local MyChar = MyPlr.Character
local UIS = game:GetService'UserInputService'
local RepStor = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Run = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local human = plr.Character:WaitForChild("Humanoid")

-- Anti Idle --
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

showstartmessage = true
showtopplayersactive = false
showtopplayersfistactive = false
showtopplayersbodyactive = false
showtopplayersspeedactive = false
showtopplayersjumpactive = false
showtopplayerspsychicactive = false
farmbtsafetyactive = false
farmbtsafety2active = false
settplocation = false
playerdied = false
deathreturnactive = false
godmodeactive = false
noclip = false
resetplayerstat = false
killplayeractive = false
farmallactive = false
farmfistactive = false
farmbodyactive = false
farmspeedactive = false
farmjumpactive = false
farmpsychicactive = false
punchmodeactive = false
ESPEnabled = false
ESPLength = 20000

CharAddedEvent = { }

Plrs.PlayerAdded:connect(function(plr)
	if CharAddedEvent[plr.Name] == nil then
		CharAddedEvent[plr.Name] = plr.CharacterAdded:connect(function(char)
			if ESPEnabled then
				RemoveESP(plr)
				CreateESP(plr)
			end
		end)
	end
end)

Plrs.PlayerRemoving:connect(function(plr)
	if CharAddedEvent[plr.Name] ~= nil then
		CharAddedEvent[plr.Name]:Disconnect()
		CharAddedEvent[plr.Name] = nil
	end
	RemoveESP(plr)
end)

function CreateESP(plr)
	if plr ~= nil then
		local GetChar = plr.Character
		if not GetChar then return end
		local GetHead do
			repeat wait() until GetChar:FindFirstChild("Head")
		end
		GetHead = GetChar.Head
		
		local bb = Instance.new("BillboardGui", CoreGui)
		bb.Adornee = GetHead
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP_" .. plr.Name
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = plr.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextColor3 = Color3.new(0, 0, 0)
		TxtName.TextSize = 14
		TxtName.TextStrokeTransparency = 0.5
		
		local TxtDist = Instance.new("TextLabel", frame)
		TxtDist.Name = "Dist"
		TxtDist.ZIndex = 10
		TxtDist.Text = ""
		TxtDist.BackgroundTransparency = 1
		TxtDist.Position = UDim2.new(0, 0, 0, -35)
		TxtDist.Size = UDim2.new(1, 0, 10, 0)
		TxtDist.Font = "SourceSansBold"
		TxtDist.TextColor3 = Color3.new(0, 0, 0)
		TxtDist.TextSize = 15
		TxtDist.TextStrokeTransparency = 0.5

		local TxtHealth = Instance.new("TextLabel", frame)
		TxtHealth.Name = "Health"
		TxtHealth.ZIndex = 10
		TxtHealth.Text = ""
		TxtHealth.BackgroundTransparency = 1
		TxtHealth.Position = UDim2.new(0, 0, 0, -25)
		TxtHealth.Size = UDim2.new(1, 0, 10, 0)
		TxtHealth.Font = "SourceSansBold"
		TxtHealth.TextColor3 = Color3.new(0, 0, 0)
		TxtHealth.TextSize = 15
		TxtHealth.TextStrokeTransparency = 0.5

		local TxtFist = Instance.new("TextLabel", frame)
		TxtFist.Name = "Fist"
		TxtFist.ZIndex = 10
		TxtFist.Text = ""
		TxtFist.BackgroundTransparency = 1
		TxtFist.Position = UDim2.new(0, 0, 0, -15)
		TxtFist.Size = UDim2.new(1, 0, 10, 0)
		TxtFist.Font = "SourceSansBold"
		TxtFist.TextColor3 = Color3.new(0, 0, 0)
		TxtFist.TextSize = 15
		TxtFist.TextStrokeTransparency = 0.5

		local TxtPsychic = Instance.new("TextLabel", frame)
		TxtPsychic.Name = "Psychic"
		TxtPsychic.ZIndex = 10
		TxtPsychic.Text = ""
		TxtPsychic.BackgroundTransparency = 1
		TxtPsychic.Position = UDim2.new(0, 0, 0, -5)
		TxtPsychic.Size = UDim2.new(1, 0, 10, 0)
		TxtPsychic.Font = "SourceSansBold"
		TxtPsychic.TextColor3 = Color3.new(0, 0, 0)
		TxtPsychic.TextSize = 15
		TxtPsychic.TextStrokeTransparency = 0.5
	end
end

function UpdateESP(plr)
	local Find = CoreGui:FindFirstChild("ESP_" .. plr.Name)
	if Find then
		local plrStatus = game.Players[plr.Name].leaderstats.Status
		if plrStatus.Value == "Criminal" then
			Find.Frame.Names.TextColor3 = Color3.new(1, 0.1, 1)
		elseif plrStatus.Value == "Lawbreaker" then
			Find.Frame.Names.TextColor3 = Color3.new(1, 0.1, 0.1)
		elseif plrStatus.Value == "Guardian" then
			Find.Frame.Names.TextColor3 = Color3.new(0.1, 0.8, 1)
		elseif plrStatus.Value == "Protector" then
			Find.Frame.Names.TextColor3 = Color3.new(0.1, 0.1, 1)
		elseif plrStatus.Value == "Supervillain" then
			Find.Frame.Names.TextColor3 = Color3.new(0.3, 0.1, 0.1)
		elseif plrStatus.Value == "Superhero" then
			Find.Frame.Names.TextColor3 = Color3.new(0.8, 0.8, 0)
		else
			Find.Frame.Names.TextColor3 = Color3.new(1, 1, 1)
		end
		Find.Frame.Dist.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Health.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Fist.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Psychic.TextColor3 = Color3.new(1, 1, 1)
		local GetChar = plr.Character
		if MyChar and GetChar then
			local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
			local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
			local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
			if Find2 and Find3 then
				local pos = Find3.Position
				local Dist = (Find2.Position - pos).magnitude
				if Dist > ESPLength then
					Find.Frame.Names.Visible = false
					Find.Frame.Dist.Visible = false
					Find.Frame.Health.Visible = false
					Find.Frame.Fist.Visible = false
					Find.Frame.Psychic.Visible = false
					return
				else
					Find.Frame.Names.Visible = true
					Find.Frame.Dist.Visible = true
					Find.Frame.Health.Visible = true
					Find.Frame.Fist.Visible = true
					Find.Frame.Psychic.Visible = true
				end
				Find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", Dist)
				--Find.Frame.Pos.Text = "(X: " .. string.format("%.0f", pos.X) .. ", Y: " .. string.format("%.0f", pos.Y) .. ", Z: " .. string.format("%.0f", pos.Z) .. ")"
				if Find4 then
					Find.Frame.Health.Text = "Health: " ..converttoletter(string.format("%.0f", Find4.Health))
					Find.Frame.Fist.Text = "Fist: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PrivateStats.FistStrength.Value))
					Find.Frame.Psychic.Text = "Psychic: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PrivateStats.PsychicPower.Value))
				else
					Find.Frame.Health.Text = ""
					Find.Frame.Fist.Text = ""
					Find.Frame.Psychic.Text = ""
				end
			end
		end
	end
end

function RemoveESP(plr)
	local ESP = CoreGui:FindFirstChild("ESP_" .. plr.Name)
	if ESP then
		ESP:Destroy()
	end
end

local MainGUI = Instance.new("ScreenGui")
local TopFrame = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local Open = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local cf = Instance.new("Frame")
local c1 = Instance.new("TextLabel")
local c = Instance.new("TextButton")
local DeathReturn = Instance.new("TextButton")
local PunchMode = Instance.new("TextButton")
local WayPoints = Instance.new("TextButton")
local WayPointsFrame = Instance.new("Frame")
local FarmExp = Instance.new("TextButton")
local FarmExpFrame = Instance.new("Frame")
local ShowLocation = Instance.new("TextLabel")
local SetLocation = Instance.new("TextButton")
local TPLocation = Instance.new("TextButton")
local Location1 = Instance.new("TextButton")
local Location2 = Instance.new("TextButton")
local LocationFS1B = Instance.new("TextButton")
local LocationFS100B = Instance.new("TextButton")
local LocationFS10T = Instance.new("TextButton")
local Location3 = Instance.new("TextButton")
local Location4 = Instance.new("TextButton")
local Location5 = Instance.new("TextButton")
local Location6 = Instance.new("TextButton")
local Location7 = Instance.new("TextButton")
local Location8 = Instance.new("TextButton")
local Location9 = Instance.new("TextButton")
local Location10 = Instance.new("TextButton")
local LocationBT1B = Instance.new("TextButton")
local LocationBT100B = Instance.new("TextButton")
local LocationBT10T = Instance.new("TextButton")
local LocationPP1M = Instance.new("TextButton")
local LocationPP1B = Instance.new("TextButton")
local LocationPP1T = Instance.new("TextButton")
local LocationPP1Qa = Instance.new("TextButton")
local LocationBody1B = Instance.new("TextButton")
local FarmAll = Instance.new("TextButton")
local FarmFist = Instance.new("TextButton")
local FarmBody = Instance.new("TextButton")
local FarmSpeed = Instance.new("TextButton")
local FarmJump = Instance.new("TextButton")
local SavePosition = Instance.new("TextLabel")
local FarmPsychic = Instance.new("TextButton")
local FarmBodyLabel = Instance.new("TextLabel")
local FarmSpeedLabel = Instance.new("TextLabel")
local esptrack = Instance.new("TextButton")
local ESPLength = Instance.new("TextBox")
local Extras = Instance.new("TextButton")
local ExtrasFrame = Instance.new("Frame")
local PlayerInfo = Instance.new("TextButton")
local PlayerInfoFrame = Instance.new("Frame")
local ShowTopPlayers = Instance.new("TextButton")
local ShowBetterFS = Instance.new("TextButton")
local ShowBetterBT = Instance.new("TextButton")
local ShowBetterPP = Instance.new("TextButton")
local ShowWorseFS = Instance.new("TextButton")
local ShowWorseBT = Instance.new("TextButton")
local ShowWorsePP = Instance.new("TextButton")
local PlayerInfoStatsFrame = Instance.new("Frame")
local PlayerInfoStatsClose = Instance.new("TextButton")
local StatBestFistText1 = Instance.new("TextLabel")
local StatBestBodyText1 = Instance.new("TextLabel")
local StatBestSpeedText1 = Instance.new("TextLabel")
local StatBestJumpText1 = Instance.new("TextLabel")
local StatBestPsychicText1 = Instance.new("TextLabel")
local PlayerInfoStatsText1 = Instance.new("TextLabel")
local ShowStatsFist1 = Instance.new("TextLabel")
local ShowStatsBody1 = Instance.new("TextLabel")
local ShowStatsSpeed1 = Instance.new("TextLabel")
local ShowStatsJump1 = Instance.new("TextLabel")
local ShowStatsPsychic1 = Instance.new("TextLabel")
local ShowStatsFist2 = Instance.new("TextLabel")
local ShowStatsBody2 = Instance.new("TextLabel")
local ShowStatsSpeed2 = Instance.new("TextLabel")
local ShowStatsJump2 = Instance.new("TextLabel")
local ShowStatsPsychic2 = Instance.new("TextLabel")
local AnnoyNameLabel = Instance.new("TextLabel")
local AnnoyName = Instance.new("TextBox")
local AnnoyStart = Instance.new("TextButton")
local KillPlayerStart = Instance.new("TextButton")
local TptoPlayer = Instance.new("TextButton")
local PanicToggleLabel = Instance.new("TextLabel")
local farmbtsafety = Instance.new("TextButton")
local farmbtsafetyText1 = Instance.new("TextLabel")
local farmbtsafetylevel = Instance.new("TextBox")
local farmbtsafety2 = Instance.new("TextButton")
local farmbtsafetylabel = Instance.new("TextLabel")
local PanicToggle = Instance.new("TextBox")
local ReJoinServer = Instance.new("TextButton")
local InfoScreen = Instance.new("TextButton")
local InfoFrame = Instance.new("Frame")
local InfoText1 = Instance.new("TextLabel")
local PlayerName = Instance.new("TextBox")
local StatsFrame = Instance.new("Frame")
local ShowStats1 = Instance.new("TextLabel")
local ShowStats2 = Instance.new("TextLabel")
local StatNameSet = Instance.new("TextButton")
local NoClip = Instance.new("TextButton")
local GodMode = Instance.new("TextButton")

-- Properties

MainGUI.Name = "MainGUI"
MainGUI.Parent = game.CoreGui
MainGUI.ResetOnSpawn = false
local MainCORE = game.CoreGui["MainGUI"]

TopFrame.Name = "TopFrame"
TopFrame.Parent = MainGUI
TopFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TopFrame.BorderColor3 = Color3.new(0, 0, 0)
TopFrame.BackgroundTransparency = 1
TopFrame.Position = UDim2.new(0.5, -30, 0, -27)
TopFrame.Size = UDim2.new(0, 80, 0, 20)
TopFrame.Visible = false

cf.Name = "cf"
cf.Parent = MainGUI
cf.BackgroundColor3 = Color3.new(0, 0, 0)
cf.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
cf.BackgroundTransparency = 0
cf.Position = UDim2.new(0.5, -195, 0.5, -110)
cf.Size = UDim2.new(0, 390, 0, 220)
cf.Visible = true

c1.Name = "c1"
c1.Parent = cf
c1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
c1.BackgroundTransparency = 1
c1.Position = UDim2.new(0, 10, 0, 13)
c1.Size = UDim2.new(0, 370, 0, 160)
c1.Font = Enum.Font.Fantasy
c1.TextColor3 = Color3.new(1, 1, 1)
c1.Text = "SUPER POWERS TRAINING SIMULATOR GUI\nmade by LuckyMMB#8645 (discord)\n\nPress F9 to read more information about the GUI\n\nThis GUI is free, if you paid for it you were scammed\nand should report it.\n\nNo unauthorized use of this GUI without written\npermission from the creator."
c1.TextSize = 17

c.Name = "c"
c.Parent = cf
c.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
c.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
c.Position = UDim2.new(0.5, -30, 0, 190)
c.Size = UDim2.new(0, 60, 0, 20)
c.Font = Enum.Font.Fantasy
c.Text = "CLOSE"
c.TextColor3 = Color3.new(1, 0, 0)
c.TextSize = 17
c.TextWrapped = true

Open.Name = "Open"
Open.Parent = TopFrame
Open.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Open.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Open.Size = UDim2.new(0, 60, 0, 20)
Open.Font = Enum.Font.Fantasy
Open.Text = "Open"
Open.TextColor3 = Color3.new(1, 1, 1)
Open.TextSize = 18
Open.Selectable = true
Open.TextWrapped = true

MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGUI
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -382.5, 0, -32)
MainFrame.Size = UDim2.new(0, 765, 0, 30)
if not cf.Visible then MainGUI:Destroy() else MainFrame.Visible = true end

Close.Name = "Close"
Close.Parent = MainFrame
Close.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Close.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Close.Position = UDim2.new(0, 10, 0, 5)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Font = Enum.Font.Fantasy
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 0, 0)
Close.TextSize = 17
Close.TextScaled = true
Close.TextWrapped = true

Minimize.Name = "Minimize"
Minimize.Parent = MainFrame
Minimize.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Minimize.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Minimize.Position = UDim2.new(0, 35, 0, 5)
Minimize.Size = UDim2.new(0, 20, 0, 20)
Minimize.Font = Enum.Font.Fantasy
Minimize.Text = "-"
Minimize.TextColor3 = Color3.new(1, 0, 1)
Minimize.TextSize = 17
Minimize.TextScaled = true
Minimize.TextWrapped = true

WayPoints.Name = "WayPoints"
WayPoints.Parent = MainFrame
WayPoints.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
WayPoints.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
WayPoints.Position = UDim2.new(0, 60, 0, 5)
WayPoints.Size = UDim2.new(0, 65, 0, 20)
WayPoints.Font = Enum.Font.Fantasy
WayPoints.TextColor3 = Color3.new(1, 1, 1)
WayPoints.Text = "Teleport"
WayPoints.TextSize = 17
WayPoints.TextWrapped = true

WayPointsFrame.Name = "WayPointsFrame"
WayPointsFrame.Parent = MainFrame
WayPointsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
WayPointsFrame.BorderColor3 = Color3.new(0, 0, 0)
WayPointsFrame.BackgroundTransparency = 0.2
WayPointsFrame.Position = UDim2.new(0, 1, 0, 33)
WayPointsFrame.Size = UDim2.new(0, 375, 0, 480)
WayPointsFrame.Visible = false

FarmExp.Name = "FarmExp"
FarmExp.Parent = MainFrame
FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmExp.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmExp.Position = UDim2.new(0, 130, 0, 5)
FarmExp.Size = UDim2.new(0, 75, 0, 20)
FarmExp.Font = Enum.Font.Fantasy
FarmExp.TextColor3 = Color3.new(1, 1, 1)
FarmExp.Text = "Farm Exp"
FarmExp.TextSize = 17
FarmExp.TextWrapped = true

FarmExpFrame.Name = "FarmExpFrame"
FarmExpFrame.Parent = MainFrame
FarmExpFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmExpFrame.BorderColor3 = Color3.new(0, 0, 0)
FarmExpFrame.BackgroundTransparency = 0.2
FarmExpFrame.Position = UDim2.new(0, 62.5, 0, 33)
FarmExpFrame.Size = UDim2.new(0, 210, 0, 165)
FarmExpFrame.Visible = false

ShowLocation.Name = "ShowLocation"
ShowLocation.Parent = WayPointsFrame
ShowLocation.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowLocation.TextColor3 = Color3.new(1, 1, 1)
ShowLocation.BorderColor3 = Color3.new(0, 0, 0)
ShowLocation.Position = UDim2.new(0, 5, 0, 5)
ShowLocation.Size = UDim2.new(0, 170, 0, 20)
ShowLocation.Font = Enum.Font.Fantasy
ShowLocation.Text = "Current Location"
ShowLocation.TextWrapped = true
ShowLocation.TextSize = 15

SetLocation.Name = "SetLocation"
SetLocation.Parent = WayPointsFrame
SetLocation.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
SetLocation.TextColor3 = Color3.new(1, 1, 1)
SetLocation.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
SetLocation.Position = UDim2.new(0, 180, 0, 5)
SetLocation.Size = UDim2.new(0, 120, 0, 20)
SetLocation.Font = Enum.Font.Fantasy
SetLocation.Text = "Set Location"
SetLocation.TextWrapped = true
SetLocation.TextSize = 16

TPLocation.Name = "TPLocation"
TPLocation.Parent = WayPointsFrame
TPLocation.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TPLocation.TextColor3 = Color3.new(1, 1, 1)
TPLocation.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
TPLocation.Position = UDim2.new(0, 305, 0, 5)
TPLocation.Size = UDim2.new(0, 65, 0, 20)
TPLocation.Font = Enum.Font.Fantasy
TPLocation.Text = "Tp to"
TPLocation.TextWrapped = true
TPLocation.TextSize = 16

Location1.Name = "Location1"
Location1.Parent = WayPointsFrame
Location1.BackgroundColor3 = Color3.new(255/255, 94/255, 40/255)
Location1.TextColor3 = Color3.new(1, 1, 1)
Location1.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location1.Position = UDim2.new(0, 5, 0, 30)
Location1.Size = UDim2.new(0, 365, 0, 20)
Location1.Font = Enum.Font.Fantasy
Location1.Text = "Teleport to Safe Zone"
Location1.TextWrapped = true
Location1.TextSize = 16

Location2.Name = "Location2"
Location2.Parent = WayPointsFrame
Location2.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
Location2.TextColor3 = Color3.new(1, 1, 1)
Location2.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location2.Position = UDim2.new(0, 5, 0, 55)
Location2.Size = UDim2.new(0, 365, 0, 20)
Location2.Font = Enum.Font.Fantasy
Location2.Text = "Teleport to Rock [10x Fist Strength]"
Location2.TextWrapped = true
Location2.TextSize = 16

Location7.Name = "Location7"
Location7.Parent = WayPointsFrame
Location7.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
Location7.TextColor3 = Color3.new(1, 1, 1)
Location7.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location7.Position = UDim2.new(0, 5, 0, 80)
Location7.Size = UDim2.new(0, 365, 0, 20)
Location7.Font = Enum.Font.Fantasy
Location7.Text = "Teleport to Crystal [100x Fist Strength]"
Location7.TextWrapped = true
Location7.TextSize = 16

LocationFS1B.Name = "LocationFS1B"
LocationFS1B.Parent = WayPointsFrame
LocationFS1B.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
LocationFS1B.TextColor3 = Color3.new(1, 1, 1)
LocationFS1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationFS1B.Position = UDim2.new(0, 5, 0, 105)
LocationFS1B.Size = UDim2.new(0, 365, 0, 20)
LocationFS1B.Font = Enum.Font.Fantasy
LocationFS1B.Text = "Teleport to Blue Star [2k x FS]: 1B+ FS required"
LocationFS1B.TextWrapped = true
LocationFS1B.TextSize = 16

LocationFS100B.Name = "LocationFS100B"
LocationFS100B.Parent = WayPointsFrame
LocationFS100B.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
LocationFS100B.TextColor3 = Color3.new(1, 1, 1)
LocationFS100B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationFS100B.Position = UDim2.new(0, 5, 0, 130)
LocationFS100B.Size = UDim2.new(0, 365, 0, 20)
LocationFS100B.Font = Enum.Font.Fantasy
LocationFS100B.Text = "Teleport to Green Star [40k x FS]: 100B+ FS required"
LocationFS100B.TextWrapped = true
LocationFS100B.TextSize = 16

LocationFS10T.Name = "LocationFS10T"
LocationFS10T.Parent = WayPointsFrame
LocationFS10T.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
LocationFS10T.TextColor3 = Color3.new(1, 1, 1)
LocationFS10T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationFS10T.Position = UDim2.new(0, 5, 0, 155)
LocationFS10T.Size = UDim2.new(0, 365, 0, 20)
LocationFS10T.Font = Enum.Font.Fantasy
LocationFS10T.Text = "Teleport to Orange Star [800k x FS]: 10T+ FS required"
LocationFS10T.TextWrapped = true
LocationFS10T.TextSize = 16

Location3.Name = "Location3"
Location3.Parent = WayPointsFrame
Location3.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
Location3.TextColor3 = Color3.new(1, 1, 1)
Location3.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location3.Position = UDim2.new(0, 5, 0, 180)
Location3.Size = UDim2.new(0, 365, 0, 20)
Location3.Font = Enum.Font.Fantasy
Location3.Text = "Tp to City Port Training 1 [5x BT]: 100+ BT required"
Location3.TextWrapped = true
Location3.TextSize = 16

Location4.Name = "Location4"
Location4.Parent = WayPointsFrame
Location4.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
Location4.TextColor3 = Color3.new(1, 1, 1)
Location4.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location4.Position = UDim2.new(0, 5, 0, 205)
Location4.Size = UDim2.new(0, 365, 0, 20)
Location4.Font = Enum.Font.Fantasy
Location4.Text = "Tp to City Port Training 2 [10x BT]: 10k+ BT required"
Location4.TextWrapped = true
Location4.TextSize = 16

Location5.Name = "Location5"
Location5.Parent = WayPointsFrame
Location5.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
Location5.TextColor3 = Color3.new(1, 1, 1)
Location5.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location5.Position = UDim2.new(0, 5, 0, 230)
Location5.Size = UDim2.new(0, 365, 0, 20)
Location5.Font = Enum.Font.Fantasy
Location5.Text = "Tp to Ice Mountain [20x BT]: 100k+ BT required"
Location5.TextWrapped = true
Location5.TextSize = 16

Location6.Name = "Location6"
Location6.Parent = WayPointsFrame
Location6.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
Location6.TextColor3 = Color3.new(1, 1, 1)
Location6.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location6.Position = UDim2.new(0, 5, 0, 255)
Location6.Size = UDim2.new(0, 365, 0, 20)
Location6.Font = Enum.Font.Fantasy
Location6.Text = "Tp to Tornado [50x BT]: 1M+ BT required"
Location6.TextWrapped = true
Location6.TextSize = 16

Location8.Name = "Location8"
Location8.Parent = WayPointsFrame
Location8.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
Location8.TextColor3 = Color3.new(1, 1, 1)
Location8.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Location8.Position = UDim2.new(0, 5, 0, 280)
Location8.Size = UDim2.new(0, 365, 0, 20)
Location8.Font = Enum.Font.Fantasy
Location8.Text = "Tp to Volcano [100x BT]: 10M+ BT required"
Location8.TextWrapped = true
Location8.TextSize = 16

LocationBT1B.Name = "LocationBT1B"
LocationBT1B.Parent = WayPointsFrame
LocationBT1B.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
LocationBT1B.TextColor3 = Color3.new(1, 1, 1)
LocationBT1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationBT1B.Position = UDim2.new(0, 5, 0, 305)
LocationBT1B.Size = UDim2.new(0, 365, 0, 20)
LocationBT1B.Font = Enum.Font.Fantasy
LocationBT1B.Text = "Tp to [2k x BT] Area: 1B+ BT required"
LocationBT1B.TextWrapped = true
LocationBT1B.TextSize = 16

LocationBT100B.Name = "LocationBT100B"
LocationBT100B.Parent = WayPointsFrame
LocationBT100B.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
LocationBT100B.TextColor3 = Color3.new(1, 1, 1)
LocationBT100B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationBT100B.Position = UDim2.new(0, 5, 0, 330)
LocationBT100B.Size = UDim2.new(0, 365, 0, 20)
LocationBT100B.Font = Enum.Font.Fantasy
LocationBT100B.Text = "Tp to [40k x BT] Area: 100B+ BT required"
LocationBT100B.TextWrapped = true
LocationBT100B.TextSize = 16

LocationBT10T.Name = "LocationBT10T"
LocationBT10T.Parent = WayPointsFrame
LocationBT10T.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
LocationBT10T.TextColor3 = Color3.new(1, 1, 1)
LocationBT10T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationBT10T.Position = UDim2.new(0, 5, 0, 355)
LocationBT10T.Size = UDim2.new(0, 365, 0, 20)
LocationBT10T.Font = Enum.Font.Fantasy
LocationBT10T.Text = "Tp to [800k x BT] Area: 10T+ BT required"
LocationBT10T.TextWrapped = true
LocationBT10T.TextSize = 16

LocationPP1M.Name = "LocationPP1M"
LocationPP1M.Parent = WayPointsFrame
LocationPP1M.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
LocationPP1M.TextColor3 = Color3.new(1, 1, 1)
LocationPP1M.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationPP1M.Position = UDim2.new(0, 5, 0, 380)
LocationPP1M.Size = UDim2.new(0, 365, 0, 20)
LocationPP1M.Font = Enum.Font.Fantasy
LocationPP1M.Text = "Tp to Psychic Island [100x PP]: 1M+ PP required"
LocationPP1M.TextWrapped = true
LocationPP1M.TextSize = 16

LocationPP1B.Name = "LocationPP1B"
LocationPP1B.Parent = WayPointsFrame
LocationPP1B.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
LocationPP1B.TextColor3 = Color3.new(1, 1, 1)
LocationPP1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationPP1B.Position = UDim2.new(0, 5, 0, 405)
LocationPP1B.Size = UDim2.new(0, 365, 0, 20)
LocationPP1B.Font = Enum.Font.Fantasy
LocationPP1B.Text = "Tp to Psychic Island [10k x PP]: 1B+ PP required"
LocationPP1B.TextWrapped = true
LocationPP1B.TextSize = 16

LocationPP1T.Name = "LocationPP1T"
LocationPP1T.Parent = WayPointsFrame
LocationPP1T.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
LocationPP1T.TextColor3 = Color3.new(1, 1, 1)
LocationPP1T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationPP1T.Position = UDim2.new(0, 5, 0, 430)
LocationPP1T.Size = UDim2.new(0, 365, 0, 20)
LocationPP1T.Font = Enum.Font.Fantasy
LocationPP1T.Text = "Tp to Psychic Island [1M x PP]: 1T+ PP required"
LocationPP1T.TextWrapped = true
LocationPP1T.TextSize = 16

LocationPP1Qa.Name = "LocationPP1Qa"
LocationPP1Qa.Parent = WayPointsFrame
LocationPP1Qa.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
LocationPP1Qa.TextColor3 = Color3.new(1, 1, 1)
LocationPP1Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
LocationPP1Qa.Position = UDim2.new(0, 5, 0, 455)
LocationPP1Qa.Size = UDim2.new(0, 365, 0, 20)
LocationPP1Qa.Font = Enum.Font.Fantasy
LocationPP1Qa.Text = "Tp to Psychic Island [100M x PP]: 1Qa+ PP required"
LocationPP1Qa.TextWrapped = true
LocationPP1Qa.TextSize = 16

FarmAll.Name = "FarmAll"
FarmAll.Parent = FarmExpFrame
FarmAll.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmAll.TextColor3 = Color3.new(1, 1, 1)
FarmAll.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmAll.Position = UDim2.new(0, 5, 0, 5)
FarmAll.Size = UDim2.new(0, 200, 0, 20)
FarmAll.Font = Enum.Font.Fantasy
FarmAll.Text = "Farm All: OFF"
FarmAll.TextWrapped = true
FarmAll.TextSize = 16

FarmFist.Name = "FarmFist"
FarmFist.Parent = FarmExpFrame
FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmFist.TextColor3 = Color3.new(1, 1, 1)
FarmFist.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmFist.Position = UDim2.new(0, 5, 0, 40)
FarmFist.Size = UDim2.new(0, 200, 0, 20)
FarmFist.Font = Enum.Font.Fantasy
FarmFist.Text = "Farm Fist Strength: OFF"
FarmFist.TextWrapped = true
FarmFist.TextSize = 16

FarmBody.Name = "FarmBody"
FarmBody.Parent = FarmExpFrame
FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmBody.TextColor3 = Color3.new(1, 1, 1)
FarmBody.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmBody.Position = UDim2.new(0, 5, 0, 65)
FarmBody.Size = UDim2.new(0, 200, 0, 20)
FarmBody.Font = Enum.Font.Fantasy
FarmBody.Text = "Farm Body Toughness: OFF"
FarmBody.TextWrapped = true
FarmBody.TextSize = 16

FarmSpeed.Name = "FarmSpeed"
FarmSpeed.Parent = FarmExpFrame
FarmSpeed.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmSpeed.TextColor3 = Color3.new(1, 1, 1)
FarmSpeed.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmSpeed.Position = UDim2.new(0, 5, 0, 90)
FarmSpeed.Size = UDim2.new(0, 200, 0, 20)
FarmSpeed.Font = Enum.Font.Fantasy
FarmSpeed.Text = "Farm Movement Speed: OFF"
FarmSpeed.TextWrapped = true
FarmSpeed.TextSize = 16

FarmJump.Name = "FarmJump"
FarmJump.Parent = FarmExpFrame
FarmJump.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmJump.TextColor3 = Color3.new(1, 1, 1)
FarmJump.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmJump.Position = UDim2.new(0, 5, 0, 115)
FarmJump.Size = UDim2.new(0, 200, 0, 20)
FarmJump.Font = Enum.Font.Fantasy
FarmJump.Text = "Farm Jump Force: OFF"
FarmJump.TextWrapped = true
FarmJump.TextSize = 16

FarmPsychic.Name = "FarmPsychic"
FarmPsychic.Parent = FarmExpFrame
FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmPsychic.TextColor3 = Color3.new(1, 1, 1)
FarmPsychic.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmPsychic.Position = UDim2.new(0, 5, 0, 140)
FarmPsychic.Size = UDim2.new(0, 200, 0, 20)
FarmPsychic.Font = Enum.Font.Fantasy
FarmPsychic.Text = "Farm Psychic Power: OFF"
FarmPsychic.TextWrapped = true
FarmPsychic.TextSize = 16

FarmBodyLabel.Name = "FarmBodyLabel"
FarmBodyLabel.Parent = FarmExpFrame
FarmBodyLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmBodyLabel.TextColor3 = Color3.new(1, 1, 1)
FarmBodyLabel.BorderColor3 = Color3.new(0.1, 0.1, 0.1)
FarmBodyLabel.Position = UDim2.new(0, 213, 0, 65)
FarmBodyLabel.Size = UDim2.new(0, 200, 0, 100)
FarmBodyLabel.Font = Enum.Font.Fantasy
FarmBodyLabel.Text = "Look at teleports and go to the best place you can go for your Body Toughness. You need 10Mil to go in the volcano but you need at least 50Mil before you can afk in there."
FarmBodyLabel.TextSize = 16
FarmBodyLabel.TextWrapped = true
FarmBodyLabel.Visible = false

FarmSpeedLabel.Name = "FarmSpeedLabel"
FarmSpeedLabel.Parent = FarmExpFrame
FarmSpeedLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmSpeedLabel.TextColor3 = Color3.new(1, 1, 1)
FarmSpeedLabel.BorderColor3 = Color3.new(0.1, 0.1, 0.1)
FarmSpeedLabel.Position = UDim2.new(0, 213, 0, 65)
FarmSpeedLabel.Size = UDim2.new(0, 200, 0, 100)
FarmSpeedLabel.Font = Enum.Font.Fantasy
FarmSpeedLabel.Text = "Press 4 and equip the 100TON weight to get the maximum boost. If you still want to move around select the heaviest weight you can move around with but you wont get as much."
FarmSpeedLabel.TextSize = 16
FarmSpeedLabel.TextWrapped = true
FarmSpeedLabel.Visible = false

DeathReturn.Name = "DeathReturn"
DeathReturn.Parent = MainFrame
DeathReturn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
DeathReturn.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
DeathReturn.Position = UDim2.new(0, 210, 0, 5)
DeathReturn.Size = UDim2.new(0, 160, 0, 20)
DeathReturn.Font = Enum.Font.Fantasy
DeathReturn.TextColor3 = Color3.new(1, 1, 1)
DeathReturn.Text = "OnDeath Return: OFF"
DeathReturn.TextSize = 17
DeathReturn.TextWrapped = true

esptrack.Name = "esptrack"
esptrack.Parent = MainFrame
esptrack.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
esptrack.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
esptrack.Position = UDim2.new(0, 375, 0, 5)
esptrack.Size = UDim2.new(0, 35, 0, 20)
esptrack.TextColor3 = Color3.new(1, 1, 1)
esptrack.Font = Enum.Font.Fantasy
esptrack.Text = "ESP"
esptrack.TextSize = 16
esptrack.TextWrapped = true

PlayerInfo.Name = "PlayerInfo"
PlayerInfo.Parent = MainFrame
PlayerInfo.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfo.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PlayerInfo.Position = UDim2.new(0, 415, 0, 5)
PlayerInfo.Size = UDim2.new(0, 85, 0, 20)
PlayerInfo.TextColor3 = Color3.new(1, 1, 1)
PlayerInfo.Font = Enum.Font.Fantasy
PlayerInfo.Text = "Top Players"
PlayerInfo.TextSize = 16
PlayerInfo.TextWrapped = true

PlayerInfoFrame.Name = "PlayerInfoFrame"
PlayerInfoFrame.Parent = MainFrame
PlayerInfoFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfoFrame.BorderColor3 = Color3.new(0, 0, 0)
PlayerInfoFrame.BackgroundTransparency = 0.2
PlayerInfoFrame.Position = UDim2.new(0, 377.5, 0, 33)
PlayerInfoFrame.Size = UDim2.new(0, 160, 0, 225)
PlayerInfoFrame.Visible = false

ShowTopPlayers.Name = "ShowTopPlayers"
ShowTopPlayers.Parent = PlayerInfoFrame
ShowTopPlayers.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowTopPlayers.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
ShowTopPlayers.Position = UDim2.new(0, 5, 0, 5)
ShowTopPlayers.Size = UDim2.new(0, 150, 0, 20)
ShowTopPlayers.TextColor3 = Color3.new(1, 1, 1)
ShowTopPlayers.Font = Enum.Font.Fantasy
ShowTopPlayers.Text = "Top Players in Server"
ShowTopPlayers.TextSize = 16
ShowTopPlayers.TextWrapped = true

PlayerInfoStatsFrame.Name = "PlayerInfoStatsFrame"
PlayerInfoStatsFrame.Parent = MainGUI
PlayerInfoStatsFrame.BackgroundColor3 = Color3.new(0, 0, 0)
PlayerInfoStatsFrame.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerInfoStatsFrame.BackgroundTransparency = 0
PlayerInfoStatsFrame.Position = UDim2.new(0.5, -427.5, 1, -120)
PlayerInfoStatsFrame.Size = UDim2.new(0, 855, 0, 115)
PlayerInfoStatsFrame.Active = true
PlayerInfoStatsFrame.Selectable = true
PlayerInfoStatsFrame.Draggable = true
PlayerInfoStatsFrame.ZIndex = 8
PlayerInfoStatsFrame.Visible = false

PlayerInfoStatsClose.Name = "PlayerInfoStatsClose"
PlayerInfoStatsClose.Parent = PlayerInfoStatsFrame
PlayerInfoStatsClose.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfoStatsClose.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PlayerInfoStatsClose.Position = UDim2.new(0, 5, 0, 5)
PlayerInfoStatsClose.Size = UDim2.new(0, 20, 0, 20)
PlayerInfoStatsClose.Font = Enum.Font.Fantasy
PlayerInfoStatsClose.Text = "X"
PlayerInfoStatsClose.TextColor3 = Color3.new(1, 0, 0)
PlayerInfoStatsClose.TextSize = 17
PlayerInfoStatsClose.ZIndex = 8
PlayerInfoStatsClose.TextScaled = true
PlayerInfoStatsClose.TextWrapped = true

StatBestFistText1.Name = "StatBestFistText1"
StatBestFistText1.Parent = PlayerInfoStatsFrame
StatBestFistText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestFistText1.BackgroundTransparency = 1
StatBestFistText1.Position = UDim2.new(0, 30, 0, 2)
StatBestFistText1.Size = UDim2.new(0, 160, 0, 20)
StatBestFistText1.TextColor3 = Color3.new(1, 1, 1)
StatBestFistText1.Font = Enum.Font.Fantasy
StatBestFistText1.Text = "Top Fist Player"
StatBestFistText1.ZIndex = 8
StatBestFistText1.TextSize = 13

ShowStatsFist1.Name = "ShowStatsFist1"
ShowStatsFist1.Parent = PlayerInfoStatsFrame
ShowStatsFist1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsFist1.BackgroundTransparency = 1
ShowStatsFist1.Position = UDim2.new(0, 30, 0, 22)
ShowStatsFist1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsFist1.Font = Enum.Font.Fantasy
ShowStatsFist1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsFist1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsFist1.TextSize = 14
ShowStatsFist1.ZIndex = 8
ShowStatsFist1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsFist2.Name = "ShowStatsFist2"
ShowStatsFist2.Parent = PlayerInfoStatsFrame
ShowStatsFist2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsFist2.BackgroundTransparency = 1
ShowStatsFist2.Position = UDim2.new(0, 85, 0, 22)
ShowStatsFist2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsFist2.Font = Enum.Font.Fantasy
ShowStatsFist2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsFist2.Text = "Stats"
ShowStatsFist2.TextSize = 14
ShowStatsFist2.ZIndex = 8
ShowStatsFist2.TextXAlignment = Enum.TextXAlignment.Right

StatBestBodyText1.Name = "StatBestBodyText1"
StatBestBodyText1.Parent = PlayerInfoStatsFrame
StatBestBodyText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestBodyText1.BackgroundTransparency = 1
StatBestBodyText1.Position = UDim2.new(0, 195, 0, 2)
StatBestBodyText1.Size = UDim2.new(0, 160, 0, 20)
StatBestBodyText1.TextColor3 = Color3.new(1, 1, 1)
StatBestBodyText1.Font = Enum.Font.Fantasy
StatBestBodyText1.Text = "Top Body Player"
StatBestBodyText1.ZIndex = 8
StatBestBodyText1.TextSize = 13

ShowStatsBody1.Name = "ShowStatsBody1"
ShowStatsBody1.Parent = PlayerInfoStatsFrame
ShowStatsBody1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsBody1.BackgroundTransparency = 1
ShowStatsBody1.Position = UDim2.new(0, 195, 0, 22)
ShowStatsBody1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsBody1.Font = Enum.Font.Fantasy
ShowStatsBody1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsBody1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsBody1.TextSize = 14
ShowStatsBody1.ZIndex = 8
ShowStatsBody1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsBody2.Name = "ShowStatsBody2"
ShowStatsBody2.Parent = PlayerInfoStatsFrame
ShowStatsBody2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsBody2.BackgroundTransparency = 1
ShowStatsBody2.Position = UDim2.new(0, 250, 0, 22)
ShowStatsBody2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsBody2.Font = Enum.Font.Fantasy
ShowStatsBody2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsBody2.Text = "Stats"
ShowStatsBody2.TextSize = 14
ShowStatsBody2.ZIndex = 8
ShowStatsBody2.TextXAlignment = Enum.TextXAlignment.Right

StatBestSpeedText1.Name = "StatBestSpeedText1"
StatBestSpeedText1.Parent = PlayerInfoStatsFrame
StatBestSpeedText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestSpeedText1.BackgroundTransparency = 1
StatBestSpeedText1.Position = UDim2.new(0, 360, 0, 2)
StatBestSpeedText1.Size = UDim2.new(0, 160, 0, 20)
StatBestSpeedText1.TextColor3 = Color3.new(1, 1, 1)
StatBestSpeedText1.Font = Enum.Font.Fantasy
StatBestSpeedText1.Text = "Top Speed Player"
StatBestSpeedText1.ZIndex = 8
StatBestSpeedText1.TextSize = 13

ShowStatsSpeed1.Name = "ShowStatsSpeed1"
ShowStatsSpeed1.Parent = PlayerInfoStatsFrame
ShowStatsSpeed1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsSpeed1.BackgroundTransparency = 1
ShowStatsSpeed1.Position = UDim2.new(0, 360, 0, 22)
ShowStatsSpeed1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsSpeed1.Font = Enum.Font.Fantasy
ShowStatsSpeed1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsSpeed1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsSpeed1.TextSize = 14
ShowStatsSpeed1.ZIndex = 8
ShowStatsSpeed1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsSpeed2.Name = "ShowStatsSpeed2"
ShowStatsSpeed2.Parent = PlayerInfoStatsFrame
ShowStatsSpeed2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsSpeed2.BackgroundTransparency = 1
ShowStatsSpeed2.Position = UDim2.new(0, 415, 0, 22)
ShowStatsSpeed2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsSpeed2.Font = Enum.Font.Fantasy
ShowStatsSpeed2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsSpeed2.Text = "Stats"
ShowStatsSpeed2.TextSize = 14
ShowStatsSpeed2.ZIndex = 8
ShowStatsSpeed2.TextXAlignment = Enum.TextXAlignment.Right

StatBestJumpText1.Name = "StatBestJumpText1"
StatBestJumpText1.Parent = PlayerInfoStatsFrame
StatBestJumpText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestJumpText1.BackgroundTransparency = 1
StatBestJumpText1.Position = UDim2.new(0, 525, 0, 2)
StatBestJumpText1.Size = UDim2.new(0, 160, 0, 20)
StatBestJumpText1.TextColor3 = Color3.new(1, 1, 1)
StatBestJumpText1.Font = Enum.Font.Fantasy
StatBestJumpText1.Text = "Top Jump Player"
StatBestJumpText1.ZIndex = 8
StatBestJumpText1.TextSize = 13

ShowStatsJump1.Name = "ShowStatsJump1"
ShowStatsJump1.Parent = PlayerInfoStatsFrame
ShowStatsJump1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsJump1.BackgroundTransparency = 1
ShowStatsJump1.Position = UDim2.new(0, 525, 0, 22)
ShowStatsJump1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsJump1.Font = Enum.Font.Fantasy
ShowStatsJump1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsJump1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsJump1.TextSize = 14
ShowStatsJump1.ZIndex = 8
ShowStatsJump1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsJump2.Name = "ShowStatsJump2"
ShowStatsJump2.Parent = PlayerInfoStatsFrame
ShowStatsJump2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsJump2.BackgroundTransparency = 1
ShowStatsJump2.Position = UDim2.new(0, 580, 0, 22)
ShowStatsJump2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsJump2.Font = Enum.Font.Fantasy
ShowStatsJump2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsJump2.Text = "Stats"
ShowStatsJump2.TextSize = 14
ShowStatsJump2.ZIndex = 8
ShowStatsJump2.TextXAlignment = Enum.TextXAlignment.Right

StatBestPsychicText1.Name = "StatBestPsychicText1"
StatBestPsychicText1.Parent = PlayerInfoStatsFrame
StatBestPsychicText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestPsychicText1.BackgroundTransparency = 1
StatBestPsychicText1.Position = UDim2.new(0, 690, 0, 2)
StatBestPsychicText1.Size = UDim2.new(0, 160, 0, 20)
StatBestPsychicText1.TextColor3 = Color3.new(1, 1, 1)
StatBestPsychicText1.Font = Enum.Font.Fantasy
StatBestPsychicText1.Text = "Top Psychic Player"
StatBestPsychicText1.ZIndex = 8
StatBestPsychicText1.TextSize = 13

ShowStatsPsychic1.Name = "ShowStatsPsychic1"
ShowStatsPsychic1.Parent = PlayerInfoStatsFrame
ShowStatsPsychic1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsPsychic1.BackgroundTransparency = 1
ShowStatsPsychic1.Position = UDim2.new(0, 690, 0, 22)
ShowStatsPsychic1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsPsychic1.Font = Enum.Font.Fantasy
ShowStatsPsychic1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsPsychic1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsPsychic1.TextSize = 14
ShowStatsPsychic1.ZIndex = 8
ShowStatsPsychic1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsPsychic2.Name = "ShowStatsPsychic2"
ShowStatsPsychic2.Parent = PlayerInfoStatsFrame
ShowStatsPsychic2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsPsychic2.BackgroundTransparency = 1
ShowStatsPsychic2.Position = UDim2.new(0, 745, 0, 22)
ShowStatsPsychic2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsPsychic2.Font = Enum.Font.Fantasy
ShowStatsPsychic2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsPsychic2.Text = "Stats"
ShowStatsPsychic2.TextSize = 14
ShowStatsPsychic2.ZIndex = 8
ShowStatsPsychic2.TextXAlignment = Enum.TextXAlignment.Right

Extras.Name = "Extras"
Extras.Parent = MainFrame
Extras.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Extras.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Extras.Position = UDim2.new(0, 505, 0, 5)
Extras.Size = UDim2.new(0, 50, 0, 20)
Extras.TextColor3 = Color3.new(1, 1, 1)
Extras.Font = Enum.Font.Fantasy
Extras.Text = "Extras"
Extras.TextSize = 16
Extras.TextWrapped = true

ExtrasFrame.Name = "ExtrasFrame"
ExtrasFrame.Parent = MainFrame
ExtrasFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ExtrasFrame.BorderColor3 = Color3.new(0, 0, 0)
ExtrasFrame.BackgroundTransparency = 0.2
ExtrasFrame.Position = UDim2.new(0, 435, 0, 33)
ExtrasFrame.Size = UDim2.new(0, 160, 0, 213)
ExtrasFrame.Visible = false

AnnoyName.Name = "AnnoyName"
AnnoyName.Parent = ExtrasFrame
AnnoyName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
AnnoyName.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
AnnoyName.Position = UDim2.new(0, 5, 0, 5)
AnnoyName.Size = UDim2.new(0, 150, 0, 20)
AnnoyName.TextColor3 = Color3.new(1, 1, 1)
AnnoyName.Font = Enum.Font.Fantasy
AnnoyName.Text = tostring(MyPlr.Name)
AnnoyName.TextSize = 14
AnnoyName.TextScaled = false
AnnoyName.TextWrapped = true

TptoPlayer.Name = "TptoPlayer"
TptoPlayer.Parent = ExtrasFrame
TptoPlayer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TptoPlayer.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
TptoPlayer.Position = UDim2.new(0, 5, 0, 26)
TptoPlayer.Size = UDim2.new(0, 150, 0, 20)
TptoPlayer.TextColor3 = Color3.new(1, 1, 1)
TptoPlayer.Font = Enum.Font.Fantasy
TptoPlayer.Text = "TP to Player"
TptoPlayer.TextSize = 16
TptoPlayer.TextWrapped = true

AnnoyStart.Name = "AnnoyStart"
AnnoyStart.Parent = ExtrasFrame
AnnoyStart.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AnnoyStart.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
AnnoyStart.Position = UDim2.new(0, 5, 0, 47)
AnnoyStart.Size = UDim2.new(0, 150, 0, 20)
AnnoyStart.TextColor3 = Color3.new(1, 1, 1)
AnnoyStart.Font = Enum.Font.Fantasy
AnnoyStart.Text = "TP Spam Player: OFF"
AnnoyStart.TextSize = 16
AnnoyStart.TextWrapped = true

PanicToggleLabel.Name = "PanicToggleLabel"
PanicToggleLabel.Parent = ExtrasFrame
PanicToggleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PanicToggleLabel.BorderSizePixel = 0
PanicToggleLabel.Position = UDim2.new(0, 5, 0, 77)
PanicToggleLabel.Size = UDim2.new(0, 125, 0, 20)
PanicToggleLabel.TextColor3 = Color3.new(1, 1, 1)
PanicToggleLabel.Font = Enum.Font.Fantasy
PanicToggleLabel.Text = "Panic KeyBind"
PanicToggleLabel.TextSize = 16
PanicToggleLabel.TextWrapped = true

PanicToggle.Name = "PanicToggle"
PanicToggle.Parent = ExtrasFrame
PanicToggle.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
PanicToggle.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
PanicToggle.Position = UDim2.new(0, 130, 0, 78)
PanicToggle.Size = UDim2.new(0, 25, 0, 18)
PanicToggle.TextColor3 = Color3.new(1, 1, 1)
PanicToggle.Font = Enum.Font.Fantasy
PanicToggle.Text = "y"
PanicToggle.TextSize = 16
PanicToggle.TextWrapped = true

NoClip.Name = "NoClip"
NoClip.Parent = ExtrasFrame
NoClip.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
NoClip.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
NoClip.Position = UDim2.new(0, 5, 0, 107)
NoClip.Size = UDim2.new(0, 150, 0, 20)
NoClip.Font = Enum.Font.Fantasy
NoClip.TextColor3 = Color3.new(1, 1, 1)
NoClip.Text = "NoClip Mode: OFF"
NoClip.TextSize = 16
NoClip.TextWrapped = true

farmbtsafetylabel.Name = "farmbtsafetylabel"
farmbtsafetylabel.Parent = ExtrasFrame
farmbtsafetylabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
farmbtsafetylabel.BorderSizePixel = 0
farmbtsafetylabel.Position = UDim2.new(0, 5, 0, 137)
farmbtsafetylabel.Size = UDim2.new(0, 120, 0, 20)
farmbtsafetylabel.TextColor3 = Color3.new(1, 1, 1)
farmbtsafetylabel.Font = Enum.Font.Fantasy
farmbtsafetylabel.Text = "Health [percent]"
farmbtsafetylabel.TextSize = 16
farmbtsafetylabel.TextWrapped = true

farmbtsafetylevel.Name = "farmbtsafetylevel"
farmbtsafetylevel.Parent = ExtrasFrame
farmbtsafetylevel.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
farmbtsafetylevel.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
farmbtsafetylevel.Position = UDim2.new(0, 125, 0, 138)
farmbtsafetylevel.Size = UDim2.new(0, 30, 0, 19)
farmbtsafetylevel.TextColor3 = Color3.new(1, 1, 1)
farmbtsafetylevel.Font = Enum.Font.Fantasy
farmbtsafetylevel.Text = "50"
farmbtsafetylevel.TextSize = 16
farmbtsafetylevel.TextWrapped = true

farmbtsafety.Name = "farmbtsafety"
farmbtsafety.Parent = ExtrasFrame
farmbtsafety.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
farmbtsafety.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
farmbtsafety.Position = UDim2.new(0, 5, 0, 158)
farmbtsafety.Size = UDim2.new(0, 150, 0, 20)
farmbtsafety.Font = Enum.Font.Fantasy
farmbtsafety.TextColor3 = Color3.new(1, 1, 1)
farmbtsafety.Text = "Safety Net: OFF"
farmbtsafety.TextSize = 16
farmbtsafety.TextWrapped = true

farmbtsafetyText1.Name = "farmbtsafetyText1"
farmbtsafetyText1.Parent = ExtrasFrame
farmbtsafetyText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
farmbtsafetyText1.TextColor3 = Color3.new(1, 1, 1)
farmbtsafetyText1.BorderColor3 = Color3.new(0.1, 0.1, 0.1)
farmbtsafetyText1.Position = UDim2.new(0, -155, 0, 141)
farmbtsafetyText1.Size = UDim2.new(0, 150, 0, 115)
farmbtsafetyText1.Font = Enum.Font.Fantasy
farmbtsafetyText1.Text = "Enable this to tp you to the safe zone when your health goes below the preset figure. Only useful if you can take more than 1 hit from your attacker."
farmbtsafetyText1.TextSize = 16
farmbtsafetyText1.TextWrapped = true
farmbtsafetyText1.Visible = false

ReJoinServer.Name = "ReJoinServer"
ReJoinServer.Parent = ExtrasFrame
ReJoinServer.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ReJoinServer.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
ReJoinServer.Position = UDim2.new(0, 5, 0, 188)
ReJoinServer.Size = UDim2.new(0, 150, 0, 20)
ReJoinServer.TextColor3 = Color3.new(1, 1, 1)
ReJoinServer.Font = Enum.Font.Fantasy
ReJoinServer.Text = "ReJoin Server"
ReJoinServer.TextSize = 16
ReJoinServer.TextWrapped = true

InfoScreen.Name = "InfoScreen"
InfoScreen.Parent = MainFrame
InfoScreen.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
InfoScreen.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
InfoScreen.Position = UDim2.new(0, 560, 0, 5)
InfoScreen.Size = UDim2.new(0, 40, 0, 20)
InfoScreen.BackgroundTransparency = 0
InfoScreen.Font = Enum.Font.Fantasy
InfoScreen.TextColor3 = Color3.new(1, 1, 1)
InfoScreen.Text = "Info"
InfoScreen.TextSize = 17
InfoScreen.TextWrapped = true

InfoText1.Name = "InfoText1"
InfoText1.Parent = MainFrame
InfoText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
InfoText1.BorderColor3 = Color3.new(0, 0, 0)
InfoText1.BackgroundTransparency = 0
InfoText1.Position = UDim2.new(0, 405, 0, 32)
InfoText1.Size = UDim2.new(0, 190, 0, 180)
InfoText1.TextColor3 = Color3.new(1, 1, 1)
InfoText1.Font = Enum.Font.Fantasy
InfoText1.Text = "This Gui was created by LuckyMMB@V3rmillion.net\nDiscord https://discord.gg/GKzJnUC\n\nCredits:\n-racist dolphin for the original ESP script which I edited and customised and whoever found the remotes for farming exp."
InfoText1.TextSize = 15
InfoText1.TextWrapped = true
InfoText1.Visible = false
InfoText1.ZIndex = 7
InfoText1.TextYAlignment = Enum.TextYAlignment.Top

PlayerName.Name = "PlayerName"
PlayerName.Parent = MainFrame
PlayerName.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerName.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PlayerName.Position = UDim2.new(0, 605, 0, 5)
PlayerName.Size = UDim2.new(0, 150, 0, 20)
PlayerName.Font = Enum.Font.Fantasy
PlayerName.TextColor3 = Color3.new(1, 1, 1)
PlayerName.Text = tostring(MyPlr.Name)
PlayerName.TextSize = 15
PlayerName.TextScaled = true
PlayerName.TextWrapped = false

StatsFrame.Name = "StatsFrame"
StatsFrame.Parent = MainFrame
StatsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatsFrame.BorderColor3 = Color3.new(0.1, 0.1, 0.1)
StatsFrame.BackgroundTransparency = 0
StatsFrame.Position = UDim2.new(0, 600, 0, 33)
StatsFrame.Size = UDim2.new(0, 161, 0, 90)
StatsFrame.Visible = false

ShowStats1.Name = "ShowStats1"
ShowStats1.Parent = StatsFrame
ShowStats1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats1.BackgroundTransparency = 1
ShowStats1.Position = UDim2.new(0, 0, 0, 0)
ShowStats1.Size = UDim2.new(0, 50, 0, 90)
ShowStats1.Font = Enum.Font.Fantasy
ShowStats1.TextColor3 = Color3.new(1, 1, 1)
ShowStats1.Text = " "
ShowStats1.TextSize = 15
ShowStats1.TextXAlignment = Enum.TextXAlignment.Right

ShowStats2.Name = "ShowStats2"
ShowStats2.Parent = StatsFrame
ShowStats2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats2.BackgroundTransparency = 1
ShowStats2.Position = UDim2.new(0, 55, 0, 0)
ShowStats2.Size = UDim2.new(0, 103, 0, 90)
ShowStats2.Font = Enum.Font.Fantasy
ShowStats2.TextColor3 = Color3.new(1, 1, 1)
ShowStats2.Text = "Stats"
ShowStats2.TextSize = 15
ShowStats2.TextXAlignment = Enum.TextXAlignment.Right

-- Close --

Open.MouseButton1Down:connect(function()
	TopFrame.Visible = false
	MainFrame.Visible = true
end)

Minimize.MouseButton1Down:connect(function()
	TopFrame.Visible = true
	MainFrame.Visible = false
end)

Close.MouseButton1Down:connect(function()
MainGUI:Destroy()
end)

-- Menus --

local Menus = {
	[WayPoints] = WayPointsFrame;
	[FarmExp] = FarmExpFrame;
	[Extras] = ExtrasFrame;
}
for button,frame in pairs(Menus) do
	button.MouseButton1Click:connect(function()
		if frame.Visible then
			frame.Visible = false
			return
		end
		for k,v in pairs(Menus) do
			v.Visible = v == frame
		end
	end)
end

FarmBody.MouseEnter:connect(function()
	FarmBodyLabel.Visible = true
end)

FarmBody.MouseLeave:connect(function()
	FarmBodyLabel.Visible = false
end)

FarmSpeed.MouseEnter:connect(function()
	FarmSpeedLabel.Visible = true
end)

FarmSpeed.MouseLeave:connect(function()
	FarmSpeedLabel.Visible = false
end)

FarmJump.MouseEnter:connect(function()
	FarmSpeedLabel.Visible = true
end)

FarmJump.MouseLeave:connect(function()
	FarmSpeedLabel.Visible = false
end)

farmbtsafety.MouseEnter:connect(function()
	farmbtsafetyText1.Visible = true
end)

farmbtsafety.MouseLeave:connect(function()
	farmbtsafetyText1.Visible = false
end)

InfoScreen.MouseEnter:connect(function()
	InfoText1.Visible = true
end)

InfoScreen.MouseLeave:connect(function()
	InfoText1.Visible = false
end)

c.MouseButton1Down:connect(function()
	cf.Visible = false
end)

-- Round Number to decimal places and convert to letter value --

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
		
function converttoletter(num)
	if num / 1e21 >=1 then
		newnum = num / 1e21
		return round(newnum, 6).. "Sx"
	elseif num / 1e18 >=1 then
		newnum = num / 1e18
		return round(newnum, 6).. "Qi"
	elseif num / 1e15 >=1 then
		newnum = num / 1e15
		return round(newnum, 6).. "Qa"
	elseif num / 1e12 >=1 then
		newnum = num / 1e12
		return round(newnum, 6).. "T"
	elseif num / 1e09 >=1 then
		newnum = num / 1e09
		return round(newnum, 6).. "B"
	elseif num / 1e06 >=1 then
		newnum = num / 1e06
		return round(newnum, 6).. "M"
	elseif num / 1e03 >=1 then
		newnum = num / 1e03
		return round(newnum, 6).. "K"
	else return num
	end
end

--- NoClip ---

NoClip.MouseButton1Down:connect(function()
	noclip = not noclip
	if noclip then
		NoClip.Text = "NoClip Mode: ON"
		NoClip.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		NoClip.Text = "NoClip Mode: OFF"
		NoClip.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)
game:GetService('RunService').Stepped:connect(function()
	if noclip then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end)

--- Farm BT Safety ---

farmbtsafety.MouseButton1Down:connect(function()
	farmbtsafetyactive = not farmbtsafetyactive
	if farmbtsafetyactive then
		farmbtsafety.Text = "Safety Net: ON"
		farmbtsafety.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmbtsafety.Text = "Safety Net: OFF"
		farmbtsafety.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

spawn(function()
	while true do
		if farmbtsafetyactive then
			while farmbtsafetyactive do
				local FindHum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
				local currenthealth = tonumber(string.format("%.0f", FindHum.Health))
				local minhealth = tonumber(string.format("%.0f", FindHum.MaxHealth))*tonumber(farmbtsafetylevel.Text)/100
				-- print("Current Health: " ..tostring(currenthealth).. ". Min Health: " ..tostring(minhealth))
				if currenthealth <= minhealth then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459, 248, 887)
				end
			wait(0.2)
			end
		end
		wait(0.5)
	end
end)

-- Show Location --

local curlocation = coroutine.wrap(function()
	while true do
		LocationX = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x, 0)
		LocationY = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y, 0)
		LocationZ = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z, 0)
		ShowLocation.Text = "Coords: "..LocationX..", "..LocationY..", "..LocationZ
		wait(0.5)
	end
end)

curlocation()

-- Set Locations --

SetLocation.MouseButton1Down:connect(function()
	function round(num, numDecimalPlaces)
		local mult = 10^(numDecimalPlaces or 0)
		return math.floor(num * mult + 0.5) / mult
	end
	setlocationx = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x, 0)
	setlocationy = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y, 0)
	setlocationz = round(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z, 0)
	print("Set Custom Location: "..setlocationx..", "..setlocationy..", "..setlocationz)
    SetLocation.Text = setlocationx..","..setlocationy..","..setlocationz
	CustomLocationSet = true
end)

--- TP to custom location ---

TPLocation.MouseButton1Down:connect(function()
	if CustomLocationSet == true then
		workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame = CFrame.new(setlocationx, setlocationy, setlocationz)
		WayPointsFrame.Visible = false
	end
end)

Location1.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459, 248, 887)
	WayPointsFrame.Visible = false
end)
	
Location2.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(409, 271, 978)
	WayPointsFrame.Visible = false
end)

LocationFS1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1176, 4789, -2293)
	WayPointsFrame.Visible = false
end)

LocationFS10T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-369, 15735, -9)
	WayPointsFrame.Visible = false
end)

LocationFS100B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1381, 9274, 1647)
	WayPointsFrame.Visible = false
end)

Location7.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2279, 1944, 1053)
	WayPointsFrame.Visible = false
end)

Location3.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(365, 249, -445)
	settplocation = "BT100Area"
	WayPointsFrame.Visible = false
end)

Location4.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(349, 263, -490)
	settplocation = "BT10KArea"
	WayPointsFrame.Visible = false
end)

Location5.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1640, 258, 2244)
	settplocation = "BT100KArea"
	WayPointsFrame.Visible = false
end)

Location6.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2307, 976, 1068)
	settplocation = "BT1MArea"
	WayPointsFrame.Visible = false
end)

Location8.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2024, 714, -1860)
	settplocation = "BT10MArea"
	WayPointsFrame.Visible = false
end)

LocationBT1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-254, 286, 980)
	settplocation = "BT1BArea"
	WayPointsFrame.Visible = false
end)

LocationBT100B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-271, 279, 991)
	settplocation = "BT100BArea"
	WayPointsFrame.Visible = false
end)

LocationBT10T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-279, 279, 1007)
	settplocation = "BT10TArea"
	WayPointsFrame.Visible = false
end)

LocationPP1M.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2527, 5486, -532)
	settplocation = "PP1MArea"
	WayPointsFrame.Visible = false
end)

LocationPP1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2560, 5500, -439)
	settplocation = "PP1BArea"
	WayPointsFrame.Visible = false
end)

LocationPP1T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2582, 5516, -504)
	settplocation = "PP1TArea"
	WayPointsFrame.Visible = false
end)

LocationPP1Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2544, 5412, -495)
	settplocation = "PP1QaArea"
	WayPointsFrame.Visible = false
end)

-- ESP Stuff --

Run:BindToRenderStep("UpdateESP", Enum.RenderPriority.Character.Value, function()
	for _, v in next, Plrs:GetPlayers() do
		UpdateESP(v)
	end
end)

-- Farm Exp --

FarmAll.MouseButton1Click:Connect(function()
	if farmallactive ~= true then
		farmallactive = true
		farmfistactive = true
		farmbodyactive = true
		farmspeedactive = true
		farmpsychicactive = true
		farmjumpactive = true
		FarmAll.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmAll.Text = "Farm All: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmallactive = false
		farmfistactive = false
		farmbodyactive = false
		farmspeedactive = false
		farmpsychicactive = false
		farmjumpactive = false
		FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmSpeed.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmJump.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmAll.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmAll.Text = "Farm All: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

FarmFist.MouseButton1Click:Connect(function()
	if farmfistactive ~= true then
		farmfistactive = true
		FarmFist.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmFist.Text = "Farm Fist Strength: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmfistactive = false
		FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmFist.Text = "Farm Fist Strength: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

FarmBody.MouseButton1Click:Connect(function()
	if farmbodyactive ~= true then
		farmbodyactive = true
		FarmBody.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmBody.Text = "Farm Body Strength: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmbodyactive = false
		FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmBody.Text = "Farm Body Strength: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

FarmSpeed.MouseButton1Click:Connect(function()
	if farmspeedactive ~= true then
		farmspeedactive = true
		FarmSpeed.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmSpeed.Text = "Farm Speed Strength: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmspeedactive = false
		FarmSpeed.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmSpeed.Text = "Farm Speed Strength: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

FarmJump.MouseButton1Click:Connect(function()
	if farmjumpactive ~= true then
		farmjumpactive = true
		FarmJump.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmJump.Text = "Farm Jump Strength: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmjumpactive = false
		FarmJump.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmJump.Text = "Farm Jump Strength: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

FarmPsychic.MouseButton1Click:Connect(function()
	if farmpsychicactive ~= true then
		farmpsychicactive = true
		FarmPsychic.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmPsychic.Text = "Farm Psychic Strength: ON"
		FarmExp.BackgroundColor3 = Color3.new(0, 0.5, 0)
	else
		farmpsychicactive = false
		FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmPsychic.Text = "Farm Psychic Strength: OFF"
		FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

spawn(function()
	while true do
		if farmfistactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			if tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.FistStrength.Value)) >= 10e12 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-369, 15735, -9)
				fistarguments = {"+FS6"}
				farmpsychicactive = false
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.FistStrength.Value)) >= 100e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1381, 9274, 1647)
				fistarguments = {"+FS5"}
				farmpsychicactive = false
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.FistStrength.Value)) >= 1e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1176, 4789, -2293)
				fistarguments = {"+FS4"}
				farmpsychicactive = false
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Strength: OFF"
			else
				fistarguments = {"+FS3", "+FS2", "+FS1"}
			end
			while farmfistactive do
				game:GetService('RunService').Stepped:wait()
				for i,v in pairs(fistarguments) do
					game.ReplicatedStorage.RemoteEvent:FireServer({[1] = v})
				end
			end
		end
		wait(1)
	end
end)

spawn(function()
	while true do
		if farmbodyactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			while farmbodyactive do
				local bodyarguments = {"+BT5", "+BT4", "+BT3", "+BT2", "+BT1"}
				local event = game.ReplicatedStorage.RemoteEvent
				for i,v in pairs(bodyarguments) do
					event:FireServer({[1] = v})
					wait()
				end
				wait()
			end
		end
		wait(1)
	end
end)

spawn(function()
	while true do
		if farmspeedactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			while farmspeedactive do
				local speedarguments = {"+MS5", "+MS4", "+MS3", "+MS2", "+MS1"}
				local event = game.ReplicatedStorage.RemoteEvent
				for i,v in pairs(speedarguments) do
					event:FireServer({[1] = v})
					wait()
				end
				wait()
			end
		end
		wait(1)
	end
end)

spawn(function()
	while true do
		if farmjumpactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			while farmjumpactive do
				local jumparguments = {"+JF5", "+JF4", "+JF3", "+JF2", "+JF1"}
				local event = game.ReplicatedStorage.RemoteEvent
				for i,v in pairs(jumparguments) do
					event:FireServer({[1] = v})
					wait()
				end
				wait()
			end
		end
		wait(1)
	end
end)

spawn(function()
	while true do
		if farmpsychicactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			if tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.PsychicPower.Value)) >= 1e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2544, 5412, -495)
				psychicarguments = {"+PP6"}
				farmfistactive = false
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.PsychicPower.Value)) >= 1e12 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2582, 5516, -504)
				psychicarguments = {"+PP5"}
				farmfistactive = false
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.PsychicPower.Value)) >= 1e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2560, 5500, -439)
				psychicarguments = {"+PP4"}
				farmfistactive = false
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PrivateStats.PsychicPower.Value)) >= 1e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2527, 5486, -532)
				psychicarguments = {"+PP3"}
				farmfistactive = false
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			else
				psychicarguments = {"+PP2", "+PP1"}
			end
			while farmpsychicactive do
				game:GetService('RunService').Stepped:wait()
				for i,v in pairs(psychicarguments) do
					game.ReplicatedStorage.RemoteEvent:FireServer({[1] = v})
				end
			end
		end
		wait(1)
	end
end)

-- Return to position on Death --

DeathReturn.MouseButton1Click:Connect(function()
	if deathreturnactive ~= true then
		deathreturnactive = true
		DeathReturn.BackgroundColor3 = Color3.new(0, 0.5, 0)
		DeathReturn.Text = "OnDeath Return: ON"
	else
		deathreturnactive = false
		DeathReturn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		DeathReturn.Text = "OnDeath Return: OFF"
	end
end)

spawn(function()
	while true do
		if deathreturnactive then
			player = game:GetService("Players").LocalPlayer
			player.Character.Humanoid.Died:connect(function()
				playerdied = true
			end)
		end
		if not playerdied then
			lastlocationx = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
			lastlocationy = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y
			lastlocationz = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
			SavePosition.Text = "Last Place: " ..lastlocationx.. "," ..lastlocationy.. "," ..lastlocationz
			--print(tostring(SavePosition.Text))
			wait(0.5)
		end
		if playerdied then
			--print("Player " ..tostring(game.Players.LocalPlayer.Name).. " Died")
			--print(tostring(SavePosition.Text))
			wait(5)
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer({[1] = "Respawn"})
			wait(1)
			game.Lighting.Blur.Enabled = false
            game.Players.LocalPlayer.PlayerGui.IntroGui.Enabled = false
            game.Players.LocalPlayer.PlayerGui.ScreenGui.Enabled = true
			wait(4)
			--print("screengui disabled")
			repeat wait(0.1) until game.Players.LocalPlayer.Character.Humanoid
			--print("Teleporting back to " ..tostring(SavePosition.Text))
			if deathreturnactive then
				local FindHum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastlocationx, lastlocationy, lastlocationz)
			end
			playerdied = false
		end
		wait(1)
	end		
end)

-- Annoy Player --

AnnoyStart.MouseButton1Click:Connect(function()
	if annoyplayeractive ~= true then
		annoyplayeractive = true
		AnnoyStart.BackgroundColor3 = Color3.new(0, 0.5, 0)
		AnnoyStart.Text = "TP Spam Player: ON"
	else
		annoyplayeractive = false
		AnnoyStart.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		AnnoyStart.Text = "TP Spam Player: OFF"
	end
end)

spawn(function()
	while true do
		wait(0.5)
		if annoyplayeractive then
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				if v.Name:lower():find(AnnoyName.Text:lower()) then
					player = game.Players.LocalPlayer.Character
					local startpos = player.HumanoidRootPart.CFrame
					v.Character.Humanoid.Died:connect(function()
						annoyplayeractive = false
						AnnoyStart.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
						AnnoyStart.Text = "TP Spam Player: OFF"
					end)
					player.Humanoid.Died:connect(function()
						annoyplayeractive = false
						AnnoyStart.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
						AnnoyStart.Text = "TP Spam Player: OFF"
					end)
					while annoyplayeractive == true do
						player.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
						wait(.005)
					end
					player.HumanoidRootPart.CFrame = startpos
				end
			end
		end
	end
end)

TptoPlayer.MouseButton1Click:Connect(function()
	for i,v in pairs(game:GetService("Players"):GetChildren()) do
		if v.Name:lower():find(AnnoyName.Text:lower()) then
			if v.Name ~= tostring(MyPlr.Name) then
				player = game.Players.LocalPlayer.Character
				player.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, 3)
			end
		end
	end
end)

mouse.KeyDown:connect(function(key)
	if key == tostring(PanicToggle.Text) then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459, 248, 887)
	end
end)

-- ESP --

esptrack.MouseButton1Click:connect(function()
	ESPEnabled = not ESPEnabled
	if ESPEnabled then
		esptrack.BackgroundColor3 = Color3.new(0, 0.5, 0)
		for _, v in next, Plrs:GetPlayers() do
			if v ~= MyPlr then
				if CharAddedEvent[v.Name] == nil then
					CharAddedEvent[v.Name] = v.CharacterAdded:connect(function(Char)
						if ESPEnabled then
							RemoveESP(v)
							CreateESP(v)
						end
						repeat wait() until Char:FindFirstChild("HumanoidRootPart")
					end)
				end
				RemoveESP(v)
				CreateESP(v)
			end
		end
	else
		esptrack.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		for _, v in next, Plrs:GetPlayers() do
			RemoveESP(v)
		end
	end
end)

-- Server Player Stats --

PlayerInfo.MouseButton1Click:connect(function()
	if not showtopplayersactive then
		showtopplayersactive = true
		showtopplayersfistactive = true
		showtopplayersbodyactive = true
		showtopplayersspeedactive = true
		showtopplayersjumpactive = true
		showtopplayerspsychicactive = true
		PlayerInfoStatsFrame.Visible = true
	else
		showtopplayersactive = false
		PlayerInfoStatsFrame.Visible = false
		showtopplayersfistactive = false
		showtopplayersbodyactive = false
		showtopplayersspeedactive = false
		showtopplayersjumpactive = false
		showtopplayerspsychicactive = false
	end
end)

PlayerInfoStatsClose.MouseButton1Click:connect(function()
	showtopplayersactive = false
	PlayerInfoStatsFrame.Visible = false
	showtopplayersfistactive = false
	showtopplayersbodyactive = false
	showtopplayersspeedactive = false
	showtopplayersjumpactive = false
	showtopplayerspsychicactive = false
end)

spawn(function()
	while true do
		if showtopplayersfistactive then
			BestPlayerFist = 1
			PlayerFistName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerFist = tonumber(game.Players[v.Name].PrivateStats.FistStrength.Value)
				if PlayerFist > tonumber(BestPlayerFist) then 
					BestPlayerFist = PlayerFist
					PlayerFistName = tostring(v.Name)
				end
			end
			StatBestFistText1.Text = "Fist: " ..tostring(PlayerFistName)
			local fistplrStatus = game.Players[PlayerFistName].leaderstats.Status
			if fistplrStatus.Value == "Criminal" then
				StatBestFistText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif fistplrStatus.Value == "Lawbreaker" then
				StatBestFistText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif fistplrStatus.Value == "Guardian" then
				StatBestFistText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif fistplrStatus.Value == "Protector" then
				StatBestFistText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif fistplrStatus.Value == "Supervillain" then
				StatBestFistText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif fistplrStatus.Value == "Superhero" then
				StatBestFistText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestFistText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerFistName].Character.Humanoid
			local FistPlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
			local FistPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PrivateStats.FistStrength.Value))
			local FistPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PrivateStats.BodyToughness.Value))
			local FistPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PrivateStats.MovementSpeed.Value))
			local FistPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PrivateStats.JumpForce.Value))
			local FistPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PrivateStats.PsychicPower.Value))
			ShowStatsFist2.Text = tostring(FistPlayerHealth.. "\n" ..FistPlayerFist.. "\n" ..FistPlayerBody.. "\n" ..FistPlayerSpeed.. "\n" ..FistPlayerJump.. "\n" ..FistPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersbodyactive then
			BestPlayerBody = 1
			PlayerBodyName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerBody = tonumber(game.Players[v.Name].PrivateStats.BodyToughness.Value)
				if PlayerBody > tonumber(BestPlayerBody) then 
					BestPlayerBody = PlayerBody
					PlayerBodyName = tostring(v.Name)
				end
			end
			StatBestBodyText1.Text = "Body: " ..tostring(PlayerBodyName)
			local bodyplrStatus = game.Players[PlayerBodyName].leaderstats.Status
			if bodyplrStatus.Value == "Criminal" then
				StatBestBodyText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif bodyplrStatus.Value == "Lawbreaker" then
				StatBestBodyText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif bodyplrStatus.Value == "Guardian" then
				StatBestBodyText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif bodyplrStatus.Value == "Protector" then
				StatBestBodyText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif bodyplrStatus.Value == "Supervillain" then
				StatBestBodyText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif bodyplrStatus.Value == "Superhero" then
				StatBestBodyText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestBodyText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerBodyName].Character.Humanoid
			local BodyPlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
			local BodyPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PrivateStats.FistStrength.Value))
			local BodyPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PrivateStats.BodyToughness.Value))
			local BodyPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PrivateStats.MovementSpeed.Value))
			local BodyPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PrivateStats.JumpForce.Value))
			local BodyPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PrivateStats.PsychicPower.Value))
			ShowStatsBody2.Text = tostring(BodyPlayerHealth.. "\n" ..BodyPlayerFist.. "\n" ..BodyPlayerBody.. "\n" ..BodyPlayerSpeed.. "\n" ..BodyPlayerJump.. "\n" ..BodyPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersspeedactive then
			BestPlayerSpeed = 1
			PlayerSpeedName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerSpeed = tonumber(game.Players[v.Name].PrivateStats.MovementSpeed.Value)
				if PlayerSpeed > tonumber(BestPlayerSpeed) then 
					BestPlayerSpeed = PlayerSpeed
					PlayerSpeedName = tostring(v.Name)
				end
			end
			StatBestSpeedText1.Text = "Speed: " ..tostring(PlayerSpeedName)
			local speedplrStatus = game.Players[PlayerSpeedName].leaderstats.Status
			if speedplrStatus.Value == "Criminal" then
				StatBestSpeedText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif speedplrStatus.Value == "Lawbreaker" then
				StatBestSpeedText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif speedplrStatus.Value == "Guardian" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif speedplrStatus.Value == "Protector" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif speedplrStatus.Value == "Supervillain" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif speedplrStatus.Value == "Superhero" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestSpeedText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerSpeedName].Character.Humanoid
			local SpeedPlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
			local SpeedPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PrivateStats.FistStrength.Value))
			local SpeedPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PrivateStats.BodyToughness.Value))
			local SpeedPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PrivateStats.MovementSpeed.Value))
			local SpeedPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PrivateStats.JumpForce.Value))
			local SpeedPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PrivateStats.PsychicPower.Value))
			ShowStatsSpeed2.Text = tostring(SpeedPlayerHealth.. "\n" ..SpeedPlayerFist.. "\n" ..SpeedPlayerBody.. "\n" ..SpeedPlayerSpeed.. "\n" ..SpeedPlayerJump.. "\n" ..SpeedPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersjumpactive then
			BestPlayerJump = 1
			PlayerJumpName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerJump = tonumber(game.Players[v.Name].PrivateStats.JumpForce.Value)
				if PlayerJump > tonumber(BestPlayerJump) then 
					BestPlayerJump = PlayerJump
					PlayerJumpName = tostring(v.Name)
				end
			end
			StatBestJumpText1.Text = "Jump: " ..tostring(PlayerJumpName)
			local JumpplrStatus = game.Players[PlayerJumpName].leaderstats.Status
			if JumpplrStatus.Value == "Criminal" then
				StatBestJumpText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif JumpplrStatus.Value == "Lawbreaker" then
				StatBestJumpText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif JumpplrStatus.Value == "Guardian" then
				StatBestJumpText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif JumpplrStatus.Value == "Protector" then
				StatBestJumpText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif JumpplrStatus.Value == "Supervillain" then
				StatBestJumpText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif JumpplrStatus.Value == "Superhero" then
				StatBestJumpText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestJumpText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerJumpName].Character.Humanoid
			local JumpPlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
			local JumpPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PrivateStats.FistStrength.Value))
			local JumpPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PrivateStats.BodyToughness.Value))
			local JumpPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PrivateStats.MovementSpeed.Value))
			local JumpPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PrivateStats.JumpForce.Value))
			local JumpPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PrivateStats.PsychicPower.Value))
			ShowStatsJump2.Text = tostring(JumpPlayerHealth.. "\n" ..JumpPlayerFist.. "\n" ..JumpPlayerBody.. "\n" ..JumpPlayerSpeed.. "\n" ..JumpPlayerJump.. "\n" ..JumpPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayerspsychicactive then
			BestPlayerPsychic = 1
			PlayerPsychicName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerPsychic = tonumber(game.Players[v.Name].PrivateStats.PsychicPower.Value)
				if PlayerPsychic > tonumber(BestPlayerPsychic) then 
					BestPlayerPsychic = PlayerPsychic
					PlayerPsychicName = tostring(v.Name)
				end
			end
			StatBestPsychicText1.Text = "Psy: " ..tostring(PlayerPsychicName)
			local PsychicplrStatus = game.Players[PlayerPsychicName].leaderstats.Status
			if PsychicplrStatus.Value == "Criminal" then
				StatBestPsychicText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif PsychicplrStatus.Value == "Lawbreaker" then
				StatBestPsychicText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif PsychicplrStatus.Value == "Guardian" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif PsychicplrStatus.Value == "Protector" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif PsychicplrStatus.Value == "Supervillain" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif PsychicplrStatus.Value == "Superhero" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestPsychicText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerPsychicName].Character.Humanoid
			local PsychicPlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
			local PsychicPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PrivateStats.FistStrength.Value))
			local PsychicPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PrivateStats.BodyToughness.Value))
			local PsychicPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PrivateStats.MovementSpeed.Value))
			local PsychicPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PrivateStats.JumpForce.Value))
			local PsychicPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PrivateStats.PsychicPower.Value))
			ShowStatsPsychic2.Text = tostring(PsychicPlayerHealth.. "\n" ..PsychicPlayerFist.. "\n" ..PsychicPlayerBody.. "\n" ..PsychicPlayerSpeed.. "\n" ..PsychicPlayerJump.. "\n" ..PsychicPlayerPsychic)
		end
		wait(0.3)
	end
end)

-- Display Player Info --

spawn(function()
	while true do
		statplayer = tostring(PlayerName.Text)
		StatsFrame.Visible = false
		if playerdied == true then repeat wait(0.5) until playerdied == false end
		for i,v in pairs(game:GetService("Players"):GetChildren()) do
			if string.lower(v.Name) == string.lower(statplayer) then
				StatsFrame.Visible = true
				local FindHum = v.Character:WaitForChild("Humanoid")
				local PlayerHealth = converttoletter(string.format("%.0f", FindHum.Health))
				local PlayerFist = converttoletter(string.format("%.0f", game.Players[v.Name].PrivateStats.FistStrength.Value))
				local PlayerBody = converttoletter(string.format("%.0f", game.Players[v.Name].PrivateStats.BodyToughness.Value))
				local PlayerSpeed = converttoletter(string.format("%.0f", game.Players[v.Name].PrivateStats.MovementSpeed.Value))
				local PlayerJump = converttoletter(string.format("%.0f", game.Players[v.Name].PrivateStats.JumpForce.Value))
				local PlayerPsychic = converttoletter(string.format("%.0f", game.Players[v.Name].PrivateStats.PsychicPower.Value))
				ShowStats1.Text = "Health:\nFist:\nBody:\nSpeed:\nJump:\nPsychic:"
				ShowStats2.Text = PlayerHealth.. "\n" ..PlayerFist.. "\n" ..PlayerBody.. "\n" ..PlayerSpeed.. "\n" ..PlayerJump.. "\n" ..PlayerPsychic
				break
			end
		end
		wait(0.25)
	end
end)

--- ReJoin Server ---

ReJoinServer.MouseButton1Click:connect(function()
	local placeId = 2202352383
	game:GetService("TeleportService"):Teleport(placeId)
end)






local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/sol"))()

--[[SolarisLib:New({
  Name - Title of the UI <string>
  FolderToSave - Name of the folder where the UI files will be stored <string>
})]]
local win = SolarisLib:New({
  Name = "Super Power Training Simulator",
  FolderToSave = "SptsStuff"
})

--win:Tab(title <string>)
local tab = win:Tab("Farm, Auto")

--tab:Section(title <string>)
local sec = tab:Section("Utilities")

--sec:Button(title <string>, callback <function>)
sec:Button("Anti Afk", function()
    local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

sec:Button("Admin", function()
  ------Fate's Admin (brought to you by Hacks Home)--------
loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
end)

sec:Button("Split", function()
    game.Players.LocalPlayer.Character.UpperTorso.Waist:remove()
end)

sec:Button("God Mode", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1ArcX/Scripts/main/God%20Mode", true))()
end)

sec:Button("AutoClicker", function()
    local vu = game:GetService("VirtualUser")
	_G.autoclick = true
	while _G.autoclick do
		vu:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(0.1)
		vu:Button1Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

sec:Button("Stop AutoClicker", function()
    local vu = game:GetService("VirtualUser")
	_G.autoclick = false
	while _G.autoclick do
		vu:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(0.1)
		vu:Button1Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

sec:Button("Aura edit", function()
    _, Protected_by_MoonSecV2, Discord = 'discord.gg/gQEH2uZxUk'


    ,nil,nil;(function() _msec=(function(K,l,o)local J=l[((0x317b/239)+-#[[impulse is hot]])];local q=o[K[(-#'moonsec got deobfuscated'+(-0x4a+773))]][K[((-93+0x396)+-#"If no milk then return ffather")]];local S=((126+-0x6c)+-#"impulse is hot")/(-0x77+(-#"Nsrds GAYYYYAIAHAKAJAVAHAUA"+(0x3780/(222+-0x7e))))local L=(((((2348346/0x8a)+-#"nico der hurensohn")/0xbf)-78)+-#[[Niggabyte]])-(171/0xab)local g=o[K[(0x138-202)]][K[(-#{{};(function()return#{('oPHhfo'):find("\72")}>0 and 1 or 0 end);'}','}','nil';'}'}+226)]];local _=(0x27-((18072-0x236a)/0xed))+(0x3a+-56)local F=o[K[(530+-#{1,{};'nil'})]][K[(0x324e4/231)]]local h=((0x23+-16)+-#"Impulse real 2022")-(((-0x604/((0x1b4-273)+-#'0nly 1337'))+-#[[Big black men]])+24)local m=((-#'testing this thingy lololollez'+(-0x17a0/(25760/(119+-#{'}';'}';41,41}))))+0x3c)local H=(0x3a+((-2115/((2891/0x31)+-#[[deadphonelua]]))-0xa))local a=((-0x145e/(-#{'nil',(function()return{','}end)(),1;'nil';(function()return{','}end)(),'}';","}+73))+82)local d=(7+-#{'nil';",",(function()return#{('HFloPK'):find("\108")}>0 and 1 or 0 end),'nil'})local f=((((0x1bbb/(0x57+-56))+-0x52)-0x7e)+-#"Impulse youtube ez")local r=(-#{113,{};{}}+6)local w=((-#{'nil';41;",";(function()return{','}end)();63,41;63}+567)/0x8c)local u=((702/(-#{1,95;80;'}';'nil',(function()return#{('oOmFhO'):find("\109")}>0 and 1 or 0 end);(function()return#{('oOmFhO'):find("\109")}>0 and 1 or 0 end)}+33))+-#[[how do i get moonsex v3]])local i=(0x6e+(((82+((-0x19+-84)+-#[[elbicho]]))+-0x21)+-#"papier ist ein kleiner schwanz lutscher"))local t=(((-#"Suck Sus0587"+(38010-(-83+0x4aa2)))/0xfd)+-0x47)local x=((94-(-#{'}',(function()return{','}end)(),(function()return{','}end)(),35;1}+67))+-#[[If no father return milk end]])local U=(0x318/((((2444-(93440/0x49))-630)+-#"Lana Rhoades")-324))local e=((((-#{",",38;38}+138)+-0x2b)+-#"I FUCKING HATE FEMBOYS")+-0x44)local n=(-0x3e+(((676-0x171)+-127)+-0x74))local M=((((659745/(-#"Faggot"+(0xac29/177)))+-24)/207)+-#"panzerfaust")local O=((123-(((52267+-#{'nil',1,10;114})-0x663c)/0xdf))+-#[[nerd]])local p=(6+-#{61,61;(function()return{','}end)(),67})local P=((0xa7-(-0x53+((348+-0x24)+-0x65)))+-#[[hypeblox likes sucking big black cock]])local j=K[((0x4bb79+-55)/0xe3)];local Y=o[K[(-#{(function()return#{('BbmKkM'):find("\109")}>0 and 1 or 0 end);",",59,'}'}+114)]][K[(-0x16+487)]];local A=o[(function(K)return type(K):sub(1,1)..'\101\116'end)('MbMmBflF')..'\109\101'..('\116\97'or'KHlbPMOb')..K[(0x47c-621)]];local y=o[K[(0x25a+-75)]][K[((0x82f-1102)+-#[[papier ist ein kleiner schwanz lutscher]])]];local N=(5+-#{'nil',{},35})-((-#'goofy ahh uncle productions'+((-78+0x33d)-0x1b4))/144)local D=(78-(276-((-0x33-10)+261)))-((0x554/124)+-#'Deezbutts')local v=o[K[((282-0x9f)+-#[[Bush Did 9 11]])]][K[(733-(0x1940/16))]];local k=function(K,o)return K..o end local C=(-#'Suck Sus0587'+(2544/0x9f))*(((102312/0xc)/0x62)-0x53)local I=o[K[(-#'if true then return your dad'+((-0x29+2410)-0x4c9))]];local B=(0x25+-35)*((0x563+(-89-(-0x4e+88)))/10)local z=(159744/0x9c)*((0x55-(172-(0xde0/32)))+-#[[I FUCKING HATE FEMBOYS]])local G=(((-0xeb0/235)-30)+98)local s=((((-#"atakan der nigga"+(-119-(0x12-49)))+0xea)+-114)+-#"impulse is hot")*(0x6b+-105)local c=o[K[(-73+0x43e)]]or o[K[(0x252+-67)]][K[(-73+0x43e)]];local b=(-#[[legend says i was here]]+(-45+((1387-0x2bf)-361)))local K=o[K[(-#{",",(function()return{','}end)(),1;108;(function()return#{('lhOFBO'):find("\79")}>0 and 1 or 0 end),{};{}}+1295)]];local y=(function(k)local p,l=1,0x10 local o={j={},v={}}local b=-h local K=l+L while true do o[k:sub(K,(function()K=p+K return K-L end)())]=(function()b=b+h return b end)()if b==(C-h)then b=""l=N break end end local b=#k while K<b+L do o.v[l]=k:sub(K,(function()K=p+K return K-L end)())l=l+h if l%S==N then l=D y(o.j,(v((o[o.v[D]]*C)+o[o.v[h]])))end end return F(o.j)end)("..:::MoonSec::..bBfFlLkKoOpPhHmMpKBmmKoKfKBHkhbKpKlKLlmoObFLOoFfPFlKmKoKOhBkHFKlmHpHLoHPKpFoPFKlHflmmKoKfKfHHOKkBlOOfmhOMmhPkKbKpKOPlhMMOPfBkKKfHpkKMfmbbMbkPHbmpKlKmKhpObFPHboBbhPLmKoHfKhKkKlpBkPFLkMOLpMfkHbKpKlKFlMkOLFfhhobMHLbmKoKfKBlhokmBLPbLPMhoPfhFmbPpKlKmKMPObFlhhHmpolKmKoKokMkkKbKpKlKmKhKKpbKkKbPpKlKmKhMohfohPooPFlKmKoKKbFLHHKkBfphFpmhOOFHhhKOfoLKmKoKfKbOhokpBfpmLOMkOhFLhPlpBkPFLkMOLpfBMfMLKmmkHkfmbLbkFmbppKlKmKMLohFmkKbhpKlKmKMPoofOHFkhHkkmflKlhkLKmhmKmkOHmOoKfKhKHkKpKmlMmKoKfKBhPblpBkPOLLmhOOlokmbKpKlKFHmhopFPHkKOHplKmHoKfKhKHFKbbmpMLPmooBhKkKbKpKlKkKhpkKfBBLlmoohBMPFLMmbkPHbHpKlKmKHKooFOhhKLBPhhkmPfkPpKHMMboHokkhoKfKhKkKbKfKOBfKoKfphKkKbKMFphlmPkfKhKkKbKpKhKfohKMmHBkKbKpKOfLbmpOfBKHFkofbphLOHHfMhKkKbKMpppLOmhOLbmHhKbKmLbmKoKfKFmHkKOBfPpLKmoopfhPHbHpKlKmKhOOkfPmbfKHoMFmhoKfKhKPhlPBbPlBOLmfhhKkKbKBbPLloMlohMfKkbKpKlKfomPoPbhHHkhBLPPfMmoOLfPHFkhBOOHmmoKfKhKppKkBOphfmMhObfBBMfLfhFfFoFMhLbkhBbKpKlKmKoKLKFOpKbPpKlKmKoKfKhKkMlKMHlpmKoKfKfOHPFOpKLBmKoKfKBPhhKMBPopLkMFOkFOOpFfPBlKmKoKkHFbHOkhMpphLOMHohFOkKbPpKlKmKmmooFlhhFfPFlKmKoKKPFOHbkmbmphLOhhOHfhHLKPfolhmKoKfKBphpKkBOphBkhLPMFBokLMmbbPfkbofhhKkKbKmHPkLOmpohpbkoPFpplKmKoKkoBKPbooPBlKmKoKKpFhHOkHbopplhhmOhFbOfbHpKlKmKMbOLFphhKOBPpBmKoKfKhKkKbKmhoKPmoPfKhKkKLFbhpHLPFKfKhKkKbKpKlKBPhKLfHBkKbKpKOpLkMhOOfphhLpboPLLpFFFHhKkKbKmOpolpMfomFOHkKhBLpPFPMOooFLHpKKboPOlhMLoplbPHbhpKlKmKmpOFFkHpkhKmlpmKoKfKfoHKKbLFlmmKoKfKfmhhKPbHphLLMHoBhKkKbKpKlKmKHFkKMkkKbKpKlKmKhKoLbKkKbMpKlKmKHpohFPPpkpBkPOlhLmfHhKkKbKMOphLlMkOPfhPHbhpKlKmKHhkPFbHlFOMHLfmKoKfKFFhhkobPphLOMpOPfoHPKpfolmmKoKfKbpHkKObhomLhMbHFHfkKbKpKoolPMlObFLPOkhBlPkLPmhHKhKkKbKpKlKpKmBkKMfKbbKpKlKFmmoOFFfHpKKbhphlPHHfmhKkKbKbHPOLkMlKObmpOoophlKmKoKkpFFHkKmBLMFmhoKfKhKPlKkBLphkbPffphKkKbKBFPPBObhPHmoLopkHFpPPohkphPBFbmMkkhMBkKLkkKKFkfhFHoKpFoomObkPHbppKlKmKmHOpMOOfbppKlKmKmPOhFlBFBbpKlKmKhpoMfoHOkobpPPlhMOKHHKkKbKpKoMLhMlooFLHkKbbPOOLkMkOPBKhoKOBPBmMhoKfKhKhPKbBpppLkMOoPMLhmkmHkpmFohhkMMOHhkBBMOhLfoKfhhKkKbKmMPkLLmhpblhoFkPHPkKOOBKbobkOkbKpKlKmKoKKKFppKFkbMHhBLbKFHKObKlkMHlmmKoKfKfMHPKPBKoBBkPkpohhkKbKpKoplMmhOpFPkKbhpKlKmKmHObFpHPkofhlKmKoKfKhKkKkLmKOHmhoKfKhKHlkoBbPLBOLmFPhKkKbKMpphLPHKOOFbHlkoBOhbFKmoOOFPpplHBOpoLlmhKHhPkKbKpKOLloMlohlokMbKpKlKfOMkoPlbpmobBOPkkhoKfKhKkKbKpKKhfKPffHhKkKbKbpPkLLmpooFPkPKLpKMmoKHmkboPpkLHpHlKmKoKOpFPHOKbBLpmkhpfmlFKbKMlfFBkfkFFFfhKkKbKmpPbLPMbpBfhHLKpbMPbLKLmFbhKkKbKbppMloMOoofpHPkhBOOHMooKfKhKpOobHLkKbomHoHfHhhKFfBhBbpPKLoMHOKHmpolKmKoKKMKFKobKpKlKFlMkOhFphhlOBhPPLPMkOLMoppKFBbppLfPkHMmLmhMfMoMMOLlkfKhPkKbKpKoploMpoMBHKBbKpKlKFPmhOMFPpOKhBPPPLkMLfKhPkKbKpKPKloMOOPfBkKbKpKlKmKbKOlbKOfBbpKlKmKhOOkfPmbfKmoPhLOmoKHhpkKbKpKomlhMPKHHbkKbKpKPmloMFOfFpHKkhbhpPBfOBfKhKkKlHBbPpLPpKKOFbhmkMBPKlmKPffmhKkKbKmMPPLPMKkmfhHPooPHlKmKoKKKFOHkKPbhppLPmhoPmKHmKbBPpMbKHlOkFkHLLpbhppmKopfKhKkKkHBpKPFHoHfKhKkKLKBFpokbmhOOlokPbKpKlKLkMKohFLkKbMpKlKmKmOObFPOLkOBMPkLOLmFBhKkKbKbkpkLpmhopFhHOkhbhPomPopFhmMpLLfMfbffkFFfPhKkKbKbppMloMOfKhPkKbKpKOpLbbBohOmkmbKpKlKFFMbomfMHPfKHOOHmPoKfKhKpMkhbopPmKObfKhKkKLKBFpokbmhOObmHhKbHflPmKoKfKfmhoKlbhhomhoKfKhKHKkpboPFLFHHFBhKkKbKMFPblmmMOPmKpoKhBOpokhoKfKhKkKbKoKPkfKHHfPhKkKbKmHPkLLMPHKlmLLBKpoMOKKlhkkBHkPbKpKlKlOmoOpFpBFBfpKlKmKHFohfohPkhBOpOLkmoOOfPkKBopKlKmKHOohFKHFKbbppoLPmhoPBpHPKkBOpolmmhfKhMkKbKpKoOLkmPpbbmmbKOBkOHmHoKfKhKpOKkbPhbbKPOLfhpkKbKpKpHLpPoLfhmkKbKpKopLkMLOLfhhpKPKmLbmKoKfKbHHbKpBPkKFFmhoHFPPHBMpKlKmKMKooFpHPkhbOPbLLPLopFkHlFkBOpoLmPkOhBfOpFmmHPBfhoPollpoofkLOHKphhkHFHkkKbKpKpPLpmHlKFbHpfKbMpoLOMlOFfhHpKpHfLFmKoKfKbohPkPmhPMLPMOoobphoKpbMlPMOpBlFlKhMOooookOFObfKhKkKlOBkpPkbhHOkFOhpkhHflPmKoKfKBBHpKkBLKkmPPPKbpKbBHoKmokmKOBfKhKkKLBBpPkLLhPohfpHkkPbhlKmpoKfKhKphLpMKhomMoKfKhKpMKhBlpoLLMkObfPBKmhHfphfkFbffoOpkkBfhFKbLhKbolBmPlkKmlpmKoKfKfHHpFpKmlpmKoKfKFFHPFofhlKmKoKfKhKpKLmmKMFmpoKfKhKhOKPHoBmmPoKfKhKpMkhbopPOFObfKhKkKlHBbPpLPpKkoFhHOkoKmLbmKoKfKbOHkkPfboHLkMOopfhkKbPpKlKmKmmooFlhhoopplKmKoKOLfhHmboLFLLmKoKfKBLhhKmBPPkLLMpOkfHHPLBMpOkFLkffKhKkKbKpKlKFphKpohMkKbKpKOPlhMMOPBpHboBbhMFmMoKfKhKPbKLBpPPloMLopfhPHBBpKlKmKHPohFMHPLpbppoLFmhoPMfKlbKpKlKloMKObMkHmkhbOpMLkMkOfFpOkLHPBlKmKoKOFFkhokPBpPPLOMbOLfmmhbKpKlKmKoKfKMopKFkHpKpBpPpLpMplplkHflpmKoKfKfOHPkoHflPmKoKfKfOmbKPbhhoMfoKfKhKhpkMbhppLfmpooFFHFkhBOlKmMoKfKhKpmLHBBOkLhHKOpbPFmbmpKlKmKHHObFpHbkOBFphOFoofKhKkKkoLFlhmKoKfKBOHbkmbMPPOFomfKhKkKLFBbpmlMMPlKMoFmBBpKlKmKMbOpFFhpKFBkPpLhMOohOmkPbKpKlKFKmoOOFPmobHpKlKmKhoOlFkHhKLBPKfMfoKfKhKPFKkbppoLFHKOFfombkhBOBmMLoKfKhKhBLbBLpPlhMMkOfhhMkoBHPbLkMOpoHFkKbKpKoOLkMOoPfhHOlpBkPFLkMOLpBHKbbKpKlKFpmpOOfhhhKLmmPhLbbhfKhKkKbKpKlKffhKbfObHHhLlkkBBkLlkkBHKbbKpKlKFPmhOMFPPFkobOphLFPffhhKkKbKmHPOloMlohlokPbKpKlKfhMLOhFlPHBfpKlKmKHPohFMHPLmBOpoLKMKohfPPHbmpKlKmKmPObFphpKkBOpPOFOBfKhKkKlmbhPPFpmhOOFHHbkpbhMFMboKfKhKhmkoBlphLpmhOLFphhHmPLlKmKoKomfoHlkhBpphLLMpohMkhMKPBPPKmPlLFBKFfKMbMlBkfkPffohKkKbKBKOHmmoKfKhKPpKbbOPFLbMLomOmkMbKpKlKfMMPOPFKPKKkBpPPhfoKfKhKkKbKpKlKmKLmfMhKkKbKmppoLFMFoOfohpKffoLbmKoKfKFmhhkObMPkLkMfKbbPmhbKpKlKmKoKfKfmpKkBpKlKmKoKfKhKOFlKMHlHmKoKfKFphMkobPPkLmoPoPpLLkhkLoMohmhkLfhMkKbKpKObLLMpOPfoHLkpbhBmmMoKfKhKPKKkBpPbLPMbOkFLmhLOppBKokMfbFPLpkbKpHlKmKoKOMFKhpkoBFPFmKObfKhKkKLmBkPOLfMpOKfohpkhLFlpmKoKfOMlkKbKpKlhmKoKfKHOMFbKpKlKkBoKfKhKkKbKpKlKmKoKfKhKkKbKpKlKmooKfKhKkKbKPOlKmKoofKhOkKbKpKLOmKoKfohKKfbKpKlKbHoKfKhokKBbpKlomKHpfKhPPhbKpKlKMboKfohKkPLhpKlKmKOBfKhokKbKbLlKmKoKfohKkKbKpOKlmKoofKhHkKbKpKLOFfoKfohKBObKpKlKmKMLfKhokKbKpKlKmKOOOphKkObKBhlKmKoKfOMlkKbppKlmmKoKfKhKMlbKpPlKmooKfKhKkKbKpKlhmKopfKhKkKBOpKlKmHoKHFhKkKbKpKlKmKohfKhOkKbOpKlHmKoKfPhKpPbKpolKmhoKfPBhkKbKpKoPmKoofKhKOHbKphlKmpoKfKhKKOKKpKlHmKOOfKhKkKfKmPlKmHoKfHhKhobKpKlpmKohfKhOkKbOpKlHlKoKfPhKpPbKpolKmhoKfPBhkKbKpKoPmKoofKhKOHbKphlKmpoKfKhKKOKKpKlHmKOOfKhKkKfKmPlKmHoKfHhKOhbKpKlpmKohfKhOkKbOpKlHlKoKfPhKpPbKpolKmhoKfPBhkKbKpKoPmKoofKhKOHbKphlKmpoKfKhKkOFlpKlHmKOkfKhKkKbKpplKmhoKfOhKkObKpHpBmKohfKmmkKbopKlomKoPKhhKkKbKhmlKmooKfPBhkKbKpKopmKoofKhKOHbKphlKmpoKfKhKKOLFpKlHmKmpfKhKkKBOpKlKmmoKKKhKkKbKPOlKmKoMfKObkKbKpKlKmKoKfmhKkmbKpMlKmHoKfKhmkKFkpKlomKoofKhPPhbKpKlKBkoKfohKKOKppKlmmKbmfKhKkKbKmFlKmHoKfHhKkmbKpHpBmKoHfKMpkKbopKlomKoPKhhKkKbKHplKmooKFOFKkKbHpKolmKoKfKhKkpbKphlKmOoKfOhKkHkKpKlPmKhPfKhokKbhpKlPFhoKfKhKpPbKpolKmKPHfKhhkKbppKlKmKOOOKhKkHbKbplKmKoKlKbPkKbHpKlHmKbFfKhKkpbKphlKmOoKfOhKkHkKpKlPmKhPfKhokKbhpKlPFhoKfKhKpPbKpolKmKPHfKhhkKbppKlKmKOOlphKkHbKbplKmKoKlKhKkKbHpKlHmKFKfKhKkKbKphlKmOoKfOhKkKbKpKlPmKohfKhKkKbPpKlKmKoKkPhKkobKpKOKmKoPfKhKkKbKpKlKLLoKfPhKkobKpKlKmHHbfKhPkKLLpKlomKoKfKhPPhbKpKlKFLoKfohKOKBOpKlhmKPbfKkhkKBOMflKmhoKHPhKkKbKpKpLmKoKfKhokKbKpKLOLKoKfhhKmObKpKlKmHbpfKhHkKbppKlomKoofKhKoKbKpKlKmOoKfKhKkKbmpKlhmKoOfKhokKbPMhlKmKoKKbhKkobKPOPKmKohfKKbkKbKpKkKKLoKfhhKkhbKPolKMOoKfKhHkKhlpKlKmKoKfKhKkhbKpOlKmOoKFOhKkKbHpKMbmKoKfKmKkKbKpHlKmHoKFohKKObKpKlmmKlofKhKkKbKpKlKmHoKfOhKkObKPOlKmKomfKKbkKbKpKkKmKoKfmhKkmbKPolKMOoKfKhMkKBhpKlKmKoKfKhKkmbKpOlKmOoKFOhKkKbMpKMbmKoKfKmKkKbKpMlKmMoKFohKKObKpKLbmKMFfKhKkKbKpKlKmMoKfOhKkObKPOlKmKObfKKbkKbKpKkKmKoKFbhKKbbKPolKMOoKfKHBkKBhpKlKmKoKfKhKKbbKpOlKmOoKFOhKkKBBpKMbmKoKfKmKkKbKPBlKMBoKFohKKObKpKLfmKMFfKhKkKbKpKlKMBoKfOhKkObKPOlKmKOffKKbkKbKpKkKmKoKFfhKKfbKPolKMOoKfKHFkKBhpKlKmKoKfKhKKfbKpOlKmOoKFOhKkKBFpKMbmKoKfKmKkKbKPFlKMFoKFohKKObKpKLlmKMFfKhKkKbKpKlKMFoKfOhKkObKPOlKmKOlfKKbkKbKpKkKmKoKFlhKKlbKPolKMOoKfKHLkKBhpKlKmKoKfKhKKlbKpOlKmOoKFOhKkKBLpKMbmKoKfKmKkKbKPLlKMLoKFohKKObKpKLkmKMFfKhKkKbKpKlKMLoKfOhKkObKPOlKmKOkfKKbkKbKpKkKmKoKFkhKKkbKPolKMOoKfKHKkKBhpKlKmKoKfKhKKkbKpOlKmOoKFOhKkKBKpKMbmKoKfKmKkKbKPKlKMKoKFohKKObKpKLomKlofKhKkKbKpKlKMKoKfOhKkObKPOlKmKOofKKbkKbKpKkKmKoKFohKKobKPolKMOoKfKHOkKBhpKlKmKoKfKhKKobKpOlKmOoKFOhKkKBOpKMbmKoKfKmKkKbKPOlKMOoKFohKKObKpKLpmKMFfKhKkKbKpKlKMOoKfOhKkObKPOlKmKOpfKKbkKbKpKkKmKoKFphKKpbKPolKMOoKfKHPkKBhpKlKmKoKfKhKKpbKpOlKmOoKFOhKkKBPpKMbmKoKfKmKkKbKPPlKMPoKFohKKObKpKLhmKMFfKhKkKbKpKlKMPoKfOhKkObKPOlKmKOhfKKbkKbKpKkKmKoKFhhKKhbKPolKMOoKfKHHkKBhpKlKmKoKfKhKKhbKpOlKmOoKFOhKkKBHpKMbmKoKfKmKkKbKPHlKMHoKFohKKObKpKLmmKMFfKhKkKbKpKlKMHoKfOhKkObKPOlKmKOmfKKbkKbKpKkKmKoKFmhKKmbKPolKMOoKfKHMkKBhpKlKmKoKfKhKKmbKpOlKmOoKFOhKkKBMpKMbmKoKfKmKkKbKPMlKMMoKFohKKObKpKkbmKMFfKhKkKbKpKlKMMoKfOhKkObKPOlKmKpbfKKbkKbKpKkKfPoKlbhKobbKPolKMOpHfKmBkKBhpKlKmKoKfKhKobbKpOlKmOoKFOhKkKfBpKMbmKoKfKmKkKbKhBlKbBoKFohKKObKpKkfmKMFfKhKkKbKpKlKbBoKfOhKkObKPOlKmKpffKKbkKbKpKkKmKoKlfhKofbKPolKMOoKfKmFkKBhpKlKmKoKfKhKofbKpOlKmOoKFOhKkKfFpKMbmKoKfKmKkKbKhFlKbFoKFohKKObKpKklmKMFfKhKkKbKpKlKbFoKfOhKkObKPOlKmKplfKKbkKbKpKkKmKoKllhKolbKPolKMOoKfKmLkKBhpKlKmKoKfKhKolbKpOlKmOoKFOhKkKfLpKMbmKoKfKmKkKbKhLlKbLoKFohKKObKpKkkmKMFfKhKkKbKpKlKbLoKfOhKkObKPOlKmKpkfKKbkKbKpKkKmKoKlkhKokbKPolKMOoKfKmKkKBhpKlKmKoKfKhKokbKpOlKmOoKFOhKkKfKpKMbmKoKfKmKkKbKhKlKbKoKFohKKObKpKkomKMFfKhKkKbKpKlKbKoKfOhKkObKPOlKmKpofKKbkKbKpKkKmKoKlohKoobKPolKMOoKfKmOkKBhpKlKmKoKfKhKoobKpOlKmOoKFOhKkKfOpKMbmKoKfKmKkKbKhOlKbOoKFohKKObKpKkpmKlKfKhKkKbKpKlKbOoKfOhKkObKPOlKmKppfKKbkKbKpKkKmKoKlphKopbKPolKMOoKfKmPkKBhpKlKmKoKfKhKopbKpOlKmOoKFOhKkKfPpKMbmKoKfKmKkKbKhPlKbPoKFohKKObKpKkhmKMFfKhKkKbKpKlKbPoKfOhKkObKPOlKmKphfKKbkKbKpKkKmKoKlhhKohbKPolKMOoKfKmHkKBhpKlKmKoKfKhKohbKpOlKmOoKFOhKkKfHpKKlmKoKfKmKkKbKhHlKbHoKlHhKKKbKpKlhmKpBfKmHkKBOpKlKbHoKmOhKkKbKhKlKmKpHfKmHkKhfpKkKmKoKlHhKoHbKKBlKMKoKfKhhkKhfpKkHmKPKfKhKkHbKbLlKmooKFKhKkKbHpKkBmKohfKHOkKbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKMFhKkKbKPOlKmKpMfKOFkKbKpKLOmKoKLbhKFFbKpKlKmKoKfKmHkKFbpKlOmKOKfKhKkHbKPklKbHoKLKhKkKbHpKoBmKpmfKHOkKbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKmLhKkKbKPOlKmKpMfKMHkKbKpKLOmKoKLbhKoFbKpKlKmKoKfKmHkKFbpKlOmKOKfKhKkHbKkFlKbHoKFOhKkKfHpKkpmKoKfKmKkKbKhHlKbHoKFohKKObKpKkmmKbffKhKkKBOpKlKbMoKMFhKkKbKPOlKmKPbfKBLkKbKpKLOmKoKLBhKFFbKpKlKmKmofKmHkKFBpKlOmKOKfKhKkHbKKPlKbHoKFOhKkKfHpKkpmKoKfKmKkKbKhHlKbHoKFohKKObKpKkmmKLFfKhKkKBOpKlKbMoKKHhKkKbKPOlKmKPbfKOFkKbKpKLOmKoKLBhKHLbKpKlKmKoKfKmHkKFBpKlOmKOKfKhKkHbKfllKbHoKFKbmkKbmpKkBmKoHfKMKmKbKpMlKlLoKkfhKKKbKpKlMmKpBfKhHkKBOpKlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKKFbKpKlKMOoKfKmMkKBFpKlKmKOOfKhKObbKPFlKmKoKfKhKkKfHpKKbmKoOfKHKkKbKpMlKMkoKlHhKOKbKpKlMmKhBfKmbkKBOBPlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOmKoKlmhKPlbKpKlKMOoKfKmMkKHFpKlKmKOOfKhKObbKKFlKmKoKFOhKkKFBpKBFmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKlMmKLPfKmHkKBOpKlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOLpoKlmhKFFbKpKlKMOMbfKmMkKPlpKlKmKOOfKhKObbKKFlKmKoKFOhKkKFBpKKMmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKlMmKblfKmHkKBOpKlKbHoKmOhKkKbKhKlKmKpHfKmHkKohpKkKmKoKlHhKoHbKmblKMKoKfKhMkKohpKkHmKPKfKhKkMbKpPlKlMoKFOBLkKfHpKlmmKoKfKmKkKbKhHlKbHoKfphKKObKpKkmmKbPfKhKkKBOpKlKbMoKpPhKkKbKPOlKmKPbfKlPkKbKpKlKmKoKlHhKObbKpOlKMKoKfKhMkKFfpKkHmKPKfKhKkMbKLBlKBOoKLKhKkKbMpKmMmKLKfKMKkKbKpMlKppoKLOhKoKlPpKkHmKoMfKFbkKfKmolKbHoKlHhKMlbKpHhpmKpMfKhPkKbopKlOmKoKlKhKkKbKpHlKmKoKfKmKkKbKpKkPmKoKfKhKoObKhHlKbMoKfohKKKbKpKLbmKpBfKhMkKFKpKlKMBoKoLhKhBbKPKlKmKOBfKmBkKbHpKLOmKoKlHhKkmbKpKlKbKoKfKmHkKfHpKlpmKOOfKhKombKlLlKmKoKFOhKkKfMpKmLmKoKfKHOkKbKHblKoLoKfKhKkKbKpKkHmKPbfKhOkKBKmmlKMBoKFkhKoHbKPOPPmKpHfKmpkKbKpKkKmKoKlHhKoHbKPolKMOoKfKmmkKpfpKlKmKOOfKhKoMbKKFlKmKoKFOhKkKFbpKpPmKoKfKHOkKbKHBlKPFoKfKhKkKbKpKkHmKPBfKhOkKBKpKlKMBoKMPhKoHbKPOlKmKpHfKmpkKbKpKkKmKoKlHhKoHbKPolKMOMpfKmmkKHFpKlKmKOOObhKoMbKmHlKmKoKFOhKkKFbpKBFmKoKfKHOkKbKHBlKpLoKfKhKkKbKpKkHmKPBfKhOkKBKpKlKMBoKplhKoHbKPOlKmKpHfKoOkKbKpKkKmKoKlHhKoHbKfhlKbKoKfKmHkKfHpKobmKOKfKhKKBbKfhlKbHoKLKhKkKBBpKlPmKfofKHOPLbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKpPhKkKbKPOlKmKpMfKlPkKbKpKLOmKoKLbhKmPbKpKlKmKoKfKmHkKFbpKlOmKOKfKhKKBbKHflKbHoKLKhKkKBBpKMBmKPOfKMKkKbKPBlKoMoKMKhKOKbKpKLBmKlpfKMOkKfKmPlKbHoKFBhKHbbKhKoomKpHfKmHkKOlpKlHkpoKlMhKkobKpolKMfoKfKmKkKbKpKLBmKoKfKhKoKbKpKlKbBoKfKhKkKfKpKlKmKpFfKhKkKbKhKlKmKoKFHhKkKbKpKkKmKoKfKHMkKbKpKlKbKoKfKhKKFbKpKlKmKpKfKhKkKBLpKlKmKoKlKhKkKbKPOlKmKoKfKmKkKbKpKLPmKoKfKhKoKbKpKlKbLoKfKhKkKfKpKlKmKpKfKhKkKbKhOlKbHoKlMhKkobKPKlKmKOffKmBkKBBpKKKmKoKFFhKhLbKPmlKMKoKfKHFkKfBpKlHmKOOfKhKoHbKpmlKmKoKlKhKkKfHpKkHmKopfKHOkKbKhmlKoLoKfKhKKObKpKkMmKfLfKhKkKBOpKlKBboKhLhKkKbKpKlKmKpHfKMbkKbOpKLKfmoKFFhKKkbKhHlKMOMPfKmHkKfppKlKmKpKfKhKoHbKhHlKMooKFOhKkKfmpKmfmKoKfKHOkKbKhMlKPFoKfKhKKObKpKKbmKOKfKhKkKBOpKlKBBoKMFhKkKbKpKlKmKpHfKMBkKbOpKLKmKoKFFhKFPbKhHlKMOoKfKmHkKfppKlKmKpKfKhKoHbKhHlKMooKFOFpkKfmpKBFmKoKfKHOHbbKhMlKfHoKfKhKKObKpKKbmKLFfKhKkKBOpKlKBBoKmLhKkKbKpKlKmKpHfKMBkKbOpKLKmKoKFFhKmlbKhHlKMOoKfKmHkKhOpKlKmKpKfKhKoHbKhHlKkhoKlKhKkKfHpKkHmKhbfKHKkKbKPFlKkhoKlHhKOKbKpKLFmKoPfKlpkKBOMLlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKmPbKpKlKMOoKfKmMkKoPpKlKmKOOfKhKObbKfPlKmKoKfKhKkKfHpKKbmKoOfKHKkKbKPFlKBfoKlHhKOKbKpKLFmKFBfKMOkKFKpKlKMFoKhMhKFKbKHKlKmKOFfKopkKFOpKkKfPoKlHhKKFbKBblKbKhofKmHkKfHpKHlmKoHpphKoMbKPFlKmooKFfhKkKfKpKlKmKOFfKhKkKbKhKlKmKoKlBhKkKbKpKkKmKoKfKmFkKbKpKlKbKoKfKhKKObKpKlKmKpKfKhKkKBPpKlKmKoKlKhKkKbKhLlKmKoKfKmKkKbKpKkKmKoKfKhKoKbKpKlKMBoKfKhKkKfKpKlKmKOLfKhKkKbKhKlKmKoKFHhKkKbKpKkKmKoKfKHMkKbKpKlKbOoKlHhKoMbKpolKMKoKfKHlkKfBpKLFmKPKfKhKKLbKbLlKOkoKFKhKkKBLpKkBmKoHfKHOkKbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKhLhKkKbKPOlKmKpMfKkLkKbKpKLOmKoKLbhKbLbKpKlKmKoKfKmHkKFbpKlOmKOKkmhKKLbKPklKbHoKFOFPkKfHpKkpmKoKfKmKkKbKhHlKbHoKFohKKObKpKkmmKfffKhKkKBOpKlKbMoKMFhKkKbKPOlKmKPbfKmfkKbKpKLOmKoKLBhKFFbKpKlKmKoKfKmHkKFBpKlOmKOKfKhKKLbKKPlKbHoKFOhKkKfHpKkpmKoKfKmKkKbKhHlKbHoKFohKKOKppKkmmKLFfKhKkKBOBblKbMoKkHhKkKbKPOlKmKPbfKOFkKbKpKLOmKoKLBhKfLbKpKlKmKoKfKmHkKFBpKlOmKOKfKhKKLbKfllKbHoKFOhKkKfHpKbOmKoKfKmKkKbKhHlKbHoKphhKoKbKpKkHmKpHfKbbkKBKpKlKMLoKphhKoHbKHKlKmKOLfKhPkKKkpKLOFLoKlHhKkmbKpKlKbKoKfKmHkKfHpKlpmKOOfKhKombKfPlKmKoKFOhKkKfMpKhPmKoKfKHOkKbKHblKkPoKfKhKkKbKpKkHmKPbfKhOkKBKpKlKMLoKLfhKoHbKHKlKmKOLfKKBkKFOpKKKmKoKFLhKbMbKKKlKBKoKfKHLkKhppKKOmKpKkPhKoHbKPLlKLboKlKbokKfHpKkHmKBlfKhHmpbKhMlKMBoKfohKKfbKpKkKmKoKfKHLkKbKpKlKbKoKfKhKKHbKpKlKmKpKfKhKkKBMpKlKmKoKlKhKkKbKPOlKmKoKfKmKkKbKpKLPmKoKfKhKoKbKpKlKbLoKfKhKkKfKpKlKmKpKfKhKkKbKhKlKmKoKFBhKkKbKpKkKmKoKfKHFkKbKpKlKbKoKfKhKoBbKpKlKmKpKfKhKkKfFpKlKmKoKkHhKoHbKhMlKmooKFKhKkKBkpKkBmKOLfKMKkKbKPKlKlLoKoFhKKKbKpKLKmKpBfKhHkKBOpKlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKbLbKpKlKMOoKfKmMkKpLpKlKmKOOfKhKObbKlLlKmKoKfKhKkKfHpKKbmKoOfKHKkKbKPKlKMkoKlHhKKObKpKkHmKppfKhKkKfKpKlKbHoKlHhKKobKPOlKmKpmfKLHkKbKpKLOmKoKlMhKFFbKpKlKMOoKfKMbkKpBpKlKmKOOfKhKOBbKKFlKmKoKfKhKkKfHpKKBmKoOfKHKkKbKPKlKPPoKlHhKKObKpKkHmKppfKhKkKfKpKlKbHoKlHhKKobKPOlKmKpmfKOFkKbKpKLOmKoKlMhKFkbKpKlKMOoKfKMbkKHFpKlKmKOOfKhKOBbKKklKmKoKfKhKkKfHpKKBmKoOfKHKkKbKPKlKkloKlHhKKKbKpKLomKpBfKHKkKFKpKlKMOoKoLhKMFbKPKlKmKOOfKmBkKBKpKLOmKoKlHhKkmbKpKlKbKoKfKmHkKfHpKlpmKOOfKhKombKmLlKmKoKFOhKkKfMpKoLmKoKfKHOkKbKHblKfLoKfKhKkKbKpKkHmKPbfKhOkKBKpKlKMOoKFkhKoHbKHKlKmKOOfKbBkKKBpKLOmKoKlHhKopbKpKlKbKoKfKmHkKfHpKLomKOOfKhKombKFKlKmKoKFOhKkKfMpKBFmKoKfKHOkKbKHblKFmoKfKhKKObKpKKBmKLFfKhKkKbKpKlKbHoKLBhKkObKPKlKmKOOfKOPkKfHpKLOmKoKlHhKopbKpKlKbKoKfKmHkKfHpKLomKOOfKhKombKKFlKmKoKFOhKkKfMpKokmKoKfKHOkKbKHblKPFoKfKhKKObKpKKBmKOMfKhKkKbKpKlKbHoKLBhKkObKPKlKmKOOfKllkKfHpKLOmKoKlHhKfObKpKlKbKoKfKmHkKfHpKhhmKpKfKhKoHbKhHlKfboKFKhKkKBOpKhhmKpHfKMKkKbKPOlKmPoKPLhKKObKpKkHmKomfKhKkKfKpKlKbHoKlHhKkpbKPOlKmKpmfKlPkKbKpKLOmKoKlMhKmPbKpKlKMOoKfKMbkKoPpKlKmKoKfKhKoHbKHblKmOoKFKhKkKBOpKKfmKpHfKMKkKbKPOlKOBoKLOhKOKbKpKLOmKfMfKOKkKFKpKlKMOoKmphKOObKhKlKmKpHfKHOkKKbpKkKmKoKlHhKoHbKFllKmOPlfKmMkKBfpKlKmKoKlOhKoHbKhMlKmooKFKhKkKBppKkBmKOOfKMKkKbKPPlKlLoKKkhKKKbKpKLPmKpBfKHKkKBOpKlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKpLbKpKlKMOoKfKmMkKlLpKlKmKOOfKhKObbKmLlKmKoKfKhKkKfHpKKbmKoOfKHKpmbKPPlKMkoKlHhKKOKPpKkHmKppfKhKkKfKpKlKbHoKlHhKKobKPOlKmKpmfKlHkKbKpKLOmKoKlMhKFFbKpKlKMOoKfKMbkKLFpKlKmKOOfKhKOBbKKFlKmKoKfKhKkKfHpKKBmKoOfKHKkKbKPPlKPPoKlHhKKObKpKkHmKppfKhKkKfKpKlKbHoKlHhKKobKPOPpmKpmfKOFkKbKpKLOLboKlMhKpkbKpKlKMOoKfKMbkKHFpKlKmKOOfKhKOBbKPMlKmKoKfKhKkKfHpKKBmKoOfKHKkKbKPPlKkloKlHhKKObKpKkHmKlOfKhKkKfKpKlKbHoKlHhKmhbKhKlKmKpHfKmHkKlbpKLKmKoKFPhKmhbKhHlKBKoKfKHPkKbPpKHLmKOOKLhKoHbKpmlKmKoKlKhKkKfHpKkHmKopfKHOkKbKhmlKkPoKfKhKKObKpKkMmKbPfKhKkKBOpKlKBboKpPhKkKbKpKlKmKpHfKMbkKbOpKLKmKoKFPhKOfbKhHlKBKoKfKHPkKPBpKKOmKPKfKhKKPbKlMlKPKoKLKhKkKBPpKbpmKPOfKmKpPbKhHlKMPoKObhKoKlopKkHmKpHfKLlkKbOHllKbMoKFlhKkKbKpKkOmKpHfKmMkKbopKLKmKoKFhhKoBbKPPlKBKoKfKHHkKkLpKmlmKOKfKhKKHbKhBlKMKoKFOhKkKfHpKlmmKoKfKmKkKbKhHlKbHoKfphKKObKpKkmmKhLfKhKkKBOpKlKbMoKkLhKkKbKPOlKmKPbfKbLkKbKpKlKmKoKlHhKObbKpOlKMKhmfKHHkKBkpKkHmKOOOPhKoHbKhplKmKoKlKhKkKfHpKkHmKOofKHOkKbKhmlKlOoKfKhKKObKpKkMmKLFfKhKkKBOpKlKBboKmMhKkKbKPOlKmKPBfKOFkKbKpKlKmKoKlHhKOBbKpOlKMKoKfKHHkKHPpKkHmKOOfKhKoHbKhplKmKoKlKhKkKfHpKkHmKOofKHOHpbKhmlKPFoKfKhKKObHpKkMmKmffKhKkKBOpKlKBboKMFhKkKbKPOlKmKPBfKmLkKbKpKlKmKoKlHhKOBbKpOlKMKoKfKHHkKolpKkHmKPKfKhKKHbKLplKLpoKFOhKkKfHpKbOmKoKfKmKkKbKhHlKbHoKphhKoKbKpKkHmKpHfKbbkKBKpKlKMHoKphhKoHbKHKKPmKOHfKhPkKPHpKLOFLoKlHhKkmbKpKlKbKoKfKmHkKfHpKlpmKOOfKhKombKfPlKmKoKFOhKkKfMpKhPmKoKfKHOkKbKHblKkPoKfKhKkKbKpKkHmKPbfKhOkKBKpKlKMHoKLfhKoHbKHKlKmKOHfKKBkKFOpKKKmKoKFHhKbMbKKKlKBKoKfKHHkKhppKKOmKpKkPhKoHbKPHlKLboKlKbokKfHpKkHmKBlfKhOOlbKhMlKMboKfKhKkKfOpKkHmKpMfKhokKBKpKlKMmoKlBhKKHbKHKlKmKOMfKfLkKLfpKLKmKoKFMhKoBbKPKlKMOoKfKmHkKbmpKlKmKpKfKhKoHbKhHlKmpoKFOhKkKfmpKoLmKoKfKHOkKbKhMlKfLoKfKhKKObKpKKbmKhLfKhKkKbKpKlKbHoKLbhKkObKPKommKOMfKHkkKfHpKLOLPoKlHhKopbKpKlKbKoKfKmHkKfHpKLomKOOfKhKombKbOlKmKoKFOhKkKfMpKBFmKoKfKHOkKbKHblKFhoKfKhKKObKpKKBmKLFfKhKkKbKpKlKbHoKLBhKkObKPKlKmKOMfKOPkKfHpKLOmKoKlHhKopbKpKlKbKoKfKmHkKfHpKLomKOOOphKombKKFlKmKoKFOhHkKfMpKpfmKoKfKHOkKbKHblKPFoKfKhKKObKpKKBmKOMfKhKkKbKpKlKbHoKLBhKkObKPKlKmKOMfKllkKfHpKKKmKoKFMhKBpbKBplKMOoKfKmHkKhOpKlKmKpKfKhKoHbKhHlKkhoKlKhKkKfHpKkHmKhbfKHKkKbKPMlKkhoKlHhKOKFPpKLMmKoPfKlLkKBOMLlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKmPbKpKlKMOoKfKmMkKoPpKlKmKOOfKhKObbKfPlKmKoKfKhKkKfHpKKbmKoOfKHKkKbKPMlKBfoKlHhKOKbKpKLMmKFBfKMOkKFKpKlKMMoKhMhKFKbKHKlKmKOMfKopkKFOpKkKfPoKlHhKKMbKBblKbKhofKmHkKfHpKHlmKoOLlhKoMbKpOlKmKoKfKmOkKfHpKkMmKoofKHKkKbKhblKbBoKFMhKOKbKpKkBmKmLfKkkkKBKpKlKbBoKlBhKKKbKPOlKmKpHfKhmkKbKpKkKmKoKlHhKoHbKpplKMOoKfKmmkKlLpKlKmKOOfKhKoMbKmLlKmKoKFOhKkKFbpKoLmKoKfKhKkKbKhHlKBboKfOhKKKlmpKkBmKOkfKmHkKBOBPlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOmKoKlmhKOKbKpKlKMOoKfKmMkKHFpKlKmKOOfKhKObbKkklKmKoKFOhKkKFBpKBFmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKkBmKLPfKmHkKBOpKlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOLpoKlmhKFFbKpKlKMOoHfKmMkKlkpKlKmKOOfKhKObbKKFlKmKoKFOhKkKFBpKLMmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKkBmKblfKmHkKFKpKlKbBoKHphKHpbKPOlKmKpHfKoOkKbKpKkKmKoKlHhKoHbKfhlKbKoKfKmHkKfHpKobmKOKfKhKoBbKfhlKbHoKLKMPkKfBpKlPmKpOfKHOPLbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKpPhKkKbKPOlKmKpMfKlPkKbKpKLOmKoKLbhKmPbKpKlKmKoKfKmHkKFbpKlOmKOKfKhKoBbKHflKbHoKLKhKkKfBpKMBmKPOfKMKkKbKhBlKoMoKMKhKOKbKpKkBmKlpfKMOkKfKmPlKbHoKlBhKHbbKhKoomKpHfKmHkKOlpKlOBloKlMhKkKbKpKlKmKpOfKmHkKfMpKlomKOKfKhKofbKhBlKbBoKLKhKkKfFpKpLmKPBfKHKkKbKhFlKbBoKFKhKKObKpKkHmKomfKhKkKfKpKlKbHoKlHhKkpbKPOlKmKpmfKbLkKbKpKLOmKoKlMhKpLbKpKlKMOoKfKMbkKlLpKlKmKoKfKhKoHbKHblKmOoKFKbmkKfFpKLkmKpHfKHOHPbKhHlKbpoKfKhKoKbKpKkHmKpHfKHokKBOpKlKbmoKLKhKkKbKPOlKmKpMfKOFkKbKpKLOmKoKLbhKMpbKpKlKMOoKfKMBkKHFpKlKmKoKfKhKoHbKHBlKmOoKFKhKkKfFpKBPmKpHfKHOkKbKhHlKbpoKfKhKoKbKpKkHmKpHfKHokKBOBplKbmoKMFhKkKbKPOlHmKpMfKbkkKbKpKLOmKoKLbhKFFbKpKlKMOoKfKMBkKBMpKlKmKoKfKhKoHbKHBlKmOoKFKhKkKfFpKhlmKpHfKMKkKbKhFlKOpoKOphKKObKpKkHmKlOfKhKkKfKpKlKbHoKlHhKmhbKhKlKmKpHfKmHkKlbpKLKmKoKlFhKmhbKhHlKBKPPfKmFkKbPpKHfmKOOKLhKoHbKpmlKmKoKlKhKkKfHpKkHmKopfKHOkKbKhmlKkPoKfKhKKObKpKkMmKbPfKhKkKBOpKlKBboKpPhKkKbKpKlKmKpHfKMbkKbOpKLKmKoKlFhKOfbKhHlKBKoKfKmFkKPBpKKOmKPKfKhKoFbKlMlKPKoKLKhKkKfFpKbpmKPOfKmKpPbKhHlKbFoKObhKoKlopKkHmKpHfKLlkKbOHllKbMoKFohKkKbKpKkOmKpHfKmMkKbopKLKmKoKllhKoBbKhFlKBKoKfKmLkKkLpKmFmKOKfKhKoLbKhBlKMKoKFOhKkKfHpKlmmKoKfKmKkKbKhHlKbHoKfphKKObKpKkmmKhLfKhKkKBOpKlKbMoKkLhKkKbKPOlKmKPbfKbLkKbKpKlKmKoKlHhKObbKpOlKMKhmfKmLkKBkpKkHmKOOOPhKoHbKhplKmKoKlKhKkKfHpKkHmKOofKHOkKbKhmlKKKoKfKhKKObKpKkMmKLFfKhKkKBOpKlKBboKFphKkKbKPOlKmKPBfKOFkKbKpKlKmKoKlHhKOBbKpOlKMKoKfKmLkKHPpKkHmKOOfKhKoHbKhplKmKoKlKhKkKfHpKkHmKOofKHOHpbKhmlKPFoKfKhKKOKbpKkMmKhkfKhKkKBOpKlKBboKMFhKkKbKPOlKmKPBfKHMkKbKpKlKmKoKlHhKOBbKpOlKMKoKfKmLkKolpKkHmKOOfKhKoHbKkOlKmKoKlKhKkKfHpKkHmKbhfKmKkKbKhHlKbHoKkbhKKKbKpKkLmKbhfKmHkKFKpKlKbLoKfPhKHObKPOOLmKpHfKhmkKbKpKkKmKoKlHhKoHbKpplKMOoKfKmmkKoPpKlKmKOOfKhKoMbKfPlKmKoKFOhKkKFbpKhPmKoKfKhKkKbKhHlKBboKfOhKKKbKpKkLmKPffKmHkKFKpKlKbLoKHBhKOObKHKlKmKpLfKkMkKHKpKKKmKoKlLhKfpbKHOlKbKhPfKmHkKfLpKPbmKpKkohKoHbKhHlKKloKfOMlkKfMpKlMmKoKfKhKoObKhHlKbMoKfohKKKbKpKkkmKpBfKmLkKFKpKlKbKoKoLhKHHbKPKlKmKpKfKmBkKBKpKLOmKoKlHhKkmbKpKlKbKoKfKmHkKfHpKlpmKOOfKhKombKmLlKmKoKFOhKkKfMpKoLmKoKfKHOkKbKHblKfLoKfKhKkKbKpKkHmKPbfKhOkKBKmmlKbKoKFkhKoHbKPOPPmKpHfKmpkKbKpKkKmKoKlHhKoHbKPolKMOoKfKmmkKoHpKlKmKOOfKhKoMbKKFlKmKoKFOhKkKFbpKlhmKoKfKHOkKbKHBlKPFoKfKhKkKbKpKkHmKPBfKhOkKBKpKlKbKoKMPhKoHbKPOlKmKpHfKmpkKbKpKkKmKoKlHhKoHbKPolKMOMpfKmmkKHFpKlKmKOOObhKoMbKmklKmKoKFOhKkKFbpKBFmKoKfKHOkKbKHBlKMMoKfKhKkKbKpKkHmKPBfKhOkKBKpKlKbKoKplhKoHbKPOlKmKpHfKoOkKbKpKkKmKoKlHhKoHbKfhlKbKoKfKmHkKfHpKobmKOKfKhKoKbKfhlKbHoKLKhKkKfKpKlPmKMOfKHOPLbKhHlKmmoKfKhKoKbKpKkHmKpHfKhpkKBOpKlKbmoKpPhKkKbKPOlKmKpMfKlPkKbKpKLOmKoKLbhKmPbKpKlKmKoKfKmHkKFbpKlOmKOKfKhKoKbKHflKbHoKLKhKkKfKpKMBmKPOfKMKkKbKhKlKoMoKMKhKOKbKpKkKmKlpfKMOkKfKmPlKbHoKlKhKHbbKhKoomKpHfKmHkKOlpKlOBloKlMhKKKbKpKlKmKhffKmHkKfMpKlomKOKfKhKoobKhBlKbKoKLKhKkKfOpKpLmKpPfKHKkKbKhOlKbBoKfHhKKObKpKkHmKomfKhKkKfKpKlKbHoKlHhKkpbKPOlKmKpmfKkLkKbKpKLOmKoKlMhKbLbKpKlKMOoKfKMbkKpLpKlKmKoKfKhKoHbKHblKmOoKFKhKkKfOpKLkmKpHfKHOkKbKhHlKbpoKfKhKoKbKpKkHmKpHfKHokKBOpKlKbmoKMFhKkKbKPOlKmKpMfKmMkKbKpKLOmKoKLbhKFFbKpKlKMOoKfKMBkKFMpKlKmKoKfKhKoHbKHBlKmOoKFKhKkKfOpKhlmKpHfKHOkKbKhHlKpOoKfKhKoKbKpKkHmKpHfKlhkKfKpKlKbHoKlHhKpbbKPKlKmKpOfKlhkKfHpKKKmKoKlOhKkPbKbmlKMOoKfKmHkKbmpKlKmKpKfKhKoHbKhHlKmpoKFOhKkKfmpKhPmKoKfKHOkKbKhMlKkPoKfKhKKObKpKKbmKbPfKhKkKbKpKlKbHoKLbhKkObKPKlKmKpOfKMfkKfHpKKKmKoKlOhKBBbKHOlKBKoKfKmOkKpMpKBKmKPKfKhKoObKkplKBOoKFKhKkKfppKkBmKpOfKMKkKbKhPlKlLoKOMhKKKbKpKkPmKpBfKhhkKBOpKlKbHoKfmhKkKbKhKlKmKpHfKmHkKbppKLOmKoKlmhKmPbKpKlKMOoKfKmMkKoPpKlKmKOOfKhKObbKfPlKmKoKfKhKkKfHpKKbmKoOfKHKkKbKhPlKMkoKlHhKOKbKpKkPmKhBfKKLkKBOpKlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOmKoKlmhKFObKpKlKMOoKfKmMkKHFpKlKmKOOfKhKObbKKhlKmKoKFOhKkKFBpKBFmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKkPmKLPfKmHkKBOpKlKbHoKlphKkKbKhKlKmKpHfKmHkKBopKLOmKoKlmhKFFbKpKlKMOoKfKmMkKpmpKlKmKOOfKhKObbKKFlKmKoKFOhKkKFBpKpKmKoKfKhKkKbKhHlKBBoKfOhKKKbKpKkPmKblfKmHkKBOpKlKbHoKmOhKkKbKhKlKmKpHfKmHkKohpKkKmKoKlHhKoHbKmblKMKoKfKmPkKohpKkHmKPKfKhKoPbKpPlKLMoKFOhKkKfHpKlmmKoKfKmKkKbKhHlKbHoKfphKKObKpKkmmKbPfKhKkKBOpKlKbMoKMFhKkKbKPOlKmKPbfKOFkKbKpKlKmKoKlHhKObbKpOlKMKoKfKmPkKFfpKkHmKPKfKhKoPbKLBlKBOoKLKhKkKfPpKmMmKLKfKMKkKbKhPlKppoKLOhKoKbKpKkHmKpPfKFbkKfKpKlKbHoKlHhKMlbKpHhpmKpMfKHLkKbopKlOmKoKlKhKkKbKhPlKmKoKfKmKkKbKpKlHmKoKfKhKmmbKhHlKbMoKfohKKKlmpKkhmKpBfKmPkKbKbLlKmKoKfohKkKbKPOlKmKoKfKhmkKbKpKlKmhoKfKhKpoKhBOpoBooKfmhKkKbKMKPFlobbohFOHpFfpmlKmKoKkPfhHpKPBOPkkbLmFfhKkKbKMFPklpmoOFBKHFkofbphLOLmfPhKkKbKbmpoLlmhHFHBkKbKpKOhLKMKohFOPPKkBOPpLkPfFbhKkKbKbppMloMOoofpHPkhBOLbmKoKfKHOpkbKpKlKmhoKfKhKoKbKpKlKmKoKfKhOkKfKpKlKmKoKfKhKkPbKhKlKmKoKfKhKkKbmpKkKmKoKfKhKkKbKpHlKbKoKfKhKkKbKpKlomKpKfKhKkKbKpKlKmpoKfKhKkKbKpKlOmKoofKhKkKbKpKlKmooKfKhKkKbKpKlKmKopfKhKkKFlpKKfmmoKfKhKPHKbBpPblOMFohlpkoBmpKlKmKoKPBhKkKbKpKlKmKoKLKhKkKbKpKlOmKoofKhKkKbKpKlKmooKfKhKOKbKpKlKmKoOfKhokKbKpKlKmKoKfOhKkKbKHKlKmKoKfKhOkKbopKlKmKoKfKhKkpbKpKlKBKoKfKhKkKbOpKlomKoKfKhKkKbKpPlKmKoKLKhKkKbKpKlOmKoofKhKkKbKpKlKmhoKfKhKOKbKpKlKmKoOfKhpkKbKpKlKmKoKfHhKkKbKHKlKmKoKfKhOkKbppKlKmKoKfKhKkmbKpKlKBKoKfKhKkKbOpKlpmKoKfKhKkKbKpMlKmKoKLKhKkKbKpKlOmKopfKhKkKbKpKlKMboKfKhKOKbKpKlKmKoOfKhpkKbKpKlKmKoKFBhKkKbKHKlKmKoKfKhOkKbppKlKmKoKfKhKkobKpKlKmKoKfKhKkKbmpKlKmKFFfPhKkKbKbmpoLlmhfKHfkKbKpKOFLkmpooFFPKKFbohblhMOfKHbkKbKpKpplMmoOOfohpKPbhPOOFomfKhKkKLKBFpokbmhOOFpFmbhpKlKmKhoOhFOhoFofoLlmKoKfKBOHbkmbMPPFhMKOKfhHOLFbhpmOFomfKhKkKlPbhPpLPMOOklbKbbKpKlKMOhkfKhKkKbopKlKmKpKfKhKkKbKpKlKmPoKlKhKkKbKpKlKmKoOfKmKkKbKpKlKmKoKfphKoKbKpKlKmKoKfKhHkKfKpKlKmKoKfKhKkhbKhKlKmKoKfKhKkKbmpKlKmKoKfKhKkObKpolKmKoKfKhKkKbopKlKmKoKfKhKkKbKpolKmKoKfKhhkKbKpKPKLOMbOLFPkPbKpKlKMOMKfKhKkKbopKlKmKoKpfhKkobKpKlKmKoKfKhmkKbKpKlOmKoofKhKhLbKpKlKmooKfKhKkKbKpKlKmKopfKhKkKmbpohommoKfKhKPHKbBpPblOMFohBMkKbhpKlKmKoKKlhKkKbKpKlKmKoKLKhKkKbKpKlOmKopfKhKkKbKpKlKmooKfKhKOKbKpKlKmKoOfKhokKbKpKlKmKoKfohKkKbKpKlKmKoKfOhOkKbKpKMFmhoKfKhKHKkpboPFLFkffKhKkKbKpKlKmKoKllhKkKbKPOPpmKoOfKhOkKbKpKLOLpoKfphKkObKpKlKMOMKfKhPkKbopKlKmKoHpphKkhbKpKlKmooKfPhKkKfKpKlKmKoOfKhKkKbKhKlKmKoKfKhKkKbKpKkKmKoKfKhpkKbKpKlKbKoKfKhKkobKpKlKmKomfKhPkKbOpKlomKoHFfhKkKbKPFlKmooKfohKkPLhpKlKmKOFfKhokKbPMhlKmKoKlbhKkobKpHKOmKoKfKmbkKbopKlomKoPKhhKkKbKhblKmooKfHMOkKbopKkbmKoofKhKkKbPMhlKmKoKlbhKkobKpKLKmKoPfKhOkKbppKlKMKoKfhhKkpbKpOlKmHOffKhPkKBhpKlomKohfKhPPhbKpKlKMhoKfohKkPLhpKlKmKpbfKhokKbKPKlKmPoKfOhKkpbKpKLKmKohfKhpkKbOpKlHMfoKfPhKoBbKpolKmhoKfPBhkKbKpKkBmKoofKhKPKbKpPlKmKoKfKhKkKKLpKlPmKoofKhKkKbKfPlKmPoKfOhKkKbKpKpLmKoKfKhokKbKpKlomKoKfKhKkKbKpKlKmmoKfKhKkKkPpKlKmKoofKhKkKbKpKlKmKoKfKhKkKbKpKlKmKoKfKhKkKbKpKlKmKoKfKhKkpbKpKlKmKoKfKhKkKbKpKlKmKoKfKhKkKbKpOlKmKoKfKhKkKbKpKlomKoKfKhKkKbKpKlpmMoKfKhKlfbKpKlKmKoKfKPKpkHmPFlKmKoKOhBkHFKlmHpHLoHPKpFoPFKlfhlKmKoKfKhKkKKKmKhompoKfKhKHpKhbOKfmPoKfKhKhpkMboPOBfoHfKhKkKKpBPPOLbMLomMfkPbKpKlKlObbOPfhkKbKpKlKmKpofKhKkKBOBKlKmpoKfOhKkKbKpKoFmKopfKhpkKbopKlHFboKfphKkmbKpolKmKoKfPBhkKbKpKlmmKoofKHOHKbKpplKmOoKfKhKkKlFpKlpmKopfKhokKbKfPlKmpoKfOhKkKbKPOPpmKopfKhokKbKpKLOBkoKfPhKkMbKpKlKMOoKfKhhkKbopKlKmKoKfKhKkHbKpKlKmKoKFOhKkKbmpKlomKoKfKhPkKbKphlKbloKfohKkKFHpKLbmKoPfKhKkKBOMHlKMBoKfHhKkKbKhKlKmKOBfKHBkKbhpKkKmKoKFfhKkKbKpPlKmKoKfKHlkKbMpKlKmKoKfKhKKLbKpMlKmKoKfKhKkKBfpKLLmKoOfKmKkKbKPflKMfoKfmhKkKbKpKLfmKoOfKhOkKbKpKlKMfoKFfhKkpbKhKlKmKOffKHfkKbppKlKmKoKFBhKkObKpOlKmKoKfKhPkKBbpKLBmKoKfKhKKbbKpplKmOoKlKhKkKbppKLbmKopfKhPOpbKphlKMloKfohKKOKKpKlhmKoOfKhKkKbKhBlKmhoKfohKkPbKpKhPmKoPfKhOkKbKpKlKlLoKfKhKkobKpKlKmKoKfKhKkobopKlKmKFFfhhKkKbKBKpploMFOFhMkKbKpKlKLLoKfohKkKbKpKlKMOMKfKhOkKbopKlKmKoHpphKkpbKpKlKmooKfOhKkKfKpKlKmKoofKhKkKbKhKlKmKoKfKhKkKbKpKlmmKoOfKhOkKbopKlKkPoKfohKkObKpKlKmKmLfKhKkKbopKlKmKoofKhKkKbKpPlKmKoKLfHFkKbKpKpmlhMPopFkHLKpBPpoLLMPOpBHkhbKpKlKlPmhoOFhhmFfPBlKmKoKObFpHFkpBFPkLpMhOOfhPHBFpKlKmKMbOpfkHFkkbpPFLkMpOhFOhhBopKlKmKOOOKhKkKbKpplKmKoKfHfBkKbKpKLlmKoofKhokKbPMhlKmKoKFlhKkobKPOPKmKoKfKhPkKbKpKlHFboKfKhKkmbKpolKmKoKfPBhkKbKpKlmmKoofKhPPhbKpKlKMloKfohKKOKKpKlKmKoofKhKkKbHMblKmKoKFfhKkobKpKlKmPHhfKhKkKBfpKlomKoPKhhKkKbKPllKmooKFOFKkKbKpKlOmKoKfKmKpPbKpKlKmKoKfohKkKofpKlomKoofKhKkKbKpplKmKoKfOhKkObKpKkhmKoKfKhKkKbKpKlKlLoKfKhKkobKpKlKmKoKfKhKkKbmpKlKmKboFfhKkKbKMFPklpmoOFBKHFkofbphLOFFfmhKkKbKmPphLpMPOOFkmbbKphlKmKoKkoFhHOkoHoOHmPoKfKhKhmkoBlphPmObfKhKkKkpbMpoLOmoopFPhhKOHflmmKoKfKBKHFkofbphLOMpHFHbkKbKpKOOLbmmoMFPpMkoBLpPMboKfKhKKOlkpKlKmKoPfKhKkKfKpKlKmKoKfKhKkHbKhKlKmKoKfKhKkKbopKkKmKoKfKhKkKbKphlKbKoKfKhKkKbKpKlmmKpKfKhKkKbKpKlKmpoKlKhKkKbKpKlKmKoOfKhKkKbKpKlKmOoKfohKkKbKpKlKmKoofKhKkKbKpKlKmKoKfmhKkKbKMHlmmKoKfKbPhhKpBPPOLkbbLfHfkKbKpKOFLkmpooFFPKKFbohblhMOKHhhkKbKpKooLhMOooMomobmpKlKmKHKOFfombkhBOPpkoOFfKhKkKLFbhpHLPHhOKFKhhKOMFphlmHHfPhKkKbKbmpoLlmhpoHbkKbKpKpplMmoOOfohpKPbhPOMboKfKhKKOlkpKlKmKoHfKhKkKfKpKlKmKoKfKhKkPbKhKlKmKoKfKhKkKbOpKkKmKoKfKhKkKbKpmlKbKoKfKhKkKbKpKlhmKpKfKhKkKbKpKlKmpoKlKhKkKbKpKlKmKoofKhKkKbKpKlKmOoKfohKkKbKpKlKmKoofKhKkKbKpKlKmKoKfphKkKbKMMloOLoKHFhmkKbKpKOHLbMpObfOHFkhPmlKmKoKfKLBkKbKpKlKmKoKfKMKkKbKpKlKmpoKfOhKkKbKpKlKmKoofKhKkKFKpKlKmKoKfphKkObKpKlKmKoKfKhOkKbKpKKKmKoKfKhKkpbKpOlKmKoKfKhKkKbppKlKmKPKfKhKkKbKpplKmOoKfKhKkKbKpKlPmKoKfKMKkKbKpKlKmpoKfOhKkKbKpKlKmKohfKhKkKFKpKlKmKoKfphKkObKpKlKmKoKfKhHkKbKpKKKmKoKfKhKkpbKpOlKmKoKfKhKkKbmpKlKmKPKfKhKkKbKpplKmooKfKhKkKbKpKlMmKoKfKMKkKbKpKlKmpoKfohKkKbKpKlKmKObfKhKkKFKpKlKmKoKfphKkobKpKlKmKoKfKHBkKbKpKKKmKoKfKhKkpbKpolKmKoKfKhKkKbopKlKmKoKfKhKkKbKpmlKmKoKpohMkKbKpKOFlhmHOPbMhoKLbPhommoKfKhKPKKFbohblhMOOpBHkmbKpKlKfPmhOpFPHOKkfblKmPoKfKhKhmkoBlphBfObfKhKkKkpbMpoLOmoopFPhhKOpKLfmKoKfKBFHkkpboPFFKMFoolbhhKOHflhmKoKfKboHhKOboKoMboKfKhKKOlkpKlKmKoPfKhKkKfKpKlKmKoKfKhKkObKhKlKmKoKfKhKkKbHpKkKmKoKfKhKkKbKphlKbKoKfKhKkKbKpKlomKpKfKhKkKbKpKlKmmoKlKhKkKbKpKlKmKopfKhKkKbKpKlKmOoKfohKkKbKpKlKmKoofKhKkKbKpKlKmKoKfphKkKbKpOlKmOooMmhmkKbKpKOHLbMpObfOHFkhPmlKmKoKfKLBkKbKpKlKmKoKfKMKkKbKpKlKmpoKfohKkKbKpKlKmKoofKhKkKFKpKlKmKoKfphKkobKpKlKmKoKfKhOkKbKpKKKmKoKfKhKkpbKpolKmKoKfKhKkKbppKlKmKPKfKhKkKbKpplKmooKfKhKkKbKpKlPmKoKfKMKkKbKpKlKmpoKfohKkKbKpKlKmKohfKhKkKFKpKlKmKoKfphKkobKpKlKmKoKfKhHkKbKpKKKmKoKfKhKkpbKpolKmKoKfKhKkKbmpKlKmKPKfKhKkKbKpplKmOoKfKhKkKbKpKlMmKoKfKMKkKbKpKlKmpoKfOhKkKbKpKlKmKObfKhKkKFKpKlKmKoKfphKkObKpKlKmKoKfKHBkKbKpKKKmKoKfKhKkpbKpOlKmKoKfKhKkKbopKlKmKoKfKhKkKbKpmlKmKoKMmhmkKbKpKOKLFmopbfhHOKpMHlPmKoKfKfmhoKlbhlKmhoKfKhKpoKhBOpoBOLmfmhKkKbKmPphLpMPOOFkmboopMlKmKoKKFfhhHKPmMpoLLmPKHHfkKbKpKOFLkmpooFFPKKFbohblhMOpoHbkKbKpKpplMmoOOfohpKPbhPOMboKfKhKKOlkpKlKmKoOfKhKkKfKpKlKmKoKfKhKkobKhKlKmKoKfKhKkKbHpKkKmKoKfKhKkKbKpmlKbKoKfKhKkKbKpKlhmKpKfKhKkKbKpKlKmpoKlKhKkKbKpKlKmKoPfKhKkKbKpKlKmOoKfohKkKbKpKlKmKoofKhKkKbKpKlKmKoKfphKkKbKpKlmmKoKfKBHHbKpBbpOLFmhbbhKlbbophlKmKoKfKBlkKbKpKlKmKoKfKMKkKbKpKlKmooKfOhKkKbKpKlKmKoofKhKkKFKpKlKmKoKfohKkpbKpKlKmKoKfKhokKbKpKlKmKoKfKhKkKbKpKlKmooKfKhKkKkLpKlKmKoofKhKkKbKpKlKmKoKfmhKkKbKMHLfmKoKfKBFHkkpboPFFKMFoolbhhKOfolhmKoKfKboHhKOboKOmKomfKhKkKLKBFpokbmhOOFpFmBbpKlKmKmpoMfoHOkobpPPlhMOpohmkKbKpKoPlhMpOPFOHkobLFlPmKoKfKfmhoKlbhOHMboKfKhKPOKbbmpMLPhMooFLhPBbpKlKmKOOkkhKkKbKpHlKmKoKlKhKkKbKpKlKmKopfKmKkKbKpKlKmKoKfohKoKbKpKlKmKoKfKhPkKfKpKlKmKoKfKhKkmbKhKlKmKoKfKhKkKbOpKkKmKoKfKhKkKbKphlKmKoKfKhKkKbOpKlomKoKfKhKkKbKpolKmKoKfKhKkKbKpKlmmKoKfKhKKBbKpKlKFhMKOKfhHOLPBkPOLpMkfKhmkKbKpKoPlhMpOPFOHkobLFlhmKoKfKboHhKOboKOOFoPfKhKkKkmboPllhFFFbhKkKbKbppMloMOoofpHPkhBOKfMfoKfKhKPFKkbppoLFHKOFfombkhBOBmmmoKfKhKPKKFbohblhMOOpHbkKbKpKLOfkoKfKhKkPbKpKlKbKoKfKhKkKbKpKlmmKpKfKhKkKbKpKlKmHoKlKhKkKbKpKlKmKohfKmKkKbKpKlKmKoKfohKoKbKpKlKmKoKfKhpkKfKpKlKmKoKfKhKkObKpKlKmKoKfKhOkKbopKlKmKoKfKhKkobKpKlKmKoKfKhK");local F=(-#"0 divided by 0"+((-0x40+32)+142))local o=89 local l=h;local K={}K={[(-19+0x14)]=function()local K,k,p,h=g(y,l,l+_);l=l+s;o=(o+(F*s))%b;return(((h+o-(F)+B*(s*S))%B)*((S*z)^S))+(((p+o-(F*S)+B*(S^_))%b)*(B*b))+(((k+o-(F*_)+z)%b)*B)+((K+o-(F*s)+z)%b);end,[((-18+0x30)+-#[[if true then return your dad]])]=function(K,K,K)local K=g(y,l,l);l=l+L;o=(o+(F))%b;return((K+o-(F)+z)%B);end,[(130-0x7f)]=function()local K,h=g(y,l,l+S);o=(o+(F*S))%b;l=l+S;return(((h+o-(F)+B*(S*s))%B)*b)+((K+o-(F*S)+b*(S^_))%B);end,[(-#'Nsrds GAYYYYAIAHAKAJAVAHAUA'+(132-0x65))]=function(l,K,o)if o then local K=(l/S^(K-h))%S^((o-L)-(K-h)+L);return K-K%h;else local K=S^(K-L);return(l%(K+K)>=K)and h or D;end;end,[(123+-0x76)]=function()local o=K[((6612/0xae)+-37)]();local l=K[(0x69/105)]();local p=h;local k=(K[(-#"nico der hurensohn"+(2926/0x85))](l,L,C+s)*(S^(C*S)))+o;local o=K[(0x62-94)](l,21,31);local K=((-h)^K[(-0x79+125)](l,32));if(o==D)then if(k==N)then return K*D;else o=L;p=N;end;elseif(o==(B*(S^_))-L)then return(k==D)and(K*(L/N))or(K*(D/N));end;return q(K,o-((b*(s))-h))*(p+(k/(S^G)));end,[(83+-0x4d)]=function(k,p,p)local p;if(not k)then k=K[(-#[[use luraph if want lost money]]+(103+-0x49))]();if(k==D)then return'';end;end;p=Y(y,l,l+k-h);l=l+k;local K=''for l=L,#p do K=j(K,v((g(Y(p,l,l))+o)%b))o=(o+F)%B end return K;end}local function z(...)return{...},I('#',...)end local function y()local m={};local p={};local o={};local k={m,p,nil,o};local l={}local O=(3875/0x9b)local b={[(-#"Big black men"+(-0x5b+106))]=(function(o)return not(#o==K[(0x6a-104)]())end),[((0xb5-146)+-#'Boosted moonsec for meme string')]=(function(o)return K[((1914/0xae)+-#'Ur mom')]()end),[(0x30-48)]=(function(o)return K[(0x58-82)]()end),[(-36+0x27)]=(function(o)local h=K[(0x4f8/212)]()local o=''local K=1 for l=1,#h do K=(K+O)%b o=j(o,v((g(h:sub(l,l))+K)%B))end return o end)};k[3]=K[(0x6d-107)]();local o=K[(187/0xbb)]()for o=1,o do local K=K[(0x5f+-93)]();local h;local K=b[K%(138-(299-0xcc))];l[o]=K and K({});end;for O=1,K[(54-0x35)]()do local o=K[(-#"cruz pp is large"+(52-0x22))]();if(K[(-#"FranzJPresents"+(0xf9c/222))](o,h,L)==N)then local p=K[(0x4d-73)](o,S,_);local b=K[(912/0xe4)](o,s,S+s);local o={K[(0x62+-95)](),K[((0x60-65)+-#"10 black dicks in your mouth")](),nil,nil};local k={[(29-0x1d)]=function()o[f]=K[(-#'You are an absolute baboon'+(0x82-101))]();o[i]=K[(-#[[anime is for fags]]+(0x4c4/61))]();end,[(107-0x6a)]=function()o[d]=K[(0xa1/161)]();end,[(0x5b-89)]=function()o[a]=K[(-49+0x32)]()-(S^C)end,[(118+-0x73)]=function()o[d]=K[(90-0x59)]()-(S^C)o[x]=K[(0x30-45)]();end};k[p]();if(K[(107+-0x67)](b,L,h)==L)then o[P]=l[o[n]]end if(K[(728/0xb6)](b,S,S)==h)then o[d]=l[o[f]]end if(K[((0x30+-32)+-#'deadphonelua')](b,_,_)==L)then o[x]=l[o[U]]end m[O]=o;end end;for K=L,K[(-#[[real roblox omg builderman caught playing real]]+(155-0x6c))]()do p[K-L]=y();end;return k;end;local function D(K,s,F)local N=K[S];local o=K[_];local b=K[h];return(function(...)local B=o;local K=z local o=h;local l={};local K=h K*=-1 local K=K;local y={};local b=b;local N=N;local C=I('#',...)-L;local g={...};local _={};for K=0,C do if(K>=B)then y[K-B]=g[K+L];else l[K]=g[K+h];end;end;local K=C-B+h local K;local B;while true do K=b[o];B=K[(27/(0x2b+-16))];k=(5116320)while B<=((-#"if syn then haxor alert end"+(32184/0x95))-0x76)do k-= k k=(10302670)while(-#'Russian letters'+(130-0x50))>=B do k-= k k=(11271088)while B<=(0x69-88)do k-= k k=(833373)while B<=(-99+0x6b)do k-= k k=(1362680)while B<=(-96+0x63)do k-= k k=(6801589)while(-#[[paidlancer]]+(0x2b-32))>=B do k-= k k=(842040)while B>(102-0x66)do k-= k l[K[M]]=l[K[f]]%K[i];break end while(k)/((-75+0x1b3))==2339 do l[K[p]]=l[K[a]]%K[i];break end;break;end while 2053==(k)/(((0x1aa1-3460)+-#[[i shoved a whole bag of jellibeans up my ass]]))do k=(7775940)while(0x63-97)<B do k-= k local K=K[p]l[K]=l[K](l[K+L])break end while 2154==(k)/(((7308-(-0x2f+3731))+-#[[waste of sperm]]))do local h=K[P];local b=l[h]local k=l[h+2];if(k>0)then if(b>l[h+1])then o=K[f];else l[h+3]=b;end elseif(b<l[h+1])then o=K[m];else l[h+3]=b;end break end;break;end break;end while(k)/(((0x395-469)+-#'testing this thingy lololollez'))==3260 do k=(4664016)while B<=((3206/(50380/0xdc))+-#'0nly segc')do k-= k k=(2728689)while(0xe4/57)<B do k-= k local k;l[K[M]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[e]][K[f]]=l[K[w]];o=o+h;K=b[o];l[K[n]]=F[K[m]];o=o+h;K=b[o];l[K[n]]=l[K[m]][K[u]];o=o+h;K=b[o];l[K[M]]=l[K[f]][K[i]];o=o+h;K=b[o];l[K[p]][K[f]]=l[K[t]];o=o+h;K=b[o];l[K[M]][K[H]]=K[x];break end while(k)/((0x844-1105))==2699 do l[K[e]]=l[K[H]][K[u]];break end;break;end while 1322==(k)/((3545+(-#[[fix vg hub dekudimz]]+(50-0x30))))do k=(6534724)while B<=(-#"Ur mom"+(-112+0x7c))do k-= k local k;l[K[e]]=K[d];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[P]][K[m]]=l[K[x]];o=o+h;K=b[o];l[K[p]][K[m]]=K[x];o=o+h;K=b[o];l[K[P]]=F[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[a]][K[x]];o=o+h;K=b[o];l[K[n]]=l[K[m]][K[w]];o=o+h;K=b[o];l[K[M]][K[a]]=l[K[i]];break;end while 3899==(k)/((0x6ff+-115))do k=(9597180)while B>(133+-0x7e)do k-= k do return end;break end while 2910==(k)/((-#'Luraph v13 has been released changed absolutely fucking nothing'+(((13713-0x1ae2)+-#'good googly moogly')-0xd7c)))do local K=K[e]l[K](l[K+L])break end;break;end break;end break;end break;end while 3193==(k)/((0x27b-(466+-0x5c)))do k=(9222087)while B<=((0x6063/235)+-#[[MSC 793z487nhvcgsdfgsudfza9889jgvz56gz56z547684z5g54z948g56z74j56475jzg645z6456 oh wait bitch]])do k-= k k=(6201330)while(-#[[null]]+(97-0x53))>=B do k-= k k=(6554016)while B>(0x558/152)do k-= k local k;l[K[e]]=l[K[a]][K[u]];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];k=K[P]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[M]][K[a]]=l[K[t]];o=o+h;K=b[o];l[K[e]][K[a]]=K[w];o=o+h;K=b[o];l[K[P]][K[H]]=K[x];o=o+h;K=b[o];l[K[P]][K[d]]=K[i];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[t]];break end while(k)/(((0x4e6dc/98)+-#'goofy ahh uncle productions'))==2016 do local h=K[n];local k=l[h+2];local b=l[h]+k;l[h]=b;if(k>0)then if(b<=l[h+1])then o=K[d];l[h+3]=b;end elseif(b>=l[h+1])then o=K[a];l[h+3]=b;end break end;break;end while(k)/((-0x4a+2179))==2946 do k=(5650824)while B>(0x667/149)do k-= k local k;l[K[M]]=F[K[r]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[x]];o=o+h;K=b[o];l[K[p]]=K[m];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];l[K[M]]=K[a];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[p]][K[m]]=l[K[x]];o=o+h;K=b[o];l[K[p]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[t]];break end while(k)/((0x4f498/230))==4002 do if(l[K[n]]~=l[K[w]])then o=o+L;else o=K[r];end;break end;break;end break;end while 3857==(k)/((0x9cf+-120))do k=(10667360)while B<=(91-0x4d)do k-= k k=(7187124)while B>((100-0x49)+-#'waste of sperm')do k-= k if(l[K[e]]==K[w])then o=o+L;else o=K[r];end;break end while(k)/(((5823-0xb79)+-#[[bigchungus]]))==2499 do do return l[K[e]]end break end;break;end while 3190==(k)/((0x1a33-3363))do k=(10113456)while B<=((0x1287-2403)/0x9c)do k-= k if(l[K[M]]==l[K[i]])then o=o+L;else o=K[a];end;break;end while(k)/((0xa80+-72))==3866 do k=(1527660)while(0x6c-92)<B do k-= k local k;l[K[p]]=K[d];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[n]][K[d]]=l[K[w]];o=o+h;K=b[o];l[K[p]]=F[K[m]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[u]];o=o+h;K=b[o];l[K[O]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[p]][K[d]]=l[K[i]];o=o+h;K=b[o];l[K[M]][K[m]]=K[u];o=o+h;K=b[o];l[K[n]]=F[K[f]];break end while(k)/((69372/0x5e))==2070 do l[K[e]]=l[K[f]]-l[K[x]];break end;break;end break;end break;end break;end break;end while 3856==(k)/((-#"Niggabyte"+(131940/0x2d)))do k=(4168094)while B<=(86-0x3c)do k-= k k=(4895842)while(0x9f-138)>=B do k-= k k=(2263925)while(0x6fa/94)>=B do k-= k k=(6403722)while(-46+0x40)<B do k-= k local k;k=K[e]l[k](c(l,k+L,K[m]))o=o+h;K=b[o];l[K[e]][K[f]]=l[K[x]];o=o+h;K=b[o];l[K[P]][K[H]]=K[u];o=o+h;K=b[o];l[K[P]][K[a]]=l[K[u]];o=o+h;K=b[o];l[K[M]]=F[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[i]];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];l[K[p]]=K[m];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[d]))break end while 1653==(k)/((0x1eac-3978))do local K={l,K};K[h][K[S][e]]=K[S][i]+K[S][r];break end;break;end while(k)/((558545/0xa9))==685 do k=(9089340)while(-#"testpsx dupe no scam legit 2022 free no virus"+(241-((0x19f-228)+-#[[monkey mode]])))<B do k-= k local k;l[K[M]]=K[r];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[O]][K[H]]=l[K[u]];o=o+h;K=b[o];l[K[M]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[w]];o=o+h;K=b[o];l[K[n]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[n]][K[d]]=l[K[i]];o=o+h;K=b[o];l[K[P]][K[m]]=K[U];break end while 2236==(k)/((((-#'zykem krul'+(0x5fd2b+-33))/96)+-#'heil eco mother fuckers'))do local K={l,K};K[L][K[S][n]]=K[h][K[S][u]]+K[L][K[S][m]];break end;break;end break;end while 2086==(k)/((4762-0x96f))do k=(4311096)while B<=((0xb1+-103)+-51)do k-= k k=(1073847)while(1958/0x59)<B do k-= k local k;k=K[p]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[n]][K[m]]=l[K[x]];o=o+h;K=b[o];l[K[P]][K[m]]=K[w];o=o+h;K=b[o];l[K[P]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[n]]=F[K[a]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[d]))break end while(k)/(((-20+0x743)+-#"windows xp startup sfx"))==591 do local K=K[n]l[K]=l[K](l[K+L])break end;break;end while(k)/((-#[[Crackzzzz]]+(333270/0xd2)))==2732 do k=(12114220)while(0x1620/236)>=B do k-= k if l[K[P]]then o=o+h;else o=K[d];end;break;end while 3070==(k)/((966770/0xf5))do k=(33015)while(((234+-0x16)-163)+-#"0nly 1337 smashed ur wap")<B do k-= k l[K[M]][l[K[f]]]=l[K[w]];break end while 355==(k)/((16275/0xaf))do local k;l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[n]]=l[K[f]][K[i]];o=o+h;K=b[o];l[K[n]]=K[r];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];k=K[P]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[M]][K[a]]=l[K[w]];o=o+h;K=b[o];l[K[e]][K[a]]=K[x];o=o+h;K=b[o];l[K[n]][K[H]]=K[U];o=o+h;K=b[o];l[K[p]][K[m]]=K[t];break end;break;end break;end break;end break;end while(k)/(((0x36950/157)+-#[[Bush Did 9 11]]))==2954 do k=(2822850)while((215-0xa9)+-#'0nly was here mf')>=B do k-= k k=(8491296)while(-#"Niggabyte"+((-0x77+212)-56))>=B do k-= k k=(14628398)while(-#"how to join the kkk"+(0x1b22/151))<B do k-= k l[K[P]]=#l[K[H]];break end while 3638==(k)/((((0x108c+-106)+-0x5d)+-#"atakan der nigga"))do local m;local k;l[K[p]]=F[K[d]];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[e]]=l[K[a]][K[u]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[w]];o=o+h;K=b[o];l[K[e]]=l[K[f]][K[w]];o=o+h;K=b[o];k=K[e];m=l[K[f]];l[k+1]=m;l[k]=m[K[i]];o=o+h;K=b[o];k=K[P]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end while(k)/(((5742-0xb47)+-#"anime is for fags"))==2992 do k=(741596)while B>(0x96-121)do k-= k l[K[P]]=s[K[f]];o=o+h;K=b[o];l[K[n]][K[H]]=K[x];o=o+h;K=b[o];l[K[n]]=s[K[a]];o=o+h;K=b[o];l[K[e]][K[m]]=K[x];o=o+h;K=b[o];l[K[n]]=s[K[f]];o=o+h;K=b[o];l[K[P]][K[H]]=K[u];o=o+h;K=b[o];l[K[M]]=s[K[H]];o=o+h;K=b[o];l[K[n]][K[H]]=K[U];o=o+h;K=b[o];l[K[M]]=s[K[H]];o=o+h;K=b[o];l[K[p]][K[f]]=K[t];o=o+h;K=b[o];l[K[M]]=s[K[d]];o=o+h;K=b[o];l[K[p]][K[r]]=K[w];o=o+h;K=b[o];l[K[e]]=s[K[m]];o=o+h;K=b[o];l[K[O]][K[r]]=K[x];o=o+h;K=b[o];l[K[n]]=s[K[r]];o=o+h;K=b[o];l[K[P]][K[f]]=K[t];o=o+h;K=b[o];l[K[O]]=s[K[r]];o=o+h;K=b[o];l[K[p]][K[a]]=K[t];o=o+h;K=b[o];l[K[O]]=s[K[a]];o=o+h;K=b[o];l[K[n]][K[H]]=K[i];o=o+h;K=b[o];l[K[O]]=s[K[a]];o=o+h;K=b[o];l[K[M]][K[d]]=K[t];o=o+h;K=b[o];do return end;break end while 1588==(k)/((-#"0 divided by 0"+(1085-0x25c)))do local k;l[K[O]]=K[r];o=o+h;K=b[o];l[K[M]]=K[r];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[M]][K[a]]=l[K[t]];o=o+h;K=b[o];l[K[e]]=F[K[a]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[u]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[u]];o=o+h;K=b[o];l[K[n]][K[f]]=l[K[t]];o=o+h;K=b[o];l[K[M]][K[m]]=K[x];break end;break;end break;end while 1230==(k)/(((-94+0x9af)+-0x5a))do k=(1078000)while B<=(6880/0xd7)do k-= k k=(4241474)while B>(-#'if syn then haxor alert end'+(228-0xaa))do k-= k l[K[O]]=l[K[f]];break end while(k)/((-#'I hate black people'+(2241+-0x30)))==1951 do local k;l[K[p]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];l[K[e]]=K[f];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[M]][K[H]]=l[K[u]];o=o+h;K=b[o];l[K[O]][K[m]]=K[t];o=o+h;K=b[o];l[K[e]][K[m]]=K[x];o=o+h;K=b[o];l[K[n]][K[d]]=K[t];o=o+h;K=b[o];l[K[e]]=l[K[d]][K[u]];break end;break;end while 1225==(k)/((76560/0x57))do k=(363432)while(-#'nicowashere'+(-0x5c+136))>=B do k-= k l[K[p]]=#l[K[d]];break;end while(k)/((-44+0x9e))==3188 do k=(254144)while(-#[[never gonna give you up never gonna let you down]]+(2378/0x1d))<B do k-= k local k;l[K[n]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[m]][K[i]];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=l[K[a]];o=o+h;K=b[o];o=K[d];break end while(k)/((0x16d-213))==1672 do local k;k=K[e]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[x]];o=o+h;K=b[o];l[K[M]][K[f]]=K[w];o=o+h;K=b[o];l[K[O]][K[m]]=l[K[u]];o=o+h;K=b[o];l[K[P]]=F[K[d]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[w]];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];l[K[P]]=K[a];o=o+h;K=b[o];l[K[M]]=K[m];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[a]))break end;break;end break;end break;end break;end break;end break;end while(k)/((((148512/0x34)+-#'elbicho')+-0x48))==3710 do k=(3500010)while B<=(-#'Fucking Retarted'+(-0x62+167))do k-= k k=(1417516)while(0x7f+-83)>=B do k-= k k=(7271594)while B<=(127+-0x58)do k-= k k=(6367998)while B<=((0x1926/87)/0x2)do k-= k k=(4628661)while(-#[[Suck Sus0587]]+(0xc9-153))<B do k-= k s[K[H]]=l[K[M]];break end while 1923==(k)/((0x12fe-2455))do local K=K[p]l[K](l[K+L])break end;break;end while(k)/((4704-0x96f))==2782 do k=(13284928)while(-0x31+((0x12e-208)+-#'mf stfu'))<B do k-= k local h=K[r];local o=l[h]for K=h+1,K[i]do o=o..l[K];end;l[K[p]]=o;break end while 3308==(k)/((550192/0x89))do local k;l[K[P]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[n]]=F[K[d]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[H]];o=o+h;K=b[o];l[K[P]]=l[K[m]][K[i]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[O]]=l[K[H]][K[u]];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[d]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[P]]=K[a];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[H]];o=o+h;K=b[o];l[K[p]]=l[K[H]][K[w]];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[d]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[x]];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[d]];o=o+h;K=b[o];l[K[e]]=l[K[f]][K[U]];o=o+h;K=b[o];l[K[O]]=K[r];o=o+h;K=b[o];k=K[e]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[m]];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[x]];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[H]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[n]]=K[r];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[O]]=l[K[f]][K[u]];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[a]];o=o+h;K=b[o];l[K[O]]=l[K[d]][K[u]];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[m]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[p]][K[H]]=l[K[i]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[t]];o=o+h;K=b[o];l[K[O]]=l[K[f]][K[u]];o=o+h;K=b[o];l[K[e]][K[H]]=l[K[x]];o=o+h;K=b[o];l[K[O]][K[m]]=K[x];o=o+h;K=b[o];l[K[P]][K[r]]=l[K[t]];o=o+h;K=b[o];l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[w]];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[M]][K[f]]=l[K[w]];o=o+h;K=b[o];l[K[M]][K[r]]=K[u];o=o+h;K=b[o];l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[e]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[H]][K[w]];o=o+h;K=b[o];l[K[P]]=K[r];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[e]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];break end;break;end break;end while(k)/((4563-0x8f9))==3209 do k=(2116302)while(0x6d-68)>=B do k-= k k=(1565270)while B>(-#'nerd'+(7480/0xaa))do k-= k local k;l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[n]]=l[K[r]][K[w]];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];l[K[M]]=K[a];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[O]][K[H]]=l[K[t]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[w]];break end while 826==(k)/((-0x3e+1957))do l[K[n]]=s[K[f]];o=o+h;K=b[o];l[K[e]][K[m]]=K[w];o=o+h;K=b[o];l[K[O]]=s[K[f]];o=o+h;K=b[o];l[K[P]][K[m]]=K[x];o=o+h;K=b[o];l[K[p]]=s[K[m]];o=o+h;K=b[o];l[K[P]][K[d]]=K[t];o=o+h;K=b[o];l[K[M]]=s[K[f]];o=o+h;K=b[o];l[K[M]][K[a]]=K[t];o=o+h;K=b[o];l[K[O]]=s[K[r]];o=o+h;K=b[o];l[K[P]][K[H]]=K[i];o=o+h;K=b[o];l[K[P]]=s[K[f]];o=o+h;K=b[o];l[K[n]][K[m]]=K[t];o=o+h;K=b[o];l[K[O]]=s[K[f]];o=o+h;K=b[o];l[K[M]][K[d]]=K[x];o=o+h;K=b[o];l[K[M]]=s[K[r]];o=o+h;K=b[o];l[K[O]][K[a]]=K[u];o=o+h;K=b[o];l[K[M]]=s[K[m]];o=o+h;K=b[o];l[K[e]][K[a]]=K[U];o=o+h;K=b[o];l[K[e]]=s[K[d]];o=o+h;K=b[o];l[K[O]][K[f]]=K[x];o=o+h;K=b[o];l[K[e]]=s[K[r]];o=o+h;K=b[o];l[K[p]][K[d]]=K[x];o=o+h;K=b[o];do return end;break end;break;end while(k)/((3149-0x632))==1354 do k=(7245230)while B<=((0x5b+-19)+-#'impulse was here pastebin reel')do k-= k local k;k=K[O]l[k](c(l,k+L,K[a]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[i]];o=o+h;K=b[o];l[K[p]][K[H]]=K[x];o=o+h;K=b[o];l[K[O]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[u]];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];l[K[M]]=K[f];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[a]))break;end while(k)/((0x36bd5/121))==3910 do k=(2835807)while B>(0x28fc/244)do k-= k local a;local k;l[K[P]]=F[K[m]];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[e]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[M]]=l[K[H]][K[t]];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[i]];o=o+h;K=b[o];l[K[n]]=l[K[f]][K[u]];o=o+h;K=b[o];k=K[p];a=l[K[f]];l[k+1]=a;l[k]=a[K[i]];o=o+h;K=b[o];k=K[O]l[k](l[k+L])o=o+h;K=b[o];do return end;break end while 3471==(k)/((-#"Big black men"+(107070/0x81)))do local k;l[K[P]]=l[K[r]][K[w]];o=o+h;K=b[o];l[K[n]]=K[a];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[O]][K[H]]=l[K[U]];o=o+h;K=b[o];l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[t]];o=o+h;K=b[o];l[K[O]]=K[f];break end;break;end break;end break;end break;end while(k)/((0x2407e/162))==1556 do k=(5316206)while((0xb3+-122)+-#"0nly 1337")>=B do k-= k k=(2594115)while(120-(0xca-128))>=B do k-= k k=(1872596)while B>(-#[[windows xp startup sfx]]+((12224/0x40)+-0x7c))do k-= k local k;l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[w]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[O]]=K[m];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[t]];o=o+h;K=b[o];l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[U]];break end while 583==(k)/((0x1957-3275))do l[K[n]]=D(N[K[a]],nil,F);break end;break;end while(k)/(((-110+((-0x29+968)+-#[[33 cocks in my mouth]]))+-#"Me be like at 5am in the morning"))==3391 do k=(2833552)while(-#"brawl stars hard gay porn shelly nsked minecraft gay porn roblox rule34 hot"+(((685-0x171)+-#"psx real dupe steal all ur pets no joke")-155))<B do k-= k local K={l,K};K[L][K[S][M]]=K[h][K[S][x]]+K[L][K[S][m]];break end while 866==(k)/((-#'freerobuxphone'+(6634-0xd14)))do local e;local m;local k;l[K[O]]=K[d];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];l[K[M]]=#l[K[f]];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];k=K[O];m=l[k]e=l[k+2];if(e>0)then if(m>l[k+1])then o=K[a];else l[k+3]=m;end elseif(m<l[k+1])then o=K[a];else l[k+3]=m;end break end;break;end break;end while 3191==(k)/((-29+0x69f))do k=(12702063)while B<=((159+-0x39)+-#"If LocalPlayer equals Dumbass then while true do end")do k-= k k=(2899032)while(0x2fda/250)<B do k-= k if(l[K[p]]==l[K[w]])then o=o+L;else o=K[d];end;break end while(k)/((-#"real roblox omg builderman caught playing real"+(143832/0x27)))==796 do local k;l[K[n]]=l[K[r]][K[t]];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[n]]=K[r];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[n]][K[H]]=l[K[w]];o=o+h;K=b[o];l[K[M]][K[f]]=K[i];o=o+h;K=b[o];l[K[p]][K[d]]=K[x];o=o+h;K=b[o];l[K[e]][K[m]]=K[i];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[x]];break end;break;end while(k)/((0x1a73-3438))==3811 do k=(746214)while(((362-0xd6)-0x5b)+-#'Faggot')>=B do k-= k local h=K[M];local k=l[h+2];local b=l[h]+k;l[h]=b;if(k>0)then if(b<=l[h+1])then o=K[H];l[h+3]=b;end elseif(b>=l[h+1])then o=K[r];l[h+3]=b;end break;end while(k)/((0x2079/17))==1526 do k=(8992494)while B>(125-0x49)do k-= k local h=K[m];local o=l[h]for K=h+1,K[i]do o=o..l[K];end;l[K[n]]=o;break end while 3103==(k)/((0xbba+-104))do l[K[M]][K[d]]=K[i];break end;break;end break;end break;end break;end break;end while 2682==(k)/((((0x5eb+-103)+-#"mama mo")+-100))do k=(9405766)while B<=(-112+0xae)do k-= k k=(11463552)while(0xa3+-106)>=B do k-= k k=(2056294)while B<=(3410/0x3e)do k-= k k=(2005380)while(4590/0x55)<B do k-= k local m;local k;l[K[M]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[e]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[w]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[i]];o=o+h;K=b[o];k=K[p];m=l[K[a]];l[k+1]=m;l[k]=m[K[w]];o=o+h;K=b[o];k=K[e]l[k](l[k+L])o=o+h;K=b[o];do return end;break end while(k)/(((0x395+-123)+-#'dies of cringe'))==2571 do l[K[P]]=l[K[m]];break end;break;end while 2042==(k)/((-0x42+1073))do k=(7452188)while((-0x21+108)+-#[[I hate black people]])<B do k-= k local k;k=K[p]l[k](c(l,k+L,K[m]))o=o+h;K=b[o];l[K[n]][K[a]]=l[K[x]];o=o+h;K=b[o];l[K[e]][K[r]]=K[x];o=o+h;K=b[o];l[K[e]][K[H]]=l[K[w]];o=o+h;K=b[o];l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[w]];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];l[K[n]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[m]))break end while(k)/((-0x51+2053))==3779 do l[K[p]]=l[K[H]][l[K[i]]];break end;break;end break;end while 3456==(k)/((-#'psx dupe is abd'+(6732-0xd48)))do k=(4925864)while((20188/0xc4)+-#[[MoonsecV2 deobfuscator 2020 free 100 percent]])>=B do k-= k k=(5164467)while((0x16c5/(-#"i shoved a whole bag of jellibeans up my ass"+(-0x36+185)))+-#[[arab porn]])<B do k-= k local B;local k;k=K[M]l[k](c(l,k+L,K[m]))o=o+h;K=b[o];l[K[n]][K[f]]=l[K[i]];o=o+h;K=b[o];l[K[p]][K[H]]=K[i];o=o+h;K=b[o];l[K[e]][K[m]]=l[K[x]];o=o+h;K=b[o];l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[e]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[O]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[M]][K[r]]=l[K[i]];o=o+h;K=b[o];l[K[O]]=F[K[a]];o=o+h;K=b[o];l[K[M]]=l[K[f]][K[t]];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[i]];o=o+h;K=b[o];l[K[M]]=F[K[r]];o=o+h;K=b[o];l[K[O]]=l[K[d]][K[u]];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[w]];o=o+h;K=b[o];l[K[p]][K[f]]=l[K[i]];o=o+h;K=b[o];l[K[p]][K[f]]=K[U];o=o+h;K=b[o];l[K[p]]=F[K[d]];o=o+h;K=b[o];l[K[n]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[e]]=K[f];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[O]][K[H]]=l[K[x]];o=o+h;K=b[o];l[K[p]][K[a]]=K[u];o=o+h;K=b[o];l[K[M]][K[a]]=K[U];o=o+h;K=b[o];l[K[M]][K[a]]=K[u];o=o+h;K=b[o];l[K[e]][K[r]]=l[K[w]];o=o+h;K=b[o];l[K[M]][K[H]]=K[u];o=o+h;K=b[o];l[K[M]][K[a]]=l[K[u]];o=o+h;K=b[o];l[K[e]]=F[K[H]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[n]]=K[a];o=o+h;K=b[o];l[K[M]]=K[m];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[n]][K[m]]=l[K[t]];o=o+h;K=b[o];l[K[p]][K[r]]=K[t];o=o+h;K=b[o];l[K[P]]=F[K[m]];o=o+h;K=b[o];l[K[M]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[e]]=K[H];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[P]]=K[r];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];l[K[O]][K[m]]=l[K[x]];o=o+h;K=b[o];l[K[n]]=F[K[f]];o=o+h;K=b[o];l[K[M]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[p]][K[a]]=l[K[w]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[n]]=l[K[f]][K[U]];o=o+h;K=b[o];l[K[P]]=l[K[m]][K[w]];o=o+h;K=b[o];l[K[p]][K[m]]=l[K[U]];o=o+h;K=b[o];l[K[n]][K[r]]=K[x];o=o+h;K=b[o];l[K[n]]=F[K[a]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[O]][K[m]]=l[K[w]];o=o+h;K=b[o];l[K[e]][K[r]]=K[w];o=o+h;K=b[o];l[K[O]][K[d]]=K[u];o=o+h;K=b[o];l[K[P]][K[f]]=K[i];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[u]];o=o+h;K=b[o];k=K[e];B=l[K[a]];l[k+1]=B;l[k]=B[K[U]];break end while(k)/((-#'mf stfu'+(0xa8d+-87)))==1981 do l[K[O]]=s[K[d]];o=o+h;K=b[o];l[K[p]][K[m]]=K[x];o=o+h;K=b[o];l[K[P]]=s[K[r]];o=o+h;K=b[o];l[K[e]][K[m]]=K[U];o=o+h;K=b[o];do return end;break end;break;end while(k)/(((0x357d8/153)+-#"heil eco mother fuckers"))==3496 do k=(795625)while(0xf5-185)>=B do k-= k l[K[O]]=l[K[a]][l[K[x]]];break;end while(k)/((2613-0x53c))==625 do k=(723528)while B>(242-0xb5)do k-= k local k;l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[t]];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[e]][K[d]]=l[K[u]];o=o+h;K=b[o];l[K[M]][K[r]]=K[U];o=o+h;K=b[o];l[K[P]][K[m]]=K[i];o=o+h;K=b[o];l[K[M]][K[m]]=K[x];break end while(k)/((-#[[cilertedcool]]+(0x1bc60/120)))==773 do s[K[H]]=l[K[e]];break end;break;end break;end break;end break;end while(k)/(((888567/0xf1)+-#[[send nudes]]))==2558 do k=(2355304)while B<=(187-(0x37c6/118))do k-= k k=(775188)while B<=(-#'Gay porn'+(0x42f0/238))do k-= k k=(3083213)while(0x333/(0x8d-128))<B do k-= k local k;l[K[p]]=l[K[m]][K[t]];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];l[K[n]]=K[H];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[M]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[P]][K[a]]=K[x];o=o+h;K=b[o];l[K[e]][K[d]]=K[t];o=o+h;K=b[o];l[K[O]][K[d]]=K[x];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[u]];break end while(k)/((-0x1d+2388))==1307 do local e;local k;l[K[O]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[d]][K[u]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[O]]=l[K[f]][K[u]];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[i]];o=o+h;K=b[o];l[K[P]]=l[K[H]][K[i]];o=o+h;K=b[o];k=K[P];e=l[K[H]];l[k+1]=e;l[k]=e[K[t]];o=o+h;K=b[o];k=K[M]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end while(k)/((-41+0x473))==706 do k=(652904)while B>(0x2698/152)do k-= k local k;l[K[O]]=K[r];o=o+h;K=b[o];l[K[M]]=K[a];o=o+h;K=b[o];l[K[M]]=K[m];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[n]][K[f]]=l[K[x]];o=o+h;K=b[o];l[K[e]][K[H]]=K[x];o=o+h;K=b[o];l[K[M]]=F[K[f]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[t]];o=o+h;K=b[o];l[K[n]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[e]][K[f]]=l[K[u]];break end while 917==(k)/((0x17a40/136))do local o=K[n];local h=l[K[H]];l[o+1]=h;l[o]=h[K[t]];break end;break;end break;end while 2456==(k)/((2038-0x437))do k=(6741176)while(-0x2f+115)>=B do k-= k k=(11832586)while((0x4eac/212)+-#'if true then return your dad')<B do k-= k l[K[O]]=l[K[r]][K[i]];break end while 3218==(k)/((7464-0xecb))do l[K[M]][K[H]]=K[i];break end;break;end while 2756==(k)/((4939-(0x9da+-29)))do k=(10037795)while(0x9e-89)>=B do k-= k o=K[r];break;end while 2983==(k)/((0x1a84-3423))do k=(4536365)while(0x1e5a/111)<B do k-= k l[K[O]][K[m]]=l[K[t]];break end while(k)/(((0xb75-1513)+-#"ambatakum"))==3215 do local B;local k;k=K[e]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[O]][K[f]]=l[K[t]];o=o+h;K=b[o];l[K[O]][K[a]]=K[w];o=o+h;K=b[o];l[K[e]][K[a]]=l[K[i]];o=o+h;K=b[o];l[K[O]]=F[K[d]];o=o+h;K=b[o];l[K[O]]=l[K[H]][K[i]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[U]];o=o+h;K=b[o];l[K[O]]=F[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[i]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[n]]=K[r];o=o+h;K=b[o];l[K[O]]=K[H];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[e]][K[f]]=l[K[w]];o=o+h;K=b[o];l[K[p]]=F[K[r]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];l[K[O]]=K[r];o=o+h;K=b[o];l[K[n]]=K[H];o=o+h;K=b[o];l[K[p]]=K[r];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[O]][K[m]]=l[K[u]];o=o+h;K=b[o];l[K[M]][K[H]]=l[K[U]];o=o+h;K=b[o];l[K[n]][K[a]]=K[x];o=o+h;K=b[o];l[K[p]][K[a]]=l[K[U]];o=o+h;K=b[o];l[K[e]]=F[K[a]];o=o+h;K=b[o];l[K[n]]=l[K[H]][K[t]];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[n]][K[d]]=l[K[w]];o=o+h;K=b[o];l[K[n]][K[d]]=K[w];o=o+h;K=b[o];l[K[O]]=F[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[U]];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[p]][K[f]]=l[K[t]];o=o+h;K=b[o];l[K[O]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[u]];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];l[K[P]]=K[a];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];l[K[n]][K[a]]=l[K[x]];o=o+h;K=b[o];l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[t]];o=o+h;K=b[o];l[K[O]]=l[K[m]][K[i]];o=o+h;K=b[o];l[K[M]][K[f]]=l[K[i]];o=o+h;K=b[o];l[K[p]][K[r]]=K[t];o=o+h;K=b[o];l[K[n]]=F[K[H]];o=o+h;K=b[o];l[K[O]]=l[K[H]][K[u]];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[P]]=K[r];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[P]][K[f]]=l[K[x]];o=o+h;K=b[o];l[K[e]][K[r]]=K[i];o=o+h;K=b[o];l[K[P]][K[f]]=K[t];o=o+h;K=b[o];l[K[M]][K[f]]=K[U];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[U]];o=o+h;K=b[o];k=K[M];B=l[K[m]];l[k+1]=B;l[k]=B[K[w]];break end;break;end break;end break;end break;end break;end break;end break;end while 1584==(k)/((0x198f-3313))do k=(3461794)while B<=(268-0xa1)do k-= k k=(3146957)while(293-0xcc)>=B do k-= k k=(9391194)while(0xc3-115)>=B do k-= k k=(13209471)while B<=(269-0xc2)do k-= k k=(3409308)while((0x3fdf/197)+-#"send nudes")>=B do k-= k k=(6989588)while(0xb5-109)<B do k-= k if l[K[e]]then o=o+h;else o=K[H];end;break end while(k)/((-115+0xddc))==2036 do local o=K[n]l[o](c(l,o+L,K[m]))break end;break;end while(k)/((-#[[waste of sperm]]+(3094+-0x5c)))==1141 do k=(8350650)while(10138/0x89)<B do k-= k F[K[d]]=l[K[n]];break end while 3850==(k)/((4375-0x89e))do local h=l[K[x]];if not h then o=o+L;else l[K[P]]=h;o=K[d];end;break end;break;end break;end while(k)/((-58+0xe05))==3741 do k=(581504)while B<=(1617/0x15)do k-= k k=(2950244)while B>(-#"Lana Rhoades"+(-0x22+122))do k-= k l[K[n]]=s[K[d]];o=o+h;K=b[o];l[K[M]][K[f]]=K[w];o=o+h;K=b[o];l[K[e]]=s[K[H]];o=o+h;K=b[o];l[K[p]][K[d]]=K[x];o=o+h;K=b[o];do return end;break end while 3529==(k)/((((0x2cca0/196)+-#[[if syn request then print your mom then end and then kill yourself]])+-0x22))do local k;local O;l[K[e]]=F[K[r]];o=o+h;K=b[o];l[K[p]]=K[m];o=o+h;K=b[o];l[K[p]]=K[H];o=o+h;K=b[o];O=K[f];k=l[O]for K=O+1,K[t]do k=k..l[K];end;l[K[P]]=k;o=o+h;K=b[o];if not l[K[e]]then o=o+L;else o=K[m];end;break end;break;end while(k)/((53867/0x53))==896 do k=(3031984)while B<=(-0x11+95)do k-= k local k;l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];l[K[P]]=K[r];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[e]][K[m]]=l[K[u]];o=o+h;K=b[o];l[K[P]][K[H]]=K[x];o=o+h;K=b[o];l[K[n]][K[a]]=K[u];o=o+h;K=b[o];l[K[p]][K[d]]=K[i];break;end while 1256==(k)/(((-#'Impulse youtube ez'+(-0x1a+4994))-0x9e8))do k=(5721798)while((0x23a-314)-177)<B do k-= k l[K[P]]=(K[m]~=0);o=o+L;break end while 1466==(k)/(((-0x10+3929)+-#"zykem krul"))do local k;l[K[P]]=F[K[r]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[O]]=K[m];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[P]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[M]]=F[K[f]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[U]];break end;break;end break;end break;end break;end while 2851==(k)/((520452/0x9e))do k=(2385510)while B<=(0xe2-142)do k-= k k=(1463966)while B<=(235-0x99)do k-= k k=(26280)while((487-0x12f)-103)<B do k-= k l[K[p]]=l[K[d]]-l[K[u]];break end while(k)/((49640/0x88))==72 do local O;local k;l[K[P]]=F[K[m]];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[i]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[e]]=l[K[f]][K[w]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[t]];o=o+h;K=b[o];l[K[M]]=l[K[m]][K[i]];o=o+h;K=b[o];k=K[e];O=l[K[d]];l[k+1]=O;l[k]=O[K[U]];o=o+h;K=b[o];k=K[p]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end while(k)/((0x297be/229))==1973 do k=(8684364)while B>((0x276/7)+-#"ÑÑÑÑÑÑÑ")do k-= k local k;k=K[e]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[O]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[P]][K[m]]=K[w];o=o+h;K=b[o];l[K[n]][K[a]]=l[K[t]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[P]]=l[K[H]][K[x]];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[H]))break end while(k)/((0x7ab68/216))==3732 do local k;l[K[n]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[M]]=K[a];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[M]]=K[f];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[P]][K[r]]=l[K[U]];o=o+h;K=b[o];l[K[O]][K[H]]=K[x];o=o+h;K=b[o];l[K[e]][K[m]]=K[t];o=o+h;K=b[o];l[K[P]][K[f]]=K[t];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[w]];break end;break;end break;end while(k)/((0xcc5e2/213))==607 do k=(7588018)while((14013/0x51)+-#[[MSC 793z487nhvcgsdfgsudfza9889jgvz56gz56z547684z5g54z948g56z74j56475jzg645z6456 oh wait]])>=B do k-= k k=(1240320)while(-50+0x87)<B do k-= k local x;local f;local B;local k;l[K[p]]=F[K[m]];o=o+h;K=b[o];l[K[P]]=l[K[m]][K[U]];o=o+h;K=b[o];k=K[P];B=l[K[r]];l[k+1]=B;l[k]=B[K[t]];o=o+h;K=b[o];l[K[P]]=l[K[H]];o=o+h;K=b[o];l[K[e]]=l[K[m]];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];k=K[M];B=l[K[a]];l[k+1]=B;l[k]=B[K[U]];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];f={l,K};f[L][f[S][P]]=f[h][f[S][t]]+f[L][f[S][H]];o=o+h;K=b[o];l[K[e]]=l[K[d]]%K[t];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];B=K[H];x=l[B]for K=B+1,K[i]do x=x..l[K];end;l[K[e]]=x;o=o+h;K=b[o];f={l,K};f[L][f[S][O]]=f[h][f[S][u]]+f[L][f[S][H]];o=o+h;K=b[o];l[K[n]]=l[K[r]]%K[w];break end while(k)/((6585-0xcf9))==380 do o=K[d];break end;break;end while(k)/((-#"da hood money generator 2022 working free no virus"+(0x125e-2374)))==3331 do k=(425280)while(-0x62+(414-0xe5))>=B do k-= k l[K[P]]=s[K[m]];break;end while 1329==(k)/((-#"elbicho"+(38259/0x75)))do k=(4633472)while B>(127+-0x27)do k-= k local O;local k;l[K[M]]=K[f];o=o+h;K=b[o];l[K[p]]=K[m];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[n]][K[a]]=l[K[U]];o=o+h;K=b[o];l[K[n]][K[m]]=K[U];o=o+h;K=b[o];l[K[n]][K[f]]=K[w];o=o+h;K=b[o];l[K[e]][K[f]]=K[U];o=o+h;K=b[o];l[K[n]]=l[K[f]][K[i]];o=o+h;K=b[o];k=K[M];O=l[K[d]];l[k+1]=O;l[k]=O[K[x]];break end while 1696==(k)/((0x30b0c/73))do local m;local k;l[K[M]]=F[K[H]];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[t]];o=o+h;K=b[o];l[K[e]]=l[K[a]][K[w]];o=o+h;K=b[o];l[K[M]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[x]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[u]];o=o+h;K=b[o];k=K[p];m=l[K[f]];l[k+1]=m;l[k]=m[K[u]];o=o+h;K=b[o];k=K[n]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end break;end break;end break;end break;end while 3919==(k)/((0x17b8b/121))do k=(4649665)while B<=(220-0x7a)do k-= k k=(609921)while(-0x13+112)>=B do k-= k k=(6740760)while(11557/0x7f)>=B do k-= k k=(833580)while(0x119-191)<B do k-= k l[K[O]]={};break end while 1980==(k)/(((199368/0xd5)-515))do if not l[K[M]]then o=o+L;else o=K[H];end;break end;break;end while(k)/((0xf2d+(-0xc21/27)))==1788 do k=(2007816)while(-#'windows xp startup sfx'+(0x133-193))<B do k-= k if not l[K[O]]then o=o+L;else o=K[m];end;break end while 538==(k)/((7511-0xec3))do local O=N[K[r]];local m;local h={};m=A({},{__index=function(o,K)local K=h[K];return K[1][K[2]];end,__newindex=function(l,K,o)local K=h[K]K[1][K[2]]=o;end;});for k=1,K[w]do o=o+L;local K=b[o];if K[(-0x32+51)]==32 then h[k-1]={l,K[f]};else h[k-1]={s,K[d]};end;_[#_+1]=h;end;l[K[p]]=D(O,m,F);break end;break;end break;end while 507==(k)/((0x4e4+-49))do k=(5409739)while B<=(2280/(-#"Suck Sus0587"+(-0x2a+78)))do k-= k k=(1310802)while B>((0x2e2-424)-0xdc)do k-= k local k;l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[u]];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];l[K[p]]=K[r];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[n]][K[d]]=l[K[w]];o=o+h;K=b[o];l[K[e]][K[H]]=K[w];o=o+h;K=b[o];l[K[p]][K[m]]=K[u];o=o+h;K=b[o];l[K[p]][K[H]]=K[U];break end while(k)/((-#'real roblox omg builderman caught playing real'+(0xa3c-1367)))==1086 do do return end;break end;break;end while(k)/((725419/0xdf))==1663 do k=(7514986)while(0x13c-220)>=B do k-= k local h=l[K[t]];if not h then o=o+L;else l[K[n]]=h;o=K[a];end;break;end while(k)/(((5759-0xb65)+-20))==2663 do k=(890600)while B>((-#[[If LocalPlayer equals Dumbass then while true do end]]+(-1470/0x15))+0xdb)do k-= k l[K[e]][l[K[d]]]=l[K[x]];break end while 3050==(k)/((605-0x139))do local k;k=K[e]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[P]][K[H]]=l[K[t]];o=o+h;K=b[o];l[K[P]]=F[K[a]];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[x]];o=o+h;K=b[o];l[K[P]]=K[r];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];l[K[M]][K[r]]=l[K[u]];break end;break;end break;end break;end break;end while 1345==(k)/((3571+-0x72))do k=(11681124)while B<=(0xf5-143)do k-= k k=(15898824)while((-0x7c+244)+-#'go kys go kys go kys')>=B do k-= k k=(768792)while(-#[[0 divided by 0]]+(0x145-212))<B do k-= k l[K[p]]=s[K[H]];o=o+h;K=b[o];l[K[M]]=#l[K[r]];o=o+h;K=b[o];s[K[H]]=l[K[e]];o=o+h;K=b[o];l[K[P]]=s[K[m]];o=o+h;K=b[o];l[K[P]]=#l[K[m]];o=o+h;K=b[o];s[K[H]]=l[K[p]];o=o+h;K=b[o];do return end;break end while 1236==(k)/(((-64+0x2b6)+-#'Gay porn'))do local k;l[K[p]]=K[f];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[e]][K[m]]=l[K[t]];o=o+h;K=b[o];l[K[M]]=F[K[f]];o=o+h;K=b[o];l[K[n]]=l[K[d]][K[u]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[x]];o=o+h;K=b[o];l[K[P]][K[r]]=l[K[w]];o=o+h;K=b[o];l[K[n]][K[r]]=K[u];break end;break;end while 4024==(k)/((-#"Impulse youtube ez"+(0xd90e0/224)))do k=(5005480)while B>(-#'mf stfu'+(0x54cc/((0x6783/121)+-#'Impulse youtube ez')))do k-= k local k;l[K[O]]=K[r];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[P]][K[H]]=l[K[x]];o=o+h;K=b[o];l[K[P]][K[a]]=K[u];o=o+h;K=b[o];l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[n]]=l[K[m]][K[w]];o=o+h;K=b[o];l[K[p]][K[d]]=l[K[t]];break end while 2312==(k)/((-33+0x896))do local p;local k;l[K[e]]=F[K[a]];o=o+h;K=b[o];l[K[P]]=l[K[d]][K[t]];o=o+h;K=b[o];l[K[O]]=l[K[m]][K[i]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[t]];o=o+h;K=b[o];l[K[O]]=l[K[f]][K[t]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[U]];o=o+h;K=b[o];k=K[P];p=l[K[f]];l[k+1]=p;l[k]=p[K[U]];o=o+h;K=b[o];k=K[e]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end break;end while(k)/((0x1f3c-4055))==2964 do k=(3953739)while B<=(0x10f-167)do k-= k k=(9165247)while B>((12546/0x52)+-#"da hood money generator 2022 working free no virus")do k-= k local k;k=K[P]l[k](c(l,k+L,K[d]))o=o+h;K=b[o];l[K[n]][K[H]]=l[K[u]];o=o+h;K=b[o];l[K[M]][K[H]]=K[i];o=o+h;K=b[o];l[K[n]][K[d]]=l[K[x]];o=o+h;K=b[o];l[K[M]]=F[K[m]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[w]];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];l[K[M]]=K[a];o=o+h;K=b[o];l[K[O]]=K[r];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[d]))break end while(k)/((-41+0xdba))==2639 do F[K[a]]=l[K[n]];break end;break;end while 3903==(k)/((-#"mike litoris"+(1087+-0x3e)))do k=(5288788)while B<=((0x165-192)+-0x3c)do k-= k local k;l[K[n]]=K[f];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[n]][K[m]]=l[K[w]];o=o+h;K=b[o];l[K[n]]=F[K[f]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[t]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[n]][K[a]]=l[K[w]];o=o+h;K=b[o];l[K[p]][K[H]]=K[i];break;end while 3683==(k)/((2934-0x5da))do k=(4760100)while B>(122+-0x10)do k-= k local k;l[K[M]]=F[K[r]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[n]]=K[m];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[r]))o=o+h;K=b[o];l[K[M]][K[f]]=l[K[U]];o=o+h;K=b[o];l[K[P]]=F[K[d]];o=o+h;K=b[o];l[K[n]]=l[K[H]][K[i]];break end while 1230==(k)/((0xd0ce6/((0x24c-348)+-#"I hate black people")))do local o=K[P]l[o]=l[o](c(l,o+h,K[a]))break end;break;end break;end break;end break;end break;end break;end while(k)/((51578/0x22))==2282 do k=(1459689)while B<=(25000/0xc8)do k-= k k=(4756860)while B<=((-0x2a+167)+-#[[Crackzzzz]])do k-= k k=(8037935)while(256-0x91)>=B do k-= k k=(6320028)while B<=(-#'how to join the kkk'+((27929-0x3699)/109))do k-= k k=(3581376)while(-#"ur mom is hot"+(0x11b-162))<B do k-= k l[K[P]]={};break end while 2433==(k)/((2973-0x5dd))do local H;local k;l[K[e]]=F[K[d]];o=o+h;K=b[o];l[K[M]]=l[K[f]][K[i]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[i]];o=o+h;K=b[o];l[K[M]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[w]];o=o+h;K=b[o];l[K[M]]=l[K[f]][K[x]];o=o+h;K=b[o];k=K[n];H=l[K[m]];l[k+1]=H;l[k]=H[K[x]];o=o+h;K=b[o];k=K[P]l[k](l[k+L])o=o+h;K=b[o];do return end;break end;break;end while 2794==(k)/(((0x1262+-118)-2326))do k=(2982603)while(0x82+-20)<B do k-= k l[K[P]][K[a]]=l[K[x]];break end while 1209==(k)/((-#"atakan der nigga"+((231748/0x5c)+-0x24)))do l[K[P]]=(K[a]~=0);break end;break;end break;end while 3301==(k)/((4936-0x9c5))do k=(1225639)while(0x4db/11)>=B do k-= k k=(3845373)while((-#"false"+(0x17b+-124))-0x8a)<B do k-= k local k;l[K[p]]=K[m];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];l[K[P]][K[r]]=l[K[t]];o=o+h;K=b[o];l[K[e]][K[f]]=K[u];o=o+h;K=b[o];l[K[e]]=F[K[r]];o=o+h;K=b[o];l[K[P]]=l[K[a]][K[i]];o=o+h;K=b[o];l[K[e]]=l[K[r]][K[i]];o=o+h;K=b[o];l[K[P]][K[H]]=l[K[x]];break end while(k)/((2080-0x41b))==3737 do l[K[P]]=F[K[a]];break end;break;end while(k)/((-#"Deezbutts"+(-80+0x480)))==1153 do k=(7509240)while B<=((-0x7e+28)+0xd4)do k-= k l[K[p]]=K[a];break;end while 3060==(k)/((-0x14+2474))do k=(987168)while(12075/0x69)<B do k-= k local k;l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[P]]=l[K[m]][K[u]];o=o+h;K=b[o];l[K[M]]=K[H];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[p]][K[f]]=l[K[U]];o=o+h;K=b[o];l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[e]]=l[K[m]][K[i]];break end while(k)/(((11891-0x1744)-3023))==339 do l[K[O]]=K[a];break end;break;end break;end break;end break;end while(k)/(((0x871b/(84+-0x4b))+-#'Big black men'))==1242 do k=(2232115)while(-#'fix vg hub dekudimz'+(369-0xe6))>=B do k-= k k=(7152138)while(0x128-178)>=B do k-= k k=(14447862)while B>(17082/0x92)do k-= k l[K[p]]=(K[f]~=0);o=o+L;break end while(k)/((0x1d74-3798))==3861 do local k;l[K[e]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[u]];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[M]]=K[d];o=o+h;K=b[o];l[K[p]]=K[r];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];k=K[n]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[e]][K[a]]=l[K[i]];o=o+h;K=b[o];l[K[M]]=F[K[r]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[t]];break end;break;end while 2862==(k)/((((0xd0b3e-427478)+-#"papier ist ein kleiner schwanz lutscher")/171))do k=(2779722)while((31428/0x6c)-0xac)<B do k-= k local k;l[K[P]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[n]]=K[f];o=o+h;K=b[o];l[K[O]]=K[m];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[P]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[p]][K[m]]=l[K[U]];o=o+h;K=b[o];l[K[M]][K[H]]=K[w];o=o+h;K=b[o];l[K[P]][K[m]]=K[t];o=o+h;K=b[o];l[K[P]][K[m]]=K[x];o=o+h;K=b[o];l[K[P]]=l[K[H]][K[w]];break end while(k)/((-37+0x8d3))==1251 do local k;l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[P]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[O]]=K[f];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];l[K[p]]=K[r];o=o+h;K=b[o];l[K[e]]=K[f];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[d]))o=o+h;K=b[o];l[K[p]][K[d]]=l[K[w]];o=o+h;K=b[o];l[K[e]]=F[K[a]];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[x]];break end;break;end break;end while 1031==(k)/((0x8bf+-74))do k=(9661575)while((362-0xe2)+-#[[waste of sperm]])>=B do k-= k k=(4430340)while(0x46e6/150)<B do k-= k local k;k=K[M]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[M]][K[r]]=l[K[w]];o=o+h;K=b[o];l[K[O]][K[d]]=K[x];o=o+h;K=b[o];l[K[O]][K[d]]=l[K[t]];o=o+h;K=b[o];l[K[e]]=F[K[m]];o=o+h;K=b[o];l[K[p]]=l[K[a]][K[t]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];l[K[P]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[a]))break end while(k)/((-0x5e+3354))==1359 do l[K[P]]=(K[r]~=0);break end;break;end while(k)/((-#'impulse loves moonsex'+(0x14dc-2690)))==3675 do k=(379610)while(6273/0x33)>=B do k-= k l[K[M]]=s[K[a]];break;end while 3451==(k)/((-#[[papier ist ein kleiner schwanz lutscher]]+(0x717f/195)))do k=(7975224)while((420-0x10d)+-#'goofy ahh uncle productions')<B do k-= k local k;l[K[p]]=K[m];o=o+h;K=b[o];l[K[n]]=K[a];o=o+h;K=b[o];l[K[e]]=K[m];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[m]))o=o+h;K=b[o];l[K[p]][K[H]]=l[K[w]];o=o+h;K=b[o];l[K[p]]=F[K[H]];o=o+h;K=b[o];l[K[O]]=l[K[m]][K[t]];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[t]];o=o+h;K=b[o];l[K[O]][K[f]]=l[K[t]];o=o+h;K=b[o];l[K[O]][K[a]]=K[U];break end while 2313==(k)/((-#[[null]]+(383172/0x6f)))do local o=K[p]l[o]=l[o](c(l,o+h,K[f]))break end;break;end break;end break;end break;end break;end while 1491==(k)/(((0x848-1119)+-#"windows xp startup sfx"))do k=(7775328)while B<=(0x6506/193)do k-= k k=(8425032)while((0x156-(-#'i fucked your dad'+(327+-0x79)))+-#[[0nly 1337 smashed ur wap]])>=B do k-= k k=(4747833)while(0x1fc/4)>=B do k-= k k=(7560188)while(0x1c0e/57)<B do k-= k local h=K[p];local o=l[K[f]];l[h+1]=o;l[h]=o[K[i]];break end while 1948==(k)/(((0x1ecf-3989)+-#'Impulse real 2022'))do local k;l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[p]]=l[K[H]][K[U]];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];l[K[e]]=K[H];o=o+h;K=b[o];l[K[P]]=K[f];o=o+h;K=b[o];l[K[P]]=K[a];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[f]))o=o+h;K=b[o];l[K[e]][K[f]]=l[K[i]];o=o+h;K=b[o];l[K[p]]=F[K[f]];o=o+h;K=b[o];l[K[M]]=l[K[a]][K[w]];break end;break;end while(k)/((67203/0x39))==4027 do k=(10545163)while(-0x74+244)<B do k-= k local k;l[K[e]]=F[K[m]];o=o+h;K=b[o];l[K[e]]=l[K[f]][K[u]];o=o+h;K=b[o];l[K[P]]=K[m];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](c(l,k+h,K[a]))o=o+h;K=b[o];l[K[p]][K[r]]=l[K[u]];o=o+h;K=b[o];l[K[O]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[r]][K[u]];break end while(k)/((5930-0xba1))==3571 do local k;l[K[e]][K[m]]=K[w];o=o+h;K=b[o];l[K[O]][K[d]]=l[K[U]];o=o+h;K=b[o];l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[M]]=l[K[m]][K[u]];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];l[K[e]]=K[r];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];k=K[e]l[k]=l[k](c(l,k+h,K[H]))o=o+h;K=b[o];l[K[O]][K[r]]=l[K[u]];o=o+h;K=b[o];l[K[n]][K[a]]=K[x];break end;break;end break;end while(k)/((-#"lego hax"+(-118+0xc9c)))==2716 do k=(2054195)while B<=(201+-0x46)do k-= k k=(8337330)while((-0x7d+262)+-#"niggers")<B do k-= k local m=N[K[H]];local p;local h={};p=A({},{__index=function(o,K)local K=h[K];return K[1][K[2]];end,__newindex=function(l,K,o)local K=h[K]K[1][K[2]]=o;end;});for k=1,K[u]do o=o+L;local K=b[o];if K[(128/0x80)]==32 then h[k-1]={l,K[H]};else h[k-1]={s,K[f]};end;_[#_+1]=h;end;l[K[M]]=D(m,p,F);break end while(k)/(((-0x48+2275)+-#[[Bush Did 9 11]]))==3807 do local k;k=K[p]l[k](c(l,k+L,K[H]))o=o+h;K=b[o];l[K[p]][K[a]]=l[K[x]];o=o+h;K=b[o];l[K[O]][K[m]]=K[U];o=o+h;K=b[o];l[K[e]][K[m]]=l[K[i]];o=o+h;K=b[o];l[K[O]]=F[K[H]];o=o+h;K=b[o];l[K[P]]=l[K[H]][K[w]];o=o+h;K=b[o];l[K[n]]=K[r];o=o+h;K=b[o];l[K[e]]=K[H];o=o+h;K=b[o];l[K[O]]=K[a];o=o+h;K=b[o];k=K[p]l[k]=l[k](c(l,k+h,K[H]))break end;break;end while(k)/(((-0x2d+121595)/0x82))==2197 do k=(3770)while B<=(-#"nigglet"+(2085/0xf))do k-= k do return l[K[P]]end break;end while 130==(k)/((-#'brawl stars hard gay porn shelly nsked minecraft gay porn roblox rule34 hot'+(-0x1a+130)))do k=(8166266)while((-0x48+357)-152)<B do k-= k if(l[K[e]]==K[u])then o=o+L;else o=K[f];end;break end while(k)/((189534/0x5d))==4007 do local k;k=K[n]l[k](c(l,k+L,K[a]))o=o+h;K=b[o];l[K[M]][K[H]]=l[K[w]];o=o+h;K=b[o];l[K[P]][K[m]]=K[w];o=o+h;K=b[o];l[K[M]][K[m]]=l[K[w]];o=o+h;K=b[o];l[K[n]]=F[K[r]];o=o+h;K=b[o];l[K[O]]=l[K[d]][K[U]];o=o+h;K=b[o];l[K[n]]=K[H];o=o+h;K=b[o];l[K[M]]=K[f];o=o+h;K=b[o];l[K[n]]=K[H];o=o+h;K=b[o];k=K[M]l[k]=l[k](c(l,k+h,K[H]))break end;break;end break;end break;end break;end while 2388==(k)/((0x9c998/197))do k=(8022000)while B<=(-#'Cock and ball tortue'+(0x172-212))do k-= k k=(4715920)while(0x182-250)>=B do k-= k k=(14197743)while(-0x37+190)<B do k-= k l[K[p]]=F[K[f]];break end while(k)/((0xed3+-18))==3759 do local o=K[n]l[o](c(l,o+L,K[f]))break end;break;end while(k)/((0x1049-2145))==2330 do k=(13213686)while B>(-0x1b+164)do k-= k l[K[e]]=s[K[a]];o=o+h;K=b[o];l[K[n]][K[a]]=K[i];o=o+h;K=b[o];l[K[n]]=s[K[m]];o=o+h;K=b[o];l[K[M]][K[H]]=K[t];o=o+h;K=b[o];l[K[M]]=s[K[m]];o=o+h;K=b[o];l[K[M]][K[m]]=K[i];o=o+h;K=b[o];l[K[O]]=s[K[m]];o=o+h;K=b[o];l[K[M]][K[H]]=K[U];o=o+h;K=b[o];l[K[e]]=s[K[m]];o=o+h;K=b[o];l[K[e]][K[r]]=K[U];o=o+h;K=b[o];l[K[M]]=s[K[f]];o=o+h;K=b[o];l[K[p]][K[a]]=K[t];o=o+h;K=b[o];l[K[e]]=s[K[r]];o=o+h;K=b[o];l[K[O]][K[r]]=K[x];o=o+h;K=b[o];l[K[O]]=s[K[d]];o=o+h;K=b[o];l[K[p]][K[d]]=K[u];o=o+h;K=b[o];l[K[n]]=s[K[m]];o=o+h;K=b[o];l[K[M]][K[m]]=K[i];o=o+h;K=b[o];l[K[n]]=s[K[f]];o=o+h;K=b[o];l[K[O]][K[a]]=K[t];o=o+h;K=b[o];l[K[M]]=s[K[r]];o=o+h;K=b[o];l[K[n]][K[m]]=K[x];o=o+h;K=b[o];do return end;break end while(k)/((((-0x72+346574)/0x55)+-#'dies of cringe'))==3253 do local h=K[e];local b=l[h]local k=l[h+2];if(k>0)then if(b>l[h+1])then o=K[m];else l[h+3]=b;end elseif(b<l[h+1])then o=K[r];else l[h+3]=b;end break end;break;end break;end while(k)/((2843+-0x2b))==2865 do k=(12074256)while((196+-0x2a)+-#[[FranzJPresents]])>=B do k-= k k=(10090767)while((396-0xe3)+-#'impulse was here pastebin reel')<B do k-= k F[K[r]]=l[K[O]];o=o+h;K=b[o];l[K[p]]={};o=o+h;K=b[o];l[K[P]]={};o=o+h;K=b[o];F[K[f]]=l[K[O]];o=o+h;K=b[o];l[K[n]]=F[K[a]];o=o+h;K=b[o];if(l[K[e]]==K[x])then o=o+L;else o=K[d];end;break end while(k)/((0x1792-3067))==3401 do l[K[n]]=D(N[K[f]],nil,F);break end;break;end while(k)/((-24+0xf87))==3056 do k=(4462080)while(0x58ad/161)>=B do k-= k local m;local k;l[K[p]]=(K[a]~=0);o=o+h;K=b[o];l[K[O]]=l[K[d]];o=o+h;K=b[o];l[K[O]]=F[K[f]];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];m=l[K[t]];if not m then o=o+L;else l[K[O]]=m;o=K[H];end;break;end while 1245==(k)/(((0x1c76-3697)+-#"sussy"))do k=(4599210)while B>(-24+0xa6)do k-= k if(l[K[P]]~=l[K[U]])then o=o+L;else o=K[r];end;break end while(k)/((-0x25+1847))==2541 do local k;l[K[M]]=l[K[H]][K[u]];o=o+h;K=b[o];l[K[O]]=K[f];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[H]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[u]];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[f]];o=o+h;K=b[o];l[K[p]]=l[K[r]][K[U]];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[a]];o=o+h;K=b[o];l[K[M]]=l[K[m]][K[u]];o=o+h;K=b[o];l[K[e]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[t]];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[r]];o=o+h;K=b[o];l[K[p]]=l[K[a]][K[u]];o=o+h;K=b[o];l[K[p]]=K[f];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[m]];o=o+h;K=b[o];l[K[p]]=l[K[d]][K[x]];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[m]];o=o+h;K=b[o];l[K[e]]=l[K[H]][K[t]];o=o+h;K=b[o];l[K[e]]=K[a];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[n]]=l[K[a]][K[t]];o=o+h;K=b[o];l[K[p]]=K[a];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[t]];o=o+h;K=b[o];l[K[M]]=K[f];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[n]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[f]][K[t]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];k=K[P]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[f]];o=o+h;K=b[o];l[K[P]]=l[K[f]][K[x]];o=o+h;K=b[o];l[K[M]]=K[m];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[r]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[x]];o=o+h;K=b[o];l[K[P]]=K[H];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[n]]=F[K[m]];o=o+h;K=b[o];l[K[p]]=l[K[H]][K[u]];o=o+h;K=b[o];l[K[p]]=K[d];o=o+h;K=b[o];k=K[e]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[a]];o=o+h;K=b[o];l[K[p]]=l[K[a]][K[i]];o=o+h;K=b[o];l[K[O]]=K[d];o=o+h;K=b[o];k=K[e]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[n]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[i]];o=o+h;K=b[o];l[K[e]]=K[d];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[O]]=F[K[r]];o=o+h;K=b[o];l[K[p]]=l[K[f]][K[w]];o=o+h;K=b[o];l[K[e]]=K[f];o=o+h;K=b[o];k=K[n]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[d]];o=o+h;K=b[o];l[K[P]]=l[K[d]][K[i]];o=o+h;K=b[o];l[K[p]]=K[m];o=o+h;K=b[o];k=K[p]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[M]]=F[K[m]];o=o+h;K=b[o];l[K[O]]=l[K[a]][K[t]];o=o+h;K=b[o];l[K[O]]=K[r];o=o+h;K=b[o];k=K[M]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[P]]=F[K[f]];o=o+h;K=b[o];l[K[O]]=l[K[H]][K[i]];o=o+h;K=b[o];l[K[n]]=K[d];o=o+h;K=b[o];k=K[O]l[k]=l[k](l[k+L])o=o+h;K=b[o];l[K[p]]=F[K[r]];break end;break;end break;end break;end break;end break;end break;end break;end o+= L end;end);end;return D(y(),{},J())()end)_msec({[((-38+0xb4)+-#'Me be like at 5am in the morning')]='\115\116'..(function(K)return(K and'(311-0xd3)')or'\114\105'or'\120\58'end)((480/0x60)==(0x5e-88))..'\110g',[((-93+0x396)+-#"If no milk then return ffather")]='\108\100'..(function(K)return(K and'((22464/0xc0)+-#[[Impulse real 2022]])')or'\101\120'or'\119\111'end)((0x24-31)==(-#[[dies of cringe]]+(0x12d4/241)))..'\112',[(-#{{};(function()return#{('oPHhfo'):find("\72")}>0 and 1 or 0 end);'}','}','nil';'}'}+226)]=(function(K)return(K and'((-0x21+142)+-#\'ambatakum\')')and'\98\121'or'\100\120'end)((0x2da/146)==(975/((-0x2c+253)+-#[[FranzJPresents]])))..'\116\101',[(733-(0x1940/16))]='\99'..(function(K)return(K and'(-#\'if syn request then print your mom then end and then kill yourself\'+(-0x2f+(-#"0nly 1337 smashed ur wap"+(0x22a-317))))')and'\90\19\157'or'\104\97'end)((0x4a1/237)==(-#'mike litoris'+(0xcd5/219)))..'\114',[(0xda36/(-#'Obfuscated By Obamas Left Nut'+(0x128-161)))]='\116\97'..(function(K)return(K and'(-21+0x79)')and'\64\113'or'\98\108'end)(((0xc8d0/36)/0xee)==(-0x44+73))..'\101',[(-0x16+487)]=(function(K)return(K and'(0x109-((18600/0x64)+-#[[impulse loves moonsex]]))')or'\115\117'or'\78\107'end)((-#[[ÑÑÑÑÑÑÑ]]+(0x9c4/250))==(-#"Faggot"+(0x7a-85)))..'\98',[(0x324e4/231)]='\99\111'..(function(K)return(K and'(0x834/21)')and'\110\99'or'\110\105\103\97'end)((1426/(-0x24+82))==(-#[[impulse was here pastebin reel]]+(0x2b5e/(0x1a2-236))))..'\97\116',[(-85+0x2f8)]=(function(K,o)return(K and'(221-0x79)')and'\48\159\158\188\10'or'\109\97'end)((110-0x69)==(1356/0xe2))..'\116\104',[(2793-0x593)]=(function(o,K)return((41-0x24)==(0x49-70)and'\48'..'\195'or o..((not'\20\95\69'and'\90'..'\180'or K)))or'\199\203\95'end),[((0x82f-1102)+-#[[papier ist ein kleiner schwanz lutscher]])]='\105\110'..(function(K,o)return(K and'(14100/0x8d)')and'\90\115\138\115\15'or'\115\101'end)(((0xa2-143)+-#"dies of cringe")==((6321/0x81)+-#"nico der hurensohn"))..'\114\116',[(-73+0x43e)]='\117\110'..(function(K,o)return(K and'((351-0xe6)+-#\'impulse reel pastebin\')')or'\112\97'or'\20\38\154'end)((-#"impulse was here pastebin reel"+(0xad-(-0x3e+200)))==(-#"0nly segc"+((0xca+-89)-0x49)))..'\99\107',[(-#'if true then return your dad'+((-0x29+2410)-0x4c9))]='\115\101'..(function(K)return(K and'((0x152-203)+-#\'how tf do i remove the meme strings\')')and'\110\112\99\104'or'\108\101'end)(((((0x19a-261)+-#[[Impulse youtube real]])-114)+-#[[zykem krul]])==(4030/0x82))..'\99\116',[(-#{",",(function()return{','}end)(),1;108;(function()return#{('lhOFBO'):find("\79")}>0 and 1 or 0 end),{};{}}+1295)]='\116\111\110'..(function(K,o)return(K and'(141+-0x29)')and'\117\109\98'or'\100\97\120\122'end)((0x72+-109)==(82+-0x4d))..'\101\114'},{[(0x62+-59)]=((getfenv))},((getfenv))()) end)()
    
    
    
end)

sec:Button("Funny Weights", function()
    _G.Weight = true;
    while _G.Weight == true do
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight1"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight2"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight3"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight4"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
    end
end)

sec:Button("Stop Funny Weights", function()
    _G.Weight = false;
    while _G.Weight == true do
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight1"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight2"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight3"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
        
        local A_1 = 
        {
            [1] = "Weight", 
            [2] = "Weight4"
        }
        local Event = game:GetService("ReplicatedStorage").RemoteEvent
        Event:FireServer(A_1)
        wait (0,8)
    end
end)


--win:Tab(title <string>)
local tab = win:Tab("Teleport")

  --tab:Section(title <string>)
  local sis = tab:Section("Main Teleports")

  sis:Button("LeadBoards", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-741.752655, 249.7549973, 748.726807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sis:Button("Spawn", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(384.752655, 249.7549973, 867.726807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sis:Button("Ghost Rider", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(175.5, 249.9973, 1237.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sis:Button("Reaper", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-125.5, 249.9973, 529.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sis:Button("Safe in Air", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1892.5, 66666.9973, -666.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)


--tab:Section(title <string>)
local sus = tab:Section("Fist Teleports")

--sec:Button(title <string>, callback <function>)
sus:Button("Rock", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(404.5, 273.9973, 979.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)
  
  sus:Button("Crystal", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2268.5, 1944.9973, 1046.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sus:Button("Blue Star", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1181.5, 4788.9973, -2293.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sus:Button("Green Star", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1381.5, 9274.9973, 1645.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sus:Button("Sun", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-343.5, 15728.9973, 2.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  --tab:Section(title <string>)
local sas = tab:Section("Body Teleports")

sas:Button("Ice Water", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(367.752655, 250.7549973, -444.726807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Fire", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(357.5, 264.9973, -493.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("IceBerg", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1636.5, 260.9973, 2247.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Tornado", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2302.5, 977.9973, 1071.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Volcano", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2059.5, 714.9973, -1885.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Green Fire", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-250.5, 287.9973, 980.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Green Pool", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-272.5, 281.9973, 992.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  sas:Button("Red Pool", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-272.752655, 281.7549973, 1002.726807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

   --tab:Section(title <string>)
local ses = tab:Section("Psychic Teleports")

ses:Button("1M", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2530.5, 5486.9973, -537.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  ses:Button("1B", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2562.5, 5501.9973, -441.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  ses:Button("10T", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2582.5, 5516.9973, -504.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)

  ses:Button("1Qa", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2545.5, 5412.9973, -490.807, -0.0571058802, -2.49452725e-08, 0.998368144, 1.21347377e-09, 1, 2.50554564e-08, -0.998368144, 2.64230726e-09, -0.0571058802)
  end)
