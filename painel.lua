-- Script para TCS com Reach, Hitbox e ESP
-- Criado por: VitorDprS2

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NerdttkGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== VARIAVEIS GLOBAIS =====
local reachMultiplier = 1
local espEnabled = false
local hitboxVisible = false
local hitboxPart = nil

-- ===== FUNCAO PARA ENCONTRAR A BOLA =====
local function findBall()
    local ball = workspace:FindFirstChild("TPS")
    if ball then return ball end
    
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("BasePart") then
            local nome = child.Name:lower()
            if nome:find("ball") or nome:find("bola") or nome:find("tps") then
                return child
            end
        end
    end
    return nil
end

-- ===== FUNCAO PARA PEGAR O REACH (Character.Humanoid) =====
local function getReach()
    local char = player.Character
    if not char then return nil end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return nil end
    return humanoid
end

-- ===== FUNCAO PARA ALTERAR REACH =====
local function alterarReach(valor)
    local humanoid = getReach()
    if not humanoid then
        print("Humanoid nao encontrado!")
        return false
    end
    
    -- Tenta diferentes propriedades de alcance
    local propriedades = {"Reach", "InteractDistance", "GrabDistance", "PickupDistance"}
    local alterado = false
    
    for _, prop in ipairs(propriedades) do
        if humanoid:FindFirstChild(prop) then
            pcall(function()
                humanoid[prop] = valor
                print("Reach alterado para: " .. valor .. " (via " .. prop .. ")")
                alterado = true
            end)
        end
    end
    
    -- Se nao achou propriedade especifica, tenta via atributo
    if not alterado then
        pcall(function()
            humanoid:SetAttribute("Reach", valor)
            print("Reach alterado para: " .. valor .. " (via atributo)")
            alterado = true
        end)
    end
    
    return alterado
end

-- ===== FUNCAO PARA CRIAR HITBOX VISUAL =====
local function criarHitbox()
    removerHitbox()
    
    local ball = findBall()
    if not ball then
        print("Bola nao encontrada para hitbox!")
        return
    end
    
    hitboxPart = Instance.new("Part")
    hitboxPart.Name = "HitboxVisual"
    hitboxPart.Size = ball.Size * 1.5
    hitboxPart.Position = ball.Position
    hitboxPart.Anchored = true
    hitboxPart.CanCollide = false
    hitboxPart.Transparency = 0.7
    hitboxPart.BrickColor = BrickColor.new("Bright red")
    hitboxPart.Material = Enum.Material.SmoothPlastic
    hitboxPart.Parent = workspace
    
    -- Wireframe para ficar mais visivel
    local boxHandle = Instance.new("BoxHandleAdornment")
    boxHandle.Parent = hitboxPart
    boxHandle.Adornee = hitboxPart
    boxHandle.Size = hitboxPart.Size
    boxHandle.AlwaysOnTop = true
    boxHandle.ZIndex = 10
    boxHandle.Color3 = Color3.fromRGB(255, 0, 0)
    boxHandle.Transparency = 0.3
    
    print("Hitbox criada!")
    hitboxVisible = true
end

local function removerHitbox()
    if hitboxPart then
        hitboxPart:Destroy()
        hitboxPart = nil
    end
    hitboxVisible = false
    print("Hitbox removida!")
end

local function atualizarHitbox()
    if not hitboxVisible or not hitboxPart then return end
    local ball = findBall()
    if ball then
        hitboxPart.Position = ball.Position
        hitboxPart.Size = ball.Size * 1.5
        local adornment = hitboxPart:FindFirstChildWhichIsA("BoxHandleAdornment")
        if adornment then
            adornment.Size = hitboxPart.Size
        end
    end
end

-- ===== FUNCAO ESP PARA A BOLA =====
local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        criarESP()
    else
        removerESP()
    end
end

local espHighlights = {}

local function criarESP()
    removerESP()
    
    local ball = findBall()
    if not ball then
        print("Bola nao encontrada para ESP!")
        return
    end
    
    -- Highlight na bola
    local highlight = Instance.new("Highlight")
    highlight.Parent = ball
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    table.insert(espHighlights, highlight)
    
    -- Adiciona uma seta/ping acima da bola
    local ping = Instance.new("BillboardGui")
    ping.Name = "ESPPing"
    ping.Parent = ball
    ping.Size = UDim2.new(0, 100, 0, 50)
    ping.StudsOffset = Vector3.new(0, 4, 0)
    ping.AlwaysOnTop = true
    
    local label = Instance.new("TextLabel")
    label.Parent = ping
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⚽ BOLA"
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0.3
    
    print("ESP ativado!")
end

local function removerESP()
    for _, h in ipairs(espHighlights) do
        pcall(function() h:Destroy() end)
    end
    espHighlights = {}
    
    -- Remove pings
    local ball = findBall()
    if ball then
        local ping = ball:FindFirstChild("ESPPing")
        if ping then ping:Destroy() end
    end
    
    print("ESP desativado!")
end

-- ===== FUNCAO PARA TROCAR A MESH =====
local function trocarMeshBola(meshId)
    local ball = findBall()
    if not ball then
        warn("Bola nao encontrada!")
        return false
    end
    
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if not mesh then
        mesh = Instance.new("SpecialMesh")
        mesh.Parent = ball
    end
    
    mesh.MeshId = meshId
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.Scale = Vector3.new(1, 1, 1)
    print("Mesh alterada para: " .. meshId)
    return true
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

local function resetBallName()
    local ball = findBall()
    if ball then
        ball.Name = "TPS"
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

-- ============================================
-- ====== CRIACAO DA UI ======
-- ============================================

-- Background
local background = Instance.new("Frame")
background.Parent = gui
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5
background.Active = true

-- Painel principal
local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 420, 0, 600)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
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
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "TCS - ALTERADOR DE BALL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
title.BackgroundTransparency = 0.3
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local titleCorner = Instance.new("UICorner")
titleCorner.Parent = title
titleCorner.CornerRadius = UDim.new(0, 15)

-- ===== ABAS =====
local abaContainer = Instance.new("Frame")
abaContainer.Parent = mainFrame
abaContainer.Size = UDim2.new(1, 0, 0, 35)
abaContainer.Position = UDim2.new(0, 0, 0, 45)
abaContainer.BackgroundTransparency = 1

local aba1 = Instance.new("TextButton")
aba1.Parent = abaContainer
aba1.Size = UDim2.new(0.33, 0, 1, 0)
aba1.Position = UDim2.new(0, 0, 0, 0)
aba1.Text = "Bola"
aba1.TextColor3 = Color3.fromRGB(255, 255, 255)
aba1.BackgroundColor3 = Color3.fromRGB(60, 50, 100)
aba1.Font = Enum.Font.GothamBold
aba1.TextSize = 13
aba1.BorderSizePixel = 0

local aba2 = Instance.new("TextButton")
aba2.Parent = abaContainer
aba2.Size = UDim2.new(0.33, 0, 1, 0)
aba2.Position = UDim2.new(0.33, 0, 0, 0)
aba2.Text = "Reach"
aba2.TextColor3 = Color3.fromRGB(200, 200, 200)
aba2.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
aba2.Font = Enum.Font.GothamBold
aba2.TextSize = 13
aba2.BorderSizePixel = 0

local aba3 = Instance.new("TextButton")
aba3.Parent = abaContainer
aba3.Size = UDim2.new(0.34, 0, 1, 0)
aba3.Position = UDim2.new(0.66, 0, 0, 0)
aba3.Text = "ESP/Hitbox"
aba3.TextColor3 = Color3.fromRGB(200, 200, 200)
aba3.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
aba3.Font = Enum.Font.GothamBold
aba3.TextSize = 13
aba3.BorderSizePixel = 0

-- ===== CONTEUDO ABA 1 =====
local content1 = Instance.new("Frame")
content1.Parent = mainFrame
content1.Size = UDim2.new(1, 0, 1, -80)
content1.Position = UDim2.new(0, 0, 0, 80)
content1.BackgroundTransparency = 1

-- ID Label
local idLabel = Instance.new("TextLabel")
idLabel.Parent = content1
idLabel.Size = UDim2.new(0.8, 0, 0, 20)
idLabel.Position = UDim2.new(0.1, 0, 0.02, 0)
idLabel.Text = "MeshId:"
idLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
idLabel.BackgroundTransparency = 1
idLabel.Font = Enum.Font.GothamBold
idLabel.TextSize = 13
idLabel.TextXAlignment = Enum.TextXAlignment.Left

local idInput = Instance.new("TextBox")
idInput.Parent = content1
idInput.Size = UDim2.new(0.8, 0, 0, 35)
idInput.Position = UDim2.new(0.1, 0, 0.08, 0)
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

local aplicarMeshBtn = Instance.new("TextButton")
aplicarMeshBtn.Parent = content1
aplicarMeshBtn.Size = UDim2.new(0.8, 0, 0, 40)
aplicarMeshBtn.Position = UDim2.new(0.1, 0, 0.18, 0)
aplicarMeshBtn.Text = "APLICAR MESH"
aplicarMeshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aplicarMeshBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
aplicarMeshBtn.Font = Enum.Font.GothamBold
aplicarMeshBtn.TextSize = 15

local btnCorner1 = Instance.new("UICorner")
btnCorner1.Parent = aplicarMeshBtn
btnCorner1.CornerRadius = UDim.new(0, 8)

local bolaNovaBtn = Instance.new("TextButton")
bolaNovaBtn.Parent = content1
bolaNovaBtn.Size = UDim2.new(0.38, 0, 0, 35)
bolaNovaBtn.Position = UDim2.new(0.06, 0, 0.30, 0)
bolaNovaBtn.Text = "Nome: OFF"
bolaNovaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
bolaNovaBtn.Font = Enum.Font.GothamBold
bolaNovaBtn.TextSize = 12

local btnCorner2 = Instance.new("UICorner")
btnCorner2.Parent = bolaNovaBtn
btnCorner2.CornerRadius = UDim.new(0, 8)

local renomearBtn = Instance.new("TextButton")
renomearBtn.Parent = content1
renomearBtn.Size = UDim2.new(0.38, 0, 0, 35)
renomearBtn.Position = UDim2.new(0.56, 0, 0.30, 0)
renomearBtn.Text = "Renomear"
renomearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
renomearBtn.BackgroundColor3 = Color3.fromRGB(50, 70, 50)
renomearBtn.Font = Enum.Font.GothamBold
renomearBtn.TextSize = 12

local btnCorner3 = Instance.new("UICorner")
btnCorner3.Parent = renomearBtn
btnCorner3.CornerRadius = UDim.new(0, 8)

local removerTexBtn = Instance.new("TextButton")
removerTexBtn.Parent = content1
removerTexBtn.Size = UDim2.new(0.38, 0, 0, 35)
removerTexBtn.Position = UDim2.new(0.06, 0, 0.40, 0)
removerTexBtn.Text = "Remover Tex"
removerTexBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
removerTexBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
removerTexBtn.Font = Enum.Font.GothamBold
removerTexBtn.TextSize = 12

local btnCorner4 = Instance.new("UICorner")
btnCorner4.Parent = removerTexBtn
btnCorner4.CornerRadius = UDim.new(0, 8)

local resetarBtn = Instance.new("TextButton")
resetarBtn.Parent = content1
resetarBtn.Size = UDim2.new(0.38, 0, 0, 35)
resetarBtn.Position = UDim2.new(0.56, 0, 0.40, 0)
resetarBtn.Text = "Resetar"
resetarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetarBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
resetarBtn.Font = Enum.Font.GothamBold
resetarBtn.TextSize = 12

local btnCorner5 = Instance.new("UICorner")
btnCorner5.Parent = resetarBtn
btnCorner5.CornerRadius = UDim.new(0, 8)

local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = content1
statusLabel.Size = UDim2.new(0.9, 0, 0, 40)
statusLabel.Position = UDim2.new(0.05, 0, 0.48, 0)
statusLabel.Text = "Pronto"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.TextWrapped = true

local buscarBtn = Instance.new("TextButton")
buscarBtn.Parent = content1
buscarBtn.Size = UDim2.new(0.8, 0, 0, 30)
buscarBtn.Position = UDim2.new(0.1, 0, 0.60, 0)
buscarBtn.Text = "BUSCAR BOLA TPS"
buscarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
buscarBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
buscarBtn.Font = Enum.Font.GothamBold
buscarBtn.TextSize = 12

local btnCorner6 = Instance.new("UICorner")
btnCorner6.Parent = buscarBtn
btnCorner6.CornerRadius = UDim.new(0, 8)

-- ===== CONTEUDO ABA 2 (REACH) =====
local content2 = Instance.new("Frame")
content2.Parent = mainFrame
content2.Size = UDim2.new(1, 0, 1, -80)
content2.Position = UDim2.new(0, 0, 0, 80)
content2.BackgroundTransparency = 1
content2.Visible = false

local reachLabel = Instance.new("TextLabel")
reachLabel.Parent = content2
reachLabel.Size = UDim2.new(0.8, 0, 0, 30)
reachLabel.Position = UDim2.new(0.1, 0, 0.05, 0)
reachLabel.Text = "Reach: 1.0x"
reachLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
reachLabel.BackgroundTransparency = 1
reachLabel.Font = Enum.Font.GothamBold
reachLabel.TextSize = 18

local reachSub = Instance.new("TextLabel")
reachSub.Parent = content2
reachSub.Size = UDim2.new(0.8, 0, 0, 20)
reachSub.Position = UDim2.new(0.1, 0, 0.14, 0)
reachSub.Text = "Alcance do personagem"
reachSub.TextColor3 = Color3.fromRGB(180, 180, 200)
reachSub.BackgroundTransparency = 1
reachSub.Font = Enum.Font.Gotham
reachSub.TextSize = 12

local reachSlider = Instance.new("Frame")
reachSlider.Parent = content2
reachSlider.Size = UDim2.new(0.7, 0, 0, 6)
reachSlider.Position = UDim2.new(0.15, 0, 0.24, 0)
reachSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
reachSlider.BorderSizePixel = 0

local reachSliderCorner = Instance.new("UICorner")
reachSliderCorner.Parent = reachSlider
reachSliderCorner.CornerRadius = UDim.new(1, 0)

local reachFill = Instance.new("Frame")
reachFill.Parent = reachSlider
reachFill.Size = UDim2.new(0.5, 0, 1, 0)
reachFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
reachFill.BorderSizePixel = 0

local reachFillCorner = Instance.new("UICorner")
reachFillCorner.Parent = reachFill
reachFillCorner.CornerRadius = UDim.new(1, 0)

local reachMenos = Instance.new("TextButton")
reachMenos.Parent = content2
reachMenos.Size = UDim2.new(0.12, 0, 0, 35)
reachMenos.Position = UDim2.new(0.1, 0, 0.30, 0)
reachMenos.Text = "-"
reachMenos.TextColor3 = Color3.fromRGB(255, 255, 255)
reachMenos.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
reachMenos.Font = Enum.Font.GothamBold
reachMenos.TextSize = 20

local reachMais = Instance.new("TextButton")
reachMais.Parent = content2
reachMais.Size = UDim2.new(0.12, 0, 0, 35)
reachMais.Position = UDim2.new(0.78, 0, 0.30, 0)
reachMais.Text = "+"
reachMais.TextColor3 = Color3.fromRGB(255, 255, 255)
reachMais.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
reachMais.Font = Enum.Font.GothamBold
reachMais.TextSize = 20

local reachValor = Instance.new("TextLabel")
reachValor.Parent = content2
reachValor.Size = UDim2.new(0.3, 0, 0, 35)
reachValor.Position = UDim2.new(0.35, 0, 0.30, 0)
reachValor.Text = "1.0"
reachValor.TextColor3 = Color3.fromRGB(255, 255, 255)
reachValor.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
reachValor.Font = Enum.Font.GothamBold
reachValor.TextSize = 16

local reachCorner = Instance.new("UICorner")
reachCorner.Parent = reachValor
reachCorner.CornerRadius = UDim.new(0, 5)

local reachStatus = Instance.new("TextLabel")
reachStatus.Parent = content2
reachStatus.Size = UDim2.new(0.8, 0, 0, 30)
reachStatus.Position = UDim2.new(0.1, 0, 0.42, 0)
reachStatus.Text = "Reach aplicado ao personagem"
reachStatus.TextColor3 = Color3.fromRGB(150, 255, 150)
reachStatus.BackgroundTransparency = 1
reachStatus.Font = Enum.Font.Gotham
reachStatus.TextSize = 12

-- ===== CONTEUDO ABA 3 (ESP/HITBOX) =====
local content3 = Instance.new("Frame")
content3.Parent = mainFrame
content3.Size = UDim2.new(1, 0, 1, -80)
content3.Position = UDim2.new(0, 0, 0, 80)
content3.BackgroundTransparency = 1
content3.Visible = false

local espLabel = Instance.new("TextLabel")
espLabel.Parent = content3
espLabel.Size = UDim2.new(0.8, 0, 0, 25)
espLabel.Position = UDim2.new(0.1, 0, 0.02, 0)
espLabel.Text = "ESP - Destaque da Bola"
espLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.GothamBold
espLabel.TextSize = 15
espLabel.TextXAlignment = Enum.TextXAlignment.Left

local espBtn = Instance.new("TextButton")
espBtn.Parent = content3
espBtn.Size = UDim2.new(0.8, 0, 0, 40)
espBtn.Position = UDim2.new(0.1, 0, 0.12, 0)
espBtn.Text = "ESP: DESATIVADO"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14

local espCorner = Instance.new("UICorner")
espCorner.Parent = espBtn
espCorner.CornerRadius = UDim.new(0, 8)

local hitboxLabel = Instance.new("TextLabel")
hitboxLabel.Parent = content3
hitboxLabel.Size = UDim2.new(0.8, 0, 0, 25)
hitboxLabel.Position = UDim2.new(0.1, 0, 0.28, 0)
hitboxLabel.Text = "Hitbox - Visualizar Tamanho"
hitboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxLabel.BackgroundTransparency = 1
hitboxLabel.Font = Enum.Font.GothamBold
hitboxLabel.TextSize = 15
hitboxLabel.TextXAlignment = Enum.TextXAlignment.Left

local hitboxBtn = Instance.new("TextButton")
hitboxBtn.Parent = content3
hitboxBtn.Size = UDim2.new(0.8, 0, 0, 40)
hitboxBtn.Position = UDim2.new(0.1, 0, 0.38, 0)
hitboxBtn.Text = "HITBOX: DESATIVADO"
hitboxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
hitboxBtn.Font = Enum.Font.GothamBold
hitboxBtn.TextSize = 14

local hitboxCorner = Instance.new("UICorner")
hitboxCorner.Parent = hitboxBtn
hitboxCorner.CornerRadius = UDim.new(0, 8)

local infoLabel = Instance.new("TextLabel")
infoLabel.Parent = content3
infoLabel.Size = UDim2.new(0.8, 0, 0, 40)
infoLabel.Position = UDim2.new(0.1, 0, 0.55, 0)
infoLabel.Text = "Hitbox mostra o tamanho real\nda bola e a area de colisao"
infoLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ===== BOTAO FECHAR =====
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
-- ====== FUNCOES DAS ABAS ======
-- ============================================

local function switchAba(aba)
    content1.Visible = (aba == 1)
    content2.Visible = (aba == 2)
    content3.Visible = (aba == 3)
    
    aba1.BackgroundColor3 = (aba == 1) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba1.TextColor3 = (aba == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    aba2.BackgroundColor3 = (aba == 2) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba2.TextColor3 = (aba == 2) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    aba3.BackgroundColor3 = (aba == 3) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba3.TextColor3 = (aba == 3) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
end

aba1.MouseButton1Click:Connect(function() switchAba(1) end)
aba2.MouseButton1Click:Connect(function() switchAba(2) end)
aba3.MouseButton1Click:Connect(function() switchAba(3) end)

-- ============================================
-- ====== ACOES DOS BOTOES ======
-- ============================================

-- ABA 1 - Bola
aplicarMeshBtn.MouseButton1Click:Connect(function()
    local meshId = idInput.Text
    if meshId and meshId ~= "" then
        if trocarMeshBola(meshId) then
            statusLabel.Text = "Mesh aplicada com sucesso!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "Bola TPS nao encontrada!"
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
        statusLabel.Text = "Nome resetado para TPS"
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
        statusLabel.Text = "Bola TPS nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

removerTexBtn.MouseButton1Click:Connect(function()
    if removerTexturas() then
        statusLabel.Text = "Texturas removidas!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.Text = "Bola TPS nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

resetarBtn.MouseButton1Click:Connect(function()
    if resetBallName() then
        statusLabel.Text = "Nome resetado para TPS"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        bolaAtiva = false
        bolaNovaBtn.Text = "Nome: OFF"
        bolaNovaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    else
        statusLabel.Text = "Bola TPS nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

buscarBtn.MouseButton1Click:Connect(function()
    local ball = findBall()
    if ball then
        statusLabel.Text = "Bola TPS encontrada: " .. ball.Name
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.Text = "Bola TPS nao encontrada!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ABA 2 - Reach
local function atualizarReachUI()
    reachLabel