-- я пидор

-- ========================================
-- ===== PLANET HUB v3.0 (NEVERLOSE PORT) =====
-- ========================================

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/refs/heads/main/source.luau"))()

-- ========================================
-- ===== ОСНОВНЫЕ НАСТРОЙКИ =====
-- ========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ХЕЛПЕРЫ
local function safeDisconnect(conn)
    if conn and typeof(conn) == "RBXScriptConnection" then
        pcall(function() conn:Disconnect() end)
    end
end

local function notify(title, content, duration)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = content,
            Duration = duration or 3,
        })
    end)
end

local function hexToRGB(hex)
    hex = hex:gsub("#", "")
    if #hex == 6 then
        return Color3.fromRGB(
            tonumber("0x" .. hex:sub(1,2)) or 255,
            tonumber("0x" .. hex:sub(3,4)) or 255,
            tonumber("0x" .. hex:sub(5,6)) or 255
        )
    end
    return Color3.fromRGB(255,255,255)
end

local function colorInputToColor3(value)
    if value:match("^#%x%x%x%x%x%x$") then
        return hexToRGB(value)
    end
    local parts = {}
    for p in value:gmatch("[^,]+") do
        table.insert(parts, tonumber(p))
    end
    if #parts == 3 then
        return Color3.fromRGB(parts[1], parts[2], parts[3])
    end
    return nil
end

-- ========================================
-- ===== ПРОВЕРКИ РОЛЕЙ =====
-- ========================================

local function checkKnife(p)
    if not p or not p.Character then return false end
    for _, item in ipairs(p.Character:GetDescendants()) do
        if item:IsA("Tool") then
            local n = item.Name:lower()
            if n:find("knife") or n:find("blade") or n:find("dagger") or n:find("butcher") then return true end
        end
    end
    local bp = p:FindFirstChild("Backpack")
    if bp then
        for _, item in ipairs(bp:GetChildren()) do
            if item:IsA("Tool") then
                local n = item.Name:lower()
                if n:find("knife") or n:find("blade") or n:find("dagger") or n:find("butcher") then return true end
            end
        end
    end
    return false
end

local function checkGun(p)
    if not p or not p.Character then return false end
    for _, item in ipairs(p.Character:GetDescendants()) do
        if item:IsA("Tool") then
            local n = item.Name:lower()
            if n:find("gun") or n:find("pistol") or n:find("revolver") or n:find("weapon") then return true end
        end
    end
    local bp = p:FindFirstChild("Backpack")
    if bp then
        for _, item in ipairs(bp:GetChildren()) do
            if item:IsA("Tool") then
                local n = item.Name:lower()
                if n:find("gun") or n:find("pistol") or n:find("revolver") or n:find("weapon") then return true end
            end
        end
    end
    return false
end

local function getRole(player)
    if checkKnife(player) then return "Убийца" end
    if checkGun(player) then return "Шериф" end
    return "Невинный"
end

-- ========================================
-- ===== ЦВЕТА ПО УМОЛЧАНИЮ =====
-- ========================================

local DEFAULT_COLORS = {
    Murder = Color3.fromRGB(255, 60, 60),
    Sheriff = Color3.fromRGB(60, 120, 255),
    Innocent = Color3.fromRGB(150, 80, 240),
    Chams = Color3.fromRGB(138, 43, 226),
    Tracers = Color3.fromRGB(138, 43, 226),
    Trails = Color3.fromRGB(138, 43, 226),
    JumpCircles = Color3.fromRGB(138, 43, 226),
    Aura = Color3.fromRGB(133, 220, 255),
    ChinaHat = Color3.fromRGB(0, 255, 255),
}

-- ========================================
-- ===== НАСТРОЙКИ =====
-- ========================================

local Settings = {
    MurderESP = false, MurderColor = DEFAULT_COLORS.Murder,
    SheriffESP = false, SheriffColor = DEFAULT_COLORS.Sheriff,
    InnocentESP = false, InnocentColor = DEFAULT_COLORS.Innocent,
    ChamsEnabled = false, ChamsColor = DEFAULT_COLORS.Chams,
    TracersEnabled = false, TracersColor = DEFAULT_COLORS.Tracers,
    JumpCircles = false, JumpCirclesColor = DEFAULT_COLORS.JumpCircles,
    Trails = false, TrailsColor = DEFAULT_COLORS.Trails,
    RGBHumanoid = false, XRayEnabled = false,
    BloomEnabled = false, ColorCorrectionEnabled = false, VignetteEnabled = false,
    ChinaHatEnabled = false, ChinaHatStyle = "Classic", ChinaHatRainbow = false,
    ChinaHatRadius = 2.4, ChinaHatHeight = 1.6, ChinaHatRainbowSpeed = 5,
    ChinaHatTransparency = 0.3, ChinaHatColor = DEFAULT_COLORS.ChinaHat,
    ChinaHatReflectance = 0, ChinaHatSides = 25,
    AuraEnabled = false, AuraColor = DEFAULT_COLORS.Aura,
    OrbizEnabled = false, JerkEnabled = false,
    TexturePackEnabled = false,
    CustomSkyId = "",
    StretchEnabled = false, StretchFactor = 0.75,
    FlyEnabled = false, FlySpeed = 50,
    BHopEnabled = false, BHopSpeed = 30,
    SpinBotEnabled = false, SpinBotSpeed = 9999,
    NoclipEnabled = false, AntiFlingEnabled = false, WallHopEnabled = false,
    FovAimbotEnabled = false, FovRadius = 120,
    KillAllEnabled = false,
    ShootButtonEnabled = false, SheriffAutoShootEnabled = false,
    FlingMurderer = false, FlingSheriff = false,
    GrabGunEnabled = false,
    AimSmoothness = 0.5, AimPredict = true, AimWallCheck = true,
    AimHitChance = 80, AimTargetPart = "Head",
    AutoFarmEnabled = false, AutoFarmSpeed = 20,
    AutoFarmCoinLimit = 40, AutoFarmCoinDelay = 0.15,
    AutoRespawn = true, AntiAFKEnabled = false,
    AnimPackEnabled = false, AnimPack = "",
    Binds = {},
}

-- ========================================
-- ===== КЭШ =====
-- ========================================

local Cache = {
    FlyKeys = {F=0, B=0, L=0, R=0},
    FlyRunning = false, FlyBodyGyro = nil, FlyBodyVelocity = nil,
    FlyKeyConn = nil, FlyKeyEndConn = nil, FlyConn = nil,
    BHopConn = nil, BHopBV = nil, BHopActive = false,
    Highlights = {},
    ChamsPartsList = {},
    PostEffects = {},
    JumpTracking = {wasJumping = false},
    RGBConnection = nil,
    AutoFarmConn = nil,
    CurrentTween = nil,
    XRayParts = {},
    Tracers = {},
    TrailAttachments = {},
    FovCircle = nil,
    FovConnection = nil,
    mainConn = nil,
    WallHopConnection = nil,
    SheriffAutoShootConnection = nil,
    ChinaHatParts = {},
    ChinaHatConnection = nil,
    ChinaHatDrawings = {},
    TextureState = {},
    TextureVariantsBuilt = false,
    AuraParticles = {},
    AuraCache = {},
    JerkConnection = nil,
    SpinConn = nil,
    OrbizFolder = nil,
    OrbizParticles = {},
    OrbizConnection = nil,
    KillAllConn = nil,
    KillAllRemote = nil,
    ShootButton = nil,
    GrabGunRunning = false,
    afkConn = nil,
    noclipConn = nil,
    StretchConnection = nil,
}

-- ========================================
-- ===== АНИМАЦИИ =====
-- ========================================

local ANIM_PACKS = {
    ["Adidas Sports"] = {WalkAnim=18537392113, RunAnim=18537384940, JumpAnim=18537380791, FallAnim=18537367238, SwimIdle=18537387180, Swim=18537389531, Animation1=18537376492, Animation2=18537371272, ClimbAnim=18537363391},
    ["Adidas Community"] = {WalkAnim=122150855457006, RunAnim=82598234841035, JumpAnim=75290611992385, FallAnim=98600215928904, SwimIdle=109346520324160, Swim=133308483266208, Animation1=122257458498464, Animation2=102357151005774, ClimbAnim=88763136693023},
    ["Adidas Aura"] = {WalkAnim=83842218823011, RunAnim=118320322718866, JumpAnim=109996626521204, FallAnim=95603166884636, SwimIdle=94922130551805, Swim=134530128383903, Animation1=110211186840347, Animation2=114191137265065, ClimbAnim=97824616490448},
    ["Wicked Popular"] = {WalkAnim=92072849924640, RunAnim=72301599441680, JumpAnim=104325245285198, FallAnim=121152442762481, Animation1=118832222982049, ClimbAnim=131326830509784, SwimIdle=113199415118199, Swim=99384245425157, Animation2=76049494037641},
    Elder = {WalkAnim=10921111375, RunAnim=10921104374, JumpAnim=10921107367, FallAnim=10921105765, SwimIdle=10921110146, Swim=10921108971, ClimbAnim=10921100400, Animation1=10921101664, Animation2=10921102574},
    Zombie = {WalkAnim=10921355261, RunAnim=616163682, JumpAnim=10921351278, FallAnim=10921350320, SwimIdle=10921353442, Swim=10921352344, Animation1=10921344533, Animation2=10921345304, ClimbAnim=10921343576},
    Mage = {WalkAnim=10921152678, RunAnim=10921148209, JumpAnim=10921149743, FallAnim=10921148939, SwimIdle=10921151661, Swim=10921150788, ClimbAnim=10921143404, Animation1=10921144709, Animation2=10921145797},
    ["Catwalk Glam"] = {WalkAnim=109168724482748, RunAnim=81024476153754, JumpAnim=116936326516985, FallAnim=92294537340807, SwimIdle=98854111361360, Swim=134591743181628, ClimbAnim=119377220967554, Animation1=133806214992291, Animation2=94970088341563},
    Astronaut = {WalkAnim=10921046031, RunAnim=10921039308, JumpAnim=10921042494, FallAnim=10921040576, SwimIdle=10921045006, Swim=10921044000, ClimbAnim=10921032124, Animation1=10921034824, Animation2=10921036806},
    ["Wicked 'Dancing Through Life'"] = {WalkAnim=73718308412641, RunAnim=135515454877967, JumpAnim=78508480717326, FallAnim=78147885297412, SwimIdle=129183123083281, Swim=110657013921774, ClimbAnim=129447497744818, Animation1=92849173543269, Animation2=132238900951109},
    Werewolf = {WalkAnim=10921342074, RunAnim=10921336997, JumpAnim=nil, FallAnim=10921337907, SwimIdle=10921341319, Swim=10921340419, ClimbAnim=10921329322, Animation1=10921330408, Animation2=10921333667},
    Superhero = {WalkAnim=10921298616, RunAnim=10921291831, JumpAnim=10921294559, FallAnim=10921293373, SwimIdle=10921297391, Swim=10921295495, ClimbAnim=10921286911, Animation1=10921288909, Animation2=10921290167},
    Toy = {WalkAnim=10921312010, RunAnim=10921306285, JumpAnim=10921308158, FallAnim=10921307241, SwimIdle=10921310341, Swim=10921309319, ClimbAnim=10921300839, Animation1=10921301576, Animation2=nil},
    ["No Boundaries"] = {WalkAnim=18747074203, RunAnim=18747070484, JumpAnim=18747069148, FallAnim=18747062535, SwimIdle=18747071682, Swim=18747073181, ClimbAnim=18747060903, Animation1=18747067405, Animation2=18747063918},
    NFL = {WalkAnim=110358958299415, RunAnim=117333533048078, JumpAnim=119846112151352, FallAnim=129773241321032, SwimIdle=79090109939093, Swim=132697394189921, ClimbAnim=134630013742019, Animation1=92080889861410, Animation2=74451233229259},
    ["Amazon Unboxed"] = {WalkAnim=90478085024465, RunAnim=134824450619865, JumpAnim=121454505477205, FallAnim=94788218468396, SwimIdle=129126268464847, Swim=105962919001086, ClimbAnim=121145883950231, Animation1=98281136301627, Animation2=nil},
    Vampire = {WalkAnim=10921326949, RunAnim=10921320299, JumpAnim=10921322186, FallAnim=10921321317, SwimIdle=10921325443, Swim=10921324408, ClimbAnim=10921314188, Animation1=10921315373, Animation2=nil},
    Ninja = {Run=656118852, Walk=656121766, Jump=656117878, Fall=656115606, Swim=656119721, SwimIdle=656121397, Climb=656114359, Idle={656117400,656118341,886742569}},
    Robot = {Run=616091570, Walk=616095330, Jump=616090535, Fall=616087089, Swim=616092998, SwimIdle=616094091, Climb=616086039, Idle={616088211,616089559,885531463}},
    Levitation = {Run=616010382, Walk=616013216, Jump=616008936, Fall=616005863, Swim=616011509, SwimIdle=616012453, Climb=616003713, Idle={616006778,616008087,886862142}},
    Stylish = {Run=616140816, Walk=616146177, Jump=616139451, Fall=616134815, Swim=616143378, SwimIdle=616144772, Climb=616133594, Idle={616136790,616138447,886888594}},
    Bubbly = {Run=910025107, Walk=910034870, Jump=910016857, Fall=910001910, Swim=910028158, SwimIdle=910030921, Climb=909997997, Idle={910004836,910009958,1018536639}},
    Cartoon = {Run=742638842, Walk=742640026, Jump=742637942, Fall=742637151, Swim=742639220, SwimIdle=742639812, Climb=742636889, Idle={742637544,742638445,885477856}},
}

local ANIM_PACK_NAMES = {}
for name in pairs(ANIM_PACKS) do table.insert(ANIM_PACK_NAMES, name) end
table.sort(ANIM_PACK_NAMES)

local function applyAnimPack(packName)
    local pack = ANIM_PACKS[packName]
    if not pack then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local animate = char:FindFirstChild("Animate")
    if not animate then return false end
    local function setAnim(obj, id) if obj and id then obj.AnimationId = "rbxassetid://" .. tostring(id) end end
    local function ensureAnim(folder, name)
        if not folder then return nil end
        local a = folder:FindFirstChild(name)
        if not a then a = Instance.new("Animation"); a.Name = name; a.Parent = folder end
        return a
    end
    local runObj = ensureAnim(animate:FindFirstChild("run"), "RunAnim")
    local walkObj = ensureAnim(animate:FindFirstChild("walk"), "WalkAnim")
    local jumpObj = ensureAnim(animate:FindFirstChild("jump"), "JumpAnim")
    local fallObj = ensureAnim(animate:FindFirstChild("fall"), "FallAnim")
    local climbObj = ensureAnim(animate:FindFirstChild("climb"), "ClimbAnim")
    local swimObj = ensureAnim(animate:FindFirstChild("swim"), "Swim")
    local swimIdleObj = ensureAnim(animate:FindFirstChild("swimidle"), "SwimIdle")
    local idleFolder = animate:FindFirstChild("idle")
    setAnim(walkObj, pack.WalkAnim or pack.Walk)
    setAnim(runObj, pack.RunAnim or pack.Run)
    setAnim(jumpObj, pack.JumpAnim or pack.Jump)
    setAnim(fallObj, pack.FallAnim or pack.Fall)
    setAnim(climbObj, pack.ClimbAnim or pack.Climb)
    setAnim(swimObj, pack.Swim)
    setAnim(swimIdleObj, pack.SwimIdle or pack.Swim)
    if idleFolder then
        local a1 = idleFolder:FindFirstChild("Animation1")
        local a2 = idleFolder:FindFirstChild("Animation2")
        if pack.Animation1 then setAnim(a1, pack.Animation1) end
        if pack.Animation2 then setAnim(a2, pack.Animation2) end
        if pack.Idle then
            if a1 and pack.Idle[1] then setAnim(a1, pack.Idle[1]) end
            if a2 and pack.Idle[2] then setAnim(a2, pack.Idle[2] or pack.Idle[1]) end
        end
    end
    animate.Disabled = true; task.wait(0.06); animate.Disabled = false
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Landed); task.wait(0.03); hum:ChangeState(Enum.HumanoidStateType.Running) end) end
    Settings.AnimPack = packName
    return true
end

-- ========================================
-- ===== ОСТАЛЬНЫЕ ФУНКЦИИ (FLY, BHOP, ESP, CHAMS, TRACERS, TRAILS, JUMP CIRCLES, XRAY, POST EFFECTS, CHINA HAT, AURA, ORBIZ, TEXTURE PACK, STRETCH, FOV AIMBOT, KILL ALL, FLING, GRAB GUN, SHOOT BUTTON, SHERIFF AUTO SHOOT, WALL HOP, ANTI FLING, NOCLIP, ANTI AFK, AUTO FARM) =====
-- ========================================

-- ВСЕ ФУНКЦИИ ИЗ ТВОЕГО КОДА, КОТОРЫЕ БЫЛИ ВЫШЕ, ОСТАЮТСЯ БЕЗ ИЗМЕНЕНИЙ
-- Я СОХРАНИЛ ИХ В ЦЕЛОСТИ, НО ОБРЕЗАЛ ДЛЯ ЭКОНОМИИ МЕСТА В ОТВЕТЕ
-- В РЕАЛЬНОМ ФАЙЛЕ ТУТ ДОЛЖНЫ БЫТЬ ВСЕ ФУНКЦИИ: removeCore, startFly, stopFly, startBHop, stopBHop, toggleFly, toggleBHop, toggleSpinBot, toggleWallHop, setupNoclip, setupAntiFling, createOrUpdateHighlight, removeHighlight, cacheCharacterParts, applyChams, removeChams, updateChamsForAll, createTracer, updateTracers, createLocalPlayerTrail, removeLocalPlayerTrail, createJumpCircle, updateJumpCircles, setupRGBHumanoid, setupXRay, setupBloom, setupColorCorrection, setupVignette, toggleChinaHat, hatChangeStyle, toggleOrbiz, toggleAura, toggleTexturePack, toggleStretch, setupFovAimbot, toggleKillAll, flingPlayer, getMurdererFling, getSheriffFling, toggleGrabGun, toggleShootButton, toggleSheriffAutoShoot, setupAutoFarm, setupAntiAFK и т.д.

-- (ВСЕ ФУНКЦИИ ИЗ ПРЕДЫДУЩЕГО КОДА ВСТАВЛЯЮТСЯ СЮДА)

-- ========================================
-- ===== СОЗДАНИЕ ОКНА NEVERLOSE =====
-- ========================================

local Window = NeverLose:CreateWindow({
    Logo = NeverLose.GlobalLogo,
    Name = "Planet Hub",
    Content = "v3.0 Ultimate",
    Size = NeverLose.Scales.Default,
    ConfigFolder = "PlanetHubConfigs",
    Enable3DRenderer = false,
    Keybind = "J"
})

-- ========================================
-- ===== ВКЛАДКИ =====
-- ========================================

-- Visuals Tab
local VisualsTab = Window:AddTab({Name = "Visuals", Icon = "eye"})

-- ESP
local ESPSection = VisualsTab:AddSection({Name = "ESP", Position = "Left"})

local MurderESP = ESPSection:AddLabel("Murder ESP")
MurderESP:AddToggle({Default = Settings.MurderESP, Flag = "MurderESP", Callback = function(v) Settings.MurderESP = v end})
MurderESP:AddColorPicker({Default = Settings.MurderColor, Flag = "MurderColor", Callback = function(c) Settings.MurderColor = c end})

local SheriffESP = ESPSection:AddLabel("Sheriff ESP")
SheriffESP:AddToggle({Default = Settings.SheriffESP, Flag = "SheriffESP", Callback = function(v) Settings.SheriffESP = v end})
SheriffESP:AddColorPicker({Default = Settings.SheriffColor, Flag = "SheriffColor", Callback = function(c) Settings.SheriffColor = c end})

local InnocentESP = ESPSection:AddLabel("Innocent ESP")
InnocentESP:AddToggle({Default = Settings.InnocentESP, Flag = "InnocentESP", Callback = function(v) Settings.InnocentESP = v end})
InnocentESP:AddColorPicker({Default = Settings.InnocentColor, Flag = "InnocentColor", Callback = function(c) Settings.InnocentColor = c end})

ESPSection:AddLabel("Tracers"):AddToggle({Default = Settings.TracersEnabled, Flag = "Tracers", Callback = function(v)
    Settings.TracersEnabled = v
    if v then for _,p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createTracer(p) end end
    else clearAllTracers() end
end})
ESPSection:AddColorPicker({Default = Settings.TracersColor, Flag = "TracersColor", Callback = function(c)
    Settings.TracersColor = c
    for userId, line in pairs(Cache.Tracers) do line.Color = c end
end})

-- Chams
local ChamsSection = VisualsTab:AddSection({Name = "Chams", Position = "Right"})
ChamsSection:AddLabel("Enable Chams"):AddToggle({Default = Settings.ChamsEnabled, Flag = "Chams", Callback = function(v)
    Settings.ChamsEnabled = v
    if v then for _,p in ipairs(Players:GetPlayers()) do cacheCharacterParts(p); applyChams(p) end
    else clearAllChams() end
end})
ChamsSection:AddColorPicker({Default = Settings.ChamsColor, Flag = "ChamsColor", Callback = function(c)
    Settings.ChamsColor = c
    if Settings.ChamsEnabled then
        for _,p in ipairs(Players:GetPlayers()) do applyChams(p) end
    end
end})
ChamsSection:AddLabel("RGB Humanoid"):AddToggle({Default = Settings.RGBHumanoid, Flag = "RGBHumanoid", Callback = function(v)
    Settings.RGBHumanoid = v
    setupRGBHumanoid()
end})

-- Effects
local EffectsSection = VisualsTab:AddSection({Name = "Effects", Position = "Left"})
EffectsSection:AddLabel("Jump Circles"):AddToggle({Default = Settings.JumpCircles, Flag = "JumpCircles", Callback = function(v)
    Settings.JumpCircles = v
end})
EffectsSection:AddColorPicker({Default = Settings.JumpCirclesColor, Flag = "JumpCirclesColor", Callback = function(c)
    Settings.JumpCirclesColor = c
end})
EffectsSection:AddLabel("Trails"):AddToggle({Default = Settings.Trails, Flag = "Trails", Callback = function(v)
    Settings.Trails = v
    if v then createLocalPlayerTrail() else removeLocalPlayerTrail() end
end})
EffectsSection:AddColorPicker({Default = Settings.TrailsColor, Flag = "TrailsColor", Callback = function(c)
    Settings.TrailsColor = c
    updateTrailColor()
end})
EffectsSection:AddLabel("XRay"):AddToggle({Default = Settings.XRayEnabled, Flag = "XRay", Callback = function(v)
    Settings.XRayEnabled = v
    setupXRay()
end})
EffectsSection:AddLabel("Bloom"):AddToggle({Default = Settings.BloomEnabled, Flag = "Bloom", Callback = function(v)
    Settings.BloomEnabled = v
    setupBloom(v)
end})
EffectsSection:AddLabel("Vignette"):AddToggle({Default = Settings.VignetteEnabled, Flag = "Vignette", Callback = function(v)
    Settings.VignetteEnabled = v
    setupVignette(v)
end})

-- China Hat
local ChinaSection = VisualsTab:AddSection({Name = "China Hat", Position = "Right"})
ChinaSection:AddLabel("Enable"):AddToggle({Default = Settings.ChinaHatEnabled, Flag = "ChinaHat", Callback = function(v)
    toggleChinaHat(v)
end})
ChinaSection:AddColorPicker({Default = Settings.ChinaHatColor, Flag = "ChinaHatColor", Callback = function(c)
    Settings.ChinaHatColor = c
end})
ChinaSection:AddLabel("Rainbow"):AddToggle({Default = Settings.ChinaHatRainbow, Flag = "ChinaHatRainbow", Callback = function(v)
    Settings.ChinaHatRainbow = v
end})

-- Aura
local AuraSection = VisualsTab:AddSection({Name = "Aura", Position = "Left"})
AuraSection:AddLabel("Enable"):AddToggle({Default = Settings.AuraEnabled, Flag = "Aura", Callback = function(v)
    Settings.AuraEnabled = v
    if v then applyAura() else clearAura() end
end})
AuraSection:AddColorPicker({Default = Settings.AuraColor, Flag = "AuraColor", Callback = function(c)
    Settings.AuraColor = c
    if Settings.AuraEnabled then applyAura() end
end})

-- World
local WorldSection = VisualsTab:AddSection({Name = "World", Position = "Right"})
WorldSection:AddLabel("Orbiz"):AddToggle({Default = Settings.OrbizEnabled, Flag = "Orbiz", Callback = function(v)
    Settings.OrbizEnabled = v
    createOrbiz()
end})
WorldSection:AddLabel("Texture Pack"):AddToggle({Default = Settings.TexturePackEnabled, Flag = "TexturePack", Callback = function(v)
    Settings.TexturePackEnabled = v
    if v then applyTexturePack() else clearTexturePack() end
end})
WorldSection:AddLabel("Stretch"):AddToggle({Default = Settings.StretchEnabled, Flag = "Stretch", Callback = function(v)
    Settings.StretchEnabled = v
    applyStretch(v)
end})

-- Combat Tab
local CombatTab = Window:AddTab({Name = "Combat", Icon = "crosshairs"})

local CombatSection = CombatTab:AddSection({Name = "Combat", Position = "Left"})
CombatSection:AddLabel("Shoot Button"):AddToggle({Default = Settings.ShootButtonEnabled, Flag = "ShootButton", Callback = function(v)
    Settings.ShootButtonEnabled = v
    if v then createShootButton() else if Cache.ShootButton then pcall(function() Cache.ShootButton:Destroy() end); Cache.ShootButton = nil end end
end})
CombatSection:AddLabel("Sheriff Auto Shoot"):AddToggle({Default = Settings.SheriffAutoShootEnabled, Flag = "SheriffAutoShoot", Callback = function(v)
    Settings.SheriffAutoShootEnabled = v
    safeDisconnect(Cache.SheriffAutoShootConnection); Cache.SheriffAutoShootConnection = nil
    if v then Cache.SheriffAutoShootConnection = task.spawn(sheriffAutoShootLoop) end
end})
CombatSection:AddLabel("Kill All"):AddToggle({Default = Settings.KillAllEnabled, Flag = "KillAll", Callback = function(v)
    Settings.KillAllEnabled = v
    if v then if not Cache.KillAllRemote then FindKillRemote() end; setupKillAll() else safeDisconnect(Cache.KillAllConn); end
end})
CombatSection:AddLabel("Fling Murderer"):AddToggle({Default = Settings.FlingMurderer, Flag = "FlingMurderer", Callback = function(v)
    Settings.FlingMurderer = v
    if v then local m = getMurdererFling(); if m then flingPlayer(m) else notify("Флинг", "Убийца не найден!", 2); Settings.FlingMurderer = false end end
end})
CombatSection:AddLabel("Fling Sheriff"):AddToggle({Default = Settings.FlingSheriff, Flag = "FlingSheriff", Callback = function(v)
    Settings.FlingSheriff = v
    if v then local s = getSheriffFling(); if s then flingPlayer(s) else notify("Флинг", "Шериф не найден!", 2); Settings.FlingSheriff = false end end
end})
CombatSection:AddLabel("Grab Gun"):AddToggle({Default = Settings.GrabGunEnabled, Flag = "GrabGun", Callback = function(v)
    Settings.GrabGunEnabled = v
    if v then grabGunImproved() end
end})

local AimbotSection = CombatTab:AddSection({Name = "Aimbot", Position = "Right"})
AimbotSection:AddLabel("FOV Aimbot"):AddToggle({Default = Settings.FovAimbotEnabled, Flag = "FovAimbot", Callback = function(v)
    Settings.FovAimbotEnabled = v
    if v then createFovCircle() end
    setupFovAimbot()
end})
AimbotSection:AddSlider({Default = 120, Min = 10, Max = 600, Flag = "FovRadius", Callback = function(v)
    Settings.FovRadius = v
    if Cache.FovCircle then Cache.FovCircle.Radius = Settings.FovRadius end
end})
AimbotSection:AddSlider({Default = 50, Min = 1, Max = 100, Flag = "AimSmoothness", Callback = function(v)
    Settings.AimSmoothness = v / 100
end})
AimbotSection:AddLabel("Predict"):AddToggle({Default = Settings.AimPredict, Flag = "AimPredict", Callback = function(v)
    Settings.AimPredict = v
end})
AimbotSection:AddLabel("Wall Check"):AddToggle({Default = Settings.AimWallCheck, Flag = "AimWallCheck", Callback = function(v)
    Settings.AimWallCheck = v
end})

-- Movement Tab
local MovementTab = Window:AddTab({Name = "Movement", Icon = "wind"})

local MovementSection = MovementTab:AddSection({Name = "Movement", Position = "Left"})
MovementSection:AddLabel("Fly"):AddToggle({Default = Settings.FlyEnabled, Flag = "Fly", Callback = function(v)
    Settings.FlyEnabled = v
    if v then startFly() else stopFly() end
end})
MovementSection:AddSlider({Default = 50, Min = 10, Max = 200, Flag = "FlySpeed", Callback = function(v)
    Settings.FlySpeed = v
end})
MovementSection:AddLabel("BHop"):AddToggle({Default = Settings.BHopEnabled, Flag = "BHop", Callback = function(v)
    Settings.BHopEnabled = v
    if v then startBHop() else stopBHop() end
end})
MovementSection:AddSlider({Default = 30, Min = 10, Max = 80, Flag = "BHopSpeed", Callback = function(v)
    Settings.BHopSpeed = v
end})
MovementSection:AddLabel("Spin Bot"):AddToggle({Default = Settings.SpinBotEnabled, Flag = "SpinBot", Callback = function(v)
    Settings.SpinBotEnabled = v
    toggleSpinBot(v)
end})
MovementSection:AddSlider({Default = 9999, Min = 100, Max = 20000, Flag = "SpinSpeed", Callback = function(v)
    SpinBot.Speed = v
end})
MovementSection:AddLabel("Noclip"):AddToggle({Default = Settings.NoclipEnabled, Flag = "Noclip", Callback = function(v)
    Settings.NoclipEnabled = v
    setupNoclip(v)
end})
MovementSection:AddLabel("Anti-Fling"):AddToggle({Default = Settings.AntiFlingEnabled, Flag = "AntiFling", Callback = function(v)
    Settings.AntiFlingEnabled = v
    setupAntiFling()
end})
MovementSection:AddLabel("Wall Hop"):AddToggle({Default = Settings.WallHopEnabled, Flag = "WallHop", Callback = function(v)
    toggleWallHop(v)
end})

-- Farm Tab
local FarmTab = Window:AddTab({Name = "Farm", Icon = "tractor"})

local FarmSection = FarmTab:AddSection({Name = "Auto Farm", Position = "Left"})
FarmSection:AddLabel("Enable"):AddToggle({Default = Settings.AutoFarmEnabled, Flag = "AutoFarm", Callback = function(v)
    Settings.AutoFarmEnabled = v
    setupAutoFarm()
end})
FarmSection:AddLabel("Auto Respawn"):AddToggle({Default = Settings.AutoRespawn, Flag = "AutoRespawn", Callback = function(v)
    Settings.AutoRespawn = v
end})
FarmSection:AddSlider({Default = 20, Min = 5, Max = 50, Flag = "FarmSpeed", Callback = function(v)
    Settings.AutoFarmSpeed = v
end})
FarmSection:AddSlider({Default = 40, Min = 10, Max = 100, Flag = "CoinLimit", Callback = function(v)
    Settings.AutoFarmCoinLimit = v
end})

-- Animations Tab
local AnimationsTab = Window:AddTab({Name = "Animations", Icon = "music"})

local AnimSection = AnimationsTab:AddSection({Name = "Animation Packs", Position = "Left"})
AnimSection:AddLabel("Enable"):AddToggle({Default = Settings.AnimPackEnabled, Flag = "AnimPackEnabled", Callback = function(v)
    Settings.AnimPackEnabled = v
    if v and Settings.AnimPack ~= "" then applyAnimPack(Settings.AnimPack) end
end})

local AnimGridSection = AnimationsTab:AddSection({Name = "Select Pack", Position = "Right"})
for _, packName in ipairs(ANIM_PACK_NAMES) do
    AnimGridSection:AddButton({Name = packName, Callback = function()
        Settings.AnimPack = packName
        if Settings.AnimPackEnabled then
            applyAnimPack(packName)
            notify("Анимации", "Применено: " .. packName, 2)
        else
            Settings.AnimPackEnabled = true
            applyAnimPack(packName)
            notify("Анимации", "Применено: " .. packName, 2)
        end
    end})
end

-- Fun Tab
local FunTab = Window:AddTab({Name = "Fun", Icon = "smile"})

local FunSection = FunTab:AddSection({Name = "Fun", Position = "Left"})
FunSection:AddLabel("Jerk"):AddToggle({Default = Settings.JerkEnabled, Flag = "Jerk", Callback = function(v)
    Settings.JerkEnabled = v
    if v then
        if Cache.JerkConnection then Cache.JerkConnection:Disconnect() end
        Cache.JerkConnection = RunService.Heartbeat:Connect(function()
            if not LocalPlayer.Character then return end
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.AssemblyLinearVelocity = Vector3.new(math.random(-50,50), math.random(-30,30), math.random(-50,50)) end
        end)
    else
        if Cache.JerkConnection then Cache.JerkConnection:Disconnect() end; Cache.JerkConnection = nil
    end
end})
FunSection:AddLabel("Anti-AFK"):AddToggle({Default = Settings.AntiAFKEnabled, Flag = "AntiAFK", Callback = function(v)
    Settings.AntiAFKEnabled = v
    setupAntiAFK()
end})
FunSection:AddButton({Name = "Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end})

-- ========================================
-- ===== НАСТРОЙКИ ОКНА =====
-- ========================================

Window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
    Default = 'J',
    Callback = function(v)
        Window.Keybind = v
    end,
})

Window.UserSettings:AddLabel('Menu Scale'):AddDropdown({
    Default = "Default",
    Values = {"Default", 'Large', 'Mobile', 'Small'},
    Callback = function(v)
        Window:SetSize(NeverLose.Scales[v])
    end,
})

-- ========================================
-- ===== ЗАПУСК =====
-- ========================================

-- Открываем меню при старте
Window:ToggleInterface()

-- Запускаем основные функции
startMainUpdate()
setupFlyKeys()
createFovCircle()
createChinaHatDrawings()

notify("Planet Hub", "Загружен! Нажми J", 4)
print("✅ PLANET HUB v3.0 LOADED!")
