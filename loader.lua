local MainColor = Color3.fromRGB(144, 66, 245)
local AllowedPlaces = {292439477}
local LHLoadString = "https://pst.klgrth.io/paste/e8ukf/raw"

local function LoadGUI()
    local LonelyLoader = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local HeaderCover = Instance.new("Frame")
    local CloseButton = Instance.new("ImageButton")
    local TextLabel = Instance.new("TextLabel")
    local ContentArea = Instance.new("Frame")
    local GameButton = Instance.new("TextButton")
    local GameButtonCorner = Instance.new("UICorner")
    local Developer = Instance.new("TextLabel")
    local DeveloperCorner = Instance.new("UICorner")

    LonelyLoader.Name = "LonelyLoader"
    LonelyLoader.Parent = game.CoreGui
    LonelyLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = LonelyLoader
    Main.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.421352237, 0, 0.423631847, 0)
    Main.Size = UDim2.new(0, 300, 0, 164)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    Header.Size = UDim2.new(0, 300, 0, 28)

    HeaderCorner.CornerRadius = UDim.new(0, 4)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    HeaderCover.Name = "HeaderCover"
    HeaderCover.Parent = Main
    HeaderCover.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    HeaderCover.BorderColor3 = Color3.fromRGB(32, 34, 37)
    HeaderCover.BorderSizePixel = 0
    HeaderCover.Position = UDim2.new(0, 0, 0.109999999, 0)
    HeaderCover.Size = UDim2.new(0, 300, 0, 10)

    CloseButton.Name = "Close Button"
    CloseButton.Parent = Main
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.903999984, 0, 0.0149999997, 0)
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)

    TextLabel.Parent = Main
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.0390907787, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 105, 0, 29)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Text = "lonely loader"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 16.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Main
    ContentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentArea.BackgroundTransparency = 1.000
    ContentArea.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0.0333333351, 0, 0.226666331, 0)
    ContentArea.Size = UDim2.new(0, 278, 0, 117)


    GameButton.Name = "GameButton"
    GameButton.Parent = ContentArea
    GameButton.BackgroundColor3 = getgenv().LH_Color
    GameButton.BorderSizePixel = 0
    GameButton.Position = UDim2.new(0.0816766769, 0, 0.155548275, 0)
    GameButton.Size = UDim2.new(0, 233, 0, 35)
    GameButton.Font = Enum.Font.Gotham
    GameButton.Text = "Loading..."
    GameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameButton.TextSize = 16.000
    GameButton.BackgroundColor3 = MainColor
    GameButtonCorner.CornerRadius = UDim.new(0, 4)
    GameButtonCorner.Name = "GameButtonCorner"
    GameButtonCorner.Parent = GameButton

    Developer.Name = "Developer"
    Developer.Parent = ContentArea
    Developer.BackgroundColor3 = Color3.fromRGB(61, 63, 70)
    Developer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Developer.BorderSizePixel = 0
    Developer.Position = UDim2.new(0.079136692, 0, 0.553485572, 0)
    Developer.Size = UDim2.new(0, 233, 0, 35)
    Developer.Font = Enum.Font.Gotham
    Developer.Text = "By: Lonely Planet#0001"
    Developer.TextColor3 = Color3.fromRGB(255, 255, 255)
    Developer.TextSize = 16.000

    DeveloperCorner.CornerRadius = UDim.new(0, 4)
    DeveloperCorner.Name = "DeveloperCorner"
    DeveloperCorner.Parent = Developer

    -- Scripts:

    local function YTVCB_fake_script() -- CloseButton.CloseScript 
        local script = Instance.new('LocalScript', CloseButton)

        local close = script.Parent
        local Main = script.Parent.Parent
        local e1 = script.Parent.Parent['ContentArea']
        local e2 = script.Parent.Parent['HeaderCover']
        local e3 = script.Parent.Parent['Header']
        local e4 = script.Parent.Parent['ContentArea']['Developer']
        local e5 = script.Parent.Parent['ContentArea']['GameButton']
        local e6 = script.Parent.Parent['TextLabel']
        
        close.MouseButton1Click:Connect(function()
            game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ImageTransparency = 1
            }):Play()
            game.TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1
            }):Play()
            game.TweenService:Create(e1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1
            }):Play()
            game.TweenService:Create(e2, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1
            }):Play()
            game.TweenService:Create(e3, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1
            }):Play()
            game.TweenService:Create(e4, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
            game.TweenService:Create(e5, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
            game.TweenService:Create(e6, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
            wait(0.25)
            script.Parent.Parent.Parent:Destroy()
        end)
        
    end
    coroutine.wrap(YTVCB_fake_script)()
    local function TZLL_fake_script() -- GameButton.GameScript 
        local script = Instance.new('LocalScript', GameButton)

        local completed = false
        local gameid = 0
        local gameloadstring = ""
        
        if game.PlaceId == 292439477 then
            wait(2)
            script.Parent.Text = "Phantom Forces"
            completed = true
            gameid = game.PlaceId
            gameloadstring = LHLoadString
        else
            wait(2)
            script.Parent.Text = "Invalid Game"
            completed = false
        end
        
        script.Parent.MouseButton1Click:Connect(function()
            if completed == false then return end
            if gameid == 0 or gameloadstring == "" then return end
            
            loadstring(game:HttpGet(gameloadstring))()
            script.Parent.Parent.Parent.Parent:Destroy()
        end)
    end
    coroutine.wrap(TZLL_fake_script)()
end

local function ArrayContains (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

if getgenv().LH_Color then MainColor = getgenv().LH_Color end

if ArrayContains(AllowedPlaces, game.PlaceId) then LoadGUI()
else print('lonely hub: Not loaded, invalid game') end