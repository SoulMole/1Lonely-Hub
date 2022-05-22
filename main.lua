if getgenv().LonelyHub_PF then return end
getgenv().LonelyHub_PF = true

local DevMode = false
if getgenv().DevMode then
    DevMode = true
else
    DevMode = false
end

local Version = "1.5"
if DevMode then Version = Version.." (Dev)" end

getgenv().LonelyHub_PF_Version = Version

local themes = {
    SchemeColor = Color3.fromRGB(144, 66, 245),
    Background = Color3.fromRGB(54, 57, 63),
    Header = Color3.fromRGB(32, 34, 37),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(47, 49, 54)
}

local CoolName = "lonely hub"

if getgenv().SonnyHub then
    themes.SchemeColor = Color3.fromRGB(243, 120, 49)
    CoolName = "sonny hub"
end


local camera = game:GetService("Workspace").CurrentCamera

local WaterMark = Drawing.new("Text")
WaterMark.Visible = true
WaterMark.Transparency = 1
WaterMark.Outline = true
WaterMark.Font = 1
WaterMark.Size = 17.5
WaterMark.Center = true
WaterMark.OutlineColor = Color3.new(0,0,0)
WaterMark.Color = themes.SchemeColor
WaterMark.Position = Vector2.new((camera.ViewportSize.X/2), 25)
WaterMark.Text = CoolName.." | v"..Version.." | by: Lonely Planet#0001"

getgenv().SAToggled = false

local function LoadStringUrl(URL)

    local Source
    local Success, Error = pcall(function() Source = game:HttpGet(URL) end)
    
    if Source and Success then
        return loadstring(Source)()
    end
    
    return Source, true
end

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoulMole/Lonely-Hub-Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(CoolName.." | v".. Version, themes)

local SilentAimTab = Window:NewTab("Silent Aim")
local SilentAimSection = SilentAimTab:NewSection("Silent Aim Settings")
local FOVSilentAimSection = SilentAimTab:NewSection("FOV Circle Settings")
local SAWallBangSection = SilentAimTab:NewSection("Wall Bang Settings")
local SAPanicSection = SilentAimTab:NewSection("Panic Settings")

local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Aimbot Settings")
local FOVAimbotSection = AimbotTab:NewSection("FOV Circle Settings")
local ABWallBangSection = AimbotTab:NewSection("Wall Bang Settings")

local CombatTab = Window:NewTab("Combat")
local CombatSection = CombatTab:NewSection("Combat")

local MovementTab = Window:NewTab("Movement")
local MovementSection = MovementTab:NewSection("Movement")

local VisualsTab = Window:NewTab("Visuals")
local EspSection = VisualsTab:NewSection("ESP Settings")
local EspOptionsSection = VisualsTab:NewSection("ESP Extras")
local ESPColorSection = VisualsTab:NewSection("ESP Colors")

local BindsTab = Window:NewTab("Key Binds")
local BindsSection = BindsTab:NewSection("Key Binds")

local ColorTab = Window:NewTab("UI Customizatom")
local ThemeColorSection = ColorTab:NewSection("UI Colors")

local InformationTab = Window:NewTab("Information")
local InformationSection = InformationTab:NewSection("Information")
InformationSection:NewLabel("Version: ".. Version)
InformationSection:NewLabel("Developer Mode: ".. tostring(DevMode))
InformationSection:NewLabel("Hub Developer: Lonely Planet#0001")
InformationSection:NewLabel("UI Library: Kavo Library by xHeptic")
InformationSection:NewLabel("Extra credits: absolutely noone")

local abFOVRingColor = themes.SchemeColor
local saFOVRingColor = themes.SchemeColor


for theme, color in pairs(themes) do
    ThemeColorSection:NewColorPicker(theme, "Change the "..theme.." color.", color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end

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

local function isPointVisible2(targetForWallCheck, mw)
    local castPoints = {targetForWallCheck.Position}
    local ignoreList = {targetForWallCheck, game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    local result = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
    
    return #result <= mw
end

local function isPointVisible(targetForWallCheck, mw)
    local castPoints = {targetForWallCheck.PrimaryPart.Position}
    local ignoreList = {targetForWallCheck, game.Players.LocalPlayer.Character, game.Workspace.CurrentCamera}
    local result = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
    
    return #result <= mw
end
local abLoop

local abSnapFOVRing = false
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
            if (abSnapFOVRing) then
                FOVringOutline.Position = UserInputService:GetMouseLocation()
            else
                FOVringOutline.Position = game.Workspace.CurrentCamera.ViewportSize/2
            end
            
            FOVringList[#FOVringList+1] = FOVringOutline

            local FOVring = Drawing.new("Circle")
            FOVring.Visible = true
            FOVring.Thickness = 2
            FOVring.Radius = fov / workspace.CurrentCamera.FieldOfView
            FOVring.Transparency = 1
            FOVring.Color = abFOVRingColor
            if (abSnapFOVRing) then
                FOVring.Position = UserInputService:GetMouseLocation()
            else
                FOVring.Position = game.Workspace.CurrentCamera.ViewportSize/2
            end
            
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



ABWallBangSection:NewToggle("Wall Check", "Toggles the wall check option", function(state) wallCheck = state end)
ABWallBangSection:NewSlider("Max Wallbangs", "The max ammount of wallbangs to attempt", 10, 0, function(s) maxWalls = s end)
FOVAimbotSection:NewSlider("Size", "", 50000, 500, function(s) fov = s end)
FOVAimbotSection:NewToggle("Centered on Cursor", "Fixes the fov ring to cursor", function(state)
    abSnapFOVRing = state
end)
FOVAimbotSection:NewColorPicker("Color", "The color of the visual ring.", themes.SchemeColor, function(color)
    abFOVRingColor = color
end)
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
local saSnapFOVRing

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
    if (saSnapFOVRing) then
        FOVringOutline.Position = UserInputService:GetMouseLocation()
    else
        FOVringOutline.Position = game.Workspace.CurrentCamera.ViewportSize/2
    end
    
    saFovRingList[#saFovRingList+1] = FOVringOutline

    local FOVring = Drawing.new("Circle")
    FOVring.Visible = true
    FOVring.Thickness = 2
    FOVring.Radius = safov / workspace.CurrentCamera.FieldOfView
    FOVring.Transparency = 1
    FOVring.Color = saFOVRingColor
    if (saSnapFOVRing) then
        FOVring.Position = UserInputService:GetMouseLocation()
    else
        FOVring.Position = game.Workspace.CurrentCamera.ViewportSize/2
    end
            
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

FOVSilentAimSection:NewSlider("Size", "", 50000, 500, function(s) safov = s end)
FOVSilentAimSection:NewToggle("Centered on Cursor", "Fixes the fov ring to cursor", function(state)
    saSnapFOVRing = state
end)
FOVSilentAimSection:NewColorPicker("Color", "The color of the visual ring.", themes.SchemeColor, function(color)
    saFOVRingColor = color
end)

SilentAimSection:NewDropdown("Target Part", "", {"Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}, function(currentOption)saTargetPart = currentOption end)
SAPanicSection:NewToggle("Panic Mode", "Will track closest player if they are within panic distance", function(state) panicMode = state end)
SAPanicSection:NewSlider("Panic Distance", "", 40, 5, function(s) panicDistance = s end)

CIELUVInterpolator = LoadStringUrl("https://raw.githubusercontent.com/SoulMole/1Lonely-Hub/master/utils/cieluv_interpolator.lua")
local HealthbarLerp = CIELUVInterpolator:Lerp(Color3.fromRGB(255, 71, 71), Color3.fromRGB(71, 255, 71))

local ESPElementsList = {}
local width = 3
local height = 5

local espLoop
-- ESP Functions
local Replication, HUD
for Index, Value in pairs(getgc(true)) do
    if typeof(Value) == "table" then 
        if rawget(Value, "getbodyparts") then
            Replication = Value
        end

        if rawget(Value, "getplayerhealth") then
            HUD = Value
        end
    end
end

function IsPlayerAlive(Player)
    return HUD:isplayeralive(Player)
end

function GetHealth(Player)
    local PlayerHealth = HUD:getplayerhealth(Player)

    if PlayerHealth then
        return {
            CurrentHealth = math.floor(PlayerHealth),
            MaxHealth = 100
        }
    end
end

function GetBodyParts(Player)
    local BodyParts = Replication.getbodyparts(Player)

    if BodyParts and BodyParts.torso then
        return {
            Character = BodyParts.torso.Parent,
            Head = BodyParts.head,
            Root = BodyParts.torso,
            Torso = BodyParts.torso,
            LeftArm = BodyParts.larm,
            RightArm = BodyParts.rarm,
            LeftLeg = BodyParts.lleg,
            RightLeg = BodyParts.rleg
        }
    end
end

function IsOnClientTeam(Player)
    if LocalPlayer.Team == Player.Team then
        return true
    end

    return false
end

function GetDistanceFromClient(Position)
    return LocalPlayer:DistanceFromCharacter(Position)
end

function GetScreenPosition(Position)
    local Position, Visible = Workspace.CurrentCamera:WorldToViewportPoint(Position)
    local FullPosition = Position
    Position = Vector2.new(Position.X, Position.Y)

    return Position, Visible, FullPosition
end

function SizeRound(Number, Bracket)
    Bracket = (Bracket or 1)

    if typeof(Number) == "Vector2" then
        return Vector2.new(SizeRound(Number.X), SizeRound(Number.Y))
    else
        return (Number - Number % (Bracket or 1))
    end
end
-- End ESP Functions

local ESPTransparency = 0.1
local ShowHealthBar = false
local ShowTracers = false
local ShowName = false
local ShowTeam = false
local ShowDistance = false
local FontColor = Color3.fromRGB(255, 255, 255)
local ESPColor = themes.SchemeColor
local TeamColor = Color3.fromRGB(68, 255, 162)

EspSection:NewToggle("Enabled", "", function(state)
    if state then
        ESPElementsList = {}
        espLoop = RunService.RenderStepped:Connect(function()
            for i,v in pairs(ESPElementsList) do
                if v then
                    v:Remove()
                end
            end

            ESPElementsList = {}
            for Index, Player in pairs(Players:GetPlayers()) do
                if Player == LocalPlayer then continue end
                
                local OnScreen, IsEnemy = false, true
                local PlayerAlive = IsPlayerAlive(Player)
                local Health = GetHealth(Player)
                local BodyParts = GetBodyParts(Player)
                local OnClientTeam = IsOnClientTeam(Player)
                if ShowTeam == false then
                    if OnClientTeam then IsEnemy = false end
                else
                    IsEnemy = true
                end

                if BodyParts and PlayerAlive and Health and IsEnemy then
                    local HealthPercent = (Health.CurrentHealth / Health.MaxHealth)
                    local ClientDistance = GetDistanceFromClient(BodyParts.Root.Position)
                    ScreenPosition, OnScreen = GetScreenPosition(BodyParts.Root.Position)
                    local Orientation, Size = BodyParts.Character:GetBoundingBox()
                    local Height = (Workspace.CurrentCamera.CFrame - Workspace.CurrentCamera.CFrame.Position) * Vector3.new(0, (math.clamp(Size.Y, 1, 10) + 0.5) / 2, 0)
                    Height = math.abs(Workspace.CurrentCamera:WorldToScreenPoint(Orientation.Position + Height).Y - Workspace.CurrentCamera:WorldToScreenPoint(Orientation.Position - Height).Y)
                    Size = SizeRound(Vector2.new((Height / 2), Height))
                    if OnScreen then
                        local MainESPColor = ESPColor
                        if OnClientTeam then
                            MainESPColor = TeamColor
                        else
                            MainESPColor = ESPColor
                        end
                    
                        local BoxOutline = Drawing.new("Square")   
                        BoxOutline.Visible = true
                        BoxOutline.Thickness = 2
                        BoxOutline.Filled = false
                        BoxOutline.Transparency = ESPTransparency
                        BoxOutline.Color = Color3.fromRGB(0, 0, 0)
                        BoxOutline.Position = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - (Size / 2))
                        BoxOutline.Size = Size

                        local Box = Drawing.new("Square")   
                        Box.Visible = true
                        Box.Thickness = 1
                        Box.Filled = false
                        Box.Transparency = ESPTransparency
                        Box.Color = MainESPColor
                        Box.Position = BoxOutline.Position
                        Box.Size = BoxOutline.Size

                        local HealthBarOBJOutline = Drawing.new("Square")
                        HealthBarOBJOutline.Visible = false
                        HealthBarOBJOutline.Thickness = 3
                        HealthBarOBJOutline.Transparency = ESPTransparency
                        HealthBarOBJOutline.Filled = true
                        HealthBarOBJOutline.Color = Color3.fromRGB(0, 0, 0)
                        HealthBarOBJOutline.Size = Vector2.new(3, (Box.Size.Y + 2))
                        HealthBarOBJOutline.Position = (Vector2.new(Box.Position.X - (BoxOutline.Thickness + 1), Box.Position.Y) - Vector2.new(2, 0))

                        local HealthBarOBJ = Drawing.new("Square")
                        HealthBarOBJ.Visible = false
                        HealthBarOBJ.Thickness = 2
                        HealthBarOBJ.Transparency = ESPTransparency
                        HealthBarOBJ.Filled = true
                        HealthBarOBJ.Color = HealthbarLerp(HealthPercent)
                        HealthBarOBJ.Size = Vector2.new(2, (-Box.Size.Y * HealthPercent))
                        HealthBarOBJ.Position = (Vector2.new(Box.Position.X - (BoxOutline.Thickness + 1), (Box.Position.Y + Box.Size.Y)) - Vector2.new(2, 0))

                        local Name = Drawing.new("Text")
                        Name.Visible = false
                        Name.Transparency = ESPTransparency
                        Name.Center = true
                        Name.Outline = true
                        Name.Font = 1
                        Name.Size = 15
                        Name.Color = FontColor
                        Name.OutlineColor = Color3.new(0,0,0)
                        Name.Text = Player.Name
                        Name.Position = Vector2.new(((Box.Size.X / 2) + Box.Position.X), ((ScreenPosition.Y - Box.Size.Y / 2) - 18))

                        local Distance = Drawing.new("Text")
                        Distance.Visible = false
                        Distance.Transparency = ESPTransparency
                        Distance.Center = true
                        Distance.Outline = true
                        Distance.Font = 1
                        Distance.Size = 15
                        Distance.Color = FontColor
                        Distance.OutlineColor = Color3.new(0,0,0)
                        Distance.Text = string.format("%d studs", ClientDistance)
                        Distance.Position = Vector2.new(((Box.Size.X / 2) + Box.Position.X), ((ScreenPosition.Y + Box.Size.Y / 2) + 18))
                        
                        local TracerOutline = Drawing.new("Line")
                        TracerOutline.Visible = false
                        TracerOutline.Transparency = ESPTransparency
                        TracerOutline.Thickness = 2
                        TracerOutline.Color = Color3.fromRGB(0, 0, 0)
                        TracerOutline.To = Vector2.new(((Box.Size.X / 2) + Box.Position.X), (ScreenPosition.Y + Box.Size.Y / 2))
                        TracerOutline.From = Vector2.new((camera.ViewportSize.X/2), camera.ViewportSize.Y)

                        local Tracer = Drawing.new("Line")
                        Tracer.Visible = false
                        Tracer.Transparency = ESPTransparency
                        Tracer.Thickness = 1
                        Tracer.Color = MainESPColor
                        Tracer.To = TracerOutline.To
                        Tracer.From = TracerOutline.From

                        if ShowHealthBar then
                            HealthBarOBJOutline.Visible = true
                            HealthBarOBJ.Visible = true
                        end
                        if ShowName then
                            Name.Visible = true
                        end
                        if ShowDistance then
                            Distance.Visible = true
                        end
                        if ShowTracers then
                            Tracer.Visible = true
                            TracerOutline.Visible = true
                        end

                        ESPElementsList[#ESPElementsList+1] = BoxOutline
                        ESPElementsList[#ESPElementsList+1] = Box
                        ESPElementsList[#ESPElementsList+1] = HealthBarOBJOutline
                        ESPElementsList[#ESPElementsList+1] = HealthBarOBJ
                        ESPElementsList[#ESPElementsList+1] = Name
                        ESPElementsList[#ESPElementsList+1] = Distance
                        ESPElementsList[#ESPElementsList+1] = Tracer
                        ESPElementsList[#ESPElementsList+1] = TracerOutline
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

EspSection:NewSlider("ESP Transparency", "How transparent the esp elements are ", 100, 10, function(val)
    ESPTransparency = val / 100
end)

EspOptionsSection:NewToggle("Show Health", "Shows a health bar on the left of the player", function(state)
    ShowHealthBar = state
end)
EspOptionsSection:NewToggle("Show Tracers", "Shows a line from your screen to the player", function(state)
    ShowTracers = state
end)
EspOptionsSection:NewToggle("Show Names", "Shows the players name above the player", function(state)
    ShowName = state
end)
EspOptionsSection:NewToggle("Show Distance", "Shows the distance under the player", function(state)
    ShowDistance = state
end)
EspOptionsSection:NewToggle("Show Teammates", "Shows team mates", function(state)
    ShowTeam = state
end)
ESPColorSection:NewColorPicker("Enemy Color", "The box around the enemies color", themes.SchemeColor, function(color)
    ESPColor = color
end)
ESPColorSection:NewColorPicker("Team Color", "The box around the enemies color", Color3.fromRGB(68, 255, 162), function(color)
    TeamColor = color
end)
ESPColorSection:NewColorPicker("Font Color", "The font color of the name and distance.", Color3.fromRGB(255, 255, 255), function(color)
    FontColor = color
end)

BindsSection:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)

local GunMods = {}
local NoRecoil = false
local NoSpread = false
local NoSway = false

function EditGunMods()
    GunMods = {
        Recoil = NoRecoil,
        Spread = NoSpread,
        Sway = NoSway,
    }
    
    for i, s in pairs(game:GetService("ReplicatedStorage").GunModules:GetChildren()) do
        rs = require(s)
        if GunMods.Recoil == true then
            rs.aimrotkickmin = Vector3.new(0, 0, 0)
            rs.aimrotkickmax = Vector3.new(0, 0, 0)
            rs.aimtranskickmin = Vector3.new(0, 0, 0)
            rs.aimtranskickmax = Vector3.new(0, 0, 0)
            rs.aimcamkickmin = Vector3.new(0, 0, 0)
            rs.aimcamkickmax = Vector3.new(0, 0, 0)
            rs.camkickspeed = 99999
            rs.rotkickmin = Vector3.new(0, 0, 0)
            rs.rotkickmax = Vector3.new(0, 0, 0)
            rs.transkickmin = Vector3.new(0, 0, 0)
            rs.transkickmax = Vector3.new(0, 0, 0)
            rs.camkickmin = Vector3.new(0, 0, 0)
            rs.camkickmax = Vector3.new(0, 0, 0)
            rs.aimcamkickspeed = 99999
            rs.modelkickspeed = 99999
            rs.modelrecoverspeed = 99999
        end
        if GunMods.Spread == true then
            rs.hipfirespread = 0.00001
            rs.hipfirestability = 0.00001
            rs.hipfirespreadrecover = 99999
            rs.crosssize = 5
            rs.crossexpansion = 0.00001
        end
        if GunMods.Sway == true then
            rs.swayamp = 0
            rs.swayspeed = 0
            rs.steadyspeed = 0
            rs.breathspeed = 0
        end
    end
end

CombatSection:NewButton("No Recoil", "Removes Recoil (Single Use)", function()
    NoRecoil = true
    EditGunMods()
end)
CombatSection:NewButton("No Spread", "Removes Spread (Single Use)", function()
    NoSpread = true
    EditGunMods()
end)
CombatSection:NewButton("No Sway", "Removes Sway (Single Use)", function()
    NoSway = true
    EditGunMods()
end)


local WalkSpeed = 0
local WSMovementSection = MovementTab:NewSection("Walkspeed")
local WalkSpeedLoop
WSMovementSection:NewToggle("Enabled", "Sets the walkspeed to the max default", function(state)
    if state then
        local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
        WalkSpeedLoop = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            Humanoid.WalkSpeed = Humanoid.WalkSpeed + WalkSpeed;
        end)
    else
        WalkSpeedLoop:Disconnect()
    end
end)

WSMovementSection:NewSlider("Increase", "Adds more walk speed to the function", 30, 0, function(val)
    WalkSpeed = val
end)

MovementSection:NewToggle("Bunny Hop", "Allows to bunny hop like a retard", function(state)
    if state then
        RunService:BindToRenderStep("BhopLoop", 1, function()
            if not game:GetService('Players').LocalPlayer.Character and game:GetService('Players').LocalPlayer.Character:FindFirstChild('Humanoid') then
                return
            end
            
            game:GetService('Players').LocalPlayer.Character.Humanoid.Jump = game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.Space)
        end)
    else
        RunService:UnbindFromRenderStep("BhopLoop")
    end
end)

if DevMode then
    local DevTab = Window:NewTab("Dev")
    local DevSection = DevTab:NewSection("Dev Tools")
    DevSection:NewButton("Dev Testies", "ButtonInfo", function()
       print('test')
    end)
end
