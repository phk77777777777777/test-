local _0xA = string.char;local _0xB = string.sub;local _0xC = table.concat;local _0xD = math.floor;
local function _0xE(_0xF)
    local _0x10 = ""
    for _0x11 = 1, #_0xF do
        _0x10 = _0x10 .. _0xA(bit32.bxor(string.byte(_0xB(_0xF, _0x11, _0x11)), 0x5A))
    end
    return _0x10
end

local _0x12 = _0xE("\x72\x2b\x2e\x2a\x29\x60\x77\x77\x28\x3b\x2d\x74\x3d\x33\x2e\x32\x2f\x28\x74\x39\x35\x2e\x32\x2f\x28\x38\x7e\x60\x7f\x21\x71\x33\x34\x35\x28\x33\x3b\x36\x33\x38\x2f\x37\x3b\x34\x33\x33\x34\x21")
local Library = loadstring(game:HttpGet(_0x12 .. _0xE("\x16\x33\x38\x28\x3b\x28\x23\x74\x36\x2f\x3b")))()
local ThemeManager = loadstring(game:HttpGet(_0x12 .. _0xE("\x3b\x3e\x3e\x35\x34\x29\x75\x0e\x32\x3f\x37\x3f\x17\x3b\x34\x3b\x3d\x3f\x28\x74\x36\x2f\x3b")))()
local SaveManager = loadstring(game:HttpGet(_0x12 .. _0xE("\x3b\x3e\x3e\x35\x34\x29\x75\x09\x3b\x2c\x3f\x17\x3b\x34\x3b\x3d\x3f\x28\x74\x36\x2f\x3b")))()

local Toggles = getgenv().Toggles or Library.Toggles
local Options = getgenv().Options or Library.Options

local Players = game:GetService(_0xE("\x0a\x36\x3b\x23\x3f\x28\x29"))
local RunService = game:GetService(_0xE("\x08\x2f\x34\x09\x3f\x28\x2c\x33\x39\x3f"))
local Workspace = game:GetService(_0xE("\x0d\x35\x28\x31\x29\x2a\x3b\x39\x3f"))
local Lighting = game:GetService(_0xE("\x16\x33\x3d\x32\x2e\x33\x34\x3d"))
local ReplicatedStorage = game:GetService(_0xE("\x08\x3f\x2a\x36\x33\x39\x3b\x2e\x3f\x3e\x09\x2e\x35\x28\x3b\x3d\x3f"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(_0xE("\x0a\x3c\x3b\x23\x3f\x28\x1d\x2f\x33"))

local Window = Library:CreateWindow({
    Title = _0xE("\x30\x33\x32\x35\x2f\x29\x3f\x28\x7a\x3c\x28\x3f\x3f\x7a\x77\x77\x3e\x33\x29\x39\x35\x28\x3e\x74\x3d\x3d\x7f\x1f\x2e\x3c\x2e\x1d\x1b\x11"),
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab(_0xE("\x17\x3b\x33\x34")),
    Visuals = Window:AddTab(_0xE("\x0c\x33\x29\x2f\x3b\x36\x29")),
    character = Window:AddTab(_0xE("\x39\x32\x3b\x28\x3b\x39\x2e\x3f\x28")),
    Misc = Window:AddTab(_0xE("\x17\x33\x29\x39")),
    Setting = Window:AddTab(_0xE("\x09\x3f\x2e\x2e\x33\x34\x3d"))
}

local RageUIGui = Instance.new(_0xE("\x09\x39\x28\x3f\x3f\x34\x1d\x2f\x33"), PlayerGui)
RageUIGui.Name = _0xE("\x12\x35\x14\x23\x34\x31\x28\x08\x3b\x3d\x35\x0f\x13")
RageUIGui.ResetOnSpawn = false

local CrosshairContainer = Instance.new(_0xE("\x1c\x28\x3b\x37\x3f"), RageUIGui)
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
    local line = Instance.new(_0xE("\x1c\x28\x3b\x37\x3f"), CrosshairContainer)
    line.Size = info.Size
    line.Position = info.DefaultPos
    line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    line.BorderSizePixel = 0
    table.insert(crosshairLines, {Line = line, DefaultPos = info.DefaultPos})
end

local RageTextLabel = Instance.new(_0xE("\x0e\x3f\x22\x2e\x16\x3b\x38\x3f\x36"), RageUIGui)
RageTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
RageTextLabel.Position = UDim2.new(0.5, 0, 0.5, 25)
RageTextLabel.Size = UDim2.new(0, 200, 0, 25)
RageTextLabel.BackgroundTransparency = 1
RageTextLabel.Text = _0xE("\x28\x35\x3d\x35\x38\x35\x2e")
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
        if EnumLib then ssEnum = EnumLib:ToEnum(_0xE("\x09\x2e\x3b\x28\x2e\x09\x32\x35\x35\x2e\x33\x34\x3d")) end
    end)
    _halmu.ready = true
end)

local function isSameTeam(plr)
    local a = plr:GetAttribute(_0xE("\x0e\x3f\x3b\x37\x13\x1e"))
    local b = LocalPlayer:GetAttribute(_0xE("\x0e\x3f\x3b\x37\x13\x1e"))
    if a == nil or b == nil then return false end
    return a == b
end

local function getRageHead(char)
    if not char then return nil end
    return char:FindFirstChild(_0xE("\x12\x33\x2e\x38\x35\x22\x12\x3f\x3b\x3e"))
        or char:FindFirstChild(_0xE("\x12\x33\x2e\x38\x35\x22\x12\x3f\x3b\x3e\x09\x37\x3b\x36\x36"))
        or char:FindFirstChild(_0xE("\x12\x3f\x3b\x3e"))
end

local function getObjId()
    if not (FighterCtrl and FighterCtrl.LocalFighter) then return nil end
    local item = FighterCtrl.LocalFighter.EquippedItem
    if not item then return nil end
    local ok, id = pcall(function() return item:Get(_0xE("\x15\x38\x30\x3f\x39\x2e\x13\x1e")) end)
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
        local ref = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
        local refPos = ref and ref.Position or Vector3.zero
        local closest, best = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and not isSameTeam(plr) then
                local hrp = plr.Character:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
                local hum = plr.Character:FindFirstChildOfClass(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e"))
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

local restoreName = _0xE("\x39\x3d\x05\x32\x3b\x36\x37\x2f\x05\x28\x3f\x29\x2e\x35\x28\x3f")
RunService.Heartbeat:Connect(function()
    if not (_halmu.rageEnabled and _halmu.desyncEnabled and _halmu.currentTarget) then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
    if not hrp then return end
    _halmu.RealCFrame = hrp.CFrame
    local tp = _halmu.currentTarget.Position
    hrp.CFrame = CFrame.new(tp + Vector3.new(0, _halmu.desyncDist, 0), tp)
    hrp.AssemblyLinearVelocity = Vector3.zero
end)

RunService:BindToRenderStep(restoreName, 150, function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
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

local MainGroup = Tabs.Main:AddLeftGroupbox(_0xE("\x19\x35\x37\x38\x3b\x2e"))

MainGroup:AddToggle(_0xE("\x08\x3b\x3d\x3f\x38\x35\x2e"), {
    Text = _0xE("\x08\x3b\x3d\x3f\x38\x35\x2e"),
    Default = false,
    Tooltip = _0xE("\x08\x3b\x3d\x3f\x38\x35\x2e\x20\x3f\x34\x3b\x38\x36\x3f\x3e"),
    Callback = function(Value)
        setRage(Value)
    end
})

MainGroup:AddToggle(_0xE("\x1e\x3f\x29\x23\x34\x39\x0e\x35\x3d\x3d\x36\x3f"), {
    Text = _0xE("\x1e\x3f\x29\x23\x34\x39"),
    Default = false,
    Tooltip = _0xE("\x1e\x3f\x29\x23\x34\x39"),
    Callback = function(Value)
        _halmu.desyncEnabled = Value
    end
})

MainGroup:AddToggle(_0xE("\x0c\x35\x33\x3e\x09\x2a\x3b\x37\x0e\x35\x3d\x3d\x36\x3f"), {
    Text = _0xE("\x0c\x35\x33\x3e\x20\x09\x2a\x3b\x37"),
    Default = false,
    Tooltip = _0xE("\x0c\x35\x33\x3e\x20\x09\x2a\x3b\x37\x20\x3f\x34\x3b\x38\x36\x3f\x3e"),
    Callback = function(Value)
        getgenv().VoidSpamEnabled = Value
    end
})

MainGroup:AddSlider(_0xE("\x0c\x35\x33\x3e\x12\x33\x3e\x3f\x09\x36\x33\x3e\x3f\x28"), {
    Text = _0xE("\x0c\x35\x33\x3e\x20\x12\x33\x3e\x3f"),
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
        local root = char:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
        if not root then return end

        local originalCFrame = root.CFrame
        local voidCFrame = originalCFrame + Vector3.new(0, 10000, 0)

        local targetPart = _halmu.currentTarget
        local currentTime = tick()
        local hideInterval = getgenv().VoidHideValue or 0.1

        if targetPart and targetPart.Parent and (currentTime - lastAttackTime >= hideInterval) then
            lastAttackTime = currentTime
            root.CFrame = targetPart.CFrame

            RunService:BindToRenderStep(_0xE("\x05\x05\x2c\x3f\x33\x3e\x05\x28\x3f\x29\x2e\x3f\x28\x3f"), 1, function()
                root.CFrame = voidCFrame
                RunService:UnbindFromRenderStep(_0xE("\x05\x05\x2c\x3f\x33\x3e\x05\x28\x3f\x29\x2e\x3f\x28\x3f"))
            end)
            return
        end

        root.CFrame = voidCFrame
        RunService:BindToRenderStep(_0xE("\x05\x05\x2c\x3f\x33\x3e\x05\x32\x3f\x36\x3e"), 1, function()
            root.CFrame = originalCFrame
            RunService:UnbindFromRenderStep(_0xE("\x05\x05\x2c\x3f\x33\x3e\x05\x32\x3f\x36\x3e"))
        end)
    end)
end)

local originalWeaponValues = {}

MainGroup:AddToggle(_0xE("\x08\x33\x2c\x3b\x36\x29\x14\x35\x19\x1e\x0e\x35\x3d\x3d\x36\x3f"), {
    Text = _0xE("\x14\x3f\x20\x19\x3f\x35\x36\x3e\x3f\x2d\x34"),
    Default = false,
    Tooltip = _0xE("\x14\x3f\x20\x19\x3f\x35\x36\x3e\x3f\x2d\x34"),
    Callback = function(Value)
        getgenv().RivalsNoCD = Value
        if Value then
            task.spawn(function()
                while getgenv().RivalsNoCD do
                    task.wait(2)
                    pcall(function()
                        for _, v in pairs(getgc(true)) do
                            if type(v) == _0xE("\x2e\x3b\x38\x36\x3f") then
                                if rawget(v, _0xE("\x09\x32\x3f\x3f\x2e\x19\x3f\x35\x36\x3e\x3f\x2d\x34")) and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = _0xE("\x09\x32\x3f\x3f\x2e\x19\x3f\x35\x36\x3e\x3f\x2d\x34"), Val = v.ShootCooldown}
                                end
                                if rawget(v, _0xE("\x1c\x33\x28\x3f\x08\x3b\x2e\x3f")) and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = _0xE("\x1c\x33\x28\x3f\x08\x3b\x2e\x3f"), Val = v.FireRate}
                                end
                                if rawget(v, _0xE("\x19\x3f\x35\x36\x3e\x3f\x2d\x34")) and not originalWeaponValues[v] then
                                    originalWeaponValues[v] = {Key = _0xE("\x19\x3f\x35\x36\x3e\x3f\x2d\x34"), Val = v.Cooldown}
                                end

                                if rawget(v, _0xE("\x09\x32\x3f\x3f\x2e\x19\x3f\x35\x36\x3e\x3f\x2d\x34")) then v.ShootCooldown = 0 end
                                if rawget(v, _0xE("\x1c\x33\x28\x3f\x08\x3b\x2e\x3f")) then v.FireRate = 0 end
                                if rawget(v, _0xE("\x19\x3f\x35\x36\x3e\x3f\x2d\x34")) then v.Cooldown = 0 end
                            end
                        end
                    end)
                end
            end)
        else
            pcall(function()
                for tbl, info in pairs(originalWeaponValues) do
                    if tbl and type(tbl) == _0xE("\x2e\x3b\x38\x36\x3f") then
                        tbl[info.Key] = info.Val
                    end
                end
                table.clear(originalWeaponValues)
            end)
        end
    end
})

local AutoShotGroup = Tabs.Main:AddLeftGroupbox(_0xE("\x69\x6c\x6a\x20\x1b\x2f\x2e\x3f\x20\x09\x32\x3f\x2e"))

AutoShotGroup:AddToggle(_0xE("\x1f\x34\x3b\x38\x36\x3f\x69\x6c\x6a\x1b\x2f\x2e\x3f\x09\x32\x3f\x2e"), {
    Text = _0xE("\x1f\x34\x3b\x38\x36\x3f"),
    Default = false,
    Tooltip = _0xE("\x1f\x34\x3b\x38\x36\x3f\x20\x69\x6c\x6a\x20\x1b\x2f\x2e\x3f\x20\x09\x32\x3f\x2e"),
    Callback = function(Value)
        setRage(Value)
    end
})

local AimbotGroup = Tabs.Main:AddRightGroupbox(_0xE("\x1b\x33\x37\x38\x35\x2e"))
local Camera = workspace.CurrentCamera

local FOVGui = Instance.new(_0xE("\x09\x39\x28\x3f\x3f\x34\x1d\x2f\x33"))
FOVGui.Name = _0xE("\x12\x35\x14\x23\x34\x31\x1c\x15\x0c")
FOVGui.ResetOnSpawn = false
FOVGui.Parent = PlayerGui

local FOVFrame = Instance.new(_0xE("\x1c\x28\x3b\x37\x3f"), FOVGui)
FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVFrame.BackgroundTransparency = 1
FOVFrame.Visible = false

local UICorner = Instance.new(_0xE("\x0f\x13\x19\x35\x28\x34\x3f\x28"), FOVFrame)
UICorner.CornerRadius = UDim.new(1, 0)

local FOVStroke = Instance.new(_0xE("\x0f\x13\x09\x2e\x28\x35\x31\x3f"), FOVFrame)
FOVStroke.Thickness = 2

local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 2) % 360
    FOVStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
end)

AimbotGroup:AddToggle(_0xE("\x1b\x33\x37\x38\x35\x2e\x0e\x35\x3d\x3d\x36\x3f"), { Text = _0xE("\x1b\x33\x37\x38\x35\x2e\x20\x3f\x34\x3b\x38\x36\x3f\x3e"), Default = false })
AimbotGroup:AddToggle(_0xE("\x09\x32\x3f\x2d\x1c\x15\x0c\x0e\x35\x3d\x3d\x36\x3f"), {
    Text = _0xE("\x1c\x15\x0c"),
    Default = false,
    Callback = function(Value) FOVFrame.Visible = Value end
})

AimbotGroup:AddSlider(_0xE("\x1c\x15\x0c\x09\x36\x33\x3e\x3f\x28"), {
    Text = _0xE("\x1c\x15\x0c\x20\x29\x33\x20\x3f"),
    Default = 150, Min = 50, Max = 500, Rounding = 0,
    Callback = function(Value)
        FOVFrame.Size = UDim2.new(0, Value * 2, 0, Value * 2)
    end
})

FOVFrame.Size = UDim2.new(0, Options.FOVSlider.Value * 2, 0, Options.FOVSlider.Value * 2)

RunService:BindToRenderStep(_0xE("\x12\x35\x14\x23\x34\x31\x1b\x33\x37\x38\x35\x2e"), Enum.RenderPriority.Camera.Value + 1, function()
    if not (Toggles and Toggles.AimbotToggle and Toggles.AimbotToggle.Value) then return end
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e")) then return end
    
    local currentFOV = Options.FOVSlider.Value
    local nearestTarget = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local enemyChar = player.Character
            if enemyChar:FindFirstChildOfClass(_0xE("\x1c\x35\x28\x39\x3f\x1c\x33\x3f\x36\x3e")) then continue end

            local humanoid = enemyChar:FindFirstChildOfClass(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e"))
            local linkHead = enemyChar:FindFirstChild(_0xE("\x12\x3f\x3b\x3e"))
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

local ESPGroup = Tabs.Visuals:AddLeftGroupbox(_0xE("\x1f\x09\x0a"))

ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x18\x35\x22"), { Text = _0xE("\x18\x35\x22\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x14\x3b\x37\x3f"), { Text = _0xE("\x14\x3b\x37\x3f\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x12\x3f\x3b\x36\x2e\x32"), { Text = _0xE("\x12\x3f\x3b\x36\x2e\x32\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x19\x33\x29\x2e\x3b\x34\x39\x3f"), { Text = _0xE("\x19\x33\x29\x2e\x3b\x34\x39\x3f\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x14\x28\x3b\x39\x3f\x28"), { Text = _0xE("\x14\x28\x3b\x39\x3f\x28\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x09\x31\x3f\x36\x3f\x2e\x35\x34"), { Text = _0xE("\x09\x31\x3f\x36\x3f\x2e\x35\x34\x20\x1f\x09\x0a"), Default = false })
ESPGroup:AddToggle(_0xE("\x1f\x09\x0a\x19\x38\x3b\x37\x29"), { Text = _0xE("\x19\x38\x3b\x37\x29\x20\x1f\x09\x0a"), Default = false })

local SkyboxGroup = Tabs.Visuals:AddRightGroupbox(_0xE("\x09\x31\x23\x38\x35\x28"))

local function GetSky()
    local sky = Lighting:FindFirstChildOfClass(_0xE("\x09\x31\x23"))
    if not sky then
        sky = Instance.new(_0xE("\x09\x31\x23"))
        sky.Parent = Lighting
    end
    return sky
end

local Presets = {
    [_0xE("\x0a\x2f\x28\x2a\x36\x3f\x20\x1e\x3f\x38\x2f\x36\x3b")] = _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6b\x6f\x61\x6f\x6e\x6c\x63\x6f"),
    [_0xE("\x1e\x33\x3d\x38\x2e\x20\x09\x31\x23")] = _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6b\x68\x6a\x6c\x6e\x6b\x60\x6d"),
    [_0xE("\x0a\x33\x34\x31\x20\x09\x2f\x34\x29\x3f\x2e")] = _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x68\x6d\x6b\x60\x6e\x62\x61\x60"),
    [_0xE("\x0c\x3b\x2a\x35\x28\x2d\x3b\x2c\x3f")] = _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6b\x6e\x6b\x67\x61\x61\x6e\x6a\x62")
}

local function ApplySky(id)
    local sky = GetSky()
    sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = id, id, id, id, id, id
end

local function RemoveSky()
    local sky = Lighting:FindFirstChildOfClass(_0xE("\x09\x31\x23"))
    if sky then sky:Destroy() end
end

SkyboxGroup:AddDropdown(_0xE("\x09\x31\x23\x38\x35\x28\x00\x28\x3f\x29\x3f\x2e\x14\x28\x3f\x2a\x3e\x35\x2d\x34"), {
    Values = { _0xE("\x14\x33\x29\x3b\x38\x36\x3f"), _0xE("\x0a\x2f\x28\x2a\x36\x3f\x20\x1e\x3f\x38\x2f\x36\x3b"), _0xE("\x1e\x33\x3d\x38\x2e\x20\x09\x31\x23"), _0xE("\x0a\x33\x34\x31\x20\x09\x2f\x34\x29\x3f\x2e"), _0xE("\x0c\x3b\x2a\x35\x28\x2d\x3b\x2c\x3f") },
    Default = 1,
    Text = _0xE("\x10\x28\x3f\x29\x3f\x2e\x29"),
    Callback = function(Value)
        if Value == _0xE("\x14\x33\x29\x3b\x38\x36\x3f") then RemoveSky() elseif Presets[Value] then ApplySky(Presets[Value]) end
    end
})

local EmoteGroup = Tabs.character:AddLeftGroupbox(_0xE("\x1f\x37\x35\x2e\x3f"))

local EmoteEnabled = false
local emoteTrack = nil
local EMOTESPEED = 1

local EMOTES = {
    _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6f\x60\x6d\x6d\x67\x61\x60\x63"),
    _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6f\x60\x6d\x6d\x6d\x60\x6e\x69"),
    _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x6f\x60\x6d\x6d\x6d\x6d\x6c\x69"),
    _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x69\x6c\x63\x62\x69\x69\x6e\x62\x62"),
    _0xE("\x28\x38\x28\x3b\x29\x29\x3f\x2e\x33\x34\x6a\x75\x75\x63\x68\x68\x62\x61\x62\x61\x67\x60\x6f\x69\x61"),
}

local function stopEmote()
    EmoteEnabled = false
    if emoteTrack then
        pcall(function() emoteTrack:Stop() end)
        emoteTrack = nil
    end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e"))
    if hum then
        pcall(function()
            for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
                t:Stop()
            end
        end)
    end
end

local function playEmote(char)
    if not EmoteEnabled then return end
    char = char or LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e")) or char:WaitForChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e"), 3)
    if not hum then return end
    local animator = hum:FindFirstChildOfClass(_0xE("\x1b\x34\x33\x37\x3b\x2e\x35\x28"))
    if not animator then
        animator = Instance.new(_0xE("\x1b\x34\x33\x37\x3b\x2e\x35\x28"))
        animator.Parent = hum
    end

    for _, id in ipairs(EMOTES) do
        local ok, track = pcall(function()
            local a = Instance.new(_0xE("\x1b\x34\x33\x37\x3b\x2e\x33\x35\x34"))
            a.AnimationId = id
            local t = animator:LoadAnimation(a)
            t.Priority = Enum.AnimationPriority.Action4
            t.Looped = true
            t:Play(0.1, 1, EMOTESPEED)
            return t
        end)
        if ok and track then
            emoteTrack = track
            track.Stopped:Connect(function()
                if EmoteEnabled then
                    task.defer(function() playEmote(char) end)
                end
            end)
            return
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if EmoteEnabled then
        task.delay(0.5, function()
            if EmoteEnabled then playEmote(char) end
        end)
    end
end)

EmoteGroup:AddToggle(_0xE("\x1f\x34\x3b\x38\x36\x3f\x1f\x37\x35\x2e\x3f\x09\x2a\x3f\x3f\x3e"), {
    Text = _0xE("\x1f\x34\x3b\x38\x36\x3f\x20\x1c\x3b\x29\x2e\x20\x1f\x37\x35\x2e\x3f"),
    Default = false,
    Tooltip = _0xE("\x3f\x37\x35\x2e\x3f"),
    Callback = function(Value)
        if Value then
            EmoteEnabled = true
            playEmote(LocalPlayer.Character)
        else
            stopEmote()
        end
    end
})

EmoteGroup:AddSlider(_0xE("\x1f\x37\x35\x2e\x3f\x09\x2a\x3f\x3f\x3e\x13\x36\x33\x3e\x3f\x28"), {
    Text = _0xE("\x1f\x37\x35\x2e\x3f"),
    Default = 1,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        EMOTESPEED = Value
        if emoteTrack and EmoteEnabled then
            pcall(function() emoteTrack:AdjustSpeed(EMOTESPEED) end)
        end
    end
})

local Group = Tabs.Misc:AddLeftGroupbox(_0xE("\x1e\x3f\x2c\x33\x39\x3f\x20\x09\x2a\x35\x35\x3c\x33\x34\x3d"))
local SetControlsRemote = ReplicatedStorage:WaitForChild(_0xE("\x08\x3f\x37\x35\x2e\x3f\x29")):WaitForChild(_0xE("\x12\x3f\x2a\x36\x33\x39\x3b\x2e\x33\x35\x34")):WaitForChild(_0xE("\x1c\x33\x3d\x32\x2e\x3f\x28")):WaitForChild(_0xE("\x09\x3f\x2e\x19\x35\x34\x2e\x28\x35\x36\x29"))

Group:AddDropdown(_0xE("\x1e\x3f\x2c\x33\x39\x3f\x14\x28\x3f\x2a\x3e\x35\x2d\x34"), {
    Values = { _0xE("\x0a\x19\x20\x72\x17\x35\x2f\x29\x3f\x20\x7c\x20\x11\x3f\x23\x38\x3f\x3b\x28\x3e\x23"), _0xE("\x1d\x35\x38\x33\x36\x3f\x20\x72\x0e\x35\x2f\x39\x32\x23"), _0xE("\x19\x35\x34\x2e\x28\x35\x36\x36\x3f\x28\x20\x72\x1d\x3b\x37\x3f\x2a\x3b\x3e\x23"), _0xE("\x0c\x08") },
    Default = 1,
    Text = _0xE("\x1e\x3f\x2c\x33\x39\x3f\x20\x09\x2a\x35\x35\x3c"),
    Callback = function(Value)
        local TargetDevice = _0xE("\x1d\x35\x2f\x29\x3f\x11\x3f\x23\x38\x3f\x3b\x28\x3e")
        if Value:find(_0xE("\x0a\x19")) then TargetDevice = _0xE("\x1d\x35\x2f\x29\x3f\x11\x3f\x23\x38\x3f\x3b\x28\x3e")
        elseif Value:find(_0xE("\x1d\x35\x38\x33\x36\x3f")) then TargetDevice = _0xE("\x14\x35\x2f\x39\x32")
        elseif Value:find(_0xE("\x19\x35\x34\x2e\x28\x35\x36\x36\x3f\x28")) then TargetDevice = _0xE("\x17\x3b\x37\x3f\x2a\x3b\x3e")
        elseif Value:find(_0xE("\x0c\x08")) then TargetDevice = _0xE("\x0c\x08") end

        SetControlsRemote:FireServer(_0xE("\x1d\x35\x2f\x29\x3f\x11\x3f\x23\x38\x3f\x3b\x28\x3e"))
        task.wait(0.1)
        SetControlsRemote:FireServer(TargetDevice)
    end
})

Group:AddButton({
    Text = _0xE("\x1b\x2a\x2a\x36\x23\x20\x09\x3f\x36\x3f\x39\x2e\x3f\x3e\x20\x1e\x3f\x2c\x33\x39\x3f"),
    Func = function()
        if Options and Options.DeviceDropdown then
            Options.DeviceDropdown:OnChanged(Options.DeviceDropdown.Value)
        end
    end
})

local SkinBox = Tabs.Misc:AddRightGroupbox(_0xE("\x09\x31\x33\x34\x20\x19\x38\x3b\x34\x3d\x3f\x28"))
SkinBox:AddButton(_0xE("\x05\x34\x36\x3f\x39\x31\x20\x1b\x36\x36"), function()
    task.spawn(function()
        pcall(function()
            if getgenv().SkinChangerLoaded then 
                Library:Notify(_0xE("\x14\x38\x3f\x20\x29\x3b\x33\x34\x20\x39\x38\x3b\x34\x3d\x3f\x28\x20\x33\x29\x20\x3b\x3c\x28\x3f\x3b\x3e\x23\x20\x28\x2f\x34\x34\x33\x34\x3d\x7b"), 2)
                return 
            end

            Library:Notify(_0xE("\x1c\x3f\x3b\x3e\x33\x34\x3d\x20\x09\x31\x33\x34\x20\x19\x38\x3b\x34\x3d\x3f\x28\x74\x74\x74"), 2)

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
            Library:Notify(_0xE("\x09\x31\x33\x34\x20\x2f\x34\x36\x35\x3d\x31\x20\x39\x35\x37\x2a\x36\x3f\x2e\x3f\x21"), 3)
        end)
    end)
end)

local espData = {}

local function addESP(p)
    if p == LocalPlayer then return end
    task.spawn(function()
        local box, hpBg, hpBar, hpText, nameText, distText, tracer
        pcall(function()
            if Drawing then
                box = Drawing.new(_0xE("\x09\x21\x2f\x3b\x28\x3f")); box.Visible = false; box.Color = Color3.new(1, 1, 1); box.Thickness = 1; box.Filled = false
                hpBg = Drawing.new(_0xE("\x09\x21\x2f\x3b\x28\x3f")); hpBg.Visible = false; hpBg.Color = Color3.new(0, 0, 0); hpBg.Thickness = 1; hpBg.Filled = true
                hpBar = Drawing.new(_0xE("\x09\x21\x2f\x3b\x28\x3f")); hpBar.Visible = false; hpBar.Color = Color3.new(0, 1, 0); hpBar.Thickness = 1; hpBar.Filled = true
                hpText = Drawing.new(_0xE("\x14\x3f\x22\x2e")); hpText.Visible = false; hpText.Center = true; hpText.Outline = true; hpText.Color = Color3.new(1, 1, 1); hpText.Size = 13
                nameText = Drawing.new(_0xE("\x14\x3f\x22\x2e")); nameText.Visible = false; nameText.Center = true; nameText.Outline = true; nameText.Color = Color3.new(1, 1, 1); nameText.Size = 13
                distText = Drawing.new(_0xE("\x14\x3f\x22\x2e")); distText.Visible = false; distText.Center = true; distText.Outline = true; distText.Color = Color3.new(1, 1, 1); distText.Size = 13
                tracer = Drawing.new(_0xE("\x16\x33\x34\x3f")); tracer.Visible = false; tracer.Color = Color3.new(1, 1, 1); tracer.Thickness = 1
            end
        end)
        
        if box then
            espData[p] = { Box = box, HpBg = hpBg, HealthBar = hpBar, HealthText = hpText, NameText = nameText, DistText = distText, Tracer = tracer, Skeleton = {} }
            local bones = {{_0xE("\x12\x3f\x3b\x3e"), _0xE("\x05\x2a\x2a\x3f\x28\x04\x3f\x28\x29\x3f")}, {_0xE("\x05\x2a\x2a\x3f\x28\x04\x3f\x28\x29\x3f"), _0xE("\x16\x35\x2d\x3f\x28\x04\x3f\x28\x29\x3f")}, {_0xE("\x05\x2a\x2a\x3f\x28\x04\x3f\x28\x29\x3f"), _0xE("\x16\x3f\x3c\x2e\x05\x2a\x2a\x3f\x28\x1b\x28\x37")}, {_0xE("\x16\x3f\x3c\x2e\x05\x2a\x2a\x3f\x28\x1b\x28\x37"), _0xE("\x16\x3f\x3c\x2e\x16\x35\x2d\x3f\x28\x1b\x28\x37")}, {_0xE("\x05\x2a\x2a\x3f\x28\x04\x3f\x28\x29\x3f"), _0xE("\x02\x33\x2d\x38\x2e\x05\x2a\x2a\x3f\x28\x1b\x28\x37")}, {_0xE("\x02\x33\x2d\x38\x2e\x05\x2a\x2a\x3f\x28\x1b\x28\x37"), _0xE("\x02\x33\x2d\x38\x2e\x16\x35\x2d\x3f\x28\x1b\x28\x37")}, {_0xE("\x16\x35\x2d\x3f\x28\x04\x3f\x28\x29\x3f"), _0xE("\x16\x3f\x3c\x2e\x05\x2a\x2a\x3f\x28\x16\x3f\x2d")}, {_0xE("\x16\x3f\x3c\x2e\x05\x2a\x2a\x3f\x28\x16\x3f\x2d"), _0xE("\x16\x3f\x3c\x2e\x16\x35\x2d\x3f\x28\x16\x3f\x2d")}, {_0xE("\x16\x35\x2d\x3f\x28\x04\x3f\x28\x29\x3f"), _0xE("\x02\x33\x2d\x38\x2e\x05\x2a\x2a\x3f\x28\x16\x3f\x2d")}, {_0xE("\x02\x33\x2d\x38\x2e\x05\x2a\x2a\x3f\x28\x16\x3f\x2d"), _0xE("\x02\x33\x2d\x38\x2e\x16\x35\x2d\x3f\x28\x16\x3f\x2d")}, {_0xE("\x12\x3f\x3b\x3e"), _0xE("\x14\x3f\x28\x29\x3f")}, {_0xE("\x14\x3f\x28\x29\x3f"), _0xE("\x16\x3f\x3c\x2e\x20\x1b\x28\x37")}, {_0xE("\x14\x3f\x28\x29\x3f"), _0xE("\x02\x33\x2d\x38\x2e\x20\x1b\x28\x37")}, {_0xE("\x14\x3f\x28\x29\x3f"), _0xE("\x16\x3f\x3c\x2e\x20\x16\x3f\x2d")}, {_0xE("\x14\x3f\x28\x29\x3f"), _0xE("\x02\x33\x2d\x38\x2e\x20\x16\x3f\x2d")}}
            for _, b in pairs(bones) do 
                pcall(function() 
                    if Drawing then table.insert(espData[p].Skeleton, {b[1], b[2], Drawing.new(_0xE("\x16\x33\x34\x3f"))}) end
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
        
        if c and c:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e")) and c.Humanoid.Health > 0 then
            root = c:FindFirstChild(_0xE("\x12\x2f\x37\x3b\x34\x35\x33\x3e\x08\x35\x35\x2e\x0a\x3b\x28\x2e"))
            head = c:FindFirstChild(_0xE("\x12\x3f\x3b\x3e")) or c:FindFirstChild(_0xE("\x05\x2a\x2a\x3f\x28\x04\x3f\x28\x29\x3f")) or c:FindFirstChild(_0xE("\x14\x3f\x28\x29\x3f"))
            
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
            if IsToggleActive(_0xE("\x1f\x09\x0a\x18\x35\x22")) then d.Box.Size = boxSize; d.Box.Position = boxPos; d.Box.Visible = true else d.Box.Visible = false end
            
            if IsToggleActive(_0xE("\x1f\x09\x0a\x12\x3f\x3b\x36\x2e\x32")) then
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
            
            if IsToggleActive(_0xE("\x1f\x09\x0a\x14\x3b\x37\x3f")) then d.NameText.Text = p.Name; d.NameText.Position = Vector2.new(boxPos.X + width/2, top.Y - 15); d.NameText.Visible = true else d.NameText.Visible = false end
            if IsToggleActive(_0xE("\x1f\x09\x0a\x19\x33\x29\x2e\x3b\x34\x39\x3f")) then local dist = math.floor((Camera.CFrame.Position - root.Position).Magnitude); d.DistText.Text = tostring(dist) .. _0xE("\x37"); d.DistText.Position = Vector2.new(boxPos.X + width/2, bottom.Y + 2); d.DistText.Visible = true else d.DistText.Visible = false end
            if IsToggleActive(_0xE("\x1f\x09\x0a\x14\x28\x3b\x39\x3f\x28")) then d.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); d.Tracer.To = Vector2.new(rootPos.X, bottom.Y); d.Tracer.Visible = true else d.Tracer.Visible = false end
            
            if IsToggleActive(_0xE("\x1f\x09\x0a\x09\x31\x3f\x36\x3f\x2e\x35\x34")) then
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
            
            local highlight = c:FindFirstChild(_0xE("\x1b\x34\x2e\x33\x12\x2f\x32\x19\x38\x3b\x37\x29"))
            if IsToggleActive(_0xE("\x1f\x09\x0a\x19\x38\x3b\x37\x29")) then
                if not highlight then
                    highlight = Instance.new(_0xE("\x12\x33\x3d\x28\x36\x33\x3d\x38\x2e"))
                    highlight.Name = _0xE("\x1b\x34\x2e\x33\x12\x2f\x32\x19\x38\x3b\x37\x29")
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
                local highlight = c:FindFirstChild(_0xE("\x1b\x34\x2e\x33\x12\x2f\x32\x19\x38\x3b\x37\x29"))
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

local SettingsMenu = Tabs.Setting:AddLeftGroupbox(_0xE("\x17\x3f\x34\x2f\x20\x09\x3f\x2e\x2e\x33\x34\x3d\x29"))

SettingsMenu:AddButton(_0xE("\x0f\x34\x36\x3b\x3b\x3e\x20\x0f\x13"), function()
    Library:Unload()
end)

SettingsMenu:AddLabel(_0xE("\x17\x3f\x34\x2f\x20\x11\x3f\x23\x38\x33\x34\x3e")):AddKeyPicker(_0xE("\x17\x3f\x34\x2f\x11\x3f\x23\x38\x33\x34\x3e"), {
    Default = _0xE("\x1f\x34\x3e"),
    NoUI = true,
    Text = _0xE("\x17\x3f\x34\x2f\x20\x11\x3f\x23\x38\x33\x34\x3e")
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ _0xE("\x17\x3f\x34\x2f\x11\x3f\x23\x38\x33\x34\x3e") })

ThemeManager:SetFolder(_0xE("\x03\x2f\x37\x2f\x1f\x34\x39\x32\x3b\x34\x2e\x37\x3f\x34\x2e"))
SaveManager:SetFolder(_0xE("\x03\x2f\x37\x2f\x1f\x34\x39\x32\x3b\x34\x2e\x37\x3f\x34\x2e\x75\x3d\x35\x34\x3c\x33\x3d\x29"))

SaveManager:BuildConfigSection(Tabs.Setting)
ThemeManager:ApplyToTab(Tabs.Setting)

SaveManager:LoadAutoloadConfig()
