-- ========================================
-- ===== PLANET HUB v3.0 (NEVERLOSE) =====
-- ========================================

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/refs/heads/main/source.luau"))()

-- ========================================
-- ===== ВСЕ ТВОИ ФУНКЦИИ (КОПИРУЙ СЮДА ИЗ РАБОЧЕГО КОДА) =====
-- ========================================

-- ТУТ ДОЛЖНЫ БЫТЬ ВСЕ ТВОИ ФУНКЦИИ:
-- checkKnife, checkGun, getRole, removeCore,
-- startFly, stopFly, toggleFly,
-- startBHop, stopBHop, toggleBHop,
-- toggleSpinBot, toggleWallHop, setupNoclip,
-- setupAntiFling, createOrUpdateHighlight, removeHighlight,
-- cacheCharacterParts, applyChams, removeChams, updateChamsForAll,
-- createTracer, updateTracers, clearAllTracers,
-- createLocalPlayerTrail, removeLocalPlayerTrail,
-- createJumpCircle, updateJumpCircles,
-- setupRGBHumanoid, setupXRay,
-- setupBloom, setupColorCorrection, setupVignette,
-- toggleChinaHat, toggleOrbiz, toggleAura,
-- toggleTexturePack, toggleStretch,
-- setupFovAimbot, toggleKillAll,
-- flingPlayer, getMurdererFling, getSheriffFling,
-- grabGunImproved, toggleShootButton, toggleSheriffAutoShoot,
-- setupAutoFarm, setupAntiAFK, applyAnimPack

-- Я НЕ БУДУ ИХ ПЕРЕПИСЫВАТЬ, ТЫ ПРОСТО ВСТАВЛЯЕШЬ ИХ СЮДА ИЗ СВОЕГО РАБОЧЕГО КОДА

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
-- ===== VISUALS TAB =====
-- ========================================

local VisualsTab = Window:AddTab({Name = "Visuals", Icon = "eye"})

-- ESP
local ESPSection = VisualsTab:AddSection({Name = "ESP", Position = "Left"})

local MurderESP = ESPSection:AddLabel("Murder ESP")
MurderESP:AddToggle({
    Default = Settings.MurderESP,
    Flag = "MurderESP",
    Callback = function(v)
        Settings.MurderESP = v
        startMainUpdate()
    end
})
MurderESP:AddColorPicker({
    Default = Settings.MurderColor,
    Flag = "MurderColor",
    Callback = function(c)
        Settings.MurderColor = c
        startMainUpdate()
    end
})

local SheriffESP = ESPSection:AddLabel("Sheriff ESP")
SheriffESP:AddToggle({
    Default = Settings.SheriffESP,
    Flag = "SheriffESP",
    Callback = function(v)
        Settings.SheriffESP = v
        startMainUpdate()
    end
})
SheriffESP:AddColorPicker({
    Default = Settings.SheriffColor,
    Flag = "SheriffColor",
    Callback = function(c)
        Settings.SheriffColor = c
        startMainUpdate()
    end
})

local InnocentESP = ESPSection:AddLabel("Innocent ESP")
InnocentESP:AddToggle({
    Default = Settings.InnocentESP,
    Flag = "InnocentESP",
    Callback = function(v)
        Settings.InnocentESP = v
        startMainUpdate()
    end
})
InnocentESP:AddColorPicker({
    Default = Settings.InnocentColor,
    Flag = "InnocentColor",
    Callback = function(c)
        Settings.InnocentColor = c
        startMainUpdate()
    end
})

ESPSection:AddLabel("Tracers"):AddToggle({
    Default = Settings.TracersEnabled,
    Flag = "Tracers",
    Callback = function(v)
        Settings.TracersEnabled = v
        if v then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then createTracer(p) end
            end
        else
            clearAllTracers()
        end
        startMainUpdate()
    end
})
ESPSection:AddColorPicker({
    Default = Settings.TracersColor,
    Flag = "TracersColor",
    Callback = function(c)
        Settings.TracersColor = c
        for userId, line in pairs(Cache.Tracers) do
            line.Color = c
        end
    end
})

-- Chams
local ChamsSection = VisualsTab:AddSection({Name = "Chams", Position = "Right"})
ChamsSection:AddLabel("Enable Chams"):AddToggle({
    Default = Settings.ChamsEnabled,
    Flag = "Chams",
    Callback = function(v)
        Settings.ChamsEnabled = v
        updateChamsForAll()
        startMainUpdate()
    end
})
ChamsSection:AddColorPicker({
    Default = Settings.ChamsColor,
    Flag = "ChamsColor",
    Callback = function(c)
        Settings.ChamsColor = c
        if Settings.ChamsEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                applyChams(p)
            end
        end
    end
})
ChamsSection:AddLabel("RGB Humanoid"):AddToggle({
    Default = Settings.RGBHumanoid,
    Flag = "RGBHumanoid",
    Callback = function(v)
        Settings.RGBHumanoid = v
        setupRGBHumanoid()
    end
})

-- Effects
local EffectsSection = VisualsTab:AddSection({Name = "Effects", Position = "Left"})
EffectsSection:AddLabel("Jump Circles"):AddToggle({
    Default = Settings.JumpCircles,
    Flag = "JumpCircles",
    Callback = function(v)
        Settings.JumpCircles = v
    end
})
EffectsSection:AddColorPicker({
    Default = Settings.JumpCirclesColor,
    Flag = "JumpCirclesColor",
    Callback = function(c)
        Settings.JumpCirclesColor = c
    end
})
EffectsSection:AddLabel("Trails"):AddToggle({
    Default = Settings.Trails,
    Flag = "Trails",
    Callback = function(v)
        Settings.Trails = v
        if v then
            createLocalPlayerTrail()
        else
            removeLocalPlayerTrail()
        end
    end
})
EffectsSection:AddColorPicker({
    Default = Settings.TrailsColor,
    Flag = "TrailsColor",
    Callback = function(c)
        Settings.TrailsColor = c
        updateTrailColor()
    end
})
EffectsSection:AddLabel("XRay"):AddToggle({
    Default = Settings.XRayEnabled,
    Flag = "XRay",
    Callback = function(v)
        Settings.XRayEnabled = v
        setupXRay()
    end
})
EffectsSection:AddLabel("Bloom"):AddToggle({
    Default = Settings.BloomEnabled,
    Flag = "Bloom",
    Callback = function(v)
        Settings.BloomEnabled = v
        setupBloom(v)
    end
})
EffectsSection:AddLabel("Vignette"):AddToggle({
    Default = Settings.VignetteEnabled,
    Flag = "Vignette",
    Callback = function(v)
        Settings.VignetteEnabled = v
        setupVignette(v)
    end
})

-- China Hat
local ChinaSection = VisualsTab:AddSection({Name = "China Hat", Position = "Right"})
ChinaSection:AddLabel("Enable"):AddToggle({
    Default = Settings.ChinaHatEnabled,
    Flag = "ChinaHat",
    Callback = function(v)
        toggleChinaHat(v)
    end
})
ChinaSection:AddColorPicker({
    Default = Settings.ChinaHatColor,
    Flag = "ChinaHatColor",
    Callback = function(c)
        Settings.ChinaHatColor = c
    end
})
ChinaSection:AddLabel("Rainbow"):AddToggle({
    Default = Settings.ChinaHatRainbow,
    Flag = "ChinaHatRainbow",
    Callback = function(v)
        Settings.ChinaHatRainbow = v
    end
})

-- Aura
local AuraSection = VisualsTab:AddSection({Name = "Aura", Position = "Left"})
AuraSection:AddLabel("Enable"):AddToggle({
    Default = Settings.AuraEnabled,
    Flag = "Aura",
    Callback = function(v)
        Settings.AuraEnabled = v
        if v then
            applyAura()
        else
            clearAura()
        end
    end
})
AuraSection:AddColorPicker({
    Default = Settings.AuraColor,
    Flag = "AuraColor",
    Callback = function(c)
        Settings.AuraColor = c
        if Settings.AuraEnabled then
            applyAura()
        end
    end
})

-- World
local WorldSection = VisualsTab:AddSection({Name = "World", Position = "Right"})
WorldSection:AddLabel("Orbiz"):AddToggle({
    Default = Settings.OrbizEnabled,
    Flag = "Orbiz",
    Callback = function(v)
        Settings.OrbizEnabled = v
        createOrbiz()
    end
})
WorldSection:AddLabel("Texture Pack"):AddToggle({
    Default = Settings.TexturePackEnabled,
    Flag = "TexturePack",
    Callback = function(v)
        Settings.TexturePackEnabled = v
        if v then
            applyTexturePack()
        else
            clearTexturePack()
        end
    end
})
WorldSection:AddLabel("Stretch"):AddToggle({
    Default = Settings.StretchEnabled,
    Flag = "Stretch",
    Callback = function(v)
        Settings.StretchEnabled = v
        applyStretch(v)
    end
})

-- ========================================
-- ===== COMBAT TAB =====
-- ========================================

local CombatTab = Window:AddTab({Name = "Combat", Icon = "crosshairs"})

local CombatSection = CombatTab:AddSection({Name = "Combat", Position = "Left"})
CombatSection:AddLabel("Shoot Button"):AddToggle({
    Default = Settings.ShootButtonEnabled,
    Flag = "ShootButton",
    Callback = function(v)
        Settings.ShootButtonEnabled = v
        if v then
            createShootButton()
        else
            if Cache.ShootButton then
                pcall(function() Cache.ShootButton:Destroy() end)
                Cache.ShootButton = nil
            end
        end
    end
})
CombatSection:AddLabel("Sheriff Auto Shoot"):AddToggle({
    Default = Settings.SheriffAutoShootEnabled,
    Flag = "SheriffAutoShoot",
    Callback = function(v)
        Settings.SheriffAutoShootEnabled = v
        safeDisconnect(Cache.SheriffAutoShootConnection)
        Cache.SheriffAutoShootConnection = nil
        if v then
            Cache.SheriffAutoShootConnection = task.spawn(sheriffAutoShootLoop)
        end
    end
})
CombatSection:AddLabel("Kill All"):AddToggle({
    Default = Settings.KillAllEnabled,
    Flag = "KillAll",
    Callback = function(v)
        Settings.KillAllEnabled = v
        if v then
            if not Cache.KillAllRemote then FindKillRemote() end
            setupKillAll()
        else
            safeDisconnect(Cache.KillAllConn)
        end
    end
})
CombatSection:AddLabel("Fling Murderer"):AddToggle({
    Default = Settings.FlingMurderer,
    Flag = "FlingMurderer",
    Callback = function(v)
        Settings.FlingMurderer = v
        if v then
            local m = getMurdererFling()
            if m then
                flingPlayer(m)
            else
                notify("Флинг", "Убийца не найден!", 2)
                Settings.FlingMurderer = false
            end
        end
    end
})
CombatSection:AddLabel("Fling Sheriff"):AddToggle({
    Default = Settings.FlingSheriff,
    Flag = "FlingSheriff",
    Callback = function(v)
        Settings.FlingSheriff = v
        if v then
            local s = getSheriffFling()
            if s then
                flingPlayer(s)
            else
                notify("Флинг", "Шериф не найден!", 2)
                Settings.FlingSheriff = false
            end
        end
    end
})
CombatSection:AddLabel("Grab Gun"):AddToggle({
    Default = Settings.GrabGunEnabled,
    Flag = "GrabGun",
    Callback = function(v)
        Settings.GrabGunEnabled = v
        if v then
            grabGunImproved()
        end
    end
})

local AimbotSection = CombatTab:AddSection({Name = "Aimbot", Position = "Right"})
AimbotSection:AddLabel("FOV Aimbot"):AddToggle({
    Default = Settings.FovAimbotEnabled,
    Flag = "FovAimbot",
    Callback = function(v)
        Settings.FovAimbotEnabled = v
        if v then
            createFovCircle()
        end
        setupFovAimbot()
    end
})
AimbotSection:AddSlider({
    Default = 120,
    Min = 10,
    Max = 600,
    Flag = "FovRadius",
    Callback = function(v)
        Settings.FovRadius = v
        if Cache.FovCircle then
            Cache.FovCircle.Radius = Settings.FovRadius
        end
    end
})
AimbotSection:AddSlider({
    Default = 50,
    Min = 1,
    Max = 100,
    Flag = "AimSmoothness",
    Callback = function(v)
        Settings.AimSmoothness = v / 100
    end
})
AimbotSection:AddLabel("Predict"):AddToggle({
    Default = Settings.AimPredict,
    Flag = "AimPredict",
    Callback = function(v)
        Settings.AimPredict = v
    end
})
AimbotSection:AddLabel("Wall Check"):AddToggle({
    Default = Settings.AimWallCheck,
    Flag = "AimWallCheck",
    Callback = function(v)
        Settings.AimWallCheck = v
    end
})

-- ========================================
-- ===== MOVEMENT TAB =====
-- ========================================

local MovementTab = Window:AddTab({Name = "Movement", Icon = "wind"})

local MovementSection = MovementTab:AddSection({Name = "Movement", Position = "Left"})
MovementSection:AddLabel("Fly"):AddToggle({
    Default = Settings.FlyEnabled,
    Flag = "Fly",
    Callback = function(v)
        toggleFly(v)
    end
})
MovementSection:AddSlider({
    Default = 50,
    Min = 10,
    Max = 200,
    Flag = "FlySpeed",
    Callback = function(v)
        Settings.FlySpeed = v
    end
})
MovementSection:AddLabel("BHop"):AddToggle({
    Default = Settings.BHopEnabled,
    Flag = "BHop",
    Callback = function(v)
        toggleBHop(v)
    end
})
MovementSection:AddSlider({
    Default = 30,
    Min = 10,
    Max = 80,
    Flag = "BHopSpeed",
    Callback = function(v)
        Settings.BHopSpeed = v
    end
})
MovementSection:AddLabel("Spin Bot"):AddToggle({
    Default = Settings.SpinBotEnabled,
    Flag = "SpinBot",
    Callback = function(v)
        toggleSpinBot(v)
    end
})
MovementSection:AddSlider({
    Default = 9999,
    Min = 100,
    Max = 20000,
    Flag = "SpinSpeed",
    Callback = function(v)
        SpinBot.Speed = v
    end
})
MovementSection:AddLabel("Noclip"):AddToggle({
    Default = Settings.NoclipEnabled,
    Flag = "Noclip",
    Callback = function(v)
        Settings.NoclipEnabled = v
        setupNoclip(v)
    end
})
MovementSection:AddLabel("Anti-Fling"):AddToggle({
    Default = Settings.AntiFlingEnabled,
    Flag = "AntiFling",
    Callback = function(v)
        Settings.AntiFlingEnabled = v
        setupAntiFling()
    end
})
MovementSection:AddLabel("Wall Hop"):AddToggle({
    Default = Settings.WallHopEnabled,
    Flag = "WallHop",
    Callback = function(v)
        toggleWallHop(v)
    end
})

-- ========================================
-- ===== FARM TAB =====
-- ========================================

local FarmTab = Window:AddTab({Name = "Farm", Icon = "tractor"})

local FarmSection = FarmTab:AddSection({Name = "Auto Farm", Position = "Left"})
FarmSection:AddLabel("Enable"):AddToggle({
    Default = Settings.AutoFarmEnabled,
    Flag = "AutoFarm",
    Callback = function(v)
        Settings.AutoFarmEnabled = v
        setupAutoFarm()
    end
})
FarmSection:AddLabel("Auto Respawn"):AddToggle({
    Default = Settings.AutoRespawn,
    Flag = "AutoRespawn",
    Callback = function(v)
        Settings.AutoRespawn = v
    end
})
FarmSection:AddSlider({
    Default = 20,
    Min = 5,
    Max = 50,
    Flag = "FarmSpeed",
    Callback = function(v)
        Settings.AutoFarmSpeed = v
    end
})
FarmSection:AddSlider({
    Default = 40,
    Min = 10,
    Max = 100,
    Flag = "CoinLimit",
    Callback = function(v)
        Settings.AutoFarmCoinLimit = v
    end
})

-- ========================================
-- ===== ANIMATIONS TAB =====
-- ========================================

local AnimationsTab = Window:AddTab({Name = "Animations", Icon = "music"})

local AnimSection = AnimationsTab:AddSection({Name = "Animation Packs", Position = "Left"})
AnimSection:AddLabel("Enable"):AddToggle({
    Default = Settings.AnimPackEnabled,
    Flag = "AnimPackEnabled",
    Callback = function(v)
        Settings.AnimPackEnabled = v
        if v and Settings.AnimPack ~= "" then
            applyAnimPack(Settings.AnimPack)
        end
    end
})

local AnimGridSection = AnimationsTab:AddSection({Name = "Select Pack", Position = "Right"})
for _, packName in ipairs(ANIM_PACK_NAMES) do
    AnimGridSection:AddButton({
        Name = packName,
        Callback = function()
            Settings.AnimPack = packName
            if Settings.AnimPackEnabled then
                applyAnimPack(packName)
                notify("Анимации", "Применено: " .. packName, 2)
            else
                Settings.AnimPackEnabled = true
                applyAnimPack(packName)
                notify("Анимации", "Применено: " .. packName, 2)
            end
        end
    })
end

-- ========================================
-- ===== FUN TAB =====
-- ========================================

local FunTab = Window:AddTab({Name = "Fun", Icon = "smile"})

local FunSection = FunTab:AddSection({Name = "Fun", Position = "Left"})
FunSection:AddLabel("Jerk"):AddToggle({
    Default = Settings.JerkEnabled,
    Flag = "Jerk",
    Callback = function(v)
        toggleJerk(v)
    end
})
FunSection:AddLabel("Anti-AFK"):AddToggle({
    Default = Settings.AntiAFKEnabled,
    Flag = "AntiAFK",
    Callback = function(v)
        Settings.AntiAFKEnabled = v
        setupAntiAFK()
    end
})
FunSection:AddButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

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
