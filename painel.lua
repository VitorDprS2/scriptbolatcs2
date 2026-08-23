local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.Name = "NerdttkGUI"

local mainFrame = Instance.new("Frame")
mainFrame.Name = "AlteradorDeBall"
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 250, 0, 350)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.Parent = mainFrame
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Alterador de ball nerdãottk"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.BackgroundTransparency = 0.3
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local bolaNovaBtn = Instance.new("TextButton")
bolaNovaBtn.Parent = mainFrame
bolaNovaBtn.Size = UDim2.new(0.8, 0, 0, 40)
bolaNovaBtn.Position = UDim2.new(0.1, 0, 0.2, 10)
bolaNovaBtn.Text = "BOLA NOVA: OFF"
bolaNovaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
bolaNovaBtn.Font = Enum.Font.GothamBold
bolaNovaBtn.TextSize = 14

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = bolaNovaBtn
btnCorner.CornerRadius = UDim.new(0, 5)

local tembarBtn = Instance.new("TextButton")
tembarBtn.Parent = mainFrame
tembarBtn.Size = UDim2.new(0.8, 0, 0, 40)
tembarBtn.Position = UDim2.new(0.1, 0, 0.35, 15)
tembarBtn.Text = "D da Tembar"
tembarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tembarBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tembarBtn.Font = Enum.Font.GothamBold
tembarBtn.TextSize = 14

local btnCorner2 = Instance.new("UICorner")
btnCorner2.Parent = tembarBtn
btnCorner2.CornerRadius = UDim.new(0, 5)

local meshBtn = Instance.new("TextButton")
meshBtn.Parent = mainFrame
meshBtn.Size = UDim2.new(0.8, 0, 0, 40)
meshBtn.Position = UDim2.new(0.1, 0, 0.5, 20)
meshBtn.Text = "D da Mesh MeshCombing"
meshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
meshBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
meshBtn.Font = Enum.Font.GothamBold
meshBtn.TextSize = 14

local btnCorner3 = Instance.new("UICorner")
btnCorner3.Parent = meshBtn
btnCorner3.CornerRadius = UDim.new(0, 5)

local removerTexturaBtn = Instance.new("TextButton")
removerTexturaBtn.Parent = mainFrame
removerTexturaBtn.Size = UDim2.new(0.8, 0, 0, 40)
removerTexturaBtn.Position = UDim2.new(0.1, 0, 0.65, 25)
removerTexturaBtn.Text = "REMOVER TEXTURA"
removerTexturaBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
removerTexturaBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
removerTexturaBtn.Font = Enum.Font.GothamBold
removerTexturaBtn.TextSize = 14

local btnCorner4 = Instance.new("UICorner")
btnCorner4.Parent = removerTexturaBtn
btnCorner4.CornerRadius = UDim.new(0, 5)

local resetarMeshBtn = Instance.new("TextButton")
resetarMeshBtn.Parent = mainFrame
resetarMeshBtn.Size = UDim2.new(0.8, 0, 0, 40)
resetarMeshBtn.Position = UDim2.new(0.1, 0, 0.8, 30)
resetarMeshBtn.Text = "RESETAR MESH"
resetarMeshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetarMeshBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
resetarMeshBtn.Font = Enum.Font.GothamBold
resetarMeshBtn.TextSize = 14

local btnCorner5 = Instance.new("UICorner")
btnCorner5.Parent = resetarMeshBtn
btnCorner5.CornerRadius = UDim.new(0, 5)

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(1, 0)

local bolaAtiva = false

local function findBall()
    local ball = workspace:FindFirstChild("Ball")
    if not ball then
        local possibleNames = {"Ball", "Bola", "SoccerBall", "Football", "Futebol", "nerdttk"}
        for _, name in ipairs(possibleNames) do
            ball = workspace:FindFirstChild(name)
            if ball then break end
        end
    end
    return ball
end

local function renameToNerdottk()
    local ball = findBall()
    if ball then
        ball.Name = "nerdttk"
        return true
    end
    return false
end

local function resetBallName()
    local ball = findBall()
    if ball then
        ball.Name = "Ball"
        return true
    end
    return false
end

bolaNovaBtn.MouseButton1Click:Connect(function()
    bolaAtiva = not bolaAtiva
    if bolaAtiva then
        bolaNovaBtn.Text = "BOLA NOVA: ON"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        renameToNerdottk()
    else
        bolaNovaBtn.Text = "BOLA NOVA: OFF"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        resetBallName()
    end
end)

tembarBtn.MouseButton1Click:Connect(function()
    tembarBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    task.wait(0.1)
    tembarBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    renameToNerdottk()
    print("Bola renomeada para: nerdttk")
end)

meshBtn.MouseButton1Click:Connect(function()
    meshBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    task.wait(0.1)
    meshBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    renameToNerdottk()
    print("Mesh aplicada: nerdttk")
end)

removerTexturaBtn.MouseButton1Click:Connect(function()
    removerTexturaBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
    task.wait(0.1)
    removerTexturaBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    local ball = findBall()
    if ball then
        for _, child in ipairs(ball:GetChildren()) do
            if child:IsA("Texture") or child:IsA("Decal") then
                child:Destroy()
            end
        end
        for _, part in ipairs(ball:GetDescendants()) do
            if part:IsA("Texture") or part:IsA("Decal") then
                part:Destroy()
            end
        end
        print("Texturas removidas da bola")
    end
end)

resetarMeshBtn.MouseButton1Click:Connect(function()
    resetarMeshBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 100)
    task.wait(0.1)
    resetarMeshBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
    resetBallName()
    print("Mesh resetada")
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local userInputService = game:GetService("UserInputService")
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.B then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

if bolaAtiva then
    renameToNerdottk()
end

print("Painel Alterador de Ball nerdttk carregado!")
print("Pressione 'B' para abrir/fechar o painel")