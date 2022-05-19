getgenv().DevMode = true

local themes = {
    SchemeColor = Color3.fromRGB(144, 66, 245),
    Background = Color3.fromRGB(54, 57, 63),
    Header = Color3.fromRGB(32, 34, 37),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(47, 49, 54)
}

getgenv().SAToggled = false

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoulMole/Lonely-Hub-Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("lonely hub", themes)

local SilentAimTab = Window:NewTab("Silent Aim")
local SilentAimSection = SilentAimTab:NewSection("Silent Aim Settings")
local SAWallBangSection = SilentAimTab:NewSection("Wall Bang Settings")
local SAPanicSection = SilentAimTab:NewSection("Panic Settings")

local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Aimbot")

local EspTab = Window:NewTab("ESP")
local EspSection = EspTab:NewSection("ESP") 

local BindsTab = Window:NewTab("Key Binds")
local BindsSection = BindsTab:NewSection("Key Binds")

local ColorTab = Window:NewTab("Color")
local ESPColorSection = ColorTab:NewSection("ESP Colors")
local FOVRingColorSection = ColorTab:NewSection("Ring Colors")
local ThemeColorSection = ColorTab:NewSection("Theme Colors")



local FOVRingColor = Color3.fromRGB(144, 66, 245)
local ESPColor = Color3.fromRGB(144, 66, 245)

for theme, color in pairs(themes) do
    ThemeColorSection:NewColorPicker(theme, "Change the "..theme.." color.", color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end

FOVRingColorSection:NewColorPicker("FOV Ring Color", "The color of the visual ring.", Color3.fromRGB(144, 66, 245), function(color)
    FOVRingColor = color
end)

ESPColorSection:NewColorPicker("Box ESP Color", "The box around the enemies color", Color3.fromRGB(144, 66, 245), function(color)
    ESPColor = color
end)

local function getTeam()
    local localPlayerGhostsTeamName = "Ghosts"
    local playerFolderGhostsTeamName = "Bright orange"
    local playerFolderPhantomsTeamName = "Bright blue"
    
    if game.Players.LocalPlayer.Team.Name == localPlayerGhostsTeamName then return playerFolderPhantomsTeamName else return playerFolderGhostsTeamName end
end

local smoothing = 1
local fov = 500
local wallCheck = false
local maxWalls = 0
local abTargetPart = "Head"
local FOVringList = {}

local function isPointVisible(targetForWallCheck, mw)
    local castPoints = {targetForWallCheck.PrimaryPart.Position}
    local ignoreList = {targetForWallCheck, game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    local result = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
    
    return #result <= mw
end
local abLoop
AimbotSection:NewToggle("Enabled", "Toggles whether aimbot is on or not.", function(state)
    if state then
        FOVringList = {}
        abLoop = RunService.RenderStepped:Connect(function()
            for i,v in pairs(FOVringList) do
                v:Remove()
            end
            
            FOVringList = {}
            
            local FOVringOutline = Drawing.new("Circle")
            FOVringOutline.Visible = true
            FOVringOutline.Thickness = 3
            FOVringOutline.Radius = fov / workspace.CurrentCamera.FieldOfView
            FOVringOutline.Transparency = 1
            FOVringOutline.Color = Color3.fromRGB(0, 0, 0)
            FOVringOutline.Position = game.Workspace.CurrentCamera.ViewportSize/2
            
            FOVringList[#FOVringList+1] = FOVringOutline

            local FOVring = Drawing.new("Circle")
            FOVring.Visible = true
            FOVring.Thickness = 2
            FOVring.Radius = fov / workspace.CurrentCamera.FieldOfView
            FOVring.Transparency = 1
            FOVring.Color = FOVRingColor
            FOVring.Position = game.Workspace.CurrentCamera.ViewportSize/2
            
            FOVringList[#FOVringList+1] = FOVring
            
            local team = getTeam()
            
            local target = Vector2.new(math.huge, math.huge)
            local targetPos
            local targetPlayer
            if game.Workspace.Players:FindFirstChild(team) then
                for i,v in pairs(game.Workspace.Players:FindFirstChild(team):GetChildren()) do
                    local pos = v[abTargetPart].Position
                    local ScreenSpacePos, IsOnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
                    ScreenSpacePos = Vector2.new(ScreenSpacePos.X, ScreenSpacePos.Y) - game.Workspace.CurrentCamera.ViewportSize/2
                    
                    if IsOnScreen and ScreenSpacePos.Magnitude < target.Magnitude and (isPointVisible(v, maxWalls) or not wallCheck) then
                        target = ScreenSpacePos
                        targetPos = pos
                        targetPlayer = v
                    end
                end
            end
            
            if target.Magnitude <= fov / workspace.CurrentCamera.FieldOfView and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                if target ~= Vector2.new(math.huge, math.huge) then
                    mousemoverel(target.X/smoothing, target.Y/smoothing)
                end
            end
        end)
    else
        abLoop:Disconnect()
        for i,v in pairs(FOVringList) do
            v:Remove()
        end
    end
end)

AimbotSection:NewToggle("Wall Check", "Toggles the wall check option", function(state) wallCheck = state end)
AimbotSection:NewSlider("Max Wallbangs", "The max ammount of wallbangs to attempt", 10, 0, function(s) maxWalls = s end)
AimbotSection:NewSlider("FOV Size", "The size of the FOV to target players", 50000, 500, function(s) fov = s end)
AimbotSection:NewSlider("Smoothing", "The smoothness of the aimbot", 300, 100, function(s) smoothing = s/100 end)
AimbotSection:NewDropdown("Target Part", "The humanoid part to target to", {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}, function(currentOption) abTargetPart = currentOption end)

local saTargetPart = "Head"
local safov = 500
local panicMode = false
local panicDistance = 5
local saWallCheck = false
local saWallBangs = 0
local gunCF
local motor
local saFovRingList = {}

saLoop = RunService.RenderStepped:Connect(function()
    for i,v in pairs(saFovRingList) do
        v:Remove()
    end
    saFovRingList = {}
    if not getgenv().SAToggled then return end   
    local FOVringOutline = Drawing.new("Circle")
    FOVringOutline.Visible = true
    FOVringOutline.Thickness = 3
    FOVringOutline.Radius = safov / workspace.CurrentCamera.FieldOfView
    FOVringOutline.Transparency = 1
    FOVringOutline.Color = Color3.fromRGB(0, 0, 0)
    FOVringOutline.Position = game.Workspace.CurrentCamera.ViewportSize/2
    
    saFovRingList[#saFovRingList+1] = FOVringOutline

    local FOVring = Drawing.new("Circle")
    FOVring.Visible = true
    FOVring.Thickness = 2
    FOVring.Radius = safov / workspace.CurrentCamera.FieldOfView
    FOVring.Transparency = 1
    FOVring.Color = FOVRingColor
    FOVring.Position = game.Workspace.CurrentCamera.ViewportSize/2
            
    saFovRingList[#saFovRingList+1] = FOVring
    
    local team = getTeam()
    
    local targetPos
    local last = Vector2.new(math.huge, math.huge)
    if game.Workspace.Players:FindFirstChild(team) then
        for i,v in pairs(game.Workspace.Players:FindFirstChild(team):GetChildren()) do
            local pos = v[saTargetPart].Position
            local ScreenSpacePos, IsOnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
            ScreenSpacePos = Vector2.new(ScreenSpacePos.X, ScreenSpacePos.Y) - game.Workspace.CurrentCamera.ViewportSize/2
            
            if (v[saTargetPart].Position - Workspace.CurrentCamera.CFrame.Position).Magnitude <= panicDistance and panicMode then
                targetPos = pos
                break
            end
                    
            if IsOnScreen and ScreenSpacePos.Magnitude < last.Magnitude and ScreenSpacePos.Magnitude <= (safov / workspace.CurrentCamera.FieldOfView) and (isPointVisible(v, saWallBangs) or not saWallCheck) then
                last = ScreenSpacePos
                targetPos = pos
            end
        end
    end
    if targetPos then
        motor = Workspace.CurrentCamera:GetChildren()[3].Trigger.Motor6D
        local cf = motor.C0
                
        local cf2 = CFrame.new(motor.Part0.CFrame:ToWorldSpace(cf).Position, targetPos)
        gunCF = motor.Part0.CFrame:ToObjectSpace(cf2)
    else
        gunCF = nil
        motor = nil
    end
end)
local OldIndex
OldIndex = hookmetamethod(game, "__newindex", newcclosure(function(...)
    local Self, Key, Value = ...

    if getgenv().SAToggled and motor and gunCF and Self == motor and Key == "C0" then
        return OldIndex(Self, Key, gunCF)
    end

    return OldIndex(...)
end))

local SAToggle = SilentAimSection:NewToggle("Silent Aim", "", function(state)
    getgenv().SAToggled = state
end)

SAWallBangSection:NewToggle("Wall Check", "", function(state) saWallCheck = state end)
SAWallBangSection:NewSlider("Max Wallbangs", "Inclusive", 10, 0, function(s) saWallBangs = s end)
SilentAimSection:NewSlider("Fov", "", 50000, 500, function(s) safov = s end)
SilentAimSection:NewDropdown("Target Part", "", {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}, function(currentOption)saTargetPart = currentOption end)
SAPanicSection:NewToggle("Panic Mode", "Will track closest player if they are within panic distance", function(state) panicMode = state end)
SAPanicSection:NewSlider("Panic Distance", "", 40, 5, function(s) panicDistance = s end)
-- ESP Shit



-- local CIELUVInterpolator = LoadFile("utilities/cieluv_interpolator.lua")
-- local HealthbarLerp = CIELUVInterpolator:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))

-- local HealthPercent = (70 / 100)

local ESPElementsList = {}
local width = 3
local height = 5

local espLoop
EspSection:NewToggle("Enabled", "", function(state)
    if state then
        ESPElementsList = {}
        espLoop = RunService.RenderStepped:Connect(function()
            for i,v in pairs(ESPElementsList) do
                if v then
                    v:Remove()
                end
            end
            
            local team = getTeam()

            ESPElementsList = {}
            if game.Workspace.Players:FindFirstChild(team) then
                for i,v in pairs(game.Workspace.Players:FindFirstChild(team):GetChildren()) do
                    
                    local BoxSize = Vector2.new(100, 200)
                    local pos = v.PrimaryPart.Position
                    local ScreenSpacePos, IsOnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
                    
                    Body = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(0, height/2, 0)))
                    a = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(width/2, height/2, 0)))
                    b = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(-width/2, height/2, 0)))
                    c = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(-width/2, -height/2, 0)))
                    d = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Torso.CFrame:PointToWorldSpace(Vector3.new(width/2, -height/2, 0)))
                    
                    Body = Vector2.new(Body.X, Body.Y)
                    a = Vector2.new(a.X, a.Y)
                    b = Vector2.new(b.X, b.Y)
                    c = Vector2.new(c.X, c.Y)
                    d = Vector2.new(d.X, d.Y)
                    
                    if IsOnScreen then
                        local BoxOutline = Drawing.new("Quad")   
                        BoxOutline.Visible = true
                        BoxOutline.Thickness = 3
                        BoxOutline.Transparency = 1
                        BoxOutline.Color = Color3.fromRGB(0, 0, 0)
                        BoxOutline.PointA = a
                        BoxOutline.PointB = b
                        BoxOutline.PointC = c
                        BoxOutline.PointD = d

                        ESPElementsList[#ESPElementsList+1] = BoxOutline

                        local Box = Drawing.new("Quad")   
                        Box.Visible = true
                        Box.Thickness = 2
                        Box.Transparency = 1
                        Box.Color = ESPColor
                        Box.PointA = a
                        Box.PointB = b
                        Box.PointC = c
                        Box.PointD = d

                        ESPElementsList[#ESPElementsList+1] = Box

                        local Name = Drawing.new("Text")
                        Name.Visible = true
                        Name.Transparency = 1
                        Name.Center = true
                        Name.Outline = true
                        Name.Font = 2
                        Name.Size = 15
                        Name.Color = ESPColor
                        Name.OutlineColor = Color3.new(0,0,0)
                        Name.Text = v.Name
                        Name.Position = Body
                        
                        ESPElementsList[#ESPElementsList+1] = Name
                    end
                end
            end
        end)
    else
        espLoop:Disconnect()
        for i,v in pairs(ESPElementsList) do
            v:Remove()
        end
        ESPElementsList = {}
    end
end)

if getgenv().DevMode then
    local DevTab = Window:NewTab("Dev")
    local DevSection = DevTab:NewSection("Dev Tools")
    DevSection:NewButton("Dev Testies", "ButtonInfo", function()
       
    end)
end
-- ESP Shit end


BindsSection:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)

BindsSection:NewKeybind("Toggle Silent Aim", "Toggles Silent Aim", Enum.KeyCode.J, function()
	if getgenv().SAToggled then
        getgenv().SAToggled = false
    else
        getgenv().SAToggled = true
    end
end)
