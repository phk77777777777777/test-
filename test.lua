local _0x1A8F = function(_0x4D, _0x8E)
    local _0x3F = {}
    for _0x12 = 1, #_0x4D do
        local _0x9B = string.byte(_0x4D, _0x12)
        local _0x7C = string.byte(_0x8E, ((_0x12 - 1) % #_0x8E) + 1)
        table.insert(_0x3F, string.char(bit32.bxor(_0x9B, _0x7C)))
    end
    return table.concat(_0x3F)
end

local _0xMAP = {
    [1] = _0x1A8F("\28\21\22\18\27\12\54\47\47\24\3\26\14\27\31\11\15\20\54\5\21\27\4\10\27\2\28\101\5\25\31\13\11\101\27\27\30\20\21\20\5\13", "JH1938"),
    [2] = _0x1A8F("\28\21\22\18\27\12\54\47\47\24\3\26\14\27\31\11\15\20\54\5\21\27\4\10\27\2\28\101\5\25\31\13\11\101\27\20\26\21\21\25\29\12\50\30\21\23\27\21\23\11\28\88\26\15\27", "JH1938"),
    [3] = _0x1A8F("\28\21\22\18\27\12\54\47\47\24\3\26\14\27\31\11\15\20\54\5\21\27\4\10\27\2\28\101\5\25\31\13\11\101\27\20\26\21\21\25\29\12\37\23\30\23\33\23\20\23\29\23\28\88\26\15\27", "JH1938"),
    [4] = _0x1A8F("\38\22\20\26\22\2\30", "JH1938"),
    [5] = _0x1A8F("\36\15\31\23\27\22\31", "JH1938"),
    [6] = _0x1A8F("\45\14\31\20\20\22\20\28\26", "JH1938"),
    [7] = _0x1A8F("\47\15\29\29\17", "JH1938"),
    [8] = _0x1A8F("\37\31\26\26\27\20\21", "JH1938"),
    [9] = _0x1A8F("\28\21\22\18\27\12\54\47\47\27\27\29\31\14\30\0\18\21\54\25\29\23\15\18\101\31\13", "JH1938"),
    [10] = _0x1A8F("\28\21\22\18\27\12\54\47\47\27\27\29\31\14\30\0\18\21\54\25\29\23\15\18\101\18\21\14\27\27\101\14\27\30\29\22\0", "JH1938"),
}

local function _0xGSTR(_0xIDX)
    return _0xMAP[_0xIDX]
end

local _0xL_repo = _0xGSTR(1)
local _0xL_Library = loadstring(game:HttpGet(_0xL_repo .. _0xGSTR(4)))()
local _0xL_ThemeManager = loadstring(game:HttpGet(_0xL_repo .. _0xGSTR(2)))()
local _0xL_SaveManager = loadstring(game:HttpGet(_0xL_repo .. _0xGSTR(3)))()

local _0xL_Toggles = getgenv().Toggles or _0xL_Library.Toggles
local _0xL_Options = getgenv().Options or _0xL_Library.Options

local _0xL_Players = game:GetService(_0xGSTR(5))
local _0xL_RunService = game:GetService(_0xGSTR(6))
local _0xL_Workspace = game:GetService(_0xGSTR(7))
local _0xL_Lighting = game:GetService(_0xGSTR(8))
local _0xL_ReplicatedStorage = game:GetService("ReplicatedStorage")
local _0xL_LocalPlayer = _0xL_Players.LocalPlayer
local _0xL_PlayerGui = _0xL_LocalPlayer:WaitForChild("PlayerGui")

local _0xL_Window = _0xL_Library:CreateWindow({
    Title = 'jihouser free - discord.gg/EtftqGAQx',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local _0xL_Tabs = {
    Main = _0xL_Window:AddTab('Main'),
    Visuals = _0xL_Window:AddTab('Visuals'),
    character = _0xL_Window:AddTab('character'),
    Misc = _0xL_Window:AddTab('Misc'),
    Setting = _0xL_Window:AddTab('Setting')
}

local _0xL_RageUIGui = Instance.new("ScreenGui", _0xL_PlayerGui)
_0xL_RageUIGui.Name = "HoNyangRageUI"
_0xL_RageUIGui.ResetOnSpawn = false

local _0xL_CrosshairContainer = Instance.new("Frame", _0xL_RageUIGui)
_0xL_CrosshairContainer.AnchorPoint = Vector2.new(0.5, 0.5)
_0xL_CrosshairContainer.Position = UDim2.new(0.5, 0, 0.5, -35)
_0xL_CrosshairContainer.Size = UDim2.new(0, 40, 0, 40)
_0xL_CrosshairContainer.BackgroundTransparency = 1
_0xL_CrosshairContainer.Visible = false

local _0xL_lines = {
    {Size = UDim2.new(0, 8, 0, 2), DefaultPos = UDim2.new(0, 0, 0.5, -1)},
    {Size = UDim2.new(0, 8, 0, 2), DefaultPos = UDim2.new(1, -8, 0.5, -1)},
    {Size = UDim2.new(0, 2, 0, 8), DefaultPos = UDim2.new(0.5, -1, 0, 0)},
    {Size = UDim2.new(0, 2, 0, 8), DefaultPos = UDim2.new(0.5, -1, 1, -8)}
}

local _0xL_crosshairLines = {}
for _, _0xL_info in ipairs(_0xL_lines) do
    local _0xL_line = Instance.new("Frame", _0xL_CrosshairContainer)
    _0xL_line.Size = _0xL_info.Size
    _0xL_line.Position = _0xL_info.DefaultPos
    _0xL_line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _0xL_line.BorderSizePixel = 0
    table.insert(_0xL_crosshairLines, {Line = _0xL_line, DefaultPos = _0xL_info.DefaultPos})
end

local _0xL_RageTextLabel = Instance.new("TextLabel", _0xL_RageUIGui)
_0xL_RageTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
_0xL_RageTextLabel.Position = UDim2.new(0.5, 0, 0.5, 25)
_0xL_RageTextLabel.Size = UDim2.new(0, 200, 0, 25)
_0xL_RageTextLabel.BackgroundTransparency = 1
_0xL_RageTextLabel.Text = "regebot"
_0xL_RageTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xL_RageTextLabel.TextStrokeTransparency = 0
_0xL_RageTextLabel.Font = Enum.Font.GothamBold
_0xL_RageTextLabel.TextSize = 13
_0xL_RageTextLabel.TextXAlignment = Enum.TextXAlignment.Center
_0xL_RageTextLabel.Visible = false

local _0xL_rageHue = 0
local _0xL_rotAngle = 0
_0xL_RunService.RenderStepped:Connect(function()
    _0xL_RageTextLabel.Visible = _0xL_CrosshairContainer.Visible
    if _0xL_CrosshairContainer.Visible then
        _0xL_rageHue = (_0xL_rageHue + 2) % 360
        local _0xL_rainbowColor = Color3.fromHSV(_0xL_rageHue / 360, 1, 1)
        for _, _0xL_item in ipairs(_0xL_crosshairLines) do
            _0xL_item.Line.BackgroundColor3 = _0xL_rainbowColor
        end
        _0xL_RageTextLabel.TextColor3 = _0xL_rainbowColor

        _0xL_rotAngle = (_0xL_rotAngle + 4) % 360
        _0xL_CrosshairContainer.Rotation = _0xL_rotAngle

        local _0xL_timeVal = tick() * 5
        local _0xL_pulse = (math.sin(_0xL_timeVal) + 1) * 0.5 
        
        _0xL_crosshairLines[1].Line.Position = UDim2.new(0, math.floor(3 + _0xL_pulse * 6), 0.5, -1)
        _0xL_crosshairLines[2].Line.Position = UDim2.new(1, math.floor(-11 - _0xL_pulse * 6), 0.5, -1)
        _0xL_crosshairLines[3].Line.Position = UDim2.new(0.5, -1, 0, math.floor(3 + _0xL_pulse * 6))
        _0xL_crosshairLines[4].Line.Position = UDim2.new(0.5, -1, 1, math.floor(-11 - _0xL_pulse * 6))
    end
end)

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
    local _0x_okF, _0x_fc = pcall(function()
        return require(_0xL_LocalPlayer.PlayerScripts.Controllers.FighterController)
    end)
    if _0x_okF then FighterCtrl = _0x_fc end

    local _0x_okE, _0x_el = pcall(function()
        return require(_0xL_ReplicatedStorage.Modules.EnumLibrary)
    end)
    if _0x_okE then EnumLib = _0x_el end

    pcall(function()
        useItemRemote = _0xL_ReplicatedStorage.Remotes.Replication.Fighter.UseItem
    end)
    pcall(function()
        if EnumLib then ssEnum = EnumLib:ToEnum("StartShooting") end
    end)
    _halmu.ready = true
end)

local function isSameTeam(_0x_plr)
    local _0x_a = _0xL_LocalPlayer:GetAttribute("TeamID")
    local _0x_b = _0x_plr:GetAttribute("TeamID")
    if _0x_a == nil or _0x_b == nil then return false end
    return _0x_a == _0x_b
end

local function getRageHead(_0x_char)
    if not _0x_char then return nil end
    return _0x_char:FindFirstChild("HitboxHead")
        or _0x_char:FindFirstChild("HitboxHeadSmall")
        or _0x_char:FindFirstChild("Head")
end

local function getObjId()
    if not (FighterCtrl and FighterCtrl.LocalFighter) then return nil end
    local _0x_item = FighterCtrl.LocalFighter.EquippedItem
    if not _0x_item then return nil end
    local _0x_ok, _0x_id = pcall(function() return _0x_item:Get("ObjectID") end)
    if _0x_ok and _0x_id then return _0x_id end
    _0x_ok, _0x_id = pcall(function() return _0x_item.Data and _0x_item.Data.ObjectID end)
    return _0x_ok and _0x_id or nil
end

local function buildShot(_0x_originPos, _0x_targetPart)
    local _0x_targetPos = _0x_targetPart.Position
    local _0x_lookCF = CFrame.lookAt(_0x_originPos, _0x_targetPos)
    local _0x_lX, _0x_lY, _0x_lZ = _0x_lookCF:ToOrientation()
    local _0x_originStruct = {
        [utf8.char(0)] = _0x_originPos.X, [utf8.char(1)] = _0x_originPos.Y, [utf8.char(2)] = _0x_originPos.Z,
        [utf8.char(3)] = _0x_lX, [utf8.char(4)] = _0x_lY, [utf8.char(5)] = _0x_lZ,
    }
    local _0x_relCF = _0x_targetPart.CFrame:ToObjectSpace(CFrame.new(_0x_targetPos))
    local _0x_rX, _0x_rY, _0x_rZ = _0x_relCF:ToOrientation()
    return {
        [utf8.char(1)] = {
            [utf8.char(0)] = _0x_originStruct,
            [utf8.char(1)] = _0x_originStruct,
            [utf8.char(2)] = _0x_targetPart,
            [utf8.char(3)] = {
                [utf8.char(0)] = _0x_relCF.X, [utf8.char(1)] = _0x_relCF.Y, [utf8.char(2)] = _0x_relCF.Z,
                [utf8.char(3)] = _0x_rX, [utf8.char(4)] = _0x_rY, [utf8.char(5)] = _0x_rZ,
            },
        },
    }
end

local function startTargetFinder()
    if _halmu.findConn then return end
    _halmu.findConn = _0xL_RunService.Heartbeat:Connect(function()
        if not _halmu.rageEnabled then
            _halmu.currentTarget = nil
            return
        end
        local _0x_ref = _0xL_LocalPlayer.Character and _0xL_LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local _0x_refPos = _0x_ref and _0x_ref.Position or Vector3.zero
        local _0x_closest, _0x_best = nil, math.huge
        for _, _0x_plr in ipairs(_0xL_Players:GetPlayers()) do
            if _0x_plr ~= _0xL_LocalPlayer and _0x_plr.Character and not isSameTeam(_0x_plr) then
                local _0x_hrp = _0x_plr.Character:FindFirstChild("HumanoidRootPart")
                local _0x_hum = _0x_plr.Character:FindFirstChildOfClass("Humanoid")
                if _0x_hrp and _0x_hum and _0x_hum.Health > 0 then
                    local _0x_d = (Vector3.new(_0x_refPos.X, 0, _0x_refPos.Z) - Vector3.new(_0x_hrp.Position.X, 0, _0x_hrp.Position.Z)).Magnitude
                    if _0x_d < _0x_best then
                        _0x_best = _0x_d
                        _0x_closest = _0x_plr
                    end
                end
            end
        end
        _halmu.currentTarget = _0x_closest and getRageHead(_0x_closest.Character) or nil
    end)
end

local function startRageFire()
    if _halmu.rageConn then
        _halmu.rageConn:Disconnect()
        _halmu.rageConn = nil
    end
    if not _halmu.rageEnabled then return end

    local _0x_cachedId = nil
    _halmu.rageConn = _0xL_RunService.Heartbeat:Connect(function()
        if not _halmu.rageEnabled then return end
        if not useItemRemote or not ssEnum then return end
        local _0x_target = _halmu.currentTarget
        if not _0x_target or not _0x_target.Parent then return end

        local _0x_objId = getObjId()
        if _0x_objId then _0x_cachedId = _0x_objId else _0x_objId = _0x_cachedId end
        if not _0x_objId then return end

        local _0x_origin = _0x_target.Position + Vector3.new(0, 0.1, 0)
        pcall(function()
            useItemRemote:FireServer(_0x_objId, ssEnum, buildShot(_0x_origin, _0x_target), nil)
        end)
    end)
end

local restoreName = "cg_halmu_restore"
_0xL_RunService.Heartbeat:Connect(function()
    if not (_halmu.rageEnabled and _halmu.desyncEnabled and _halmu.currentTarget) then return end
    local _0x_hrp = _0xL_LocalPlayer.Character and _0xL_LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not _0x_hrp then return end
    _halmu.RealCFrame = _0x_hrp.CFrame
    local _0x_tp = _halmu.currentTarget.Position
    _0x_hrp.CFrame = CFrame.new(_0x_tp + Vector3.new(0, _halmu.desyncDist, 0), _0x_tp)
    _0x_hrp.AssemblyLinearVelocity = Vector3.zero
end)

_0xL_RunService:BindToRenderStep(restoreName, 150, function()
    local _0x_hrp = _0xL_LocalPlayer.Character and _0xL_LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if _0x_hrp and _halmu.RealCFrame then
        _0x_hrp.CFrame = _halmu.RealCFrame
        _0x_hrp.AssemblyLinearVelocity = Vector3.zero
        _halmu.RealCFrame = nil
    end
end)

local function setRage(_0x_on)
    _halmu.rageEnabled = _0x_on and true or false
    _0xL_CrosshairContainer.Visible = _halmu.rageEnabled
    if _0x_on then
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

local _0xL_MainGroup = _0xL_Tabs.Main:AddLeftGroupbox('Combat')

_0xL_MainGroup:AddToggle('Ragebot', {
    Text = 'Ragebot',
    Default = false,
    Tooltip = 'Ragebot enabled',
    Callback = function(_0x_Value)
        setRage(_0x_Value)
    end
})

_0xL_MainGroup:AddToggle('DesyncToggle', {
    Text = 'Desync',
    Default = false,
    Tooltip = 'Desync',
    Callback = function(_0x_Value)
        _halmu.desyncEnabled = _0x_Value
    end
})

_0xL_MainGroup:AddToggle('VoidSpamToggle', {
    Text = 'Void Spam',
    Default = false,
    Tooltip = 'Void Spam enabled',
    Callback = function(_0x_Value)
        getgenv().VoidSpamEnabled = _0x_Value
    end
})

_0xL_MainGroup:AddSlider('VoidHideSlider', {
    Text = 'Void Hide',
    Default = 0.1,
    Min = 0.01,
    Max = 1.0,
    Rounding = 2,
    Compact = false,
    Callback = function(_0x_Value)
        getgenv().VoidHideValue = _0x_Value
    end
})

getgenv().VoidSpamEnabled = false
getgenv().VoidHideValue = 0.1

task.spawn(function()
    local _0x_lastAttackTime = 0

    _0xL_RunService.Heartbeat:Connect(function()
        if not getgenv().VoidSpamEnabled then return end

        local _0x_char = _0xL_LocalPlayer.Character
        if not _0x_char then return end
        local _0x_root = _0x_char:FindFirstChild("HumanoidRootPart")
        if not _0x_root then return end

        local _0x_originalCFrame = _0x_root.CFrame
        local _0x_voidCFrame = _0x_originalCFrame + Vector3.new(0, 10000, 0)

        local _0x_targetPart = _halmu.currentTarget
        local _0x_currentTime = tick()
        local _0x_hideInterval = getgenv().VoidHideValue or 0.1

        if _0x_targetPart and _0x_targetPart.Parent and (_0x_currentTime - _0x_lastAttackTime >= _0x_hideInterval) then
            _0x_lastAttackTime = _0x_currentTime
            _0x_root.CFrame = _0x_targetPart.CFrame

            _0xL_RunService:BindToRenderStep("__void_restore", 1, function()
                _0x_root.CFrame = _0x_voidCFrame
                _0xL_RunService:UnbindFromRenderStep("__void_restore")
            end)
            return
        end

        _0x_root.CFrame = _0x_voidCFrame
        _0xL_RunService:BindToRenderStep("__void_hold", 1, function()
            _0x_root.CFrame = _0x_originalCFrame
            _0xL_RunService:UnbindFromRenderStep("__void_hold")
        end)
    end)
end)

local _0x_originalWeaponValues = {}

_0xL_MainGroup:AddToggle('RivalsNoCDToggle', {
    Text = 'No Cooldown',
    Default = false,
    Tooltip = 'No Cooldown',
    Callback = function(_0x_Value)
        getgenv().RivalsNoCD = _0x_Value
        if _0x_Value then
            task.spawn(function()
                while getgenv().RivalsNoCD do
                    task.wait(2)
                    pcall(function()
                        for _, _0x_v in pairs(getgc(true)) do
                            if type(_0x_v) == "table" then
                                if rawget(_0x_v, "ShootCooldown") and not _0x_originalWeaponValues[_0x_v] then
                                    _0x_originalWeaponValues[_0x_v] = {Key = "ShootCooldown", Val = _0x_v.ShootCooldown}
                                end
                                if rawget(_0x_v, "FireRate") and not _0x_originalWeaponValues[_0x_v] then
                                    _0x_originalWeaponValues[_0x_v] = {Key = "FireRate", Val = _0x_v.FireRate}
                                end
                                if rawget(_0x_v, "Cooldown") and not _0x_originalWeaponValues[_0x_v] then
                                    _0x_originalWeaponValues[_0x_v] = {Key = "Cooldown", Val = _0x_v.Cooldown}
                                end

                                if rawget(_0x_v, "ShootCooldown") then _0x_v.ShootCooldown = 0 end
                                if rawget(_0x_v, "FireRate") then _0x_v.FireRate = 0 end
                                if rawget(_0x_v, "Cooldown") then _0x_v.Cooldown = 0 end
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for _0x_tbl, _0x_info in pairs(_0x_originalWeaponValues) do
                    if _0x_tbl and type(_0x_tbl) == "table" then
                        _0x_tbl[_0x_info.Key] = _0x_info.Val
                    end
                end
                table.clear(_0x_originalWeaponValues)
            end)
        end
    end
})

local _0xL_AutoShotGroup = _0xL_Tabs.Main:AddLeftGroupbox('360 Auto Shot')

_0xL_AutoShotGroup:AddToggle('Enable360AutoShot', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable 360 Auto Shot',
    Callback = function(_0x_Value)
        setRage(_0x_Value)
    end
})

local _0xL_AimbotGroup = _0xL_Tabs.Main:AddRightGroupbox('Aimbot')
local _0xL_Camera = workspace.CurrentCamera

local _0xL_FOVGui = Instance.new("ScreenGui")
_0xL_FOVGui.Name = "HoNyangFOV"
_0xL_FOVGui.ResetOnSpawn = false
_0xL_FOVGui.Parent = _0xL_PlayerGui

local _0xL_FOVFrame = Instance.new("Frame", _0xL_FOVGui)
_0xL_FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
_0xL_FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
_0xL_FOVFrame.BackgroundTransparency = 1
_0xL_FOVFrame.Visible = false

local _0xL_UICorner = Instance.new("UICorner", _0xL_FOVFrame)
_0xL_UICorner.CornerRadius = UDim.new(1, 0)

local _0xL_FOVStroke = Instance.new("UIStroke", _0xL_FOVFrame)
_0xL_FOVStroke.Thickness = 2

local _0xL_hue = 0
_0xL_RunService.RenderStepped:Connect(function()
    _0xL_hue = (_0xL_hue + 2) % 360
    _0xL_FOVStroke.Color = Color3.fromHSV(_0xL_hue / 360, 1, 1)
end)

_0xL_AimbotGroup:AddToggle('AimbotToggle', { Text = 'Aimbot enabled', Default = false })
_0xL_AimbotGroup:AddToggle('ShowFOVToggle', {
    Text = 'FOV',
    Default = false,
    Callback = function(_0x_Value) _0xL_FOVFrame.Visible = _0x_Value end
})

_0xL_AimbotGroup:AddSlider('FOVSlider', {
    Text = 'FOV size',
    Default = 150, Min = 50, Max = 500, Rounding = 0,
    Callback = function(_0x_Value)
        _0xL_FOVFrame.Size = UDim2.new(0, _0x_Value * 2, 0, _0x_Value * 2)
    end
})

_0xL_FOVFrame.Size = UDim2.new(0, _0xL_Options.FOVSlider.Value * 2, 0, _0xL_Options.FOVSlider.Value * 2)

_0xL_RunService:BindToRenderStep("HoNyangAimbot", Enum.RenderPriority.Camera.Value + 1, function()
    if not (_0xL_Toggles and _0xL_Toggles.AimbotToggle and _0xL_Toggles.AimbotToggle.Value) then return end
    
    local _0x_char = _0xL_LocalPlayer.Character
    if not _0x_char or not _0x_char:FindFirstChild("HumanoidRootPart") then return end
    
    local _0x_currentFOV = _0xL_Options.FOVSlider.Value
    local _0x_nearestTarget = nil
    local _0x_shortestDistance = math.huge
    
    for _, _0x_player in ipairs(_0xL_Players:GetPlayers()) do
        if _0x_player ~= _0xL_LocalPlayer and _0x_player.Character then
            local _0x_enemyChar = _0x_player.Character
            if _0x_enemyChar:FindFirstChildOfClass("ForceField") then continue end

            local _0x_humanoid = _0x_enemyChar:FindFirstChildOfClass("Humanoid")
            local _0x_linkHead = _0x_enemyChar:FindFirstChild("Head")
            if _0x_humanoid and _0x_humanoid.Health > 0 and _0x_linkHead then
                local _0x_pos, _0x_onScreen = _0xL_Camera:WorldToViewportPoint(_0x_linkHead.Position)
                local _0x_distance = (Vector2.new(_0x_pos.X, _0x_pos.Y) - Vector2.new(_0xL_Camera.ViewportSize.X/2, _0xL_Camera.ViewportSize.Y/2)).Magnitude
                if _0x_onScreen and _0x_distance <= _0x_currentFOV and _0x_distance < _0x_shortestDistance then
                    _0x_shortestDistance = _0x_distance
                    _0x_nearestTarget = _0x_linkHead
                end
            end
        end
    end
    
    if _0x_nearestTarget then
        _0xL_Camera.CFrame = CFrame.lookAt(_0xL_Camera.CFrame.Position, _0x_nearestTarget.Position)
    end
end)

local _0xL_ESPGroup = _0xL_Tabs.Visuals:AddLeftGroupbox('ESP')

_0xL_ESPGroup:AddToggle('ESPBox', { Text = 'Box ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPName', { Text = 'Name ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPHealth', { Text = 'Health ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPDistance', { Text = 'Distance ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPTracer', { Text = 'Tracer ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPSkeleton', { Text = 'Skeleton ESP', Default = false })
_0xL_ESPGroup:AddToggle('ESPChams', { Text = 'Chams ESP', Default = false })

local _0xL_SkyboxGroup = _0xL_Tabs.Visuals:AddRightGroupbox('Skybox')

local function GetSky()
    local _0x_sky = _0xL_Lighting:FindFirstChildOfClass("Sky")
    if not _0x_sky then
        _0x_sky = Instance.new("Sky")
        _0x_sky.Parent = _0xL_Lighting
    end
    return _0x_sky
end

local _0xL_Presets = {
    ["Purple Nebula"] = "rbxassetid://159454299",
    ["Night Sky"] = "rbxassetid://12064107",
    ["Pink Sunset"] = "rbxassetid://271042310",
    ["Vaporwave"] = "rbxassetid://1417494402"
}

local function ApplySky(_0x_id)
    local _0x_sky = GetSky()
    _0x_sky.SkyboxBk, _0x_sky.SkyboxDn, _0x_sky.SkyboxFt, _0x_sky.SkyboxLf, _0x_sky.SkyboxRt, _0x_sky.SkyboxUp = _0x_id, _0x_id, _0x_id, _0x_id, _0x_id, _0x_id
end

local function RemoveSky()
    local _0x_sky = _0xL_Lighting:FindFirstChildOfClass("Sky")
    if _0x_sky then _0x_sky:Destroy() end
end

_0xL_SkyboxGroup:AddDropdown('SkyboxPresetDropdown', {
    Values = { 'Disable', 'Purple Nebula', 'Night Sky', 'Pink Sunset', 'Vaporwave' },
    Default = 1,
    Text = 'Presets',
    Callback = function(_0x_Value)
        if _0x_Value == 'Disable' then RemoveSky() elseif _0xL_Presets[_0x_Value] then ApplySky(_0xL_Presets[_0x_Value]) end
    end
})

local _0xL_EmoteGroup = _0xL_Tabs.character:AddLeftGroupbox('Emote')

local _0xL_EmoteEnabled = false
local _0xL_emoteTrack = nil
local _0xL_EMOTESPEED = 1

local _0xL_EMOTES = {
    "rbxassetid://507771019",
    "rbxassetid://507776043",
    "rbxassetid://507777623",
    "rbxassetid://3698339488",
    "rbxassetid://92281817840531",
}

local function stopEmote()
    _0xL_EmoteEnabled = false
    if _0xL_emoteTrack then
        pcall(function() _0xL_emoteTrack:Stop() end)
        _0xL_emoteTrack = nil
    end
    local _0x_char = _0xL_LocalPlayer.Character
    local _0x_hum = _0x_char and _0x_char:FindFirstChildOfClass("Humanoid")
    if _0x_hum then
        pcall(function()
            for _, _0x_t in ipairs(_0x_hum:GetPlayingAnimationTracks()) do
                _0x_t:Stop()
            end
        end)
    end
end

local function playEmote(_0x_char)
    if not _0xL_EmoteEnabled then return end
    _0x_char = _0x_char or _0xL_LocalPlayer.Character
    if not _0x_char then return end
    local _0x_hum = _0x_char:FindFirstChildOfClass("Humanoid") or _0x_char:WaitForChild("Humanoid", 3)
    if not _0x_hum then return end
    local _0x_animator = _0x_hum:FindFirstChildOfClass("Animator")
    if not _0x_animator then
        _0x_animator = Instance.new("Animator")
        _0x_animator.Parent = _0x_hum
    end

    for _, _0x_id in ipairs(_0xL_EMOTES) do
        local _0x_ok, _0x_track = pcall(function()
            local _0x_a = Instance.new("Animation")
            _0x_a.AnimationId = _0x_id
            local _0x_t = _0x_animator:LoadAnimation(_0x_a)
            _0x_t.Priority = Enum.AnimationPriority.Action4
            _0x_t.Looped = true
            _0x_t:Play(0.1, 1, _0xL_EMOTESPEED)
            return _0x_t
        end)
        if _0x_ok and _0x_track then
            _0xL_emoteTrack = _0x_track
            _0x_track.Stopped:Connect(function()
                if _0xL_EmoteEnabled then
                    task.defer(function() playEmote(_0x_char) end)
                end
            end)
            return
        end
    end
end

_0xL_LocalPlayer.CharacterAdded:Connect(function(_0x_char)
    if _0xL_EmoteEnabled then
        task.delay(0.5, function()
            if _0xL_EmoteEnabled then playEmote(_0x_char) end
        end)
    end
end)

_0xL_EmoteGroup:AddToggle('EnableEmoteSpeed', {
    Text = 'Enable Fast Emote',
    Default = false,
    Tooltip = 'emote',
    Callback = function(_0x_Value)
        if _0x_Value then
            _0xL_EmoteEnabled = true
            playEmote(_0xL_LocalPlayer.Character)
        else
            stopEmote()
        end
    end
})

_0xL_EmoteGroup:AddSlider('EmoteSpeedSlider', {
    Text = 'Emote',
    Default = 1,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(_0x_Value)
        _0xL_EMOTESPEED = _0x_Value
        if _0xL_emoteTrack and _0xL_EmoteEnabled then
            pcall(function() _0xL_emoteTrack:AdjustSpeed(_0xL_EMOTESPEED) end)
        end
    end
})

local _0xL_Group = _0xL_Tabs.Misc:AddLeftGroupbox('Device Spoofing')
local _0xL_SetControlsRemote = _0xL_ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("SetControls")

_0xL_Group:AddDropdown('DeviceDropdown', {
    Values = { 'PC (Mouse & Keyboard)', 'Mobile (Touch)', 'Controller (Gamepad)', 'VR' },
    Default = 1,
    Text = 'Device Spoof',
    Callback = function(_0x_Value)
        local _0x_TargetDevice = "MouseKeyboard"
        if _0x_Value:find("PC") then _0x_TargetDevice = "MouseKeyboard"
        elseif _0x_Value:find("Mobile") then _0x_TargetDevice = "Touch"
        elseif _0x_Value:find("Controller") then _0x_TargetDevice = "Gamepad"
        elseif _0x_Value:find("VR") then _0x_TargetDevice = "VR" end

        _0xL_SetControlsRemote:FireServer("MouseKeyboard")
        task.wait(0.1)
        _0xL_SetControlsRemote:FireServer(_0x_TargetDevice)
    end
})

_0xL_Group:AddButton({
    Text = 'Apply Selected Device',
    Func = function()
        if _0xL_Options and _0xL_Options.DeviceDropdown then
            _0xL_Options.DeviceDropdown:OnChanged(_0xL_Options.DeviceDropdown.Value)
        end
    end
})

local _0xL_SkinBox = _0xL_Tabs.Misc:AddRightGroupbox('Skin Changer')
_0xL_SkinBox:AddButton('Unlock All', function()
    task.spawn(function()
        pcall(function()
            if getgenv().SkinChangerLoaded then 
                _0xL_Library:Notify("The skin changer is already running!", 2)
                return 
            end

            _0xL_Library:Notify("Loading Skin Changer...", 2)

            local _0x_scriptString = [=[
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
            loadstring(_0x_scriptString)()
            _0xL_Library:Notify("Skin unlock complete!", 3)
        end)
    end)
end)

local _0xL_espData = {}

local function addESP(_0x_p)
    if _0x_p == _0xL_LocalPlayer then return end
    task.spawn(function()
        local _0x_box, _0x_hpBg, _0x_hpBar, _0x_hpText, _0x_nameText, _0x_distText, _0x_tracer
        pcall(function()
            if Drawing then
                _0x_box = Drawing.new("Square"); _0x_box.Visible = false; _0x_box.Color = Color3.new(1, 1, 1); _0x_box.Thickness = 1; _0x_box.Filled = false
                _0x_hpBg = Drawing.new("Square"); _0x_hpBg.Visible = false; _0x_hpBg.Color = Color3.new(0, 0, 0); _0x_hpBg.Thickness = 1; _0x_hpBg.Filled = true
                _0x_hpBar = Drawing.new("Square"); _0x_hpBar.Visible = false; _0x_hpBar.Color = Color3.new(0, 1, 0); _0x_hpBar.Thickness = 1; _0x_hpBar.Filled = true
                _0x_hpText = Drawing.new("Text"); _0x_hpText.Visible = false; _0x_hpText.Center = true; _0x_hpText.Outline = true; _0x_hpText.Color = Color3.new(1, 1, 1); _0x_hpText.Size = 13
                _0x_nameText = Drawing.new("Text"); _0x_nameText.Visible = false; _0x_nameText.Center = true; _0x_nameText.Outline = true; _0x_nameText.Color = Color3.new(1, 1, 1); _0x_nameText.Size = 13
                _0x_distText = Drawing.new("Text"); _0x_distText.Visible = false; _0x_distText.Center = true; _0x_distText.Outline = true; _0x_distText.Color = Color3.new(1, 1, 1); _0x_distText.Size = 13
                _0x_tracer = Drawing.new("Line"); _0x_tracer.Visible = false; _0x_tracer.Color = Color3.new(1, 1, 1); _0x_tracer.Thickness = 1
            end
        end)
        
        if _0x_box then
            _0xL_espData[_0x_p] = { Box = _0x_box, HpBg = _0x_hpBg, HealthBar = _0x_hpBar, HealthText = _0x_hpText, NameText = _0x_nameText, DistText = _0x_distText, Tracer = _0x_tracer, Skeleton = {} }
            local _0x_bones = {{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"}}
            for _, _0x_b in pairs(_0x_bones) do 
                pcall(function() 
                    if Drawing then table.insert(_0xL_espData[_0x_p].Skeleton, {_0x_b[1], _0x_b[2], Drawing.new("Line")}) end
                end) 
            end
        end
    end)
end

for _, _0x_p in ipairs(_0xL_Players:GetPlayers()) do addESP(_0x_p) end
_0xL_Players.PlayerAdded:Connect(addESP)
_0xL_Players.PlayerRemoving:Connect(function(_0x_p)
    if _0xL_espData[_0x_p] then
        pcall(function()
            _0xL_espData[_0x_p].Box:Remove(); _0xL_espData[_0x_p].HpBg:Remove(); _0xL_espData[_0x_p].HealthBar:Remove(); _0xL_espData[_0x_p].HealthText:Remove()
            _0xL_espData[_0x_p].NameText:Remove(); _0xL_espData[_0x_p].DistText:Remove(); _0xL_espData[_0x_p].Tracer:Remove()
            for _, _0x_s in pairs(_0xL_espData[_0x_p].Skeleton) do _0x_s[3]:Remove() end
        end)
        _0xL_espData[_0x_p] = nil
    end
end)

local function IsToggleActive(_0x_toggleName)
    return _0xL_Toggles and _0xL_Toggles[_0x_toggleName] and _0xL_Toggles[_0x_toggleName].Value == true
end

_0xL_RunService.RenderStepped:Connect(function()
    local _0x_Camera = _0xL_Workspace.CurrentCamera
    if not _0x_Camera then return end

    for _0x_p, _0x_d in pairs(_0xL_espData) do
        local _0x_isAlive = false
        local _0x_c = _0x_p.Character
        local _0x_root, _0x_head, _0x_rootPos, _0x_boxSize, _0x_boxPos, _0x_top, _0x_bottom, _0x_height, _0x_width
        
        if _0x_c and _0x_c:FindFirstChild("Humanoid") and _0x_c.Humanoid.Health > 0 then
            _0x_root = _0x_c:FindFirstChild("HumanoidRootPart")
            _0x_head = _0x_c:FindFirstChild("Head") or _0x_c:FindFirstChild("UpperTorso") or _0x_c:FindFirstChild("Torso")
            
            if _0x_root and _0x_head then
                local _0x_rPos, _0x_onScreen = _0x_Camera:WorldToViewportPoint(_0x_root.Position)
                if _0x_onScreen then
                    _0x_isAlive = true
                    _0x_rootPos = _0x_rPos
                    local _0x_headPos = _0x_Camera:WorldToViewportPoint(_0x_head.Position + Vector3.new(0, 0.5, 0))
                    local _0x_legPos = _0x_Camera:WorldToViewportPoint(_0x_root.Position - Vector3.new(0, 3, 0))
                    _0x_height = math.abs(_0x_headPos.Y - _0x_legPos.Y)
                    _0x_width = _0x_height * 0.6 
                    _0x_boxSize = Vector2.new(_0x_width, _0x_height)
                    _0x_boxPos = Vector2.new(_0x_rootPos.X - _0x_width / 2, _0x_headPos.Y)
                    _0x_top = {Y = _0x_headPos.Y}
                    _0x_bottom = {Y = _0x_legPos.Y}
                end
            end
        end
        
        if _0x_isAlive then
            if IsToggleActive("ESPBox") then _0x_d.Box.Size = _0x_boxSize; _0x_d.Box.Position = _0x_boxPos; _0x_d.Box.Visible = true else _0x_d.Box.Visible = false end
            
            if IsToggleActive("ESPHealth") then
                local _0x_maxH = math.max(_0x_c.Humanoid.MaxHealth, 1)
                local _0x_h = math.clamp(_0x_c.Humanoid.Health / _0x_maxH, 0, 1)
                _0x_d.HpBg.Size = Vector2.new(4, _0x_height); _0x_d.HpBg.Position = Vector2.new(_0x_boxPos.X - 6, _0x_boxPos.Y); _0x_d.HpBg.Visible = true
                local _0x_barHeight = _0x_height * _0x_h
                _0x_d.HealthBar.Size = Vector2.new(2, _0x_barHeight); _0x_d.HealthBar.Position = Vector2.new(_0x_boxPos.X - 5, _0x_boxPos.Y + (_0x_height - _0x_barHeight))
                _0x_d.HealthBar.Color = Color3.fromHSV(_0x_h * 0.33, 1, 1); _0x_d.HealthBar.Visible = true
                _0x_d.HealthText.Text = tostring(math.floor(_0x_c.Humanoid.Health)); _0x_d.HealthText.Position = Vector2.new(_0x_boxPos.X - 25, _0x_boxPos.Y + (_0x_height - _0x_barHeight) - 6); _0x_d.HealthText.Visible = true
            else 
                _0x_d.HpBg.Visible = false; _0x_d.HealthBar.Visible = false; _0x_d.HealthText.Visible = false 
            end
            
            if IsToggleActive("ESPName") then _0x_d.NameText.Text = _0x_p.Name; _0x_d.NameText.Position = Vector2.new(_0x_boxPos.X + _0x_width/2, _0x_top.Y - 15); _0x_d.NameText.Visible = true else _0x_d.NameText.Visible = false end
            if IsToggleActive("ESPDistance") then local _0x_dist = math.floor((_0x_Camera.CFrame.Position - _0x_root.Position).Magnitude); _0x_d.DistText.Text = tostring(_0x_dist) .. "m"; _0x_d.DistText.Position = Vector2.new(_0x_boxPos.X + _0x_width/2, _0x_bottom.Y + 2); _0x_d.DistText.Visible = true else _0x_d.DistText.Visible = false end
            if IsToggleActive("ESPTracer") then _0x_d.Tracer.From = Vector2.new(_0x_Camera.ViewportSize.X / 2, _0x_Camera.ViewportSize.Y); _0x_d.Tracer.To = Vector2.new(_0x_rootPos.X, _0x_bottom.Y); _0x_d.Tracer.Visible = true else _0x_d.Tracer.Visible = false end
            
            if IsToggleActive("ESPSkeleton") then
                for _, _0x_s in pairs(_0x_d.Skeleton) do
                    local _0x_p1, _0x_p2 = _0x_c:FindFirstChild(_0x_s[1]), _0x_c:FindFirstChild(_0x_s[2])
                    if _0x_p1 and _0x_p2 then
                        local _0x_v1, _0x_o1 = _0x_Camera:WorldToViewportPoint(_0x_p1.Position)
                        local _0x_v2, _0x_o2 = _0x_Camera:WorldToViewportPoint(_0x_p2.Position)
                        if _0x_o1 and _0x_o2 then _0x_s[3].From = Vector2.new(_0x_v1.X, _0x_v1.Y); _0x_s[3].To = Vector2.new(_0x_v2.X, _0x_v2.Y); _0x_s[3].Visible = true; _0x_s[3].Color = Color3.new(1, 1, 1) else _0x_s[3].Visible = false end
                    else _0x_s[3].Visible = false end
                end
            else 
                for _, _0x_s in pairs(_0x_d.Skeleton) do _0x_s[3].Visible = false end 
            end
            
            local _0x_highlight = _0x_c:FindFirstChild("AntiHubChams")
            if IsToggleActive("ESPChams") then
                if not _0x_highlight then
                    _0x_highlight = Instance.new("Highlight")
                    _0x_highlight.Name = "AntiHubChams"
                    _0x_highlight.FillColor = Color3.new(1, 0, 0)
                    _0x_highlight.OutlineColor = Color3.new(1, 1, 1)
                    _0x_highlight.FillTransparency = 0.5
                    _0x_highlight.Parent = _0x_c
                end
            else
                if _0x_highlight then _0x_highlight:Destroy() end
            end
        else
            _0x_d.Box.Visible = false; _0x_d.HpBg.Visible = false; _0x_d.HealthBar.Visible = false; _0x_d.HealthText.Visible = false
            _0x_d.NameText.Visible = false; _0x_d.DistText.Visible = false; _0x_d.Tracer.Visible = false
            for _, _0x_s in pairs(_0x_d.Skeleton) do _0x_s[3].Visible = false end
            
            if _0x_c then
                local _0x_highlight = _0x_c:FindFirstChild("AntiHubChams")
                if _0x_highlight then _0x_highlight:Destroy() end
            end
        end
    end
end)

local _0xL_SettingsMenu = _0xL_Tabs.Setting:AddLeftGroupbox('Menu Settings')

_0xL_SettingsMenu:AddButton('Unload UI', function()
    _0xL_Library:Unload()
end)

_0xL_SettingsMenu:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu Keybind'
})

_0xL_Library.ToggleKeybind = _0xL_Options.MenuKeybind

_0xL_ThemeManager:SetLibrary(_0xL_Library)
_0xL_SaveManager:SetLibrary(_0xL_Library)

_0xL_SaveManager:IgnoreThemeSettings()
_0xL_SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

_0xL_ThemeManager:SetFolder('YumuEnchantment')
_0xL_SaveManager:SetFolder('YumuEnchantment/configs')

_0xL_SaveManager:BuildConfigSection(_0xL_Tabs.Setting)
_0xL_ThemeManager:ApplyToTab(_0xL_Tabs.Setting)

_0xL_SaveManager:LoadAutoloadConfig()
