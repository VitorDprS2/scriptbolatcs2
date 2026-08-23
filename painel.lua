local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local textures = {
    {name = "Bola Original", meshId = "", textureId = ""},
    {name = "Bola Fire", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066046"},
    {name = "Bola Neon", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066047"},
    {name = "Bola Cosmic", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066048"},
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NerdTTK_Texture_Mod"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 600)
mainFrame.Position = UDim2.new(1, -420, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 200, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "NERDTTK TEXTURE MOD"
titleLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleLabel

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
subtitleLabel.Position = UDim2.new(0, 0, 0, 50)
subtitleLabel.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
subtitleLabel.BorderSizePixel = 0
subtitleLabel.Text = "The Classic Soccer Ball Texture Mod"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextSize = 12
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainFrame

local customMeshLabel = Instance.new("TextLabel")
customMeshLabel.Name = "CustomMeshLabel"
customMeshLabel.Size = UDim2.new(1, -10, 0, 20)
customMeshLabel.Position = UDim2.new(0, 5, 0, 85)
customMeshLabel.BackgroundTransparency = 1
customMeshLabel.Text = "MeshID:"
customMeshLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
customMeshLabel.TextSize = 12
customMeshLabel.Font = Enum.Font.GothamBold
customMeshLabel.TextXAlignment = Enum.TextXAlignment.Left
customMeshLabel.Parent = mainFrame

local customMeshInput = Instance.new("TextBox")
customMeshInput.Name = "CustomMeshInput"
customMeshInput.Size = UDim2.new(1, -10, 0, 30)
customMeshInput.Position = UDim2.new(0, 5, 0, 105)
customMeshInput.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
customMeshInput.BorderSizePixel = 0
customMeshInput.Text = ""
customMeshInput.TextColor3 = Color3.fromRGB(100, 200, 255)
customMeshInput.TextSize = 12
customMeshInput.Font = Enum.Font.Gotham
customMeshInput.PlaceholderText = "rbxassetid://12345678"
customMeshInput.Parent = mainFrame

local meshCorner = Instance.new("UICorner")
meshCorner.CornerRadius = UDim.new(0, 8)
meshCorner.Parent = customMeshInput

local customTextureLabel = Instance.new("TextLabel")
customTextureLabel.Name = "CustomTextureLabel"
customTextureLabel.Size = UDim2.new(1, -10, 0, 20)
customTextureLabel.Position = UDim2.new(0, 5, 0, 140)
customTextureLabel.BackgroundTransparency = 1
customTextureLabel.Text = "TextureID:"
customTextureLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
customTextureLabel.TextSize = 12
customTextureLabel.Font = Enum.Font.GothamBold
customTextureLabel.TextXAlignment = Enum.TextXAlignment.Left
customTextureLabel.Parent = mainFrame

local customTextureInput = Instance.new("TextBox")
customTextureInput.Name = "CustomTextureInput"
customTextureInput.Size = UDim2.new(1, -10, 0, 30)
customTextureInput.Position = UDim2.new(0, 5, 0, 160)
customTextureInput.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
customTextureInput.BorderSizePixel = 0
customTextureInput.Text = ""
customTextureInput.TextColor3 = Color3.fromRGB(100, 200, 255)
customTextureInput.TextSize = 12
customTextureInput.Font = Enum.Font.Gotham
customTextureInput.PlaceholderText = "rbxassetid://87654321"
customTextureInput.Parent = mainFrame

local textureCorner = Instance.new("UICorner")
textureCorner.CornerRadius = UDim.new(0, 8)
textureCorner.Parent = customTextureInput

local applyCustomButton = Instance.new("TextButton")
applyCustomButton.Name = "ApplyCustomButton"
applyCustomButton.Size = UDim2.new(1, -10, 0, 35)
applyCustomButton.Position = UDim2.new(0, 5, 0, 195)
applyCustomButton.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
applyCustomButton.BorderSizePixel = 0
applyCustomButton.Text = "Aplicar Customizado"
applyCustomButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyCustomButton.TextSize = 13
applyCustomButton.Font = Enum.Font.GothamBold
applyCustomButton.Parent = mainFrame

local customBtnCorner = Instance.new("UICorner")
customBtnCorner.CornerRadius = UDim.new(0, 8)
customBtnCorner.Parent = applyCustomButton

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 0, 280)
scrollFrame.Position = UDim2.new(0, 5, 0, 235)
scrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #textures * 55 + 20)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)
padding.PaddingTop = UDim.new(0, 5)
padding.PaddingBottom = UDim.new(0, 5)
padding.Parent = scrollFrame

function FindBall()
    local workspace = game:GetService("Workspace")
    
    local ball = workspace:FindFirstChild("Ball")
    if ball then return ball end
    
    ball = workspace:FindFirstChild("soccer_ball")
    if ball then return ball end
    
    ball = workspace:FindFirstChild("SoccerBall")
    if ball then return ball end
    
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name:lower():find("ball") or part.Name:lower():find("soccer")) then
            return part
        end
    end
    
    return nil
end

function ApplyTexture(meshId, textureId)
    local ball = FindBall()
    
    if not ball then
        print("Bola nao encontrada!")
        return false
    end
    
    print("Bola encontrada: " .. ball.Name)
    
    if ball:IsA("BasePart") then
        local allMeshes = ball:FindFirstChildOfClass("SpecialMesh")
        
        if allMeshes then
            allMeshes:Destroy()
            print("Mesh antigo removido")
        end
        
        if meshId ~= "" and textureId ~= "" then
            local newMesh = Instance.new("SpecialMesh")
            newMesh.MeshType = Enum.MeshType.Sphere
            newMesh.MeshId = meshId
            newMesh.TextureId = textureId
            newMesh.Scale = Vector3.new(1, 1, 1)
            newMesh.Parent = ball
            
            print("Novo mesh criado!")
            print("MeshId: " .. meshId)
            print("TextureId: " .. textureId)
        end
        
        return true
    end
    
    return false
end

for index, texture in ipairs(textures) do
    local button = Instance.new("TextButton")
    button.Name = texture.name
    button.Size = UDim2.new(1, -10, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
    button.BorderSizePixel = 0
    button.Text = ""
    button.Parent = scrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = button
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(70, 150, 220)
    btnStroke.Thickness = 1
    btnStroke.Parent = button
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.7, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = texture.name
    nameLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = button
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0.3, 0, 1, 0)
    iconLabel.Position = UDim2.new(0.7, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = ">"
    iconLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    iconLabel.TextSize = 16
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Right
    iconLabel.Parent = button
    
    button.MouseButton1Click:Connect(function()
        ApplyTexture(texture.meshId, texture.textureId)
        button.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
        task.wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
    end)
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(35, 75, 110)
        btnStroke.Color = Color3.fromRGB(100, 200, 255)
        btnStroke.Thickness = 2
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
        btnStroke.Thickness = 1
    end)
end

applyCustomButton.MouseButton1Click:Connect(function()
    local customMesh = customMeshInput.Text
    local customTexture = customTextureInput.Text
    
    if customMesh == "" and customTexture == "" then
        print("Preencha pelo menos um campo!")
        return
    end
    
    ApplyTexture(customMesh, customTexture)
    
    applyCustomButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    task.wait(0.1)
    applyCustomButton.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
end)

applyCustomButton.MouseEnter:Connect(function()
    applyCustomButton.BackgroundColor3 = Color3.fromRGB(70, 170, 240)
end)

applyCustomButton.MouseLeave:Connect(function()
    applyCustomButton.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, -150, 0, 20)
notification.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
notification.BorderSizePixel = 0
notification.Text = "Script Carregado! Pressione K"
notification.TextColor3 = Color3.fromRGB(255, 255, 255)
notification.TextSize = 14
notification.Font = Enum.Font.GothamBold
notification.Parent = screenGui

local notiCorner = Instance.new("UICorner")
notiCorner.CornerRadius = UDim.new(0, 10)
notiCorner.Parent = notification

task.wait(3)
notification:Destroy()

print("Script iniciado! Pressione K para abrir a UI")