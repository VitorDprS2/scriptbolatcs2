-- Script com suporte a MeshId e MeshContent
-- Criado por: VitorDprS2

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NerdttkGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== FUNCAO PARA ENCONTRAR A BOLA =====
local function findBall()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("BasePart") then
            local nome = child.Name:lower()
            if nome:find("ball") or nome:find("bola") or nome:find("futebol") or nome:find("soccer") then
                return child
            end
            local mesh = child:FindFirstChildWhichIsA("SpecialMesh")
            if mesh and mesh.MeshType == Enum.MeshType.Sphere then
                return child
            end
        end
    end
    return nil
end

-- ===== FUNCAO PARA APLICAR A MESH =====
local function aplicarMesh(ball, meshId, meshContent)
    if not ball then
        warn("Bola nao encontrada!")
        return false
    end
    
    local sucesso = false
    
    -- TENTA USAR MeshContent (para MeshPart)
    if ball:IsA("MeshPart") then
        pcall(function()
            ball.MeshContent = meshContent
            print("MeshContent aplicado em MeshPart: " .. meshContent)
            sucesso = true
        end)
        if sucesso then return true end
    end
    
    -- TENTA USAR MeshId (para SpecialMesh)
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if not mesh then
        mesh = Instance.new("SpecialMesh")
        mesh.Parent = ball
    end
    
    pcall(function()
        mesh.MeshId = meshId
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.Scale = Vector3.new(1, 1, 1)
        print("MeshId aplicado em SpecialMesh: " .. meshId)
        sucesso = true
    end)
    
    -- SE NENHUM FUNCIONOU, TENTA SUBSTITUIR A BOLA
    if not sucesso then
        warn("Nenhum metodo funcionou, tentando substituir a bola...")
        local newBall = Instance.new("Part")
        newBall.Size = ball.Size
        newBall.Position = ball.Position
        newBall.CFrame = ball.CFrame
        newBall.Anchored = ball.Anchored
        newBall.CanCollide = ball.CanCollide
        newBall.Parent = workspace
        
        local newMesh = Instance.new("SpecialMesh")
        newMesh.Parent = newBall
        newMesh.MeshId = meshId
        newMesh.MeshType = Enum.MeshType.FileMesh
        newMesh.Scale = Vector3.new(1, 1, 1)
        
        ball:Destroy()
        print("Bola substituida com sucesso!")
        return true
    end
    
    return sucesso
end

-- ===== FUNCAO PARA RENOMEAR =====
local function renameToNerdttk()
    local ball = findBall()
    if ball then
        ball.Name = "nerdttk"
        return true
    end
    return false
end

-- ===== FUNCAO PARA RESETAR =====
local function resetBallName()
    local ball = findBall()
    if ball then
        ball.Name = "Ball"
        return true
    end
    return false
end

-- ===== FUNCAO PARA REMOVER TEXTURAS =====
local function removerTexturas()
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
        return true
    end
    return false
end

-- ===== DEBUG =====
local function debugBola()
    print("=== DEBUG DA BOLA ===")
    local ball = findBall()
    if not ball then
        print("Nenhuma bola encontrada!")
        return
    end
    
    print("Nome: " .. ball.Name)
    print("Classe: " .. ball.ClassName)
    print("Local: " .. ball.Parent.Name)
    
    if ball:IsA("MeshPart") then
        print("Tipo: MeshPart")
        print("MeshContent: " .. tostring(ball.MeshContent))
        print("MeshId: " .. tostring(ball.MeshId))
    end
    
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if mesh then
        print("Tem SpecialMesh")
        print("MeshId: " .. tostring(mesh.MeshId))
        print("MeshType: " .. tostring(mesh.MeshType))
    end
    
    print("=== FIM DEBUG ===")
end

-- ============================================
-- ====== CRIACAO DA UI ======
-- ============================================

local background = Instance.new("Frame")
background.Parent = gui
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5
background.Active = true

local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 400, 0, 600)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 15)

-- TITULO
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "ALTERADOR DE BALL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
title.BackgroundTransparency = 0.3
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local titleCorner = Instance.new("UICorner")
titleCorner.Parent = title
titleCorner.CornerRadius = UDim.new(0, 15)

-- SUBTITULO
local subtitle = Instance.new("TextLabel")
subtitle.Parent = mainFrame
subtitle.Size = UDim2.new(1, 0, 0, 25)
subtitle.Position = UDim2.new(0, 0, 0, 50)
subtitle.Text = "Suporte a MeshId e MeshContent"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13

-- LABEL ID
local idLabel = Instance.new("TextLabel")
idLabel.Parent = mainFrame
idLabel.Size = UDim2.new(0.8, 0, 0, 20)
idLabel.Position = UDim2.new(0.1, 0, 0.17, 0)
idLabel.Text = "ID da Mesh:"
idLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
idLabel.BackgroundTransparency = 1
idLabel.Font = Enum.Font.GothamBold
idLabel.TextSize = 13
idLabel.TextXAlignment = Enum.TextXAlignment.Left

-- CAMPO ID
local idInput = Instance.new("TextBox")
idInput.Parent = mainFrame
idInput.Size = UDim2.new(0.8, 0, 0, 35)
idInput.Position = UDim2.new(0.1, 0, 0.22, 0)
idInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
idInput.BorderSizePixel = 0
idInput.Text = "rbxassetid://11765504"
idInput.TextColor3 = Color3.fromRGB(255, 255, 255)
idInput.Font = Enum.Font.Gotham
idInput.TextSize = 14
idInput.ClearTextOnFocus = false

local idCorner = Instance.new("UICorner")
idCorner.Parent = idInput
idCorner.CornerRadius = UDim.new(0, 8)

-- BOTAO APLICAR MESH
local aplicarMeshBtn = Instance.new("TextButton")
aplicarMeshBtn.Parent = mainFrame
aplicarMeshBtn.Size = UDim2.new(0.8, 0, 0, 40)
aplicarMeshBtn.Position = UDim2.new(0.1, 0, 0.31, 0)
aplicarMeshBtn.Text = "APLICAR MESH"
aplicarMeshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aplicarMeshBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
aplicarMeshBtn.Font = Enum.Font.GothamBold
aplicarMeshBtn.TextSize = 15

local btnCorner1 = Instance.new("UICorner")
btnCorner1.Parent = aplicarMeshBtn
btnCorner1.CornerRadius = UDim.new(0, 8)

-- BOTAO NOME
local bolaNovaBtn = Instance.new("TextButton")
bolaNovaBtn.Parent = mainFrame
bolaNovaBtn.Size = UDim2.new(0.38, 0, 0, 40)
bolaNovaBtn.Position = UDim2.new(0.06, 0, 0.40, 0)
bolaNovaBtn.Text = "Nome: OFF"
bolaNovaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
bolaNovaBtn.Font = Enum.Font.GothamBold
bolaNovaBtn.TextSize = 13

local btnCorner2 = Instance.new("UICorner")
btnCorner2.Parent = bolaNovaBtn
btnCorner2.CornerRadius = UDim.new(0, 8)

-- BOTAO RENOMEAR
local renomearBtn = Instance.new("TextButton")
renomearBtn.Parent = mainFrame
renomearBtn.Size = UDim2.new(0.38, 0, 0, 40)
renomearBtn.Position = UDim2.new(0.56, 0, 0.40, 0)
renomearBtn.Text = "Renomear"
renomearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
renomearBtn.BackgroundColor3 = Color3.fromRGB(50, 70, 50)
renomearBtn.Font = Enum.Font.GothamBold
renomearBtn.TextSize = 13

local btnCorner3 = Instance.new("UICorner")
btnCorner3.Parent = renomearBtn
btnCorner3.CornerRadius = UDim.new(0, 8)

-- BOTAO REMOVER TEXTURA
local removerTexBtn = Instance.new("TextButton")
removerTexBtn.Parent = mainFrame
removerTexBtn.Size = UDim2.new(0.38, 0, 0, 40)
removerTexBtn.Position = UDim2.new(0.06, 0, 0.50, 0)
removerTexBtn.Text = "Remover Tex"
removerTexBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
removerTexBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
removerTexBtn.Font = Enum.Font.GothamBold
removerTexBtn.TextSize = 13

local btnCorner4 = Instance.new("UICorner")
btnCorner4.Parent = removerTexBtn
btnCorner4.CornerRadius = UDim.new(0, 8)

-- BOTAO RESETAR
local resetarBtn = Instance.new("TextButton")
resetarBtn.Parent = mainFrame
resetarBtn.Size = UDim2.new(0.38, 0, 0, 40)
resetarBtn.Position = UDim2.new(0.56, 0, 0.50, 0)
resetarBtn.Text = "Resetar"
resetarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetarBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
resetarBtn.Font = Enum.Font.GothamBold
resetarBtn.TextSize = 13

local btnCorner5 = Instance.new("UICorner")
btnCorner5.Parent = resetarBtn
btnCorner5.CornerRadius = UDim.new(0, 8)

-- STATUS
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = mainFrame
statusLabel.Size = UDim2.new(0.9, 0, 0, 40)
statusLabel.Position = UDim2.new(0.05, 0, 0.60, 0)
statusLabel.Text = "Pronto"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextWrapped = true

-- BOTAO DEBUG
local debugBtn = Instance.new("TextButton")
debugBtn.Parent = mainFrame
debugBtn.Size = UDim2.new(0.8, 0, 0, 35)
debugBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
debugBtn.Text = "DEBUG - Ver tipo da bola"
debugBtn.TextColor3 = Color3.fromRGB(255, 255, 200)
debugBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
debugBtn.Font = Enum.Font.Gotham
debugBtn.TextSize = 13

local btnCorner6 = Instance.new("UICorner")
btnCorner6.Parent = debugBtn
btnCorner6.CornerRadius = UDim.new(0, 8)

-- BOTAO FECHAR
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -42, 0, 8)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(1, 0)

-- ============================================
-- ====== ACOES DOS BOTOES ======
-- ============================================

aplicarMeshBtn.MouseButton1Click:Connect(function()
    local id = idInput.Text
    if id and id ~= "" then
        local ball = findBall()
        if not ball then
            statusLabel.Text = "Bola nao encontrada!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        
        -- Tenta aplicar com MeshId e MeshContent
        if aplicarMesh(ball, id, id) then
            statusLabel.Text = "Mesh aplicada com sucesso!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "Falha ao aplicar mesh!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        statusLabel.Text = "Digite um ID valido!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    end
end)

local bolaAtiva = false
bolaNovaBtn.MouseButton1Click:Connect(function()
    bolaAtiva = not bolaAtiva
    if bolaAtiva then
        bolaNovaBtn.Text = "Nome: ON"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        renameToNerdttk()
        statusLabel.Text = "Nome alterado para nerdttk"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        bolaNovaBtn.Text = "Nome: OFF"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        resetBallName()
        statusLabel.Text = "Nome resetado para Ball"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end)

renomearBtn.MouseButton1Click:Connect(function()
    if renameToNerdttk() then
        statusLabel.Text = "Renomeado para nerdttk"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        bolaAtiva = true
        bolaNovaBtn.Text = "Nome: ON"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    else
        statusLabel.Text = "Bola nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

removerTexBtn.MouseButton1Click:Connect(function()
    if removerTexturas() then
        statusLabel.Text = "Texturas removidas!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.Text = "Bola nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

resetarBtn.MouseButton1Click:Connect(function()
    if resetBallName() then
        statusLabel.Text = "Nome resetado para Ball"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        bolaAtiva = false
        bolaNovaBtn.Text = "Nome: OFF"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    else
        statusLabel.Text = "Bola nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

debugBtn.MouseButton1Click:Connect(function()
    debugBola()
    statusLabel.Text = "Debug executado! Veja F9"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    background.Visible = mainFrame.Visible
end)

local userInputService = game:GetService("UserInputService")
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.B then
        mainFrame.Visible = not mainFrame.Visible
        background.Visible = mainFrame.Visible
    end
end)

-- ============================================
-- ====== INICIALIZACAO ======
-- ============================================

print("========================================")
print("ALTERADOR DE BALL - MeshId e MeshContent")
print("========================================")
print("Pressione B para abrir/fechar")
print("ID padrao: rbxassetid://11765504")
print("========================================")

local ball = findBall()
if ball then
    print("Bola encontrada: " .. ball.Name)
    statusLabel.Text = "Bola: " .. ball.Name
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
else
    print("Nenhuma bola encontrada!")
    statusLabel.Text = "Nenhuma bola encontrada!"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
end