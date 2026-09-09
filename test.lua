local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

-- LinoriaLib 전역 객체 바인딩 (ESP 및 UI 상태 참조용)
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
RageTextLabel.Text = "ragebot"
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
-- Ragebot 메커니즘 & 딥싱크 (Desync)
-- ==========================================
local __a1b2c3 = setmetatable({}, {
    __index = function(__d4e5f6, __g7h8i9)
        local __j0k1l2, __m3n4o5 = pcall(function()
            return game:GetService(__g7h8i9)
        end)
        if __m3n4o5 then
            return cloneref(__m3n4o5)
        end
        return nil
    end
})

local __p6q7r8 = getgenv()
local __v2w3x4 = __a1b2c3.Players
local __y5z6a7 = __a1b2c3.RunService
local __b8c9d0 = __a1b2c3.ReplicatedStorage
local __k7l8m9 = __v2w3x4.LocalPlayer
local __q3r4s5 = __k7l8m9:WaitForChild("PlayerScripts")

local __t6u7v8, __w9x0y1
pcall(function()
    __t6u7v8 = require(__q3r4s5:WaitForChild("Modules"):WaitForChild("ItemTypes"):WaitForChild("Gun"))
    __w9x0y1 = require(__b8c9d0:WaitForChild("Modules"):WaitForChild("Utility"))
end)

local __z2a3b4 = setmetatable({}, {
    __index = function(_, __c5d6e7)
        local __f8g9h0 = __k7l8m9.Character
        if not __f8g9h0 then return nil end
        if __c5d6e7 == "__root" then
            return __f8g9h0:FindFirstChild("HumanoidRootPart")
        elseif __c5d6e7 == "__head" then
            return __f8g9h0:FindFirstChild("Head")
        end
        return nil
    end
})

__p6q7r8.__s9t0u1 = {}

do
    local __i1j2k3 = __p6q7r8.__s9t0u1

    local function isImmune(char, player)
        if not char then return true end
        if char:FindFirstChildOfClass("ForceField") then return true end
        if player then
            local spawnTime = player:GetAttribute("SpawnTime") or 0
            if tick() - spawnTime < 1.5 then return true end
        end
        return false
    end

    function __i1j2k3:__init()
        self.__active = false
        self.__target = nil
        self.__desync = false
        self.__conn1 = nil
        self.__conn2 = nil
        self.__task1 = nil
        self.__oldfunc = nil
        self.__activateTime = 0
        self:__setup()
    end

    function __i1j2k3:__setup()
        self.__conn1 = __y5z6a7.Heartbeat:Connect(function()
            if not self.__active then return end
            self.__target = self:__find()
        end)

        if __t6u7v8 then
            local __l4m5n6 = __t6u7v8.StartShooting
            self.__oldfunc = __l4m5n6
            __t6u7v8.StartShooting = function(__o7p8q9, ...)
                local __r0s1t2 = {__l4m5n6(__o7p8q9, ...)}
                if not self.__active then return unpack(__r0s1t2) end

                if tick() - self.__activateTime < 1.4 then
                    return unpack(__r0s1t2)
                end

                if not __o7p8q9.ClientFighter or not __o7p8q9.ClientFighter.IsLocalPlayer then
                    return unpack(__r0s1t2)
                end

                local __u3v4w5 = __r0s1t2[3]
                if not __u3v4w5 or typeof(__u3v4w5) ~= "table" then
                    return unpack(__r0s1t2)
                end

                local __x6y7z8 = self.__target

                if not __x6y7z8 or not __x6y7z8.Character or isImmune(__x6y7z8.Character, __x6y7z8) then
                    return unpack(__r0s1t2)
                end

                __r0s1t2[4] = true

                if not self.__desync or self.__curr ~= __x6y7z8 then
                    self:__desync_start(__x6y7z8)
                end

                if self.__task1 then
                    task.cancel(self.__task1)
                    self.__task1 = nil
                end

                local __a9b0c1 = __x6y7z8.Character:FindFirstChild("Head")
                if not __a9b0c1 then return unpack(__r0s1t2) end

                local __d2e3f4 = __a9b0c1.Position
                local __g5h6i7 = __a9b0c1.CFrame
                local __p4q5r6 = __g5h6i7:ToObjectSpace(CFrame.new(__d2e3f4))

                __u3v4w5[utf8.char(0)] = __w9x0y1:EncodeCFrame(__g5h6i7)
                __u3v4w5[utf8.char(1)] = __w9x0y1:EncodeCFrame(__g5h6i7)
                __u3v4w5[utf8.char(2)] = __a9b0c1
                __u3v4w5[utf8.char(3)] = __w9x0y1:EncodeCFrame(__p4q5r6)

                self.__task1 = task.delay(0.04, function()
                    self:__desync_stop()
                end)

                return unpack(__r0s1t2)
            end
        end

        if __w9x0y1 then
            local old_ray = __w9x0y1.Raycast
            if old_ray then
                __w9x0y1.Raycast = function(s, o, d, len, f, ft, viz)
                    if self.__active then
                        if len and len > 50 and f then
                            local tgt = self.__target
                            if tgt and tgt.Character and tgt.Character:FindFirstChild("Head") then
                                local head = tgt.Character.Head
                                local hitpos = head.Position
                                return {
                                    Position = hitpos,
                                    Distance = (hitpos - o).Magnitude,
                                    Instance = head,
                                    Material = head.Material,
                                    Normal = Vector3.yAxis
                                }
                            end
                        end
                    end
                    return old_ray(s, o, d, len, f, ft, viz)
                end
            end
        end
    end

    function __i1j2k3:__find()
        local myChar = __k7l8m9.Character
        if not myChar then return nil end
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
       
        local closest = nil
        local closestDist = math.huge
        local MAX_DISTANCE = math.huge

        for _, player in next, __v2w3x4:GetPlayers() do
            if player == __k7l8m9 then continue end
            if player:GetAttribute("TeamID") == __k7l8m9:GetAttribute("TeamID") then continue end
           
            local char = player.Character
            if not char then continue end

            if isImmune(char, player) then continue end

            local root = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            
            if not (root and head and hum and hum.Health > 0) then continue end
           
            local dist = (myRoot.Position - root.Position).Magnitude
            if dist > MAX_DISTANCE then continue end
            
            if dist < closestDist then
                closestDist = dist
                closest = player
            end
        end
        
        return closest
    end

    function __i1j2k3:__desync_start(__c3d4e5)
        if self.__conn2 then self.__conn2:Disconnect() end
        self.__desync = true
        self.__curr = __c3d4e5

        self.__conn2 = __y5z6a7.Heartbeat:Connect(function()
            if not self.__desync then return end
            local __f6g7h8 = __z2a3b4.__root
            if not __f6g7h8 then return end

            if not __c3d4e5.Character or isImmune(__c3d4e5.Character, __c3d4e5) then
                self:__desync_stop()
                return
            end

            local enemyHead = __c3d4e5.Character:FindFirstChild("Head")
            if not enemyHead then
                self:__desync_stop()
                return
            end

            local __l2m3n4 = __f6g7h8.CFrame
            local __o5p6q7 = __f6g7h8.Velocity
            local __r8s9t0 = __f6g7h8.RotVelocity

            __f6g7h8.CFrame = enemyHead.CFrame + Vector3.new(0, 0, 0)

            __y5z6a7:BindToRenderStep("__restore", 1, function()
                __f6g7h8.CFrame = __l2m3n4
                __f6g7h8.Velocity = __o5p6q7
                __f6g7h8.RotVelocity = __r8s9t0
                __y5z6a7:UnbindFromRenderStep("__restore")
            end)
        end)
    end

    function __i1j2k3:__desync_stop()
        self.__desync = false
        self.__curr = nil
        if self.__conn2 then
            self.__conn2:Disconnect()
            self.__conn2 = nil
        end
    end

    function __i1j2k3:SetState(state)
        self.__active = state
        CrosshairContainer.Visible = state
        if state then
            self.__activateTime = tick() 
        else
            self:__desync_stop()
        end
    end

    __i1j2k3:__init()
end

-- ==========================================
-- 1. Main 탭 설정 (Ragebot & No Cooldown)
-- ==========================================
local MainGroup = Tabs.Main:AddLeftGroupbox('Combat')

MainGroup:AddToggle('Ragebot', {
    Text = 'Enable Ragebot',
    Default = false,
    Tooltip = 'Ragebot 기능 및 크로스헤어 UI를 활성화합니다.',
    Callback = function(Value)
        if getgenv().__s9t0u1 and getgenv().__s9t0u1.SetState then
            getgenv().__s9t0u1:SetState(Value)
        end
    end
})

local originalWeaponValues = {}

MainGroup:AddToggle('RivalsNoCDToggle', {
    Text = 'Triggerbot',
    Default = false,
    Tooltip = 'Triggerbot',
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
    sky.SkyboxBk = id
    sky.SkyboxDn = id
    sky.SkyboxFt = id
    sky.SkyboxLf = id
    sky.SkyboxRt = id
    sky.SkyboxUp = id
end

local function RemoveSky()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then sky:Destroy() end
end

SkyboxGroup:AddDropdown('SkyboxPresetDropdown', {
    Values = { 'Disable', 'Purple Nebula', 'Night Sky', 'Pink Sunset', 'Vaporwave' },
    Default = 1,
    Multi = false,
    Text = 'Presets',
    Callback = function(Value)
        if Value == 'Disable' then
            RemoveSky()
        elseif Presets[Value] then
            ApplySky(Presets[Value])
        end
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
    Multi = false,
    Text = 'Device Spoof',
    Tooltip = 'Rivals 서버로 전송할 입력 기기를 변경합니다.',
    Callback = function(Value)
        local TargetDevice = "MouseKeyboard"

        if Value:find("PC") then
            TargetDevice = "MouseKeyboard"
        elseif Value:find("Mobile") then
            TargetDevice = "Touch"
        elseif Value:find("Controller") then
            TargetDevice = "Gamepad"
        elseif Value:find("VR") then
            TargetDevice = "VR"
        end

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
    end,
    DoubleClick = false,
    Tooltip = '선택한 디바이스 신호를 서버로 즉시 재전송합니다.'
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

-- 3. Skin Changer (Misc 탭)
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
