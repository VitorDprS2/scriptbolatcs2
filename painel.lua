-- TCS - Alterador de Ball com Reach, Hitbox e ESP
-- Criado por: VitorDprS2

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "NerdttkGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== VARIAVEIS =====
local reachMultiplier = 1
local espEnabled = false
local hitboxVisible = false
local hitboxPart = nil
local espHighlights = {}

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

-- ===== REACH =====
local function getHumanoid()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

local function aplicarReach(valor)
    local humanoid = getHumanoid()
    if not humanoid then return false end
    local props = {"Reach", "InteractDistance", "GrabDistance", "PickupDistance"}
    local ok = false
    for _, p in ipairs(props) do
        if humanoid:FindFirstChild(p) then
            pcall(function() humanoid[p] = valor; ok = true end)
        end
    end
    if not ok then
        pcall(function() humanoid:SetAttribute("Reach", valor); ok = true end)
    end
    return ok
end

-- ===== HITBOX =====
local function criarHitbox()
    removerHitbox()
    local ball = findBall()
    if not ball then return end
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
    local adorn = Instance.new("BoxHandleAdornment")
    adorn.Parent = hitboxPart
    adorn.Adornee = hitboxPart
    adorn.Size = hitboxPart.Size
    adorn.AlwaysOnTop = true
    adorn.ZIndex = 10
    adorn.Color3 = Color3.fromRGB(255, 0, 0)
    adorn.Transparency = 0.3
    hitboxVisible = true
end

local function removerHitbox()
    if hitboxPart then hitboxPart:Destroy(); hitboxPart = nil end
    hitboxVisible = false
end

local function atualizarHitbox()
    if not hitboxVisible or not hitboxPart then return end
    local ball = findBall()
    if ball then
        hitboxPart.Position = ball.Position
        hitboxPart.Size = ball.Size * 1.5
        local adorn = hitboxPart:FindFirstChildWhichIsA("BoxHandleAdornment")
        if adorn then adorn.Size = hitboxPart.Size end
    end
end

-- ===== ESP =====
local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        local ball = findBall()
        if ball then
            local h = Instance.new("Highlight")
            h.Parent = ball
            h.FillColor = Color3.fromRGB(0, 255, 0)
            h.FillTransparency = 0.5
            h.OutlineColor = Color3.fromRGB(255, 255, 255)
            h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            table.insert(espHighlights, h)
            local ping = Instance.new("BillboardGui")
            ping.Name = "ESPPing"
            ping.Parent = ball
            ping.Size = UDim2.new(0, 100, 0, 50)
            ping.StudsOffset = Vector3.new(0, 4, 0)
            ping.AlwaysOnTop = true
            local lbl = Instance.new("TextLabel")
            lbl.Parent = ping
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = "BOLA"
            lbl.TextColor3 = Color3.fromRGB(0, 255, 0)
            lbl.TextScaled = true
            lbl.Font = Enum.Font.GothamBold
            lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            lbl.TextStrokeTransparency = 0.3
            print("ESP ativado!")
        else
            print("Bola nao encontrada para ESP")
            espEnabled = false
        end
    else
        for _, h in ipairs(espHighlights) do pcall(function() h:Destroy() end) end
        espHighlights = {}
        local ball = findBall()
        if ball then
            local ping = ball:FindFirstChild("ESPPing")
            if ping then ping:Destroy() end
        end
        print("ESP desativado!")
    end
end

-- ===== MESH =====
local function trocarMesh(meshId)
    local ball = findBall()
    if not ball then return false end
    local mesh = ball:FindFirstChildWhichIsA("SpecialMesh")
    if not mesh then mesh = Instance.new("SpecialMesh", ball) end
    mesh.MeshId = meshId
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.Scale = Vector3.new(1, 1, 1)
    return true
end

local function renameToNerdttk()
    local ball = findBall()
    if ball then ball.Name = "nerdttk"; return true end
    return false
end

local function resetBallName()
    local ball = findBall()
    if ball then ball.Name = "TPS"; return true end
    return false
end

local function removerTexturas()
    local ball = findBall()
    if ball then
        for _, c in ipairs(ball:GetChildren()) do
            if c:IsA("Texture") or c:IsA("Decal") then c:Destroy() end
        end
        for _, p in ipairs(ball:GetDescendants()) do
            if p:IsA("Texture") or p:IsA("Decal") then p:Destroy() end
        end
        return true
    end
    return false
end

-- ============================================
-- ====== UI ======
-- ============================================

local bg = Instance.new("Frame")
bg.Parent = gui
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.5

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 420, 0, 580)
main.Position = UDim2.new(0.5, -210, 0.5, -290)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local mc = Instance.new("UICorner", main)
mc.CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "TCS - ALTERADOR DE BALL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
title.BackgroundTransparency = 0.3
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local tc = Instance.new("UICorner", title)
tc.CornerRadius = UDim.new(0, 15)

-- ABAS
local abaContainer = Instance.new("Frame", main)
abaContainer.Size = UDim2.new(1, 0, 0, 35)
abaContainer.Position = UDim2.new(0, 0, 0, 45)
abaContainer.BackgroundTransparency = 1

local aba1 = Instance.new("TextButton", abaContainer)
aba1.Size = UDim2.new(0.33, 0, 1, 0)
aba1.Position = UDim2.new(0, 0, 0, 0)
aba1.Text = "Bola"
aba1.TextColor3 = Color3.fromRGB(255, 255, 255)
aba1.BackgroundColor3 = Color3.fromRGB(60, 50, 100)
aba1.Font = Enum.Font.GothamBold
aba1.TextSize = 13
aba1.BorderSizePixel = 0

local aba2 = Instance.new("TextButton", abaContainer)
aba2.Size = UDim2.new(0.33, 0, 1, 0)
aba2.Position = UDim2.new(0.33, 0, 0, 0)
aba2.Text = "Reach"
aba2.TextColor3 = Color3.fromRGB(200, 200, 200)
aba2.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
aba2.Font = Enum.Font.GothamBold
aba2.TextSize = 13
aba2.BorderSizePixel = 0

local aba3 = Instance.new("TextButton", abaContainer)
aba3.Size = UDim2.new(0.34, 0, 1, 0)
aba3.Position = UDim2.new(0.66, 0, 0, 0)
aba3.Text = "ESP/Hitbox"
aba3.TextColor3 = Color3.fromRGB(200, 200, 200)
aba3.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
aba3.Font = Enum.Font.GothamBold
aba3.TextSize = 13
aba3.BorderSizePixel = 0

-- CONTEUDO ABA 1
local c1 = Instance.new("Frame", main)
c1.Size = UDim2.new(1, 0, 1, -80)
c1.Position = UDim2.new(0, 0, 0, 80)
c1.BackgroundTransparency = 1

local idLabel = Instance.new("TextLabel", c1)
idLabel.Size = UDim2.new(0.8, 0, 0, 20)
idLabel.Position = UDim2.new(0.1, 0, 0.02, 0)
idLabel.Text = "MeshId:"
idLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
idLabel.BackgroundTransparency = 1
idLabel.Font = Enum.Font.GothamBold
idLabel.TextSize = 13
idLabel.TextXAlignment = Enum.TextXAlignment.Left

local idInput = Instance.new("TextBox", c1)
idInput.Size = UDim2.new(0.8, 0, 0, 35)
idInput.Position = UDim2.new(0.1, 0, 0.08, 0)
idInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
idInput.BorderSizePixel = 0
idInput.Text = "rbxassetid://11765504"
idInput.TextColor3 = Color3.fromRGB(255, 255, 255)
idInput.Font = Enum.Font.Gotham
idInput.TextSize = 14
idInput.ClearTextOnFocus = false
local idc = Instance.new("UICorner", idInput)
idc.CornerRadius = UDim.new(0, 8)

local btnMesh = Instance.new("TextButton", c1)
btnMesh.Size = UDim2.new(0.8, 0, 0, 40)
btnMesh.Position = UDim2.new(0.1, 0, 0.18, 0)
btnMesh.Text = "APLICAR MESH"
btnMesh.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMesh.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
btnMesh.Font = Enum.Font.GothamBold
btnMesh.TextSize = 15
local bmc = Instance.new("UICorner", btnMesh)
bmc.CornerRadius = UDim.new(0, 8)

local btnNome = Instance.new("TextButton", c1)
btnNome.Size = UDim2.new(0.38, 0, 0, 35)
btnNome.Position = UDim2.new(0.06, 0, 0.30, 0)
btnNome.Text = "Nome: OFF"
btnNome.TextColor3 = Color3.fromRGB(255, 255, 255)
btnNome.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
btnNome.Font = Enum.Font.GothamBold
btnNome.TextSize = 12
local bnc = Instance.new("UICorner", btnNome)
bnc.CornerRadius = UDim.new(0, 8)

local btnRenomear = Instance.new("TextButton", c1)
btnRenomear.Size = UDim2.new(0.38, 0, 0, 35)
btnRenomear.Position = UDim2.new(0.56, 0, 0.30, 0)
btnRenomear.Text = "Renomear"
btnRenomear.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRenomear.BackgroundColor3 = Color3.fromRGB(50, 70, 50)
btnRenomear.Font = Enum.Font.GothamBold
btnRenomear.TextSize = 12
local brc = Instance.new("UICorner", btnRenomear)
brc.CornerRadius = UDim.new(0, 8)

local btnTex = Instance.new("TextButton", c1)
btnTex.Size = UDim2.new(0.38, 0, 0, 35)
btnTex.Position = UDim2.new(0.06, 0, 0.40, 0)
btnTex.Text = "Remover Tex"
btnTex.TextColor3 = Color3.fromRGB(255, 200, 200)
btnTex.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
btnTex.Font = Enum.Font.GothamBold
btnTex.TextSize = 12
local btc = Instance.new("UICorner", btnTex)
btc.CornerRadius = UDim.new(0, 8)

local btnReset = Instance.new("TextButton", c1)
btnReset.Size = UDim2.new(0.38, 0, 0, 35)
btnReset.Position = UDim2.new(0.56, 0, 0.40, 0)
btnReset.Text = "Resetar"
btnReset.TextColor3 = Color3.fromRGB(255, 255, 255)
btnReset.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
btnReset.Font = Enum.Font.GothamBold
btnReset.TextSize = 12
local brc2 = Instance.new("UICorner", btnReset)
brc2.CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel", c1)
status.Size = UDim2.new(0.9, 0, 0, 40)
status.Position = UDim2.new(0.05, 0, 0.48, 0)
status.Text = "Pronto"
status.TextColor3 = Color3.fromRGB(100, 255, 100)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextWrapped = true

local btnBuscar = Instance.new("TextButton", c1)
btnBuscar.Size = UDim2.new(0.8, 0, 0, 30)
btnBuscar.Position = UDim2.new(0.1, 0, 0.60, 0)
btnBuscar.Text = "BUSCAR BOLA TPS"
btnBuscar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnBuscar.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
btnBuscar.Font = Enum.Font.GothamBold
btnBuscar.TextSize = 12
local bbc = Instance.new("UICorner", btnBuscar)
bbc.CornerRadius = UDim.new(0, 8)

-- CONTEUDO ABA 2
local c2 = Instance.new("Frame", main)
c2.Size = UDim2.new(1, 0, 1, -80)
c2.Position = UDim2.new(0, 0, 0, 80)
c2.BackgroundTransparency = 1
c2.Visible = false

local lblReach = Instance.new("TextLabel", c2)
lblReach.Size = UDim2.new(0.8, 0, 0, 30)
lblReach.Position = UDim2.new(0.1, 0, 0.05, 0)
lblReach.Text = "Reach: 1.0x"
lblReach.TextColor3 = Color3.fromRGB(255, 255, 255)
lblReach.BackgroundTransparency = 1
lblReach.Font = Enum.Font.GothamBold
lblReach.TextSize = 18

local lblSub = Instance.new("TextLabel", c2)
lblSub.Size = UDim2.new(0.8, 0, 0, 20)
lblSub.Position = UDim2.new(0.1, 0, 0.14, 0)
lblSub.Text = "Alcance do personagem"
lblSub.TextColor3 = Color3.fromRGB(180, 180, 200)
lblSub.BackgroundTransparency = 1
lblSub.Font = Enum.Font.Gotham
lblSub.TextSize = 12

local btnMenos = Instance.new("TextButton", c2)
btnMenos.Size = UDim2.new(0.12, 0, 0, 35)
btnMenos.Position = UDim2.new(0.1, 0, 0.30, 0)
btnMenos.Text = "-"
btnMenos.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMenos.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
btnMenos.Font = Enum.Font.GothamBold
btnMenos.TextSize = 20
local bmc2 = Instance.new("UICorner", btnMenos)
bmc2.CornerRadius = UDim.new(0, 5)

local btnMais = Instance.new("TextButton", c2)
btnMais.Size = UDim2.new(0.12, 0, 0, 35)
btnMais.Position = UDim2.new(0.78, 0, 0.30, 0)
btnMais.Text = "+"
btnMais.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMais.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
btnMais.Font = Enum.Font.GothamBold
btnMais.TextSize = 20
local bmc3 = Instance.new("UICorner", btnMais)
bmc3.CornerRadius = UDim.new(0, 5)

local lblValor = Instance.new("TextLabel", c2)
lblValor.Size = UDim2.new(0.3, 0, 0, 35)
lblValor.Position = UDim2.new(0.35, 0, 0.30, 0)
lblValor.Text = "1.0"
lblValor.TextColor3 = Color3.fromRGB(255, 255, 255)
lblValor.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
lblValor.Font = Enum.Font.GothamBold
lblValor.TextSize = 16
local lvc = Instance.new("UICorner", lblValor)
lvc.CornerRadius = UDim.new(0, 5)

local lblStatusReach = Instance.new("TextLabel", c2)
lblStatusReach.Size = UDim2.new(0.8, 0, 0, 30)
lblStatusReach.Position = UDim2.new(0.1, 0, 0.42, 0)
lblStatusReach.Text = "Reach aplicado ao personagem"
lblStatusReach.TextColor3 = Color3.fromRGB(150, 255, 150)
lblStatusReach.BackgroundTransparency = 1
lblStatusReach.Font = Enum.Font.Gotham
lblStatusReach.TextSize = 12

-- CONTEUDO ABA 3
local c3 = Instance.new("Frame", main)
c3.Size = UDim2.new(1, 0, 1, -80)
c3.Position = UDim2.new(0, 0, 0, 80)
c3.BackgroundTransparency = 1
c3.Visible = false

local lblEsp = Instance.new("TextLabel", c3)
lblEsp.Size = UDim2.new(0.8, 0, 0, 25)
lblEsp.Position = UDim2.new(0.1, 0, 0.02, 0)
lblEsp.Text = "ESP - Destaque da Bola"
lblEsp.TextColor3 = Color3.fromRGB(255, 255, 255)
lblEsp.BackgroundTransparency = 1
lblEsp.Font = Enum.Font.GothamBold
lblEsp.TextSize = 15
lblEsp.TextXAlignment = Enum.TextXAlignment.Left

local btnEsp = Instance.new("TextButton", c3)
btnEsp.Size = UDim2.new(0.8, 0, 0, 40)
btnEsp.Position = UDim2.new(0.1, 0, 0.12, 0)
btnEsp.Text = "ESP: DESATIVADO"
btnEsp.TextColor3 = Color3.fromRGB(255, 255, 255)
btnEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
btnEsp.Font = Enum.Font.GothamBold
btnEsp.TextSize = 14
local bec = Instance.new("UICorner", btnEsp)
bec.CornerRadius = UDim.new(0, 8)

local lblHitbox = Instance.new("TextLabel", c3)
lblHitbox.Size = UDim2.new(0.8, 0, 0, 25)
lblHitbox.Position = UDim2.new(0.1, 0, 0.28, 0)
lblHitbox.Text = "Hitbox - Visualizar Tamanho"
lblHitbox.TextColor3 = Color3.fromRGB(255, 255, 255)
lblHitbox.BackgroundTransparency = 1
lblHitbox.Font = Enum.Font.GothamBold
lblHitbox.TextSize = 15
lblHitbox.TextXAlignment = Enum.TextXAlignment.Left

local btnHitbox = Instance.new("TextButton", c3)
btnHitbox.Size = UDim2.new(0.8, 0, 0, 40)
btnHitbox.Position = UDim2.new(0.1, 0, 0.38, 0)
btnHitbox.Text = "HITBOX: DESATIVADO"
btnHitbox.TextColor3 = Color3.fromRGB(255, 255, 255)
btnHitbox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
btnHitbox.Font = Enum.Font.GothamBold
btnHitbox.TextSize = 14
local bhc = Instance.new("UICorner", btnHitbox)
bhc.CornerRadius = UDim.new(0, 8)

local lblInfo = Instance.new("TextLabel", c3)
lblInfo.Size = UDim2.new(0.8, 0, 0, 40)
lblInfo.Position = UDim2.new(0.1, 0, 0.55, 0)
lblInfo.Text = "Hitbox mostra o tamanho real da bola\ne a area de colisao"
lblInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
lblInfo.BackgroundTransparency = 1
lblInfo.Font = Enum.Font.Gotham
lblInfo.TextSize = 12
lblInfo.TextXAlignment = Enum.TextXAlignment.Left

-- FECHAR
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -42, 0, 8)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0
local ccc = Instance.new("UICorner", closeBtn)
ccc.CornerRadius = UDim.new(1, 0)

-- ============================================
-- ====== FUNCOES DAS ABAS ======
-- ============================================
local function switchAba(n)
    c1.Visible = (n == 1)
    c2.Visible = (n == 2)
    c3.Visible = (n == 3)
    aba1.BackgroundColor3 = (n == 1) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba1.TextColor3 = (n == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    aba2.BackgroundColor3 = (n == 2) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba2.TextColor3 = (n == 2) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    aba3.BackgroundColor3 = (n == 3) and Color3.fromRGB(60, 50, 100) or Color3.fromRGB(40, 40, 60)
    aba3.TextColor3 = (n == 3) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
end

aba1.MouseButton1Click:Connect(function() switchAba(1) end)
aba2.MouseButton1Click:Connect(function() switchAba(2) end)
aba3.MouseButton1Click:Connect(function() switchAba(3) end)

-- ============================================
-- ====== ACOES DOS BOTOES ======
-- ============================================

-- ABA 1
btnMesh.MouseButton1Click:Connect(function()
    local id = idInput.Text
    if id and id ~= "" then
        if trocarMesh(id) then
            status.Text = "Mesh aplicada com sucesso!"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            status.Text = "Bola TPS nao encontrada!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        status.Text = "Digite um ID valido!"
        status.TextColor3 = Color3.fromRGB(255, 200, 50)
    end
end)

local nomeAtivo = false
btnNome.MouseButton1Click:Connect(function()
    nomeAtivo = not nomeAtivo
    if nomeAtivo then
        btnNome.Text = "Nome: ON"
        btnNome.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        renameToNerdttk()
        status.Text = "Nome alterado para nerdttk"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        btnNome.Text = "Nome: OFF"
        btnNome.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        resetBallName()
        status.Text = "Nome resetado para TPS"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end)

btnRenomear.MouseButton1Click:Connect(function()
    if renameToNerdttk() then
        status.Text = "Renomeado para nerdttk"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        nomeAtivo = true
        btnNome.Text = "Nome: ON"
        btnNome.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    else
        status.Text = "Bola TPS nao encontrada!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

btnTex.MouseButton1Click:Connect(function()
    if removerTexturas() then
        status.Text = "Texturas removidas!"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        status.Text = "Bola TPS nao encontrada!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

btnReset.MouseButton1Click:Connect(function()
    if resetBallName() then
        status.Text = "Nome resetado para TPS"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        nomeAtivo = false
        btnNome.Text = "Nome: OFF"
        btnNome.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    else
        status.Text = "Bola TPS nao encontrada!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

btnBuscar.MouseButton1Click:Connect(function()
    local ball = findBall()
    if ball then
        status.Text = "Bola TPS encontrada: " .. ball.Name
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        status.Text = "Bola TPS nao encontrada!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ABA 2 - Reach
local function atualizarReach()
    lblReach.Text = "Reach: " .. string.format("%.1f", reachMultiplier) .. "x"
    lblValor.Text = string.format("%.1f", reachMultiplier)
    local val = 10 + (reachMultiplier - 0.5) * 20
    local pct = math.clamp((reachMultiplier - 0.5) / 3.5, 0, 1)
end

btnMenos.MouseButton1Click:Connect(function()
    if reachMultiplier > 0.5 then
        reachMultiplier = reachMultiplier - 0.1
        local valorFinal = math.floor(reachMultiplier * 10) / 10
        if aplicarReach(valorFinal) then
            lblStatusReach.Text = "Reach ajustado para: " .. string.format("%.1f", valorFinal)
            lblStatusReach.TextColor3 = Color3.fromRGB(150, 255, 150)
        else
            lblStatusReach.Text = "Erro ao aplicar Reach!"
            lblStatusReach.TextColor3 = Color3.fromRGB(255, 150, 150)
        end
        atualizarReach()
    end
end)

btnMais.MouseButton1Click:Connect(function()
    if reachMultiplier < 4.0 then
        reachMultiplier = reachMultiplier + 0.1
        local valorFinal = math.floor(reachMultiplier * 10) / 10
        if aplicarReach(valorFinal) then
            lblStatusReach.Text = "Reach ajustado para: " .. string.format("%.1f", valorFinal)
            lblStatusReach.TextColor3 = Color3.fromRGB(150, 255, 150)
        else
            lblStatusReach.Text = "Erro ao aplicar Reach!"
            lblStatusReach.TextColor3 = Color3.fromRGB(255, 150, 150)
        end
        atualizarReach()
    end
end)

-- ABA 3 - ESP/Hitbox
btnEsp.MouseButton1Click:Connect(function()
    toggleESP()
    if espEnabled then
        btnEsp.Text = "ESP: ATIVADO"
        btnEsp.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    else
        btnEsp.Text = "ESP: DESATIVADO"
        btnEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end
end)

btnHitbox.MouseButton1Click:Connect(function()
    if hitboxVisible then
        removerHitbox()
        btnHitbox.Text = "HITBOX: DESATIVADO"
        btnHitbox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    else
        criarHitbox()
        btnHitbox.Text = "HITBOX: ATIVADO"
        btnHitbox.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    end
end)

-- FECHAR
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    bg.Visible = main.Visible
end)

-- ATALHO B
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.B then
        main.Visible = not main.Visible
        bg.Visible = main.Visible
    end
end)

-- ATUALIZAR HITBOX
game:GetService("RunService").Heartbeat:Connect(function()
    atualizarHitbox()
end)

-- ============================================
-- ====== INICIALIZACAO ======
-- ============================================
print("TCS - Alterador de Ball carregado!")
print("Pressione B para abrir/fechar")

local ball = findBall()
if ball then
    print("Bola TPS encontrada: " .. ball.Name)
    status.Text = "Bola TPS: " .. ball.Name
else
    print("Bola TPS nao encontrada!")
    status.Text = "Bola TPS nao encontrada!"
    status.TextColor3 = Color3.fromRGB(255, 200, 50)
end