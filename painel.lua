-- Vitorxyz - Alterador de ball
-- UI Preta e Branca + Bola Lisa com Cores + Keybind
-- Criado por: Vitorxyz

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "VitorxyzGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== VARIAVEIS =====
local bolaAtiva = false
local bolaOriginal = nil
local bolaLisaAtiva = false
local corOriginal = nil
local corSelecionada = Color3.fromRGB(255, 255, 255)
local minimizado = false

-- ===== FUNCAO PARA ENCONTRAR A BOLA =====
local function findBall()
    local stadium = workspace:FindFirstChild("WorkspaceStadiumMap1")
    if stadium then
        local tfs = stadium:FindFirstChild("TF'S")
        if tfs then
            local ball = tfs:FindFirstChild("TPS")
            if ball then return ball end
            for _, child in ipairs(tfs:GetChildren()) do
                if child:IsA("BasePart") or child:IsA("MeshPart") then
                    local nome = child.Name:lower()
                    if nome:find("ball") or nome:find("bola") or nome:find("tps") then
                        return child
                    end
                end
            end
        end
    end
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("BasePart") or child:IsA("MeshPart") then
            local nome = child.Name:lower()
            if nome:find("ball") or nome:find("bola") or nome:find("tps") then
                return child
            end
        end
        if child:IsA("Model") then
            for _, sub in ipairs(child:GetChildren()) do
                if sub:IsA("BasePart") or sub:IsA("MeshPart") then
                    local nome = sub.Name:lower()
                    if nome:find("ball") or nome:find("bola") or nome:find("tps") then
                        return sub
                    end
                end
            end
        end
    end
    return nil
end

-- ===== FUNCAO PARA APLICAR MESH =====
local function aplicarMesh(meshId)
    local ball = findBall()
    if not ball then return false end
    if not bolaOriginal then bolaOriginal = ball end
    if ball:IsA("MeshPart") then
        pcall(function() ball.MeshContent = meshId end)
        return true
    end
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if not mesh then
        mesh = Instance.new("SpecialMesh")
        mesh.Parent = ball
    end
    mesh.MeshId = meshId
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.Scale = Vector3.new(1, 1, 1)
    return true
end

-- ===== FUNCAO PARA APLICAR TEXTURA =====
local function aplicarTextura(textureId)
    local ball = findBall()
    if not ball then return false end
    for _, child in ipairs(ball:GetChildren()) do
        if child:IsA("Texture") or child:IsA("Decal") then
            child:Destroy()
        end
    end
    local texture = Instance.new("Texture")
    texture.Texture = textureId
    texture.Face = Enum.NormalId.Top
    texture.Parent = ball
    local texture2 = Instance.new("Texture")
    texture2.Texture = textureId
    texture2.Face = Enum.NormalId.Bottom
    texture2.Parent = ball
    return true
end

-- ===== FUNCAO PARA REMOVER TEXTURAS =====
local function removerTexturas()
    local ball = findBall()
    if not ball then return false end
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

-- ===== FUNCAO PARA RESETAR MESH =====
local function resetarMesh()
    local ball = findBall()
    if not ball then return false end
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if mesh then mesh:Destroy() end
    if ball:IsA("MeshPart") and bolaOriginal then
        pcall(function() ball.MeshContent = bolaOriginal.MeshContent end)
    end
    return true
end

-- ===== FUNCAO PARA DEIXAR A BOLA LISA =====
local function deixarBolaLisa()
    local ball = findBall()
    if not ball then return false end
    
    if not corOriginal then
        corOriginal = ball.Color
    end
    
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
    
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if mesh then mesh:Destroy() end
    
    ball.Material = Enum.Material.SmoothPlastic
    ball.Color = corSelecionada
    ball.Reflectance = 0.2
    
    return true
end

-- ===== FUNCAO PARA RESETAR BOLA LISA =====
local function resetarBolaLisa()
    local ball = findBall()
    if not ball then return false end
    if corOriginal then ball.Color = corOriginal end
    ball.Material = Enum.Material.Plastic
    ball.Reflectance = 0
    return true
end

-- ===== FUNCAO PARA RENOMEAR =====
local function renomearBola()
    local ball = findBall()
    if ball then
        ball.Name = "Vitorxyz"
        return true
    end
    return false
end

-- ============================================
-- ====== CRIAR UI PRETA E BRANCA ======
-- ============================================

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 320, 0, 560)
main.Position = UDim2.new(0.5, -160, 0.5, -280)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 2

-- TITULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Vitorxyz - Alterador de ball"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- BOTAO MINIMIZAR
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -72, 0, 5)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)
local sm = Instance.new("UIStroke", minBtn)
sm.Color = Color3.fromRGB(255, 255, 255)
sm.Thickness = 1

-- BOTAO FECHAR
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
local sc = Instance.new("UIStroke", closeBtn)
sc.Color = Color3.fromRGB(255, 255, 255)
sc.Thickness = 1

-- ===== CONTAINER DE CONTEUDO (para minimizar) =====
local conteudo = Instance.new("Frame", main)
conteudo.Size = UDim2.new(1, 0, 1, -40)
conteudo.Position = UDim2.new(0, 0, 0, 40)
conteudo.BackgroundTransparency = 1

-- BOTAO BOLA NOVA
local btnBolaNova = Instance.new("TextButton", conteudo)
btnBolaNova.Size = UDim2.new(0.85, 0, 0, 35)
btnBolaNova.Position = UDim2.new(0.075, 0, 0.04, 0)
btnBolaNova.Text = "BOLA NOVA: OFF"
btnBolaNova.TextColor3 = Color3.fromRGB(255, 255, 255)
btnBolaNova.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnBolaNova.Font = Enum.Font.GothamBold
btnBolaNova.TextSize = 14
btnBolaNova.BorderSizePixel = 0
Instance.new("UICorner", btnBolaNova).CornerRadius = UDim.new(0, 8)
local s1 = Instance.new("UIStroke", btnBolaNova)
s1.Color = Color3.fromRGB(80, 80, 80)
s1.Thickness = 1

-- BOTAO BOLA LISA
local btnBolaLisa = Instance.new("TextButton", conteudo)
btnBolaLisa.Size = UDim2.new(0.85, 0, 0, 35)
btnBolaLisa.Position = UDim2.new(0.075, 0, 0.12, 0)
btnBolaLisa.Text = "BOLA LISA: OFF"
btnBolaLisa.TextColor3 = Color3.fromRGB(255, 255, 255)
btnBolaLisa.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnBolaLisa.Font = Enum.Font.GothamBold
btnBolaLisa.TextSize = 14
btnBolaLisa.BorderSizePixel = 0
Instance.new("UICorner", btnBolaLisa).CornerRadius = UDim.new(0, 8)
local s2 = Instance.new("UIStroke", btnBolaLisa)
s2.Color = Color3.fromRGB(80, 80, 80)
s2.Thickness = 1

-- LABEL CORES
local corLabel = Instance.new("TextLabel", conteudo)
corLabel.Size = UDim2.new(0.85, 0, 0, 20)
corLabel.Position = UDim2.new(0.075, 0, 0.20, 0)
corLabel.Text = "COR DA BOLA LISA:"
corLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
corLabel.BackgroundTransparency = 1
corLabel.Font = Enum.Font.GothamBold
corLabel.TextSize = 12

-- BOTOES DE COR
local cores = {
    {nome = "Branco", cor = Color3.fromRGB(255, 255, 255)},
    {nome = "Preto", cor = Color3.fromRGB(0, 0, 0)},
    {nome = "Vermelho", cor = Color3.fromRGB(255, 0, 0)},
    {nome = "Azul", cor = Color3.fromRGB(0, 0, 255)},
    {nome = "Verde", cor = Color3.fromRGB(0, 255, 0)},
    {nome = "Amarelo", cor = Color3.fromRGB(255, 255, 0)},
    {nome = "Rosa", cor = Color3.fromRGB(255, 0, 255)},
    {nome = "Laranja", cor = Color3.fromRGB(255, 165, 0)},
    {nome = "Roxo", cor = Color3.fromRGB(128, 0, 128)},
    {nome = "Ciano", cor = Color3.fromRGB(0, 255, 255)},
}

local corFrame = Instance.new("Frame", conteudo)
corFrame.Size = UDim2.new(0.85, 0, 0, 70)
corFrame.Position = UDim2.new(0.075, 0, 0.24, 0)
corFrame.BackgroundTransparency = 1

local corGrid = Instance.new("UIGridLayout", corFrame)
corGrid.CellSize = UDim2.new(0, 30, 0, 30)
corGrid.CellPadding = UDim2.new(0, 6, 0, 6)
corGrid.SortOrder = Enum.SortOrder.LayoutOrder

for i, c in ipairs(cores) do
    local btnCor = Instance.new("TextButton", corFrame)
    btnCor.Size = UDim2.new(0, 30, 0, 30)
    btnCor.BackgroundColor3 = c.cor
    btnCor.Text = ""
    btnCor.BorderSizePixel = 0
    btnCor.LayoutOrder = i
    
    local cc = Instance.new("UICorner", btnCor)
    cc.CornerRadius = UDim.new(1, 0)
    
    local stroke = Instance.new("UIStroke", btnCor)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    
    btnCor.MouseButton1Click:Connect(function()
        corSelecionada = c.cor
        if bolaLisaAtiva then
            local ball = findBall()
            if ball then ball.Color = c.cor end
        end
        for _, other in ipairs(corFrame:GetChildren()) do
            if other:IsA("TextButton") then
                local s = other:FindFirstChildWhichIsA("UIStroke")
                if s then
                    if other == btnCor then
                        s.Color = Color3.fromRGB(0, 170, 255)
                        s.Thickness = 3
                    else
                        s.Color = Color3.fromRGB(255, 255, 255)
                        s.Thickness = 2
                    end
                end
            end
        end
    end)
end

-- BOTAO ID DE TEXTURA
local btnTextura = Instance.new("TextButton", conteudo)
btnTextura.Size = UDim2.new(0.85, 0, 0, 35)
btnTextura.Position = UDim2.new(0.075, 0, 0.40, 0)
btnTextura.Text = "ID de Textura"
btnTextura.TextColor3 = Color3.fromRGB(0, 170, 255)
btnTextura.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnTextura.Font = Enum.Font.GothamBold
btnTextura.TextSize = 14
btnTextura.BorderSizePixel = 0
Instance.new("UICorner", btnTextura).CornerRadius = UDim.new(0, 8)
local s3 = Instance.new("UIStroke", btnTextura)
s3.Color = Color3.fromRGB(80, 80, 80)
s3.Thickness = 1

-- BOTAO ID DE MESH
local btnMesh = Instance.new("TextButton", conteudo)
btnMesh.Size = UDim2.new(0.85, 0, 0, 35)
btnMesh.Position = UDim2.new(0.075, 0, 0.48, 0)
btnMesh.Text = "ID de Mesh (MeshContent)"
btnMesh.TextColor3 = Color3.fromRGB(0, 170, 255)
btnMesh.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnMesh.Font = Enum.Font.GothamBold
btnMesh.TextSize = 13
btnMesh.BorderSizePixel = 0
Instance.new("UICorner", btnMesh).CornerRadius = UDim.new(0, 8)
local s4 = Instance.new("UIStroke", btnMesh)
s4.Color = Color3.fromRGB(80, 80, 80)
s4.Thickness = 1

-- BOTAO REMOVER TEXTURA
local btnRemoverTex = Instance.new("TextButton", conteudo)
btnRemoverTex.Size = UDim2.new(0.85, 0, 0, 35)
btnRemoverTex.Position = UDim2.new(0.075, 0, 0.56, 0)
btnRemoverTex.Text = "REMOVER TEXTURA"
btnRemoverTex.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRemoverTex.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnRemoverTex.Font = Enum.Font.GothamBold
btnRemoverTex.TextSize = 14
btnRemoverTex.BorderSizePixel = 0
Instance.new("UICorner", btnRemoverTex).CornerRadius = UDim.new(0, 8)
local s5 = Instance.new("UIStroke", btnRemoverTex)
s5.Color = Color3.fromRGB(80, 80, 80)
s5.Thickness = 1

-- BOTAO RESETAR MESH
local btnResetarMesh = Instance.new("TextButton", conteudo)
btnResetarMesh.Size = UDim2.new(0.85, 0, 0, 35)
btnResetarMesh.Position = UDim2.new(0.075, 0, 0.64, 0)
btnResetarMesh.Text = "RESETAR MESH"
btnResetarMesh.TextColor3 = Color3.fromRGB(255, 255, 255)
btnResetarMesh.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnResetarMesh.Font = Enum.Font.GothamBold
btnResetarMesh.TextSize = 14
btnResetarMesh.BorderSizePixel = 0
Instance.new("UICorner", btnResetarMesh).CornerRadius = UDim.new(0, 8)
local s6 = Instance.new("UIStroke", btnResetarMesh)
s6.Color = Color3.fromRGB(80, 80, 80)
s6.Thickness = 1

-- ===== CAMPOS DE INPUT =====
local textureInput = Instance.new("TextBox", conteudo)
textureInput.Size = UDim2.new(0.85, 0, 0, 30)
textureInput.Position = UDim2.new(0.075, 0, 0.40, 0)
textureInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textureInput.TextColor3 = Color3.fromRGB(255, 255, 255)
textureInput.PlaceholderText = "rbxassetid://ID_DA_TEXTURA"
textureInput.Text = ""
textureInput.Font = Enum.Font.Gotham
textureInput.TextSize = 12
textureInput.Visible = false
textureInput.BorderSizePixel = 0
Instance.new("UICorner", textureInput).CornerRadius = UDim.new(0, 8)

local meshInput = Instance.new("TextBox", conteudo)
meshInput.Size = UDim2.new(0.85, 0, 0, 30)
meshInput.Position = UDim2.new(0.075, 0, 0.48, 0)
meshInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
meshInput.TextColor3 = Color3.fromRGB(255, 255, 255)
meshInput.PlaceholderText = "rbxassetid://ID_DA_MESH"
meshInput.Text = ""
meshInput.Font = Enum.Font.Gotham
meshInput.TextSize = 12
meshInput.Visible = false
meshInput.BorderSizePixel = 0
Instance.new("UICorner", meshInput).CornerRadius = UDim.new(0, 8)

-- ============================================
-- ====== FUNCOES DOS BOTOES ======
-- ============================================

btnBolaNova.MouseButton1Click:Connect(function()
    bolaAtiva = not bolaAtiva
    if bolaAtiva then
        btnBolaNova.Text = "BOLA NOVA: ON"
        btnBolaNova.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        renomearBola()
    else
        btnBolaNova.Text = "BOLA NOVA: OFF"
        btnBolaNova.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        local ball = findBall()
        if ball then ball.Name = "TPS" end
    end
end)

btnBolaLisa.MouseButton1Click:Connect(function()
    bolaLisaAtiva = not bolaLisaAtiva
    if bolaLisaAtiva then
        btnBolaLisa.Text = "BOLA LISA: ON"
        btnBolaLisa.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        deixarBolaLisa()
    else
        btnBolaLisa.Text = "BOLA LISA: OFF"
        btnBolaLisa.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        resetarBolaLisa()
    end
end)

btnTextura.MouseButton1Click:Connect(function()
    textureInput.Visible = not textureInput.Visible
    if textureInput.Visible then textureInput:CaptureFocus() end
end)

textureInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local id = textureInput.Text
        if id and id ~= "" then
            aplicarTextura(id)
            textureInput.Visible = false
        end
    end
end)

btnMesh.MouseButton1Click:Connect(function()
    meshInput.Visible = not meshInput.Visible
    if meshInput.Visible then meshInput:CaptureFocus() end
end)

meshInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local id = meshInput.Text
        if id and id ~= "" then
            aplicarMesh(id)
            meshInput.Visible = false
        end
    end
end)

btnRemoverTex.MouseButton1Click:Connect(function()
    removerTexturas()
end)

btnResetarMesh.MouseButton1Click:Connect(function()
    resetarMesh()
end)

-- MINIMIZAR
minBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    conteudo.Visible = not minimizado
    if minimizado then
        main.Size = UDim2.new(0, 320, 0, 40)
        minBtn.Text = "+"
    else
        main.Size = UDim2.new(0, 320, 0, 560)
        minBtn.Text = "-"
    end
end)

-- FECHAR
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- ============================================
-- ====== KEYBIND (TECLA K) ======
-- ============================================

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        minimizado = not minimizado
        conteudo.Visible = not minimizado
        if minimizado then
            main.Size = UDim2.new(0, 320, 0, 40)
            minBtn.Text = "+"
        else
            main.Size = UDim2.new(0, 320, 0, 560)
            minBtn.Text = "-"
        end
    end
end)

-- ===== INICIALIZACAO =====
print("Vitorxyz - Alterador de ball carregado!")
print("Pressione K para minimizar/abrir o hub")
print("Bola Lisa com 10 cores disponiveis!")