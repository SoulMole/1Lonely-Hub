local function LoadChangeLog()
    -- Instances:

    local Changelog = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local HeaderCover = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local ContentArea = Instance.new("Frame")
    local Changes = Instance.new("TextLabel")
    local TextLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("ImageButton")

    --Properties:

    Changelog.Name = "Changelog"
    Changelog.Parent = game.CoreGui
    Changelog.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = Changelog
    Main.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.4020814, 0, 0.402315825, 0)
    Main.Size = UDim2.new(0, 375, 0, 210)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    HeaderCover.Name = "HeaderCover"
    HeaderCover.Parent = Main
    HeaderCover.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    HeaderCover.BorderColor3 = Color3.fromRGB(32, 34, 37)
    HeaderCover.BorderSizePixel = 0
    HeaderCover.Position = UDim2.new(0, 0, 0.0861905292, 0)
    HeaderCover.Size = UDim2.new(0, 375, 0, 10)

    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    Header.Size = UDim2.new(0, 375, 0, 28)

    HeaderCorner.CornerRadius = UDim.new(0, 4)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Main
    ContentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentArea.BackgroundTransparency = 1.000
    ContentArea.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0.0282975268, 0, 0.194957629, 0)
    ContentArea.Size = UDim2.new(0, 354, 0, 158)

    Changes.Name = "Changes"
    Changes.Parent = ContentArea
    Changes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Changes.BackgroundTransparency = 1.000
    Changes.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Changes.BorderSizePixel = 0
    Changes.Position = UDim2.new(0, 0, 0.00831557158, 0)
    Changes.Size = UDim2.new(0, 354, 0, 161)
    Changes.Font = Enum.Font.Gotham
    Changes.TextColor3 = Color3.fromRGB(255, 255, 255)
    Changes.TextSize = 15.000
    Changes.Text = game:HttpGet("http://52.255.55.167:1337/changelog", true)
    Changes.TextXAlignment = Enum.TextXAlignment.Left
    Changes.TextYAlignment = Enum.TextYAlignment.Top

    TextLabel.Parent = Main
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.0282975268, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 159, 0, 29)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Text = "lonely changelog"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 16.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "Close Button"
    CloseButton.Parent = Main
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.930000007, 0, 0.0149999997, 0)
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)

    -- Scripts:
    coroutine.wrap(RCSBPSJ_fake_script)()
    local function YLCGHHZ_fake_script() -- CloseButton.CloseScript 
        local script = Instance.new('LocalScript', CloseButton)

        local close = script.Parent
        local Main = script.Parent.Parent
        local e1 = script.Parent.Parent['ContentArea']
        local e2 = script.Parent.Parent['HeaderCover']
        local e3 = script.Parent.Parent['Header']
        local e4 = script.Parent.Parent['ContentArea']['Changes']
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
            game.TweenService:Create(e6, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
            wait(0.25)
            script.Parent.Parent.Parent:Destroy()
        end)
        
    end
    coroutine.wrap(YLCGHHZ_fake_script)()
end

local function getexploit()
    local exploit =
        (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or
        (KRNL_LOADED and "KRNL") or
        (nil)
  
    return exploit
  end    

local response = request({Url = "http://52.255.55.167:1337/lloader/"..getgenv().LH_Key, Method = "GET"}).Body
    getgenv().LH_Excutor = getexploit()
    if string.find(response, 'https://raw.githubusercontent.com') then
        loadstring(game:HttpGet(response))()
        LoadChangeLog()
    end
