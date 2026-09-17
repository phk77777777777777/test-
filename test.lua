Local repo = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

local Toggles = getgenv().Toggles or Library.Toggles
local Options = getgenv().Options or Library.Options

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Window = Library:CreateWindow({
    Title = 'Yumu Enchantment - discord.gg/qTV5c5Fn6',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Visuals = Window:AddTab('Visuals'),
    character = Window:AddTab('character'),
    Misc = Window:AddTab('Misc'),
    Setting = Window:AddTab('Setting')
}

-- Crosshair GUI
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
-- [개선된] Dynamic Ragebot Engine
-- ==========================================
local _halmu = {
    rageEnabled = false,
    desyncEnabled = false,
    targetPartSetting = "Head", -- "Head", "Torso", "Random"
    currentTarget = nil,
    rageConn = nil,
    findConn = nil,
    ready = false,
}

local FighterCtrl, EnumLib, useItemRemote, ssEnum

task.spawn(function()
    pcall(function() FighterCtrl = require(LocalPlayer.PlayerScripts.Controllers.FighterController) end)
    pcall(function() EnumLib = require(ReplicatedStorage.Modules.EnumLibrary) end)
    pcall(function() useItemRemote = ReplicatedStorage.Remotes.Replication.Fighter.UseItem end)
    pcall(function() if EnumLib then ssEnum = EnumLib:ToEnum("StartShooting") end end)
    _halmu.ready = true
end)

local function isSameTeam(plr)
    local a = LocalPlayer:GetAttribute("TeamID")
    local b = plr:GetAttribute("TeamID")
    if a == nil or b == nil then return false end
    return a == b
end

-- [무적 시간 및 ForceField 감지]
local function isInvulnerable(char)
    if not char then return true end
    if char:FindFirstChildOfClass("ForceField") then return true end
    local head = char:FindFirstChild("Head")
    if head and head.Transparency >= 0.9 then return true end
    return false
end

-- [헤드 / 바디 조절 파트 탐색]
local function getRageTargetPart(char)
    if not char or isInvulnerable(char) then return nil end
    
    local mode = _halmu.targetPartSetting
    if mode == "Random" then
        mode = (math.random(1, 2) == 1) and "Head" or "Torso"
    end

    if mode == "Head" then
        return char:FindFirstChild("HitboxHead") 
            or char:FindFirstChild("HitboxHeadSmall") 
            or char:FindFirstChild("Head")
    else
        return char:FindFirstChild("UpperTorso") 
            or char:FindFirstChild("Torso") 
            or char:FindFirstChild("HumanoidRootPart")
    end
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
                local char = plr.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                -- 무적 상태가 아니며 체력이 남아있는 상대만 타겟팅
                if hrp and hum and hum.Health > 0 and not isInvulnerable(char) then
                    local d = (Vector3.new(refPos.X, 0, refPos.Z) - Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude
                    if d < best then
                        best = d
                        closest = char
                    end
                end
            end
        end
        _halmu.currentTarget = closest and getRageTargetPart(closest) or nil
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
-- 1. Main 탭 (Combat & Aimbot)
-- ==========================================
local MainGroup = Tabs.Main:AddLeftGroupbox('Combat')

MainGroup:AddToggle('Ragebot', {
    Text = 'Ragebot',
    Default = false,
    Tooltip = 'Enable Ragebot',
    Callback = function(Value)
        setRage(Value)
    end
})

MainGroup:AddDropdown('RageTargetPart', {
    Values = { 'Head', 'Torso', 'Random' },
    Default = 1,
    Multi = false,
    Text = 'Target Part',
    Tooltip = '조준 위치 (헤드 / 바디 / 랜덤)',
    Callback = function(Value)
        _halmu.targetPartSetting = Value
    end
})

MainGroup:AddToggle('DesyncToggle', {
    Text = 'Ragebot Anti-Aim (Desync)',
    Default = false,
    Tooltip = '상대 Ragebot 조준 교란',
    Callback = function(Value)
        _halmu.desyncEnabled = Value
    end
})

-- 이동 버그가 없는 안전한 Desync 로직
RunService.Heartbeat:Connect(function()
    if not (_halmu.rageEnabled and _halmu.desyncEnabled) then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- 캐릭터 이동 물리 속도를 훼손하지 않는 난수 오프셋 계산
        local randOffset = Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
        hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity + randOffset
    end
end)

MainGroup:AddToggle('RivalsNoCDToggle', {
    Text = 'No Cooldown',
    Default = false,
    Callback = function(Value)
        getgenv().RivalsNoCD = Value
        if Value then
            task.spawn(function()
                while getgenv().RivalsNoCD do
                    task.wait(2)
                    pcall(function()
                        for _, v in pairs(getgc(true)) do
                            if type(v) == "table" then
                                if rawget(v, "ShootCooldown") then v.ShootCooldown = 0 end
                                if rawget(v, "FireRate") then v.FireRate = 0 end
                                if rawget(v, "Cooldown") then v.Cooldown = 0 end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

-- UI Library 설정 초기화 및 실행
Library:Notify("Ragebot Engine Initialized Successfully!", 3)
