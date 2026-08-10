-- ========================================
-- ===== PLANET HUB v3.0 (NEVERLOSE) =====
-- ========================================

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/refs/heads/main/source.luau"))()

-- ========================================
-- ===== ВСЕ ТВОИ НАСТРОЙКИ И ФУНКЦИИ =====
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

-- ТВОИ ФУНКЦИИ (ESP, FLY, BHOP, CHAMS, И Т.Д.)
-- ВСТАВЛЯЙ ИХ СЮДА ИЗ СВОЕГО РАБОЧЕГО КОДА

-- ========================================
-- ===== СОЗДАНИЕ ОКНА =====
-- ========================================

local Window = NeverLose:CreateWindow({
    Name = "Planet Hub",
    Content = "v3.0 Ultimate",
    Size = UDim2.fromOffset(800, 600),
    Keybind = "J"
})

-- ========================================
-- ===== ВКЛАДКИ =====
-- ========================================

-- 1. VISUALS
local VisualsTab = Window:AddTab({Name = "Visuals", Icon = "eye"})

local ESPSection = VisualsTab:AddSection({Name = "ESP", Position = "Left"})
local MurderESP = ESPSection:AddLabel("Murder ESP")
MurderESP:AddToggle({Default = Settings.MurderESP, Callback = function(v) Settings.MurderESP = v; startMainUpdate() end})
MurderESP:AddColorPicker({Default = Settings.MurderColor, Callback = function(c) Settings.MurderColor = c; startMainUpdate() end})

local SheriffESP = ESPSection:AddLabel("Sheriff ESP")
SheriffESP:AddToggle({Default = Settings.SheriffESP, Callback = function(v) Settings.SheriffESP = v; startMainUpdate() end})
SheriffESP:AddColorPicker({Default = Settings.SheriffColor, Callback = function(c) Settings.SheriffColor = c; startMainUpdate() end})

local InnocentESP = ESPSection:AddLabel("Innocent ESP")
InnocentESP:AddToggle({Default = Settings.InnocentESP, Callback = function(v) Settings.InnocentESP = v; startMainUpdate() end})
InnocentESP:AddColorPicker({Default = Settings.InnocentColor, Callback = function(c) Settings.InnocentColor = c; startMainUpdate() end})

ESPSection:AddLabel("Tracers"):AddToggle({Default = Settings.TracersEnabled, Callback = function(v) Settings.TracersEnabled = v; startMainUpdate() end})
ESPSection:AddColorPicker({Default = Settings.TracersColor, Callback = function(c) Settings.TracersColor = c; startMainUpdate() end})

local ChamsSection = VisualsTab:AddSection({Name = "Chams", Position = "Right"})
ChamsSection:AddLabel("Enable"):AddToggle({Default = Settings.ChamsEnabled, Callback = function(v) Settings.ChamsEnabled = v; updateChamsForAll(); startMainUpdate() end})
ChamsSection:AddColorPicker({Default = Settings.ChamsColor, Callback = function(c) Settings.ChamsColor = c; if Settings.ChamsEnabled then updateChamsForAll() end})
ChamsSection:AddLabel("RGB Humanoid"):AddToggle({Default = Settings.RGBHumanoid, Callback = function(v) Settings.RGBHumanoid = v; setupRGBHumanoid() end})

local EffectsSection = VisualsTab:AddSection({Name = "Effects", Position = "Left"})
EffectsSection:AddLabel("Jump Circles"):AddToggle({Default = Settings.JumpCircles, Callback = function(v) Settings.JumpCircles = v end})
EffectsSection:AddColorPicker({Default = Settings.JumpCirclesColor, Callback = function(c) Settings.JumpCirclesColor = c end})
EffectsSection:AddLabel("Trails"):AddToggle({Default = Settings.Trails, Callback = function(v) Settings.Trails = v; if v then createLocalPlayerTrail() else removeLocalPlayerTrail() end})
EffectsSection:AddColorPicker({Default = Settings.TrailsColor, Callback = function(c) Settings.TrailsColor = c; updateTrailColor() end})
EffectsSection:AddLabel("XRay"):AddToggle({Default = Settings.XRayEnabled, Callback = function(v) Settings.XRayEnabled = v; setupXRay() end})
EffectsSection:AddLabel("Bloom"):AddToggle({Default = Settings.BloomEnabled, Callback = function(v) Settings.BloomEnabled = v; setupBloom(v) end})
EffectsSection:AddLabel("Vignette"):AddToggle({Default = Settings.VignetteEnabled, Callback = function(v) Settings.VignetteEnabled = v; setupVignette(v) end})

local ChinaSection = VisualsTab:AddSection({Name = "China Hat", Position = "Right"})
ChinaSection:AddLabel("Enable"):AddToggle({Default = Settings.ChinaHatEnabled, Callback = function(v) toggleChinaHat(v) end})
ChinaSection:AddColorPicker({Default = Settings.ChinaHatColor, Callback = function(c) Settings.ChinaHatColor = c end})
ChinaSection:AddLabel("Rainbow"):AddToggle({Default = Settings.ChinaHatRainbow, Callback = function(v) Settings.ChinaHatRainbow = v end})

local AuraSection = VisualsTab:AddSection({Name = "Aura", Position = "Left"})
AuraSection:AddLabel("Enable"):AddToggle({Default = Settings.AuraEnabled, Callback = function(v) Settings.AuraEnabled = v; if v then applyAura() else clearAura() end})
AuraSection:AddColorPicker({Default = Settings.AuraColor, Callback = function(c) Settings.AuraColor = c; if Settings.AuraEnabled then applyAura() end})

local WorldSection = VisualsTab:AddSection({Name = "World", Position = "Right"})
WorldSection:AddLabel("Orbiz"):AddToggle({Default = Settings.OrbizEnabled, Callback = function(v) Settings.OrbizEnabled = v; createOrbiz() end})
WorldSection:AddLabel("Texture Pack"):AddToggle({Default = Settings.TexturePackEnabled, Callback = function(v) Settings.TexturePackEnabled = v; if v then applyTexturePack() else clearTexturePack() end})
WorldSection:AddLabel("Stretch"):AddToggle({Default = Settings.StretchEnabled, Callback = function(v) Settings.StretchEnabled = v; applyStretch(v) end})

-- 2. COMBAT
local CombatTab = Window:AddTab({Name = "Combat", Icon = "crosshairs"})

local CombatSection = CombatTab:AddSection({Name = "Combat", Position = "Left"})
CombatSection:AddLabel("Shoot Button"):AddToggle({Default = Settings.ShootButtonEnabled, Callback = function(v) toggleShootButton(v) end})
CombatSection:AddLabel("Sheriff Auto"):AddToggle({Default = Settings.SheriffAutoShootEnabled, Callback = function(v) toggleSheriffAutoShoot(v) end})
CombatSection:AddLabel("Kill All"):AddToggle({Default = Settings.KillAllEnabled, Callback = function(v) toggleKillAll(v) end})
CombatSection:AddLabel("Fling Murderer"):AddToggle({Default = Settings.FlingMurderer, Callback = function(v) if v then local m = getMurdererFling(); if m then flingPlayer(m) else Settings.FlingMurderer = false end end})
CombatSection:AddLabel("Fling Sheriff"):AddToggle({Default = Settings.FlingSheriff, Callback = function(v) if v then local s = getSheriffFling(); if s then flingPlayer(s) else Settings.FlingSheriff = false end end})
CombatSection:AddLabel("Grab Gun"):AddToggle({Default = Settings.GrabGunEnabled, Callback = function(v) if v then grabGunImproved() end})

local AimbotSection = CombatTab:AddSection({Name = "Aimbot", Position = "Right"})
AimbotSection:AddLabel("FOV Aimbot"):AddToggle({Default = Settings.FovAimbotEnabled, Callback = function(v) Settings.FovAimbotEnabled = v; setupFovAimbot() end})
AimbotSection:AddSlider({Default = Settings.FovRadius, Min = 10, Max = 600, Callback = function(v) Settings.FovRadius = v; if Cache.FovCircle then Cache.FovCircle.Radius = Settings.FovRadius end})
AimbotSection:AddSlider({Default = 50, Min = 1, Max = 100, Callback = function(v) Settings.AimSmoothness = v / 100 end})
AimbotSection:AddLabel("Predict"):AddToggle({Default = Settings.AimPredict, Callback = function(v) Settings.AimPredict = v end})
AimbotSection:AddLabel("Wall Check"):AddToggle({Default = Settings.AimWallCheck, Callback = function(v) Settings.AimWallCheck = v end})

-- 3. MOVEMENT
local MovementTab = Window:AddTab({Name = "Movement", Icon = "wind"})

local MovementSection = MovementTab:AddSection({Name = "Movement", Position = "Left"})
MovementSection:AddLabel("Fly"):AddToggle({Default = Settings.FlyEnabled, Callback = function(v) toggleFly(v) end})
MovementSection:AddSlider({Default = Settings.FlySpeed, Min = 10, Max = 200, Callback = function(v) Settings.FlySpeed = v end})
MovementSection:AddLabel("BHop"):AddToggle({Default = Settings.BHopEnabled, Callback = function(v) toggleBHop(v) end})
MovementSection:AddSlider({Default = Settings.BHopSpeed, Min = 10, Max = 80, Callback = function(v) Settings.BHopSpeed = v end})
MovementSection:AddLabel("Spin Bot"):AddToggle({Default = Settings.SpinBotEnabled, Callback = function(v) toggleSpinBot(v) end})
MovementSection:AddSlider({Default = Settings.SpinBotSpeed, Min = 100, Max = 20000, Callback = function(v) SpinBot.Speed = v end})
MovementSection:AddLabel("Noclip"):AddToggle({Default = Settings.NoclipEnabled, Callback = function(v) setupNoclip(v) end})
MovementSection:AddLabel("Anti-Fling"):AddToggle({Default = Settings.AntiFlingEnabled, Callback = function(v) Settings.AntiFlingEnabled = v; setupAntiFling() end})
MovementSection:AddLabel("Wall Hop"):AddToggle({Default = Settings.WallHopEnabled, Callback = function(v) toggleWallHop(v) end})

-- 4. FARM
local FarmTab = Window:AddTab({Name = "Farm", Icon = "tractor"})

local FarmSection = FarmTab:AddSection({Name = "Auto Farm", Position = "Left"})
FarmSection:AddLabel("Enable"):AddToggle({Default = Settings.AutoFarmEnabled, Callback = function(v) Settings.AutoFarmEnabled = v; setupAutoFarm() end})
FarmSection:AddLabel("Auto Respawn"):AddToggle({Default = Settings.AutoRespawn, Callback = function(v) Settings.AutoRespawn = v end})
FarmSection:AddSlider({Default = Settings.AutoFarmSpeed, Min = 5, Max = 50, Callback = function(v) Settings.AutoFarmSpeed = v end})
FarmSection:AddSlider({Default = Settings.AutoFarmCoinLimit, Min = 10, Max = 100, Callback = function(v) Settings.AutoFarmCoinLimit = v end})

-- 5. ANIMATIONS
local AnimationsTab = Window:AddTab({Name = "Animations", Icon = "music"})

local AnimSection = AnimationsTab:AddSection({Name = "Animations", Position = "Left"})
AnimSection:AddLabel("Enable"):AddToggle({Default = Settings.AnimPackEnabled, Callback = function(v) Settings.AnimPackEnabled = v; if v and Settings.AnimPack ~= "" then applyAnimPack(Settings.AnimPack) end})

local AnimGrid = AnimationsTab:AddSection({Name = "Select Pack", Position = "Right"})
for _, packName in ipairs(ANIM_PACK_NAMES) do
    AnimGrid:AddButton({Name = packName, Callback = function() Settings.AnimPack = packName; applyAnimPack(packName) end})
end

-- 6. FUN
local FunTab = Window:AddTab({Name = "Fun", Icon = "smile"})

local FunSection = FunTab:AddSection({Name = "Fun", Position = "Left"})
FunSection:AddLabel("Jerk"):AddToggle({Default = Settings.JerkEnabled, Callback = function(v) toggleJerk(v) end})
FunSection:AddLabel("Anti-AFK"):AddToggle({Default = Settings.AntiAFKEnabled, Callback = function(v) Settings.AntiAFKEnabled = v; setupAntiAFK() end})
FunSection:AddButton({Name = "Rejoin", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end})

-- ========================================
-- ===== НАСТРОЙКИ ОКНА =====
-- ========================================

Window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
    Default = 'J',
    Callback = function(v) Window.Keybind = v end,
})

Window.UserSettings:AddLabel('Menu Scale'):AddDropdown({
    Default = "Default",
    Values = {"Default", 'Large', 'Mobile', 'Small'},
    Callback = function(v) Window:SetSize(NeverLose.Scales[v]) end,
})

-- ========================================
-- ===== ЗАПУСК =====
-- ========================================

Window:ToggleInterface()
startMainUpdate()
setupFlyKeys()
createFovCircle()
createChinaHatDrawings()

notify("Planet Hub", "Загружен! Нажми J", 4)
print("✅ PLANET HUB LOADED!")
