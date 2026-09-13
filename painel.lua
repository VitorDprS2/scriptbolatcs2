-- Vitorxyz - Sistema de Key + Painel
local player = game.Players.LocalPlayer

local function getHWID()
    local hwid = nil
    pcall(function()
        hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if not hwid then hwid = tostring(player.UserId) end
    return tostring(hwid)
end

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

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VitorxyzKeyGUI"
keyGui.Parent = player.PlayerGui
keyGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0, 380, 0, 320)
keyFrame.Position = UDim2.new(0.5, -190, 0.5, -160)
keyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)
local keyStroke = Instance.new("UIStroke", keyFrame)
keyStroke.Color = Color3.fromRGB(0, 170, 255)
keyStroke.Thickness = 2

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 50)
keyTitle.Text = "VITORXYZ - VERIFICACAO"
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.BackgroundTransparency = 1
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 20

local keySub = Instance.new("TextLabel", keyFrame)
keySub.Size = UDim2.new(1, 0, 0, 20)
keySub.Position = UDim2.new(0, 0, 0, 50)
keySub.Text = "Digite sua key para continuar"
keySub.TextColor3 = Color3.fromRGB(180, 180, 180)
keySub.BackgroundTransparency = 1
keySub.Font = Enum.Font.Gotham
keySub.TextSize = 12

local keyInput = Instance.new("TextBox", keyFrame)
keyInput.Size = UDim2.new(0.85, 0, 0, 45)
keyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Digite sua key aqui..."
keyInput.Text = ""
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.BorderSizePixel = 0
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.85, 0, 0, 45)
keyBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
keyBtn.Text = "VERIFICAR KEY"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 15
keyBtn.BorderSizePixel = 0
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 8)

local keyStatus = Instance.new("TextLabel", keyFrame)
keyStatus.Size = UDim2.new(0.9, 0, 0, 40)
keyStatus.Position = UDim2.new(0.05, 0, 0.78, 0)
keyStatus.Text = ""
keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
keyStatus.BackgroundTransparency = 1
keyStatus.Font = Enum.Font.GothamBold
keyStatus.TextSize = 12
keyStatus.TextWrapped = true

local keyVerificada = false

local function verificarKey()
    local input = keyInput.Text
    local hwidAtual = getHWID()
    if input == "" then
        keyStatus.Text = "Digite uma key valida!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 200, 50)
        return
    end
    local hwidSalvo = keysValidas[input]
    if hwidSalvo == nil then
        keyStatus.Text = "Key invalida!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    if hwidSalvo == "" then
        keysValidas[input] = hwidAtual
        keyStatus.Text = "Key ativada neste PC!"
        keyStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(1.5)
        keyVerificada = true
        keyFrame:Destroy()
        keyGui:Destroy()
        return
    end
    if hwidSalvo ~= hwidAtual then
        keyStatus.Text = "Key nao pertence a este PC!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    keyVerificada = true
    keyStatus.Text = "Key valida!"
    keyStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(1)
    keyFrame:Destroy()
    keyGui:Destroy()
end

keyBtn.MouseButton1Click:Connect(verificarKey)
keyInput.FocusLost:Connect(function(e) if e then verificarKey() end end)

while not keyVerificada do task.wait(0.1) end
-- ============================================
-- ====== PAINEL VITORXYZ ======
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "VitorxyzGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local bolaAtiva = false
local bolaOriginal = nil
local bolaLisaAtiva = false
local corOriginal = nil
local corSelecionada = Color3.fromRGB(255, 255, 255)
local minimizado = false
local tamanhoMultiplier = 1.0

local function findBall()
    local stadium = workspace:FindFirstChild("WorkspaceStadiumMap1")
    if stadium then
        local tfs = stadium:FindFirstChild("TF'S")
        if tfs then
            local ball = tfs:FindFirstChild("TPS")
            if ball then return ball end
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

local function aplicarTamanhoVisual()
    local b = findBall()
    if not b then return end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then
        pcall(function() m.Scale = Vector3.new(tamanhoMultiplier, tamanhoMultiplier, tamanhoMultiplier) end)
    else
        local nm = Instance.new("SpecialMesh", b)
        nm.MeshType = Enum.MeshType.Sphere
        nm.Scale = Vector3.new(tamanhoMultiplier, tamanhoMultiplier, tamanhoMultiplier)
    end
end

local function resetarTamanhoVisual()
    local b = findBall()
    if not b then return end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then pcall(function() m.Scale = Vector3.new(1, 1, 1) end) end
    tamanhoMultiplier = 1.0
end

local function aplicarMesh(meshId)
    local b = findBall()
    if not b then return false end
    if not bolaOriginal then bolaOriginal = b end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if not m then m = Instance.new("SpecialMesh", b) end
    m.MeshId = meshId
    m.MeshType = Enum.MeshType.FileMesh
    m.Scale = Vector3.new(tamanhoMultiplier, tamanhoMultiplier, tamanhoMultiplier)
    return true
end

local function aplicarTextura(textureId)
    local b = findBall()
    if not b then return false end
    for _, c in ipairs(b:GetChildren()) do
        if c:IsA("Texture") or c:IsA("Decal") then c:Destroy() end
    end
    local t = Instance.new("Texture", b)
    t.Texture = textureId
    t.Face = Enum.NormalId.Top
    local t2 = Instance.new("Texture", b)
    t2.Texture = textureId
    t2.Face = Enum.NormalId.Bottom
    return true
end

local function removerTexturas()
    local b = findBall()
    if not b then return false end
    for _, c in ipairs(b:GetChildren()) do
        if c:IsA("Texture") or c:IsA("Decal") then c:Destroy() end
    end
    for _, p in ipairs(b:GetDescendants()) do
        if p:IsA("Texture") or p:IsA("Decal") then p:Destroy() end
    end
    return true
end

local function resetarMesh()
    local b = findBall()
    if not b then return false end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then m:Destroy() end
    return true
end

local function deixarBolaLisa()
    local b = findBall()
    if not b then return false end
    if not corOriginal then corOriginal = b.Color end
    for _, c in ipairs(b:GetChildren()) do
        if c:IsA("Texture") or c:IsA("Decal") then c:Destroy() end
    end
    for _, p in ipairs(b:GetDescendants()) do
        if p:IsA("Texture") or p:IsA("Decal") then p:Destroy() end
    end
    local m = b:FindFirstChildWhichIsA("SpecialMesh")
    if m then m:Destroy() end
    b.Material = Enum.Material.SmoothPlastic
    b.Color = corSelecionada
    b.Reflectance = 0.2
    return true
end

local function resetarBolaLisa()
    local b = findBall()
    if not b then return false end
    if corOriginal then b.Color = corOriginal end
    b.Material = Enum.Material.Plastic
    b.Reflectance = 0
    return true
end

local function renomearBola()
    local b = findBall()
    if b then b.Name = "Vitorxyz"; return true end
    return false
end

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 340, 0, 680)
main.Position = UDim2.new(0.5, -170, 0.5, -340)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
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

local function criarBotao(y, texto, cor)
    local b = Instance.new("TextButton", conteudo)
    b.Size = UDim2.new(0.85, 0, 0, 32)
    b.Position = UDim2.new(0.075, 0, y, 0)
    b.Text = texto
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.BackgroundColor3 = cor or Color3.fromRGB(30, 30, 30)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    local st = Instance.new("UIStroke", b)
    st.Color = Color3.fromRGB(80, 80, 80)
    st.Thickness = 1
    return b
end

local btnBolaNova = criarBotao(0.02, "BOLA NOVA: OFF")
local btnBolaLisa = criarBotao(0.09, "BOLA LISA: OFF")

local corLabel = Instance.new("TextLabel", conteudo)
corLabel.Size = UDim2.new(0.85, 0, 0, 18)
corLabel.Position = UDim2.new(0.075, 0, 0.16, 0)
corLabel.Text = "COR DA BOLA LISA:"
corLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
corLabel.BackgroundTransparency = 1
corLabel.Font = Enum.Font.GothamBold
corLabel.TextSize = 11
    local cores = {
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