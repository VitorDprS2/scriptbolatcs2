-- ============================================
-- VITORXYZ - ALTERADOR DE BALL
-- Key + HWID Lock + Painel Completo
-- ============================================

local player = game.Players.LocalPlayer

-- ===== HWID =====
local function getHWID()
    local hwid = nil
    pcall(function()
        hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if not hwid then
        hwid = tostring(player.UserId)
    end
    return tostring(hwid)
end

-- ===== KEYS =====
local keysValidas = {
    ["A7K9-M2XP-4QW8-N3RT"] = "",
    ["B4L8-N5VZ-7YT2-P9MK"] = "",
    ["C2M6-Q8WD-3ER7-T5YU"] = "",
    ["D9N3-R4TF-6YH8-U2IO"] = "",
    ["E5P7-S6YH-8UJ9-I3OP"] = "",
    ["F3Q8-T7UI-9OK0-P4AS"] = "",
    ["G6R2-U8IO-0PL1-A5DF"] = "",
    ["H8S4-V9OP-1AM2-S6DG"] = "",
    ["I2T6-W0AQ-2BN3-D7FH"] = "",
    ["J4U8-X1BR-3CO4-F8GJ"] = "",
    ["K7V3-Y2CS-4DP5-G9HK"] = "",
    ["L9W5-Z3DT-5EQ6-H0JL"] = "",
    ["M3X7-A4EU-6FR7-J1KM"] = "",
    ["N5Y9-B5FV-7GS8-K2LN"] = "",
    ["O8Z2-C6GW-8HT9-L3MO"] = "",
    ["P4A6-D7HX-9IU0-M4NP"] = "",
    ["Q7B9-E8IY-0JV1-N5OQ"] = "",
    ["R2C5-F9JZ-1KW2-O6PR"] = "",
    ["S6D8-G0KA-2LX3-P7QS"] = "",
    ["T9E3-H1LB-3MY4-Q8RT"] = "",
    ["U5F7-I2MC-4NZ5-R9SU"] = "",
    ["V8G2-J3ND-5OA6-S0TV"] = "",
    ["W3H6-K4OE-6PB7-T1UW"] = "",
    ["X7I9-L5PF-7QC8-U2VX"] = "",
    ["Y2J4-M6QG-8RD9-V3WY"] = "",
    ["Z6K8-N7RH-9SE0-W4XZ"] = "",
    ["A9L3-O8SI-0TF1-X5YA"] = "",
    ["B5M7-P9TJ-1UG2-Y6ZB"] = "",
    ["C8N2-Q0UK-2VH3-Z7AC"] = "",
    ["D4O6-R1VL-3WI4-A8BD"] = "",
    ["E7P9-S2WM-4XJ5-B9CE"] = "",
    ["F2Q5-T3XN-5YK6-C0DF"] = "",
    ["G9R8-U4YO-6ZL7-D1EG"] = "",
    ["H3S6-V5ZP-7AM8-E2FH"] = "",
    ["I7T9-W6AQ-8BN9-F3GI"] = "",
    ["J2U5-X7BR-9CO0-G4HJ"] = "",
    ["K9V8-Y8CS-0DP1-H5IK"] = "",
    ["L3W6-Z9DT-1EQ2-I6JL"] = "",
    ["M7X9-A0EU-2FR3-J7KM"] = "",
    ["N2Y5-B1FV-3GS4-K8LN"] = "",
    ["O9Z8-C2GW-4HT5-L9MO"] = "",
    ["P3A6-D3HX-5IU6-M0NP"] = "",
    ["Q7B9-E4IY-6JV7-N1OQ"] = "",
    ["R2C5-F5JZ-7KW8-O2PR"] = "",
    ["S9D8-G6KA-8LX9-P3QS"] = "",
    ["T3E6-H7LB-9MY0-Q4RT"] = "",
    ["U7F9-I8MC-0NZ1-R5SU"] = "",
    ["V2G5-J9ND-1OA2-S6TV"] = "",
    ["W9H8-K0OE-2PB3-T7UW"] = "",
    ["X3I6-L1PF-3QC4-U8VX"] = "",
    ["Y7J9-M2QG-4RD5-V9WY"] = "",
    ["Z2K5-N3RH-5SE6-W0XZ"] = "",
    ["A9L8-O4SI-6TF7-X1YA"] = "",
    ["B3M6-P5TJ-7UG8-Y2ZB"] = "",
    ["C7N9-Q6UK-8VH9-Z3AC"] = "",
    ["D2O5-R7VL-9WI0-A4BD"] = "",
    ["E9P8-S8WM-0XJ1-B5CE"] = "",
    ["F3Q6-T9XN-1YK2-C6DF"] = "",
    ["G7R9-U0YO-2ZL3-D7EG"] = "",
    ["H2S5-V1ZP-3AM4-E8FH"] = "",
    ["I9T8-W2AQ-4BN5-F9GI"] = "",
    ["J3U6-X3BR-5CO6-G0HJ"] = "",
    ["K7V9-Y4CS-6DP7-H1IK"] = "",
    ["L2W5-Z5DT-7EQ8-I2JL"] = "",
    ["M9X8-A6EU-8FR9-J3KM"] = "",
    ["N3Y6-B7FV-9GS0-K4LN"] = "",
    ["O7Z9-C8GW-0HT1-L5MO"] = "",
    ["P2A5-D9HX-1IU2-M6NP"] = "",
    ["Q9B8-E0IY-2JV3-N7OQ"] = "",
    ["R3C6-F1JZ-3KW4-O8PR"] = "",
    ["S7D9-G2KA-4LX5-P9QS"] = "",
    ["T2E5-H3LB-5MY6-Q0RT"] = "",
    ["U9F8-I4MC-6NZ7-R1SU"] = "",
    ["V3G6-J5ND-7OA8-S2TV"] = "",
    ["W7H9-K6OE-8PB9-T3UW"] = "",
    ["X2I5-L7PF-9QC0-U4VX"] = "",
    ["Y9J8-M8QG-0RD1-V5WY"] = "",
    ["Z3K6-N9RH-1SE2-W6XZ"] = "",
    ["A7L9-O0SI-2TF3-X7YA"] = "",
    ["B2M5-P1TJ-3UG4-Y8ZB"] = "",
    ["C9N8-Q2UK-4VH5-Z9AC"] = "",
    ["D3O6-R3VL-5WI6-A0BD"] = "",
    ["E7P9-S4WM-6XJ7-B1CE"] = "",
    ["F2Q5-T5XN-7YK8-C2DF"] = "",
    ["G9R8-U6YO-8ZL9-D3EG"] = "",
    ["H3S6-V7ZP-9AM0-E4FH"] = "",
    ["I7T9-W8AQ-0BN1-F5GI"] = "",
    ["J2U5-X9BR-1CO2-G6HJ"] = "",
    ["K9V8-Y0CS-2DP3-H7IK"] = "",
    ["L3W6-Z1DT-3EQ4-I8JL"] = "",
    ["M7X9-A2EU-4FR5-J9KM"] = "",
    ["N2Y5-B3FV-5GS6-K0LN"] = "",
    ["O9Z8-C4GW-6HT7-L1MO"] = "",
    ["P3A6-D5HX-7IU8-M2NP"] = "",
    ["Q7B9-E6IY-8JV9-N3OQ"] = "",
    ["R2C5-F7JZ-9KW0-O4PR"] = "",
    ["S9D8-G8KA-0LX1-P5QS"] = "",
    ["T3E6-H9LB-1MY2-Q6RT"] = "",
    ["U7F9-I0MC-2NZ3-R7SU"] = "",
    ["V2G5-J1ND-3OA4-S8TV"] = "",
    ["W9H8-K2OE-4PB5-T9UW"] = "",
    ["X3I6-L3PF-5QC6-U0VX"] = "",
    ["Y7J9-M4QG-6RD7-V1WY"] = "",
    ["Z2K5-N5RH-7SE8-W2XZ"] = "",
    ["A9L8-O6SI-8TF9-X3YA"] = "",
    ["B3M6-P7TJ-9UG0-Y4ZB"] = "",
    ["C7N9-Q8UK-0VH1-Z5AC"] = "",
    ["D2O5-R9VL-1WI2-A6BD"] = "",
    ["E9P8-S0WM-2XJ3-B7CE"] = "",
    ["F3Q6-T1XN-3YK4-C8DF"] = "",
    ["G7R9-U2YO-4ZL5-D9EG"] = "",
    ["H2S5-V3ZP-5AM6-E0FH"] = "",
    ["I9T8-W4AQ-6BN7-F1GI"] = "",
    ["J3U6-X5BR-7CO8-G2HJ"] = "",
    ["K7V9-Y6CS-8DP9-H3IK"] = "",
    ["L2W5-Z7DT-9EQ0-I4JL"] = "",
    ["M9X8-A8EU-0FR1-J5KM"] = "",
    ["N3Y6-B9FV-1GS2-K6LN"] = "",
    ["O7Z9-C0GW-2HT3-L7MO"] = "",
    ["P2A5-D1HX-3IU4-M8NP"] = "",
    ["Q9B8-E2IY-4JV5-N9OQ"] = "",
    ["R3C6-F3JZ-5KW6-O0PR"] = "",
    ["S7D9-G4KA-6LX7-P1QS"] = "",
    ["T2E5-H5LB-7MY8-Q2RT"] = "",
    ["U9F8-I6MC-8NZ9-R3SU"] = "",
    ["V3G6-J7ND-9OA0-S4TV"] = "",
    ["W7H9-K8OE-0PB1-T5UW"] = "",
    ["X2I5-L9PF-1QC2-U6VX"] = "",
    ["Y9J8-M0QG-2RD3-V7WY"] = "",
    ["Z3K6-N1RH-3SE4-W8XZ"] = "",
    ["A7L9-O2SI-4TF5-X9YA"] = "",
    ["B2M5-P3TJ-5UG6-Y0ZB"] = "",
    ["C9N8-Q4UK-6VH7-Z1AC"] = "",
    ["D3O6-R5VL-7WI8-A2BD"] = "",
    ["E7P9-S6WM-8XJ9-B3CE"] = "",
    ["F2Q5-T7XN-9YK0-C4DF"] = "",
    ["G9R8-U8YO-0ZL1-D5EG"] = "",
    ["H3S6-V9ZP-1AM2-E6FH"] = "",
    ["I7T9-W0AQ-2BN3-F7GI"] = "",
    ["J2U5-X1BR-3CO4-G8HJ"] = "",
    ["K9V8-Y2CS-4DP5-H9IK"] = "",
    ["L3W6-Z3DT-5EQ6-I0JL"] = "",
    ["M7X9-A4EU-6FR7-J1KM"] = "",
    ["N2Y5-B5FV-7GS8-K2LN"] = "",
    ["O9Z8-C6GW-8HT9-L3MO"] = "",
    ["P3A6-D7HX-9IU0-M4NP"] = "",
    ["Q7B9-E8IY-0JV1-N5OQ"] = "",
    ["R2C5-F9JZ-1KW2-O6PR"] = "",
    ["S9D8-G0KA-2LX3-P7QS"] = "",
    ["T3E6-H1LB-3MY4-Q8RT"] = "",
    ["U7F9-I2MC-4NZ5-R9SU"] = "",
    ["V2G5-J3ND-5OA6-S0TV"] = "",
    ["W9H8-K4OE-6PB7-T1UW"] = "",
    ["X3I6-L5PF-7QC8-U2VX"] = "",
    ["Y7J9-M6QG-8RD9-V3WY"] = "",
    ["Z2K5-N7RH-9SE0-W4XZ"] = "",
    ["A9L8-O8SI-0TF1-X5YA"] = "",
    ["B3M6-P9TJ-1UG2-Y6ZB"] = "",
    ["C7N9-Q0UK-2VH3-Z7AC"] = "",
    ["D2O5-R1VL-3WI4-A8BD"] = "",
    ["E9P8-S2WM-4XJ5-B9CE"] = "",
    ["F3Q6-T3XN-5YK6-C0DF"] = "",
    ["G7R9-U4YO-6ZL7-D1EG"] = "",
    ["H2S5-V5ZP-7AM8-E2FH"] = "",
    ["I9T8-W6AQ-8BN9-F3GI"] = "",
    ["J3U6-X7BR-9CO0-G4HJ"] = "",
    ["K7V9-Y8CS-0DP1-H5IK"] = "",
    ["L2W5-Z9DT-1EQ2-I6JL"] = "",
    ["M9X8-A0EU-2FR3-J7KM"] = "",
    ["N3Y6-B1FV-3GS4-K8LN"] = "",
    ["O7Z9-C2GW-4HT5-L9MO"] = "",
    ["P2A5-D3HX-5IU6-M0NP"] = "",
    ["Q9B8-E4IY-6JV7-N1OQ"] = "",
    ["R3C6-F5JZ-7KW8-O2PR"] = "",
    ["S7D9-G6KA-8LX9-P3QS"] = "",
    ["T2E5-H7LB-9MY0-Q4RT"] = "",
    ["U9F8-I8MC-0NZ1-R5SU"] = "",
    ["V3G6-J9ND-1OA2-S6TV"] = "",
    ["W7H9-K0OE-2PB3-T7UW"] = "",
    ["X2I5-L1PF-3QC4-U8VX"] = "",
    ["Y9J8-M2QG-4RD5-V9WY"] = "",
    ["Z3K6-N3RH-5SE6-W0XZ"] = "",
    ["A7L9-O4SI-6TF7-X1YA"] = "",
    ["B2M5-P5TJ-7UG8-Y2ZB"] = "",
    ["C9N8-Q6UK-8VH9-Z3AC"] = "",
    ["D3O6-R7VL-9WI0-A4BD"] = "",
    ["E7P9-S8WM-0XJ1-B5CE"] = "",
    ["F2Q5-T9XN-1YK2-C6DF"] = "",
    ["G9R8-U0YO-2ZL3-D7EG"] = "",
    ["H3S6-V1ZP-3AM4-E8FH"] = "",
    ["I7T9-W2AQ-4BN5-F9GI"] = "",
    ["J2U5-X3BR-5CO6-G0HJ"] = "",
    ["K9V8-Y4CS-6DP7-H1IK"] = "",
    ["L3W6-Z5DT-7EQ8-I2JL"] = "",
    ["M7X9-A6EU-8FR9-J3KM"] = "",
    ["N2Y5-B7FV-9GS0-K4LN"] = "",
    ["O9Z8-C8GW-0HT1-L5MO"] = "",
    ["P3A6-D9HX-1IU2-M6NP"] = "",
    ["Q7B9-E0IY-2JV3-N7OQ"] = "",
    ["R2C5-F1JZ-3KW4-O8PR"] = "",
    ["S9D8-G2KA-4LX5-P9QS"] = "",
    ["T3E6-H3LB-5MY6-Q0RT"] = "",
    ["U7F9-I4MC-6NZ7-R1SU"] = "",
    ["V2G5-J5ND-7OA8-S2TV"] = "",
    ["W9H8-K6OE-8PB9-T3UW"] = "",
    ["X3I6-L7PF-9QC0-U4VX"] = "",
    ["Y7J9-M8QG-0RD1-V5WY"] = "",
    ["Z2K5-N9RH-1SE2-W6XZ"] = "",
    ["A9L8-O0SI-2TF3-X7YA"] = "",
    ["B3M6-P1TJ-3UG4-Y8ZB"] = "",
    ["C7N9-Q2UK-4VH5-Z9AC"] = "",
    ["D2O5-R3VL-5WI6-A0BD"] = "",
    ["E9P8-S4WM-6XJ7-B1CE"] = "",
    ["F3Q6-T5XN-7YK8-C2DF"] = "",
    ["G7R9-U6YO-8ZL9-D3EG"] = "",
    ["H2S5-V7ZP-9AM0-E4FH"] = "",
    ["I9T8-W8AQ-0BN1-F5GI"] = "",
    ["J3U6-X9BR-1CO2-G6HJ"] = "",
    ["K7V9-Y0CS-2DP3-H7IK"] = "",
    ["L2W5-Z1DT-3EQ4-I8JL"] = "",
}

-- ===== UI DE KEY =====
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VitorxyzKey"
keyGui.Parent = player.PlayerGui
keyGui.ResetOnSpawn = false

local kf = Instance.new("Frame")
kf.Size = UDim2.new(0, 350, 0, 250)
kf.Position = UDim2.new(0.5, -175, 0.5, -125)
kf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
kf.BorderSizePixel = 0
kf.Active = true
kf.Draggable = true
kf.Parent = keyGui
Instance.new("UICorner", kf).CornerRadius = UDim.new(0, 12)
local ks = Instance.new("UIStroke", kf)
ks.Color = Color3.fromRGB(0, 170, 255)
ks.Thickness = 2

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1, 0, 0, 50)
kt.Text = "VITORXYZ - VERIFICACAO"
kt.TextColor3 = Color3.fromRGB(0, 170, 255)
kt.BackgroundTransparency = 1
kt.Font = Enum.Font.GothamBold
kt.TextSize = 18

local ki = Instance.new("TextBox", kf)
ki.Size = UDim2.new(0.85, 0, 0, 45)
ki.Position = UDim2.new(0.075, 0, 0.35, 0)
ki.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ki.TextColor3 = Color3.fromRGB(255, 255, 255)
ki.PlaceholderText = "Digite sua key..."
ki.Text = ""
ki.Font = Enum.Font.Gotham
ki.TextSize = 13
ki.BorderSizePixel = 0
Instance.new("UICorner", ki).CornerRadius = UDim.new(0, 8)

local kb = Instance.new("TextButton", kf)
kb.Size = UDim2.new(0.85, 0, 0, 45)
kb.Position = UDim2.new(0.075, 0, 0.55, 0)
kb.Text = "VERIFICAR KEY"
kb.TextColor3 = Color3.fromRGB(255, 255, 255)
kb.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
kb.Font = Enum.Font.GothamBold
kb.TextSize = 14
kb.BorderSizePixel = 0
Instance.new("UICorner", kb).CornerRadius = UDim.new(0, 8)

local kst = Instance.new("TextLabel", kf)
kst.Size = UDim2.new(0.9, 0, 0, 30)
kst.Position = UDim2.new(0.05, 0, 0.78, 0)
kst.Text = ""
kst.TextColor3 = Color3.fromRGB(255, 100, 100)
kst.BackgroundTransparency = 1
kst.Font = Enum.Font.GothamBold
kst.TextSize = 12

local verificada = false

local function checkKey()
    local k = ki.Text
    local hwidAtual = getHWID()
    if k == "" then
        kst.Text = "Digite uma key!"
        kst.TextColor3 = Color3.fromRGB(255, 200, 50)
        return
    end
    local salvo = keysValidas[k]
    if salvo == nil then
        kst.Text = "Key invalida!"
        kst.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    if salvo == "" then
        keysValidas[k] = hwidAtual
        kst.Text = "Key ativada!"
        kst.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(1)
        verificada = true
        kf:Destroy()
        keyGui:Destroy()
        return
    end
    if salvo ~= hwidAtual then
        kst.Text = "Key nao pertence a este PC!"
        kst.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    verificada = true
    kst.Text = "Key valida!"
    kst.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(0.5)
    kf:Destroy()
    keyGui:Destroy()
end

kb.MouseButton1Click:Connect(checkKey)
ki.FocusLost:Connect(function(e) if e then checkKey() end end)

while not verificada do task.wait(0.1) end

-- ============================================
-- PAINEL
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "VitorxyzGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local bolaLisaAtiva = false
local corOriginal = nil
local corSelecionada = Color3.fromRGB(255, 255, 255)
local tamanhoMultiplier = 1.0

-- ===== FUNCOES =====
local function findBall()
    local stadium = workspace:FindFirstChild("WorkspaceStadiumMap1")
    if stadium then
        local tfs = stadium:FindFirstChild("TF'S")
        if tfs then
            local b = tfs:FindFirstChild("TPS")
            if b then return b end
            for _, c in ipairs(tfs:GetChildren()) do
                if c:IsA("BasePart") or c:IsA("MeshPart") then
                    local n = c.Name:lower()
                    if n:find("ball") or n:find("bola") or n:find("tps") then return c end
                end
            end
        end
    end
    for _, c in ipairs(workspace:GetChildren()) do
        if c:IsA("BasePart") or c:IsA("MeshPart") then
            local n = c.Name:lower()
            if n:find("ball") or n:find("bola") or n:find("tps") then return c end
        end
    end
    return nil
end

local function aplicarTamanho()
    local b = findBall()
    if not b then return end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if not m then
        m = Instance.new("SpecialMesh", b)
        m.MeshType = Enum.MeshType.Sphere
    end
    m.Scale = Vector3.new(tamanhoMultiplier, tamanhoMultiplier, tamanhoMultiplier)
end

local function resetarTamanho()
    local b = findBall()
    if not b then return end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then m.Scale = Vector3.new(1, 1, 1) end
    tamanhoMultiplier = 1.0
end

local function removerTexturas()
    local b = findBall()
    if not b then return end
    for _, c in ipairs(b:GetChildren()) do
        if c:IsA("Texture") or c:IsA("Decal") then c:Destroy() end
    end
    for _, p in ipairs(b:GetDescendants()) do
        if p:IsA("Texture") or p:IsA("Decal") then p:Destroy() end
    end
end

local function resetarMesh()
    local b = findBall()
    if not b then return end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then m:Destroy() end
end

local function deixarLisa()
    local b = findBall()
    if not b then return end
    if not corOriginal then corOriginal = b.Color end
    removerTexturas()
    resetarMesh()
    b.Material = Enum.Material.SmoothPlastic
    b.Color = corSelecionada
    b.Reflectance = 0.2
end

local function resetarLisa()
    local b = findBall()
    if not b then return end
    if corOriginal then b.Color = corOriginal end
    b.Material = Enum.Material.Plastic
    b.Reflectance = 0
end

local function renomearBola()
    local b = findBall()
    if b then b.Name = "Vitorxyz" end
end

-- ===== UI =====
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 340, 0, 620)
main.Position = UDim2.new(0.5, -170, 0.5, -310)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", main)
ms.Color = Color3.fromRGB(255, 255, 255)
ms.Thickness = 2

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Vitorxyz - Alterador de ball"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

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

local conteudo = Instance.new("Frame", main)
conteudo.Size = UDim2.new(1, 0, 1, -40)
conteudo.Position = UDim2.new(0, 0, 0, 40)
conteudo.BackgroundTransparency = 1

-- Botao 1: Bola Nova
local b1 = Instance.new("TextButton", conteudo)
b1.Size = UDim2.new(0.85, 0, 0, 32)
b1.Position = UDim2.new(0.075, 0, 0.02, 0)
b1.Text = "BOLA NOVA: OFF"
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
b1.Font = Enum.Font.GothamBold
b1.TextSize = 13
b1.BorderSizePixel = 0
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 8)

-- Botao 2: Bola Lisa
local b2 = Instance.new("TextButton", conteudo)
b2.Size = UDim2.new(0.85, 0, 0, 32)
b2.Position = UDim2.new(0.075, 0, 0.10, 0)
b2.Text = "BOLA LISA: OFF"
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
b2.Font = Enum.Font.GothamBold
b2.TextSize = 13
b2.BorderSizePixel = 0
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 8)

-- Label cores
local cl = Instance.new("TextLabel", conteudo)
cl.Size = UDim2.new(0.85, 0, 0, 18)
cl.Position = UDim2.new(0.075, 0, 0.18, 0)
cl.Text = "COR DA BOLA LISA:"
cl.TextColor3 = Color3.fromRGB(0, 170, 255)
cl.BackgroundTransparency = 1
cl.Font = Enum.Font.GothamBold
cl.TextSize = 11

-- Cores
local coresLista = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(128, 0, 128),
    Color3.fromRGB(0, 255, 255),
}

local cf = Instance.new("Frame", conteudo)
cf.Size = UDim2.new(0.85, 0, 0, 70)
cf.Position = UDim2.new(0.075, 0, 0.22, 0)
cf.BackgroundTransparency = 1
local cg = Instance.new("UIGridLayout", cf)
cg.CellSize = UDim2.new(0, 30, 0, 30)
cg.CellPadding = UDim2.new(0, 6, 0, 6)

for i, c in ipairs(coresLista) do
    local bc = Instance.new("TextButton", cf)
    bc.Size = UDim2.new(0, 30, 0, 30)
    bc.BackgroundColor3 = c
    bc.Text = ""
    bc.BorderSizePixel = 0
    bc.LayoutOrder = i
    Instance.new("UICorner", bc).CornerRadius = UDim.new(1, 0)
    local st = Instance.new("UIStroke", bc)
    st.Color = Color3.fromRGB(255, 255, 255)
    st.Thickness = 2
    bc.MouseButton1Click:Connect(function()
        corSelecionada = c
        if bolaLisaAtiva then
            local b = findBall()
            if b then b.Color = c end
        end
    end)
end

-- Label Tamanho
local tl = Instance.new("TextLabel", conteudo)
tl.Size = UDim2.new(0.85, 0, 0, 18)
tl.Position = UDim2.new(0.075, 0, 0.38, 0)
tl.Text = "TAMANHO VISUAL:"
tl.TextColor3 = Color3.fromRGB(0, 170, 255)
tl.BackgroundTransparency = 1
tl.Font = Enum.Font.GothamBold
tl.TextSize = 11

-- Botao -
local bm = Instance.new("TextButton", conteudo)
bm.Size = UDim2.new(0.15, 0, 0, 35)
bm.Position = UDim2.new(0.075, 0, 0.42, 0)
bm.Text = "-"
bm.TextColor3 = Color3.fromRGB(255, 255, 255)
bm.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
bm.Font = Enum.Font.GothamBold
bm.TextSize = 20
bm.BorderSizePixel = 0
Instance.new("UICorner", bm).CornerRadius = UDim.new(0, 5)

-- Botao +
local bp = Instance.new("TextButton", conteudo)
bp.Size = UDim2.new(0.15, 0, 0, 35)
bp.Position = UDim2.new(0.77, 0, 0.42, 0)
bp.Text = "+"
bp.TextColor3 = Color3.fromRGB(255, 255, 255)
bp.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
bp.Font = Enum.Font.GothamBold
bp.TextSize = 20
bp.BorderSizePixel = 0
Instance.new("UICorner", bp).CornerRadius = UDim.new(0, 5)

-- Valor
local vt = Instance.new("TextLabel", conteudo)
vt.Size = UDim2.new(0.5, 0, 0, 35)
vt.Position = UDim2.new(0.25, 0, 0.42, 0)
vt.Text = "1.0x"
vt.TextColor3 = Color3.fromRGB(255, 255, 255)
vt.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
vt.Font = Enum.Font.GothamBold
vt.TextSize = 16
vt.BorderSizePixel = 0
Instance.new("UICorner", vt).CornerRadius = UDim.new(0, 5)

-- Botao Resetar Tamanho
local br = Instance.new("TextButton", conteudo)
br.Size = UDim2.new(0.85, 0, 0, 25)
br.Position = UDim2.new(0.075, 0, 0.50, 0)
br.Text = "RESETAR TAMANHO"
br.TextColor3 = Color3.fromRGB(255, 200, 200)
br.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
br.Font = Enum.Font.GothamBold
br.TextSize = 11
br.BorderSizePixel = 0
Instance.new("UICorner", br).CornerRadius = UDim.new(0, 5)

-- Botao Remover Textura
local bt = Instance.new("TextButton", conteudo)
bt.Size = UDim2.new(0.85, 0, 0, 32)
bt.Position = UDim2.new(0.075, 0, 0.56, 0)
bt.Text = "REMOVER TEXTURA"
bt.TextColor3 = Color3.fromRGB(255, 255, 255)
bt.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bt.Font = Enum.Font.GothamBold
bt.TextSize = 13
bt.BorderSizePixel = 0
Instance.new("UICorner", bt).CornerRadius = UDim.new(0, 8)

-- Botao Resetar Mesh
local brm = Instance.new("TextButton", conteudo)
brm.Size = UDim2.new(0.85, 0, 0, 32)
brm.Position = UDim2.new(0.075, 0, 0.64, 0)
brm.Text = "RESETAR MESH"
brm.TextColor3 = Color3.fromRGB(255, 255, 255)
brm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
brm.Font = Enum.Font.GothamBold
brm.TextSize = 13
brm.BorderSizePixel = 0
Instance.new("UICorner", brm).CornerRadius = UDim.new(0, 8)

-- ===== ACOES =====

b1.MouseButton1Click:Connect(function()
    if b1.Text == "BOLA NOVA: OFF" then
        b1.Text = "BOLA NOVA: ON"
        b1.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        renomearBola()
    else
        b1.Text = "BOLA NOVA: OFF"
        b1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        local b = findBall()
        if b then b.Name = "TPS" end
    end
end)

b2.MouseButton1Click:Connect(function()
    bolaLisaAtiva = not bolaLisaAtiva
    if bolaLisaAtiva then
        b2.Text = "BOLA LISA: ON"
        b2.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        deixarLisa()
    else
        b2.Text = "BOLA LISA: OFF"
        b2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        resetarLisa()
    end
end)

bp.MouseButton1Click:Connect(function()
    if tamanhoMultiplier < 10.0 then
        tamanhoMultiplier = math.floor((tamanhoMultiplier + 0.5) * 10) / 10
        vt.Text = string.format("%.1fx", tamanhoMultiplier)
        aplicarTamanho()
    end
end)

bm.MouseButton1Click:Connect(function()
    if tamanhoMultiplier > 0.5 then
        tamanhoMultiplier = math.floor((tamanhoMultiplier - 0.5) * 10) / 10
        vt.Text = string.format("%.1fx", tamanhoMultiplier)
        aplicarTamanho()
    end
end)

br.MouseButton1Click:Connect(function()
    resetarTamanho()
    vt.Text = "1.0x"
end)

bt.MouseButton1Click:Connect(function()
    removerTexturas()
end)

brm.MouseButton1Click:Connect(function()
    resetarMesh()
end)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

minBtn.MouseButton1Click:Connect(function()
    if conteudo.Visible then
        conteudo.Visible = false
        main.Size = UDim2.new(0, 340, 0, 40)
        minBtn.Text = "+"
    else
        conteudo.Visible = true
        main.Size = UDim2.new(0, 340, 0, 620)
        minBtn.Text = "-"
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.K then
        if conteudo.Visible then
            conteudo.Visible = false
            main.Size = UDim2.new(0, 340, 0, 40)
            minBtn.Text = "+"
        else
            conteudo.Visible = true
            main.Size = UDim2.new(0, 340, 0, 620)
            minBtn.Text = "-"
        end
    end
end)

print("Vitorxyz - Alterador de ball carregado!")
print("Pressione K para minimizar/abrir")