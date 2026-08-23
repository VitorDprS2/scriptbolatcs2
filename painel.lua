--[[
    NerdTTK Texture Mod Ball - The Classic Soccer
    Script visual para trocar texturas da bola
    Compativel com Xeno Executor
    Apenas visual - Sem vantagem competitiva
]]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Tabela de Texturas Disponiveis
local textures = {
    {name = "Bola Original", meshId = "rbxasset://textures/Blank.png", textureId = "rbxasset://textures/Blank.png"},
    {name = "Bola Fire", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066046"},
    {name = "Bola Neon", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066047"},
    {name = "Bola Cosmic", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066048"},
    {name = "Bola Agua", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066049"},
    {name = "Bola Espelho", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066050"},
    {name = "Bola Madeira", meshId = "rbxassetid://9475066045", textureId = "rbxassetid://9475066051"},
}

-- Configuracao da UI
local UICorner = 15

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NerdTTK_Texture_Mod"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(1, -420, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, UICorner)
corner.Parent = mainFrame

-- Stroke para o frame
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 200, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Titulo
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
titleCorner.CornerRadius = UDim.new(0, UICorner)
titleCorner.Parent = titleLabel

-- Subtitulo
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
subtitleLabel.Position = UDim2.new(0, 0, 0, 50)
subtitleLabel.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
subtitleLabel.BorderSizePixel = 0
subtitleLabel.Text = "Apenas Visual - Sem Vantagem"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitleLabel.TextSize = 12
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = mainFrame

-- ScrollingFrame para as texturas
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 0, 350)
scrollFrame.Position = UDim2.new(0, 5, 0, 85)
scrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #textures * 55 + 20)
scrollFrame.Parent = mainFrame

-- UIListLayout no ScrollFrame
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

-- Padding
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)
padding.PaddingTop = UDim.new(0, 5)
padding.PaddingBottom = UDim.new(0, 5)
padding.Parent = scrollFrame

-- Criar botoes de texturas
local textureButtons = {}

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
    
    -- Label do nome
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
    
    -- Icone de aplicar
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
    
    -- Funcao ao clicar
    button.MouseButton1Click:Connect(function()
        ApplyTexture(texture)
        
        -- Efeito visual
        button.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
        task.wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
    end)
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(35, 75, 110)
        btnStroke.Color = Color3.fromRGB(100, 200, 255)
        btnStroke.Thickness = 2
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
        btnStroke.Thickness = 1
    end)
    
    table.insert(textureButtons, button)
end

-- Footer
local footerLabel = Instance.new("TextLabel")
footerLabel.Name = "FooterLabel"
footerLabel.Size = UDim2.new(1, 0, 0, 30)
footerLabel.Position = UDim2.new(0, 0, 1, -30)
footerLabel.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
footerLabel.BorderSizePixel = 0
footerLabel.Text = "Press [P] to Toggle - Made by NerdTTK"
footerLabel.TextColor3 = Color3.fromRGB(100, 150, 180)
footerLabel.TextSize = 10
footerLabel.Font = Enum.Font.Gotham
footerLabel.Parent = mainFrame

-- Funcao para aplicar textura
function ApplyTexture(texture)
    local workspace = game:GetService("Workspace")
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("soccer_ball")
    
    if not ball then
        print("Bola nao encontrada!")
        return
    end
    
    -- Aplicar texture na bola
    if ball:IsA("Part") then
        ball.Color = Color3.fromRGB(255, 255, 255)
        
        if ball:FindFirstChild("Mesh") then
            local mesh = ball.Mesh
            mesh.MeshId = texture.meshId
            mesh.TextureId = texture.textureId
        else
            local newMesh = Instance.new("SpecialMesh")
            newMesh.MeshType = Enum.MeshType.Sphere
            newMesh.MeshId = texture.meshId
            newMesh.TextureId = texture.textureId
            newMesh.Parent = ball
        end
        
        if ball:FindFirstChild("SurfaceGui") then
            ball.SurfaceGui:Destroy()
        end
    end
    
    print("Textura aplicada: " .. texture.name)
end

-- Toggle da UI com P
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.P then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Notificacao de script carregado
local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, -150, 0, 20)
notification.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
notification.BorderSizePixel = 0
notification.Text = "NerdTTK Texture Mod Carregado!"
notification.TextColor3 = Color3.fromRGB(255, 255, 255)
notification.TextSize = 14
notification.Font = Enum.Font.GothamBold
notification.Parent = screenGui

local notiCorner = Instance.new("UICorner")
notiCorner.CornerRadius = UDim.new(0, 10)
notiCorner.Parent = notification

task.wait(3)
notification:Destroy()

print("NerdTTK Texture Mod Ball - Script Iniciado!")
print("Pressione P para abrir/fechar a UI")
print("Selecione uma textura para aplicar")