local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

-- LinoriaLib 전역 객체 바인딩
local Toggles = getgenv().Toggles or Library.Toggles
local Options = getgenv().Options or Library.Options

-- 로블록스 필수 서비스 선언
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Window = Library:CreateWindow({
    Title = 'Yumu - Rivals',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Visuals = Window:AddTab('Visuals'),
    Misc = Window:AddTab('Misc'),
    Setting = Window:AddTab('Setting')
}

-- ==========================================
-- Ragebot Custom UI (Crosshair & Watermark)
-- ==========================================
local RageUIGui = Instance.new("ScreenGui", PlayerGui)
RageUIGui.Name = "HoNyangRageUI"
RageUIGui.ResetOnSpawn = false

local CrosshairContainer = Instance.new("Frame", RageUIGui)
CrosshairContainer.AnchorPoint = Vector2.new(0.5, 0.5)
CrosshairContainer.Position = UDim2.new(0.5, 0, 0.5, -35)
CrosshairContainer.Size = UDim2.new(0, 40, 0, 40)
CrosshairContainer.BackgroundTransparency = 1
CrosshairContainer.Visible = false

local lines = {
    {Size = UDim2.new(0, 8, 0, 2), DefaultPos = UDim2.new(0, 0, 0.5, -1)},
    {Size = UDim2.new(0, 8, 0, 2), DefaultPos = UDim2.new(1, -8, 0.5, -1)},
    {Size = UDim2.new(0, 2, 0, 8), DefaultPos = UDim2.new(0.5, -1, 0, 0)},
    {Size = UDim2.new(0, 2, 0, 8), DefaultPos = UDim2.new(0.5, -1, 1, -8)}
}

local crosshairLines = {}
for _, info in ipairs(lines) do
    local line = Instance.new("Frame", CrosshairContainer)
    line.Size = info.Size
    line.Position = info.DefaultPos
    line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    line.BorderSizePixel = 0
    table.insert(crosshairLines, {Line = line, DefaultPos = info.DefaultPos})
end

local RageTextLabel = Instance.new("TextLabel", RageUIGui)
RageTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
RageTextLabel.Position = UDim2.new(0.5, 0, 0.5, 25)
RageTextLabel.Size = UDim2.new(0, 200, 0, 25)
RageTextLabel.BackgroundTransparency = 1
RageTextLabel.Text = "regebot"
RageTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RageTextLabel.TextStrokeTransparency = 0
RageTextLabel.Font = Enum.Font.GothamBold
RageTextLabel.TextSize = 13
RageTextLabel.TextXAlignment = Enum.TextXAlignment.Center
RageTextLabel.Visible = false

local rageHue = 0
local rotAngle = 0
RunService.RenderStepped:Connect(function()
    RageTextLabel.Visible = CrosshairContainer.Visible
    if CrosshairContainer.Visible then
        rageHue = (rageHue + 2) % 360
        local rainbowColor = Color3.fromHSV(rageHue / 360, 1, 1)
        for _, item in ipairs(crosshairLines) do
            item.Line.BackgroundColor3 = rainbowColor
        end
        RageTextLabel.TextColor3 = rainbowColor

        rotAngle = (rotAngle + 4) % 360
        CrosshairContainer.Rotation = rotAngle

        local timeVal = tick() * 5
        local pulse = (math.sin(timeVal) + 1) * 0.5 
        
        crosshairLines[1].Line.Position = UDim2.new(0, math.floor(3 + pulse * 6), 0.5, -1)
        crosshairLines[2].Line.Position = UDim2.new(1, math.floor(-11 - pulse * 6), 0.5, -1)
        crosshairLines[3].Line.Position = UDim2.new(0.5, -1, 0, math.floor(3 + pulse * 6))
        crosshairLines[4].Line.Position = UDim2.new(0.5, -1, 1, math.floor(-11 - pulse * 6))
    end
end)

-- ==========================================
-- [요청 반영] Halmu-style Ragebot Engine
-- ==========================================
local _halmu = {
    rageEnabled = false,
    desyncEnabled = false,
    desyncDist = 3,
    currentTarget = nil,
    rageConn = nil,
    findConn = nil,
    RealCFrame = nil,
    ready = false,
}

local FighterCtrl, EnumLib, useItemRemote, ssEnum

task.spawn(function()
    local okF, fc = pcall(function()
        return require(LocalPlayer.PlayerScripts.Controllers.FighterController)
    end)
    if okF then FighterCtrl = fc end

    local okE, el = pcall(function()
        return require(ReplicatedStorage.Modules.EnumLibrary)
    end)
    if okE then EnumLib = el end

    pcall(function()
        useItemRemote = ReplicatedStorage.Remotes.Replication.Fighter.UseItem
    end)
    pcall(function()
        if EnumLib then ssEnum = EnumLib:ToEnum("StartShooting") end
    end)
    _halmu.ready = true
end)

local function isSameTeam(plr)
    local a = LocalPlayer:GetAttribute("TeamID")
    local b = plr:GetAttribute("TeamID")
    if a == nil or b == nil then return false end
    return a == b
end

local function getRageHead(char)
    if not char then return nil end
    return char:FindFirstChild("HitboxHead")
        or char:FindFirstChild("HitboxHeadSmall")
        or char:FindFirstChild("Head")
end

local function getObjId()
    if not (FighterCtrl and FighterCtrl.LocalFighter) then return nil end
    local item = FighterCtrl.LocalFighter.EquippedItem
    if not item then return nil end
    local ok, id = pcall(function() return item:Get("ObjectID") end)
    if ok and id then return id end
    ok, id = pcall(function() return item.Data and item.Data.ObjectID end)
    return ok and id or nil
end

local function buildShot(originPos, targetPart)
    local targetPos = targetPart.Position
    local lookCF = CFrame.lookAt(originPos, targetPos)
    local lX, lY, lZ = lookCF:ToOrientation()
    local originStruct = {
        [utf8.char(0)] = originPos.X, [utf8.char(1)] = originPos.Y, [utf8.char(2)] = originPos.Z,
        [utf8.char(3)] = lX, [utf8.char(4)] = lY, [utf8.char(5)] = lZ,
    }
    local relCF = targetPart.CFrame:ToObjectSpace(CFrame.new(targetPos))
    local rX, rY, rZ = relCF:ToOrientation()
    return {
        [utf8.char(1)] = {
            [utf8.char(0)] = originStruct,
            [utf8.char(1)] = originStruct,
            [utf8.char(2)] = targetPart,
            [utf8.char(3)] = {
                [utf8.char(0)] = relCF.X, [utf8.char(1)] = relCF.Y, [utf8.char(2)] = relCF.Z,
                [utf8.char(3)] = rX, [utf8.char(4)] = rY, [utf8.char(5)] = rZ,
            },
        },
    }
end

local function startTargetFinder()
    if _halmu.findConn then return end
    _halmu.findConn = RunService.Heartbeat:Connect(function()
        if not _halmu.rageEnabled then
            _halmu.currentTarget = nil
            return
        end
        local ref = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local refPos = ref and ref.Position or Vector3.zero
        local closest, best = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and not isSameTeam(plr) then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local d = (Vector3.new(refPos.X, 0, refPos.Z) - Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude
                    if d < best then
                        best = d
                        closest = plr
                    end
                end
            end
        end
        _halmu.currentTarget = closest and getRageHead(closest.Character) or nil
    end)
end

local function startRageFire()
    if _halmu.rageConn then
        _halmu.rageConn:Disconnect()
        _halmu.rageConn = nil
    end
    if not _halmu.rageEnabled then return end

    local cachedId = nil
    _halmu.rageConn = RunService.Heartbeat:Connect(function()
        if not _halmu.rageEnabled then return end
        if not useItemRemote or not ssEnum then return end
        local target = _halmu.currentTarget
        if not target or not target.Parent then return end

        local objId = getObjId()
        if objId then cachedId = objId else objId = cachedId end
        if not objId then return end

        local origin = target.Position + Vector3.new(0, 0.1, 0)
        pcall(function()
            useItemRemote:FireServer(objId, ssEnum, buildShot(origin, target), nil)
        end)
    end)
end

-- Soft desync (optional)
local restoreName = "cg_halmu_restore"
RunService.Heartbeat:Connect(function()
    if not (_halmu.rageEnabled and _halmu.desyncEnabled and _halmu.currentTarget) then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    _halmu.RealCFrame = hrp.CFrame
    local tp = _halmu.currentTarget.Position
    hrp.CFrame = CFrame.new(tp + Vector3.new(0, _halmu.desyncDist, 0), tp)
    hrp.AssemblyLinearVelocity = Vector3.zero
end)

RunService:BindToRenderStep(restoreName, 150, function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and _halmu.RealCFrame then
        hrp.CFrame = _halmu.RealCFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        _halmu.RealCFrame = nil
    end
end)

local function setRage(on)
    _halmu.rageEnabled = on and true or false
    CrosshairContainer.Visible = _halmu.rageEnabled
    if on then
        startTargetFinder()
        startRageFire()
    else
        if _halmu.rageConn then
            _halmu.rageConn:Disconnect()
            _halmu.rageConn = nil
        end
        _halmu.currentTarget = nil
    end
end

-- ==========================================
-- 1. Main 탭 설정 (Combat & Aimbot)
-- ==========================================
local MainGroup = Tabs.Main:AddLeftGroupbox('Combat')

MainGroup:AddToggle('Ragebot', {
    Text = 'Ragebot',
    Default = false,
    Tooltip = 'Ragebot enabled',
    Callback = function(Value)
        setRage(Value)
    end
})

MainGroup:AddToggle('DesyncToggle', {
    Text = 'Halmu Soft Desync',
    Default = false,
    Tooltip = 'Halmu Soft Desync',
    Callback = function(Value)
        _halmu.desyncEnabled = Value
    end
})

MainGroup:AddToggle('VoidSpamToggle', {
    Text = 'Void Spam',
    Default = false,
    Tooltip = 'Void Spam enabled',
    Callback = function(Value)
        getgenv().VoidSpamEnabled = Value
    end
})

MainGroup:AddSlider('VoidHideSlider', {
    Text = 'Void Hide',
    Default = 0.1,
    Min = 0.01,
    Max = 1.0,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().VoidHideValue = Value
    end
})

getgenv().VoidSpamEnabled = false
getgenv().VoidHideValue = 0.1

task.spawn(function()
    local lastAttackTime = 0

    RunService.Heartbeat:Connect(function()
        if not getgenv().VoidSpamEnabled then return end

        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local originalCFrame = root.CFrame
        local voidCFrame = originalCFrame + Vector3.new(0, 10000, 0)

        local targetPart = _halmu.currentTarget
        local currentTime = tick()
        local hideInterval = getgenv().VoidHideValue or 0.1

        if targetPart and targetPart.Parent and (currentTime - lastAttackTime >= hideInterval) then
            lastAttackTime = currentTime
            root.CFrame = targetPart.CFrame

            RunService:BindToRenderStep("__void_restore", 1, function()
                root.CFrame = voidCFrame
                RunService:UnbindFromRenderStep("__void_restore")
            end)
            return
        end

        root.CFrame = voidCFrame
        RunService:BindToRenderStep("__void_hold", 1, function()
            root.CFrame = originalCFrame
            RunService:UnbindFromRenderStep("__void_hold")
        end)
    end)
end)

local originalWeaponValues = {}

MainGroup:AddToggle('RivalsNoCDToggle', {
    Text = 'No Cooldown',
    Default = false,
    Tooltip = 'No Cooldown',
    Callback = function(Value)
        getgenv().RivalsNoCD = Value
        if Value then
            task.spawn(function()
                while getgenv().RivalsNoCD do
                    task.wait(2)
                    pcall(function()
                        for _, v in pairs(getgc(true)) do
                            if type(v) == "table" then
                                if rawget(v, "ShootCooldown") and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = "ShootCooldown", Val = v.ShootCooldown}
                                end
                                if rawget(v, "FireRate") and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = "FireRate", Val = v.FireRate}
                                end
                                if rawget(v, "Cooldown") and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = "Cooldown", Val = v.Cooldown}
                                end

                                if rawget(v, "ShootCooldown") then v.ShootCooldown = 0 end
                                if rawget(v, "FireRate") then v.FireRate = 0 end
                                if rawget(v, "Cooldown") then v.Cooldown = 0 end
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for tbl, info in pairs(originalWeaponValues) do
                    if tbl and type(tbl) == "table" then
                        tbl[info.Key] = info.Val
                    end
                end
                table.clear(originalWeaponValues)
            end)
        end
    end
})

-- Aimbot 그룹박스
local AimbotGroup = Tabs.Main:AddLeftGroupbox('Aimbot')
local Camera = workspace.CurrentCamera

local FOVGui = Instance.new("ScreenGui")
FOVGui.Name = "HoNyangFOV"
FOVGui.ResetOnSpawn = false
FOVGui.Parent = PlayerGui

local FOVFrame = Instance.new("Frame", FOVGui)
FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVFrame.BackgroundTransparency = 1
FOVFrame.Visible = false

local UICorner = Instance.new("UICorner", FOVFrame)
UICorner.CornerRadius = UDim.new(1, 0)

local FOVStroke = Instance.new("UIStroke", FOVFrame)
FOVStroke.Thickness = 2

local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 2) % 360
    FOVStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
end)

AimbotGroup:AddToggle('AimbotToggle', { Text = 'Aimbot enabled', Default = false })
AimbotGroup:AddToggle('ShowFOVToggle', {
    Text = 'FOV',
    Default = false,
    Callback = function(Value) FOVFrame.Visible = Value end
})

AimbotGroup:AddSlider('FOVSlider', {
    Text = 'FOV size',
    Default = 150, Min = 50, Max = 500, Rounding = 0,
    Callback = function(Value)
        FOVFrame.Size = UDim2.new(0, Value * 2, 0, Value * 2)
    end
})

FOVFrame.Size = UDim2.new(0, Options.FOVSlider.Value * 2, 0, Options.FOVSlider.Value * 2)

RunService:BindToRenderStep("HoNyangAimbot", Enum.RenderPriority.Camera.Value + 1, function()
    if not (Toggles and Toggles.AimbotToggle and Toggles.AimbotToggle.Value) then return end
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local currentFOV = Options.FOVSlider.Value
    local nearestTarget = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local enemyChar = player.Character
            if enemyChar:FindFirstChildOfClass("ForceField") then continue end

            local humanoid = enemyChar:FindFirstChildOfClass("Humanoid")
            local linkHead = enemyChar:FindFirstChild("Head")
            if humanoid and humanoid.Health > 0 and linkHead then
                local pos, onScreen = Camera:WorldToViewportPoint(linkHead.Position)
                local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if onScreen and distance <= currentFOV and distance < shortestDistance then
                    shortestDistance = distance
                    nearestTarget = linkHead
                end
            end
        end
    end
    
    if nearestTarget then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, nearestTarget.Position)
    end
end)

-- ==========================================
-- 2. Visuals 탭 (ESP & Skybox)
-- ==========================================
local ESPGroup = Tabs.Visuals:AddLeftGroupbox('ESP')

ESPGroup:AddToggle('ESPBox', { Text = 'Box ESP', Default = false })
ESPGroup:AddToggle('ESPName', { Text = 'Name ESP', Default = false })
ESPGroup:AddToggle('ESPHealth', { Text = 'Health ESP', Default = false })
ESPGroup:AddToggle('ESPDistance', { Text = 'Distance ESP', Default = false })
ESPGroup:AddToggle('ESPTracer', { Text = 'Tracer ESP', Default = false })
ESPGroup:AddToggle('ESPSkeleton', { Text = 'Skeleton ESP', Default = false })
ESPGroup:AddToggle('ESPChams', { Text = 'Chams ESP', Default = false })

local SkyboxGroup = Tabs.Visuals:AddRightGroupbox('Skybox')

local function GetSky()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = Lighting
    end
    return sky
end

local Presets = {
    ["Purple Nebula"] = "rbxassetid://159454299",
    ["Night Sky"] = "rbxassetid://12064107",
    ["Pink Sunset"] = "rbxassetid://271042310",
    ["Vaporwave"] = "rbxassetid://1417494402"
}

local function ApplySky(id)
    local sky = GetSky()
    sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = id, id, id, id, id, id
end

local function RemoveSky()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then sky:Destroy() end
end

SkyboxGroup:AddDropdown('SkyboxPresetDropdown', {
    Values = { 'Disable', 'Purple Nebula', 'Night Sky', 'Pink Sunset', 'Vaporwave' },
    Default = 1,
    Text = 'Presets',
    Callback = function(Value)
        if Value == 'Disable' then RemoveSky() elseif Presets[Value] then ApplySky(Presets[Value]) end
    end
})

-- ==========================================
-- 3. Misc 탭 (Device Spoof & Skin Changer)
-- ==========================================
local Group = Tabs.Misc:AddLeftGroupbox('Device Spoofing')
local SetControlsRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("SetControls")

Group:AddDropdown('DeviceDropdown', {
    Values = { 'PC (Mouse & Keyboard)', 'Mobile (Touch)', 'Controller (Gamepad)', 'VR' },
    Default = 1,
    Text = 'Device Spoof',
    Callback = function(Value)
        local TargetDevice = "MouseKeyboard"
        if Value:find("PC") then TargetDevice = "MouseKeyboard"
        elseif Value:find("Mobile") then TargetDevice = "Touch"
        elseif Value:find("Controller") then TargetDevice = "Gamepad"
        elseif Value:find("VR") then TargetDevice = "VR" end

        SetControlsRemote:FireServer("MouseKeyboard")
        task.wait(0.1)
        SetControlsRemote:FireServer(TargetDevice)
    end
})

Group:AddButton({
    Text = 'Apply Selected Device',
    Func = function()
        if Options and Options.DeviceDropdown then
            Options.DeviceDropdown:OnChanged(Options.DeviceDropdown.Value)
        end
    end
})

-- ==========================================
-- 4. ESP Render Loop
-- ==========================================
local espData = {}

local function addESP(p)
    if p == LocalPlayer then return end
    task.spawn(function()
        local box, hpBg, hpBar, hpText, nameText, distText, tracer
        pcall(function()
            if Drawing then
                box = Drawing.new("Square"); box.Visible = false; box.Color = Color3.new(1, 1, 1); box.Thickness = 1; box.Filled = false
                hpBg = Drawing.new("Square"); hpBg.Visible = false; hpBg.Color = Color3.new(0, 0, 0); hpBg.Thickness = 1; hpBg.Filled = true
                hpBar = Drawing.new("Square"); hpBar.Visible = false; hpBar.Color = Color3.new(0, 1, 0); hpBar.Thickness = 1; hpBar.Filled = true
                hpText = Drawing.new("Text"); hpText.Visible = false; hpText.Center = true; hpText.Outline = true; hpText.Color = Color3.new(1, 1, 1); hpText.Size = 13
                nameText = Drawing.new("Text"); nameText.Visible = false; nameText.Center = true; nameText.Outline = true; nameText.Color = Color3.new(1, 1, 1); nameText.Size = 13
                distText = Drawing.new("Text"); distText.Visible = false; distText.Center = true; distText.Outline = true; distText.Color = Color3.new(1, 1, 1); distText.Size = 13
                tracer = Drawing.new("Line"); tracer.Visible = false; tracer.Color = Color3.new(1, 1, 1); tracer.Thickness = 1
            end
        end)
        
        if box then
            espData[p] = { Box = box, HpBg = hpBg, HealthBar = hpBar, HealthText = hpText, NameText = nameText, DistText = distText, Tracer = tracer, Skeleton = {} }
            local bones = {{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"}}
            for _, b in pairs(bones) do 
                pcall(function() 
                    if Drawing then table.insert(espData[p].Skeleton, {b[1], b[2], Drawing.new("Line")}) end
                end) 
            end
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)
Players.PlayerRemoving:Connect(function(p)
    if espData[p] then
        pcall(function()
            espData[p].Box:Remove(); espData[p].HpBg:Remove(); espData[p].HealthBar:Remove(); espData[p].HealthText:Remove()
            espData[p].NameText:Remove(); espData[p].DistText:Remove(); espData[p].Tracer:Remove()
            for _, s in pairs(espData[p].Skeleton) do s[3]:Remove() end
        end)
        espData[p] = nil
    end
end)

local function IsToggleActive(toggleName)
    return Toggles and Toggles[toggleName] and Toggles[toggleName].Value == true
end

RunService.RenderStepped:Connect(function()
    local Camera = Workspace.CurrentCamera
    if not Camera then return end

    for p, d in pairs(espData) do
        local isAlive = false
        local c = p.Character
        local root, head, rootPos, boxSize, boxPos, top, bottom, height, width
        
        if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
            root = c:FindFirstChild("HumanoidRootPart")
            head = c:FindFirstChild("Head") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso")
            
            if root and head then
                local rPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    isAlive = true
                    rootPos = rPos
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                    height = math.abs(headPos.Y - legPos.Y)
                    width = height * 0.6 
                    boxSize = Vector2.new(width, height)
                    boxPos = Vector2.new(rootPos.X - width / 2, headPos.Y)
                    top = {Y = headPos.Y}
                    bottom = {Y = legPos.Y}
                end
            end
        end
        
        if isAlive then
            if IsToggleActive("ESPBox") then d.Box.Size = boxSize; d.Box.Position = boxPos; d.Box.Visible = true else d.Box.Visible = false end
            
            if IsToggleActive("ESPHealth") then
                local maxH = math.max(c.Humanoid.MaxHealth, 1)
                local h = math.clamp(c.Humanoid.Health / maxH, 0, 1)
                d.HpBg.Size = Vector2.new(4, height); d.HpBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y); d.HpBg.Visible = true
                local barHeight = height * h
                d.HealthBar.Size = Vector2.new(2, barHeight); d.HealthBar.Position = Vector2.new(boxPos.X - 5, boxPos.Y + (height - barHeight))
                d.HealthBar.Color = Color3.fromHSV(h * 0.33, 1, 1); d.HealthBar.Visible = true
                d.HealthText.Text = tostring(math.floor(c.Humanoid.Health)); d.HealthText.Position = Vector2.new(boxPos.X - 25, boxPos.Y + (height - barHeight) - 6); d.HealthText.Visible = true
            else 
                d.HpBg.Visible = false; d.HealthBar.Visible = false; d.HealthText.Visible = false 
            end
            
            if IsToggleActive("ESPName") then d.NameText.Text = p.Name; d.NameText.Position = Vector2.new(boxPos.X + width/2, top.Y - 15); d.NameText.Visible = true else d.NameText.Visible = false end
            if IsToggleActive("ESPDistance") then local dist = math.floor((Camera.CFrame.Position - root.Position).Magnitude); d.DistText.Text = tostring(dist) .. "m"; d.DistText.Position = Vector2.new(boxPos.X + width/2, bottom.Y + 2); d.DistText.Visible = true else d.DistText.Visible = false end
            if IsToggleActive("ESPTracer") then d.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(rootPos.X, bottom.Y); d.Tracer.Visible = true else d.Tracer.Visible = false end
            
            if IsToggleActive("ESPSkeleton") then
                for _, s in pairs(d.Skeleton) do
                    local p1, p2 = c:FindFirstChild(s[1]), c:FindFirstChild(s[2])
                    if p1 and p2 then
                        local v1, o1 = Camera:WorldToViewportPoint(p1.Position)
                        local v2, o2 = Camera:WorldToViewportPoint(p2.Position)
                        if o1 and o2 then s[3].From = Vector2.new(v1.X, v1.Y); s[3].To = Vector2.new(v2.X, v2.Y); s[3].Visible = true; s[3].Color = Color3.new(1, 1, 1) else s[3].Visible = false end
                    else s[3].Visible = false end
                end
            else 
                for _, s in pairs(d.Skeleton) do s[3].Visible = false end 
            end
            
            local highlight = c:FindFirstChild("AntiHubChams")
            if IsToggleActive("ESPChams") then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "AntiHubChams"
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = c
                end
            else
                if highlight then highlight:Destroy() end
            end
        else
            d.Box.Visible = false; d.HpBg.Visible = false; d.HealthBar.Visible = false; d.HealthText.Visible = false
            d.NameText.Visible = false; d.DistText.Visible = false; d.Tracer.Visible = false
            for _, s in pairs(d.Skeleton) do s[3].Visible = false end
            
            if c then
                local highlight = c:FindFirstChild("AntiHubChams")
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

-- Skin Changer (Misc 탭)
local SkinBox = Tabs.Misc:AddRightGroupbox('Skin Changer')
SkinBox:AddButton('Unlock All', function()
    task.spawn(function()
        pcall(function()
            if getgenv().SkinChangerLoaded then 
                Library:Notify("The skin changer is already running!", 2)
                return 
            end

            Library:Notify("Loading Skin Changer...", 2)

            local scriptString = [=[
local plrs = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local player = plrs.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")
local controllers = playerScripts:WaitForChild("Controllers")

local EnumLibrary, CosmeticLibrary, ItemLibrary, DataController
pcall(function() EnumLibrary = require(ReplicatedStorage.Modules:WaitForChild("EnumLibrary", 10)) end)
if EnumLibrary and EnumLibrary.WaitForEnumBuilder then pcall(function() EnumLibrary:WaitForEnumBuilder() end) end
pcall(function() CosmeticLibrary = require(ReplicatedStorage.Modules:WaitForChild("CosmeticLibrary", 10)) end)
pcall(function() ItemLibrary = require(ReplicatedStorage.Modules:WaitForChild("ItemLibrary", 10)) end)
pcall(function() DataController = require(controllers:WaitForChild("PlayerDataController", 10)) end)

if not (CosmeticLibrary and ItemLibrary and DataController) then return end

getgenv().SkinChangerLoaded = true

local equipped, favorites = {}, {}
local constructingWeapon, viewingProfile = nil, nil
local lastUsedWeapon = nil

local remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
local dataRemotes = remotes and remotes:WaitForChild("Data", 5)
local equipRemote = dataRemotes and dataRemotes:WaitForChild("EquipCosmetic", 5)
local favoriteRemote = dataRemotes and dataRemotes:WaitForChild("FavoriteCosmetic", 5)
local replicationRemotes = remotes and remotes:WaitForChild("Replication", 5)
local fighterRemotes = replicationRemotes and replicationRemotes:WaitForChild("Fighter", 5)
local useItemRemote = fighterRemotes and fighterRemotes:WaitForChild("UseItem", 5)

local function cloneCosmetic(name, cosmeticType, options)
    local base = CosmeticLibrary.Cosmetics[name]
    if not base then return nil end
    local data = {}
    for key, value in pairs(base) do data[key] = value end
    data.Name = name
    data.Type = data.Type or cosmeticType
    data.Seed = data.Seed or math.random(1, 1000000)
    if EnumLibrary then
        local success, enumId = pcall(EnumLibrary.ToEnum, EnumLibrary, name)
        if success and enumId then data.Enum, data.ObjectID = enumId, data.ObjectID or enumId end
    end
    if options then
        if options.inverted ~= nil then data.Inverted = options.inverted end
        if options.favoritesOnly ~= nil then data.OnlyUseFavorites = options.favoritesOnly end
    end
    return data
end

CosmeticLibrary.OwnsCosmeticNormally = function() return true end
CosmeticLibrary.OwnsCosmeticUniversally = function() return true end
CosmeticLibrary.OwnsCosmeticForWeapon = function() return true end
local originalOwnsCosmetic = CosmeticLibrary.OwnsCosmetic
CosmeticLibrary.OwnsCosmetic = function(self, inventory, name, weapon)
    if name and typeof(name) == "string" and name:find("MISSING_") then return originalOwnsCosmetic(self, inventory, name, weapon) end
    return true
end

local originalGet = DataController.Get
DataController.Get = function(self, key)
    local data = originalGet(self, key)
    if key == "CosmeticInventory" then
        local proxy = {}
        if data then for k, v in pairs(data) do proxy[k] = v end end
        return setmetatable(proxy, {__index = function() return true end})
    end
    if key == "FavoritedCosmetics" then
        local result = data and table.clone(data) or {}
        for weapon, favs in pairs(favorites) do
            result[weapon] = result[weapon] or {}
            for name, isFav in pairs(favs) do result[weapon][name] = isFav end
        end
        return result
    end
    return data
end

local originalGetWeaponData = DataController.GetWeaponData
DataController.GetWeaponData = function(self, weaponName)
    local data = originalGetWeaponData(self, weaponName)
    if not data then return nil end
    local merged = {}
    for key, value in pairs(data) do merged[key] = value end
    merged.Name = weaponName
    if equipped[weaponName] then
        for cosmeticType, cosmeticData in pairs(equipped[weaponName]) do merged[cosmeticType] = cosmeticData end
    end
    return merged
end

local FighterController
pcall(function() FighterController = require(controllers:WaitForChild("FighterController", 10)) end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method ~= "FireServer" or checkcaller() then return oldNamecall(self, ...) end
    local args = {...}
    
    if useItemRemote and self == useItemRemote then
        local objectID = args[1]
        if FighterController then
            pcall(function()
                local fighter = FighterController:GetFighter(player)
                if fighter and typeof(fighter) == "table" and fighter.Items then
                    for _, item in pairs(fighter.Items) do
                        if type(item) == "table" and item.Get then
                            if item:Get("ObjectID") == objectID then
                                lastUsedWeapon = item.Name
                                break
                            end
                        end
                    end
                end
            end)
        end
    end            
    
    if equipRemote and self == equipRemote then
        local weaponName, cosmeticType, cosmeticName, options = args[1], args[2], args[3], args[4] or {}                
        if cosmeticName and cosmeticName ~= "None" and cosmeticName ~= "" then
            local inventory = DataController:Get("CosmeticInventory")
            if inventory and rawget(inventory, cosmeticName) then return oldNamecall(self, ...) end
        end                
        equipped[weaponName] = equipped[weaponName] or {}                
        if not cosmeticName or cosmeticName == "None" or cosmeticName == "" then
            equipped[weaponName][cosmeticType] = nil
            if not next(equipped[weaponName]) then equipped[weaponName] = nil end
        else
            local cloned = cloneCosmetic(cosmeticName, cosmeticType, {inverted = options.IsInverted, favoritesOnly = options.OnlyUseFavorites})
            if cloned then equipped[weaponName][cosmeticType] = cloned end
        end                
        task.defer(function()
            pcall(function() DataController.CurrentData:Replicate("WeaponInventory") end)
        end)
        return
    end            
    
    if favoriteRemote and self == favoriteRemote then
        favorites[args[1]] = favorites[args[1]] or {}
        favorites[args[1]][args[2]] = args[3] or nil
        task.spawn(function() pcall(function() DataController.CurrentData:Replicate("FavoritedCosmetics") end) end)
        return
    end            
    return oldNamecall(self, ...)
end)

local ClientItem
pcall(function() ClientItem = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem) end)
if ClientItem and type(ClientItem) == "table" and ClientItem._CreateViewModel then
    local originalCreateViewModel = ClientItem._CreateViewModel
    ClientItem._CreateViewModel = function(self, viewmodelRef)
        local weaponName = self.Name
        local weaponPlayer = self.ClientFighter and self.ClientFighter.Player
        constructingWeapon = (weaponPlayer == player) and weaponName or nil    
        pcall(function()
            if weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Skin and viewmodelRef then
                local dataKey, skinKey, nameKey = self:ToEnum("Data"), self:ToEnum("Skin"), self:ToEnum("Name")
                if viewmodelRef[dataKey] then
                    viewmodelRef[dataKey][skinKey] = equipped[weaponName].Skin
                    viewmodelRef[dataKey][nameKey] = equipped[weaponName].Skin.Name
                elseif viewmodelRef.Data then
                    viewmodelRef.Data.Skin = equipped[weaponName].Skin
                    viewmodelRef.Data.Name = equipped[weaponName].Skin.Name
                end
            end
        end)
        local result
        pcall(function() result = originalCreateViewModel(self, viewmodelRef) end)
        constructingWeapon = nil
        return result or viewmodelRef
    end
end

local viewModelModule = player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel")
if viewModelModule then
    local ClientViewModel = require(viewModelModule)
    if ClientViewModel.GetWrap then
        local originalGetWrap = ClientViewModel.GetWrap
        ClientViewModel.GetWrap = function(self)
            local weaponName = self.ClientItem and self.Name
            local weaponPlayer = self.ClientItem and self.ClientItem.ClientFighter and self.ClientItem.ClientFighter.Player
            if weaponName and weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Wrap then
                return equipped[weaponName].Wrap
            end
            return originalGetWrap(self)
        end
    end
    local originalNew = ClientViewModel.new
    ClientViewModel.new = function(replicatedData, clientItem)
        local weaponPlayer = clientItem.ClientFighter and clientItem.ClientFighter.Player
        local weaponName = constructingWeapon or clientItem.Name
        if weaponPlayer == player and equipped[weaponName] then
            local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass)
            local dataKey = ReplicatedClass:ToEnum("Data")
            replicatedData[dataKey] = replicatedData[dataKey] or {}
            local cosmetics = equipped[weaponName]
            if cosmetics.Skin then replicatedData[dataKey][ReplicatedClass:ToEnum("Skin")] = cosmetics.Skin end
            if cosmetics.Wrap then replicatedData[dataKey][ReplicatedClass:ToEnum("Wrap")] = cosmetics.Wrap end
            if cosmetics.Charm then replicatedData[dataKey][ReplicatedClass:ToEnum("Charm")] = cosmetics.Charm end
        end
        local result = originalNew(replicatedData, clientItem)
        if weaponPlayer == player and equipped[weaponName] and equipped[weaponName].Wrap and result._UpdateWrap then
            result:_UpdateWrap()
            task.delay(0.1, function() if not result._destroyed then result:_UpdateWrap() end end)
        end
        return result
    end
end

local originalGetViewModelImage = ItemLibrary.GetViewModelImageFromWeaponData
ItemLibrary.GetViewModelImageFromWeaponData = function(self, weaponData, highRes)
    if not weaponData then return originalGetViewModelImage(self, weaponData, highRes) end
    local weaponName = weaponData.Name
    local shouldShowSkin = (weaponData.Skin and equipped[weaponName] and weaponData.Skin == equipped[weaponName].Skin) or (viewingProfile == player and equipped[weaponName] and equipped[weaponName].Skin)
    if shouldShowSkin and equipped[weaponName] and equipped[weaponName].Skin then
        local skinInfo = self.ViewModels[equipped[weaponName].Skin.Name]
        if skinInfo then return skinInfo[highRes and "ImageHighResolution" or "Image"] or skinInfo.Image end
    end
    return originalGetViewModelImage(self, weaponData, highRes)
end

pcall(function()
    local ViewProfile = require(player.PlayerScripts.Modules.Pages.ViewProfile)
    if ViewProfile and ViewProfile.Fetch then
        local originalFetch = ViewProfile.Fetch
        ViewProfile.Fetch = function(self, targetPlayer)
            viewingProfile = targetPlayer
            return originalFetch(self, targetPlayer)
        end
    end
end)

local ClientEntity
pcall(function() ClientEntity = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity) end)
if ClientEntity and ClientEntity.ReplicateFromServer then
    local originalReplicateFromServer = ClientEntity.ReplicateFromServer
    ClientEntity.ReplicateFromServer = function(self, action, ...)
        if action == "FinisherEffect" then
            local args = {...}
            local killerName = args[3]            
            local decodedKiller = killerName
            if type(killerName) == "userdata" and EnumLibrary and EnumLibrary.FromEnum then
                local ok, decoded = pcall(EnumLibrary.FromEnum, EnumLibrary, killerName)
                if ok and decoded then decodedKiller = decoded end
            end            
            local isOurKill = tostring(decodedKiller) == player.Name or tostring(decodedKiller):lower() == player.Name:lower()            
            if isOurKill and lastUsedWeapon and equipped[lastUsedWeapon] and equipped[lastUsedWeapon].Finisher then
                local finisherData = equipped[lastUsedWeapon].Finisher
                local finisherEnum = finisherData.Enum                
                if not finisherEnum and EnumLibrary then
                    local ok, result = pcall(EnumLibrary.ToEnum, EnumLibrary, finisherData.Name)
                    if ok and result then finisherEnum = result end
                end                
                if finisherEnum then
                    args[1] = finisherEnum
                    return originalReplicateFromServer(self, action, unpack(args))
                end
            end
        end        
        return originalReplicateFromServer(self, action, ...)
    end
end
]=]
            loadstring(scriptString)()
            Library:Notify("Skin unlock complete!", 3)
        end)
    end)
end)
