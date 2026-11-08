-- MALAM SAMA OPAH - WAGURI HUB 🌸 V41 (PERFECT UI & TOGGLE MINIMIZE)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada agar tidak menumpuk
local existingGui = playerGui:FindFirstChild("WaguriHubMenu")
if existingGui then existingGui:Destroy() end

local existingFloat = playerGui:FindFirstChild("WaguriFloatTP")
if existingFloat then existingFloat:Destroy() end

local existingIntro = playerGui:FindFirstChild("WaguriIntroGui")
if existingIntro then existingIntro:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WaguriHubMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Sound Effect Klik Renyah
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9114221317"
clickSound.Volume = 1
clickSound.Parent = gui


-- === 🌸 ANIME INTRO ANIMATION ===
local introGui = Instance.new("ScreenGui")
introGui.Name = "WaguriIntroGui"
introGui.ResetOnSpawn = false
introGui.Parent = playerGui

local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.fromOffset(300, 120)
introFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
introFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
introFrame.BackgroundTransparency = 1
introFrame.BorderSizePixel = 0
introFrame.ZIndex = 10
introFrame.Parent = introGui

Instance.new("UICorner", introFrame).CornerRadius = UDim.new(0, 16)

local introStroke = Instance.new("UIStroke")
introStroke.Color = Color3.fromRGB(255, 105, 180)
introStroke.Thickness = 2.5
introStroke.Transparency = 1
introStroke.Parent = introFrame

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(1, 0, 1, 0)
introText.BackgroundTransparency = 1
introText.Text = "🌸 WAGURI HUB 🌸\nLoading Experience..."
introText.TextColor3 = Color3.fromRGB(255, 190, 220)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 16
introText.TextTransparency = 1
introText.ZIndex = 11
introText.Parent = introFrame

TweenService:Create(introFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
TweenService:Create(introStroke, TweenInfo.new(0.6), {Transparency = 0}):Play()
TweenService:Create(introText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()

task.spawn(function()
    task.wait(1.2)
    introText.Text = "✨ Welcome, " .. player.Name .. " ✨\nEnjoy the game!"
    task.wait(1.5)
    TweenService:Create(introFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    TweenService:Create(introStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    TweenService:Create(introText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.5)
    introGui:Destroy()
end)
-- ===================================


-- Panel Utama Waguri Hub (Ukuran: 380 x 420)
local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(380, 420)
panel.Position = UDim2.new(0.5, -190, 0.5, -210)
panel.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
panel.Active = true
panel.Draggable = true
panel.Parent = gui

Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local border = Instance.new("UIStroke")
border.Thickness = 2.5
border.Color = Color3.fromRGB(255, 105, 180)
border.Parent = panel

-- Background Gradient
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 20, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 18, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 20, 55))
})
bgGradient.Rotation = 45
bgGradient.Parent = panel

-- Header Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.fromOffset(12, 6)
title.BackgroundTransparency = 1
title.Text = "🌸 WAGURI HUB 🌸"
title.TextColor3 = Color3.fromRGB(255, 190, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.ZIndex = 2
title.Parent = panel

-- Tombol Minimize / Expand (Berubah dari − jadi + dan sebaliknya)
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(28, 24)
minimize.Position = UDim2.new(1, -34, 0, 8)
minimize.Text = "−"
minimize.TextSize = 16
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(130, 60, 160)
minimize.ZIndex = 2
minimize.Parent = panel
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 6)

local minimizedState = false
minimize.MouseButton1Click:Connect(function()
    pcall(function() clickSound:Play() end)
    minimizedState = not minimizedState
    for _, child in pairs(panel:GetChildren()) do
        if child ~= title and child ~= minimize and child ~= border and child ~= bgGradient and child.ClassName ~= "UICorner" and child.ClassName ~= "UIStroke" then
            child.Visible = not minimizedState
        end
    end
    minimize.Text = minimizedState and "+" or "−"
    panel.Size = minimizedState and UDim2.fromOffset(380, 50) or UDim2.fromOffset(380, 420)
end)

local tabNav = Instance.new("Frame")
tabNav.Size = UDim2.new(1, -24, 0, 32)
tabNav.Position = UDim2.fromOffset(12, 52)
tabNav.BackgroundTransparency = 1
tabNav.ZIndex = 2
tabNav.Parent = panel

local container = Instance.new("Frame")
container.Position = UDim2.fromOffset(12, 92)
container.Size = UDim2.new(1, -24, 1, -100)
container.BackgroundTransparency = 1
container.ZIndex = 2
container.Parent = panel

local tabs = {}
local function createTab(name, index)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.32, 0, 1, 0)
    tabBtn.Position = UDim2.new((index-1)*0.34, 0, 0, 0)
    tabBtn.BackgroundColor3 = index == 1 and Color3.fromRGB(219, 112, 147) or Color3.fromRGB(45, 30, 65)
    tabBtn.TextColor3 = index == 1 and Color3.new(1, 1, 1) or Color3.fromRGB(210, 210, 210)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 11
    tabBtn.Text = name
    tabBtn.ZIndex = 2
    tabBtn.Parent = tabNav
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (index == 1)
    page.CanvasSize = UDim2.new(0, 0, 0, 480)
    page.ScrollBarThickness = 3
    page.ZIndex = 2
    page.Parent = container

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    tabBtn.MouseButton1Click:Connect(function()
        pcall(function() clickSound:Play() end)
        for _, t in pairs(tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(45, 30, 65)
            t.Button.TextColor3 = Color3.fromRGB(210, 210, 210)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(219, 112, 147)
        tabBtn.TextColor3 = Color3.new(1, 1, 1)
    end)

    table.insert(tabs, {Button = tabBtn, Page = page})
    return page
end

local espTab = createTab("👀 ESP", 1)
local moveTab = createTab("🏃 MOVE", 2)
local tpTab = createTab("⚡ TELEPORT", 3)

local function makeButton(parentPage, label, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Text = label
    b.ZIndex = 2
    b.Parent = parentPage
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1.2
    stroke.Parent = b

    b.MouseButton1Click:Connect(function()
        pcall(function() clickSound:Play() end)
        if callback then
            pcall(function() callback() end)
        end
    end)
    return b
end

local function makeToggleButton(parentPage, label, color, defaultState, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 36)
    b.BackgroundColor3 = defaultState and Color3.fromRGB(110, 40, 80) or Color3.fromRGB(35, 25, 50)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Text = label .. (defaultState and " [ ON ]" or " [ OFF ]")
    b.ZIndex = 2
    b.Parent = parentPage
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1.2
    stroke.Parent = b

    local active = defaultState
    b.MouseButton1Click:Connect(function()
        pcall(function() clickSound:Play() end)
        active = not active
        b.Text = label .. (active and " [ ON ]" or " [ OFF ]")
        b.BackgroundColor3 = active and Color3.fromRGB(110, 40, 80) or Color3.fromRGB(35, 25, 50)
        if callback then
            pcall(function() callback(active) end)
        end
    end)

    if defaultState and callback then
        task.spawn(function()
            task.wait(0.5)
            pcall(function() callback(true) end)
        end)
    end

    return b
end


-- === TAB 1: ESP MENU ===

makeToggleButton(espTab, "ESP OPAH", Color3.fromRGB(255, 60, 60), true, function(state)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local name = obj.Name:lower()
            if (name:find("opah") or name:find("nenek") or name:find("granny") or name:find("monster")) and obj ~= player.Character and obj:FindFirstChildOfClass("Humanoid") then
                local head = obj:FindFirstChild("Head") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if head then
                    local hl = obj:FindFirstChild("OpahHL")
                    local bb = head:FindFirstChild("OpahBB")

                    if state then
                        if not hl then
                            local h = Instance.new("Highlight")
                            h.Name = "OpahHL"
                            h.FillColor = Color3.fromRGB(255, 50, 50)
                            h.OutlineColor = Color3.new(1,1,1)
                            h.FillTransparency = 0.4
                            h.Parent = obj
                        end
                        if not bb then
                            local b = Instance.new("BillboardGui")
                            b.Name = "OpahBB"
                            b.Size = UDim2.new(0, 140, 0, 40)
                            b.StudsOffset = Vector3.new(0, 2.5, 0)
                            b.AlwaysOnTop = true
                            b.Parent = head

                            local txt = Instance.new("TextLabel")
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.fromRGB(255, 50, 50)
                            txt.TextSize = 12
                            txt.Font = Enum.Font.GothamBold
                            txt.TextStrokeTransparency = 0
                            txt.Parent = b

                            task.spawn(function()
                                while b.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                                    local dist = math.floor((player.Character.HumanoidRootPart.Position - head.Position).Magnitude)
                                    txt.Text = "👵 OPAH [" .. dist .. "m]"
                                    task.wait(0.5)
                                end
                            end)
                        end
                    else
                        if hl then hl:Destroy() end
                        if bb then bb:Destroy() end
                    end
                end
            end
        end
    end
end)

makeToggleButton(espTab, "ESP KUNCI", Color3.fromRGB(255, 215, 0), true, function(state)
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") or item:IsA("Model") then
            local name = item.Name:lower()
            local isKey = (name == "key" or name == "kunci" or name == "item_key" or name == "key_item" or name == "red_key" or name == "blue_key" or name == "yellow_key" or name == "green_key" or name == "golden_key")
            local isBlocked = (name:find("door") or name:find("lockpad") or name:find("pintu") or name:find("cabinet") or name:find("drawer") or name:find("music") or name:find("box") or name:find("chair") or name:find("table") or name:find("audio") or name:find("radio"))

            if isKey and not isBlocked then
                local target = item:IsA("Model") and item or item.Parent
                local targetPart = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")) or item
                
                if targetPart then
                    local hl = target:FindFirstChild("KeyHL")
                    local bb = targetPart:FindFirstChild("KeyBB")

                    if state then
                        local keyColor = Color3.fromRGB(255, 215, 0)
                        local keyName = "🔑 KUNCI"

                        if name:find("red") or name:find("merah") then
                            keyColor = Color3.fromRGB(255, 60, 60)
                            keyName = "🔑 K. MERAH"
                        elseif name:find("blue") or name:find("biru") then
                            keyColor = Color3.fromRGB(60, 150, 255)
                            keyName = "🔑 K. BIRU"
                        elseif name:find("yellow") or name:find("kuning") then
                            keyColor = Color3.fromRGB(255, 255, 60)
                            keyName = "🔑 K. KUNING"
                        elseif name:find("green") or name:find("hijau") then
                            keyColor = Color3.fromRGB(60, 255, 60)
                            keyName = "🔑 K. HIJAU"
                        end

                        if not hl then
                            local h = Instance.new("Highlight")
                            h.Name = "KeyHL"
                            h.FillColor = keyColor
                            h.OutlineColor = Color3.new(1,1,1)
                            h.FillTransparency = 0.4
                            h.Parent = target
                        end

                        if not bb then
                            local b = Instance.new("BillboardGui")
                            b.Name = "KeyBB"
                            b.Size = UDim2.new(0, 120, 0, 35)
                            b.StudsOffset = Vector3.new(0, 1.5, 0)
                            b.AlwaysOnTop = true
                            b.Parent = targetPart

                            local txt = Instance.new("TextLabel")
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = keyColor
                            txt.TextSize = 11
                            txt.Font = Enum.Font.GothamBold
                            txt.TextStrokeTransparency = 0
                            txt.Parent = b

                            task.spawn(function()
                                while b.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                                    local dist = math.floor((player.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude)
                                    txt.Text = keyName .. " [" .. dist .. "m]"
                                    task.wait(0.5)
                                end
                            end)
                        end
                    else
                        if hl then hl:Destroy() end
                        if bb then bb:Destroy() end
                    end
                end
            end
        end
    end
end)

makeToggleButton(espTab, "ESP PASCODE", Color3.fromRGB(255, 100, 200), true, function(state)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            if name == "note" or name == "paper" or name == "kertas" or name == "code" or name:find("note_") or name:find("paper_") or name:find("code_") then
                local target = obj:IsA("Model") and obj or obj.Parent
                local targetPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                
                if targetPart then
                    local hl = target:FindFirstChild("CodeHL")
                    local bb = targetPart:FindFirstChild("CodeBB")

                    if state then
                        if not hl then
                            local h = Instance.new("Highlight")
                            h.Name = "CodeHL"
                            h.FillColor = Color3.fromRGB(255, 100, 200)
                            h.OutlineColor = Color3.new(1,1,1)
                            h.FillTransparency = 0.4
                            h.Parent = target
                        end
                        if not bb then
                            local b = Instance.new("BillboardGui")
                            b.Name = "CodeBB"
                            b.Size = UDim2.new(0, 120, 0, 35)
                            b.StudsOffset = Vector3.new(0, 1.5, 0)
                            b.AlwaysOnTop = true
                            b.Parent = targetPart

                            local txt = Instance.new("TextLabel")
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.fromRGB(255, 100, 200)
                            txt.TextSize = 11
                            txt.Font = Enum.Font.GothamBold
                            txt.TextStrokeTransparency = 0
                            txt.Parent = b

                            task.spawn(function()
                                while b.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                                    local dist = math.floor((player.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude)
                                    txt.Text = "📄 KERTAS [" .. dist .. "m]"
                                    task.wait(0.5)
                                end
                            end)
                        end
                    else
                        if hl then hl:Destroy() end
                        if bb then bb:Destroy() end
                    end
                end
            end
        end
    end
end)

makeToggleButton(espTab, "ESP KEYPAD", Color3.fromRGB(255, 140, 0), true, function(state)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            local isIgnored = (name:find("bike") or name:find("sepeda") or name:find("motor") or name:find("chair") or name:find("table") or name:find("floor") or name:find("wall"))
            local isKeypad = (name == "keypad" or name == "padlock" or name == "gembok" or name:find("keypad_") or name:find("padlock_"))

            if isKeypad and not isIgnored then
                local target = obj:IsA("Model") and obj or obj.Parent
                local targetPart = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                
                if targetPart then
                    local hl = target:FindFirstChild("LockHL")
                    local bb = targetPart:FindFirstChild("LockBB")

                    if state then
                        if not hl then
          
