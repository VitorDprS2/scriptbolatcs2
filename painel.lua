-- Alterador de ball Foldenxzz
-- UI Preta e Branca + Bola Lisa
-- Criado por: VitorDprS2

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "VitorzGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== VARIAVEIS =====
local bolaAtiva = false
local bolaOriginal = nil
local bolaLisaAtiva = false
local corOriginal = nil

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
    
    -- Salva a cor original
    if not corOriginal then
        corOriginal = ball.Color
    end
    
    -- Remove todas as texturas e decais
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
    
    -- Remove a mesh
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if mesh then
        mesh:Destroy()
    end
    
    -- Deixa a bola com cor sólida e brilhante
    ball.Material = Enum.Material.SmoothPlastic
    ball.Color = Color3.fromRGB(255, 255, 255)
    ball.Reflectance = 0.2
    
    print("Bola lisa ativada!")
    return true
end

-- ===== FUNCAO PARA RESETAR BOLA LISA =====
local function resetarBolaLisa()
    local ball = findBall()
    if not ball then return false end
    
    if corOriginal then
        ball.Color = corOriginal
    end
    ball.Material = Enum.Material.Plastic
    ball.Reflectance = 0
    
    print("Bola lisa desativada!")
    return true
end

-- ===== FUNCAO PARA RENOMEAR =====
local function renomearBola()
    local ball = findBall()
    if ball then
        ball.Name = "Foldenxzz"
        return true
    end
    return false
end

-- ============================================
-- ====== CRIAR UI PRETA E BRANCA ======
-- ============================================

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 460)
main.Position = UDim2.new(0.5, -150, 0.5, -230)
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
title.Text = "Alterador de ball Foldenxzz"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- BOTAO BOLA NOVA
local btnBolaNova = Instance.new("TextButton", main)
btnBolaNova.Size = UDim2.new(0.85, 0, 0, 40)
btnBolaNova.Position = UDim2.new(0.075, 0, 0.10, 0)
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
local btnBolaLisa = Instance.new("TextButton", main)
btnBolaLisa.Size = UDim2.new(0.85, 0, 0, 40)
btnBolaLisa.Position = UDim2.new(0.075, 0, 0.21, 0)
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

-- BOTAO ID DE TEXTURA
local btnTextura = Instance.new("TextButton", main)
btnTextura.Size = UDim2.new(0.85, 0, 0, 40)
btnTextura.Position = UDim2.new(0.075, 0, 0.32, 0)
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
local btnMesh = Instance.new("TextButton", main)
btnMesh.Size = UDim2.new(0.85, 0, 0, 40)
btnMesh.Position = UDim2.new(0.075, 0, 0.43, 0)
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
local btnRemoverTex = Instance.new("TextButton", main)
btnRemoverTex.Size = UDim2.new(0.85, 0, 0, 40)
btnRemoverTex.Position = UDim2.new(0.075, 0, 0.54, 0)
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
local btnResetarMesh = Instance.new("TextButton", main)
btnResetarMesh.Size = UDim2.new(0.85, 0, 0, 40)
btnResetarMesh.Position = UDim2.new(0.075, 0, 0.65, 0)
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
local s7 = Instance.new("UIStroke", closeBtn)
s7.Color = Color3.fromRGB(255, 255, 255)
s7.Thickness = 1

-- ===== CAMPOS DE INPUT =====
local textureInput = Instance.new("TextBox", main)
textureInput.Size = UDim2.new(0.85, 0, 0, 35)
textureInput.Position = UDim2.new(0.075, 0, 0.32, 0)
textureInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textureInput.TextColor3 = Color3.fromRGB(255, 255, 255)
textureInput.PlaceholderText = "rbxassetid://ID_DA_TEXTURA"
textureInput.Text = ""
textureInput.Font = Enum.Font.Gotham
textureInput.TextSize = 12
textureInput.Visible = false
textureInput.BorderSizePixel = 0
Instance.new("UICorner", textureInput).CornerRadius = UDim.new(0, 8)

local meshInput = Instance.new("TextBox", main)
meshInput.Size = UDim2.new(0.85, 0, 0, 35)
meshInput.Position = UDim2.new(0.075, 0, 0.43, 0)
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

-- BOLA NOVA (Toggle)
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

-- BOLA LISA (Toggle)
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

-- ID DE TEXTURA
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

-- ID DE MESH
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

-- REMOVER TEXTURA
btnRemoverTex.MouseButton1Click:Connect(function()
    removerTexturas()
end)

-- RESETAR MESH
btnResetarMesh.MouseButton1Click:Connect(function()
    resetarMesh()
end)

-- FECHAR
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- ===== INICIALIZACAO =====
print("Alterador de ball carregado!")
print("UI preta e branca + Bola Lisa!")