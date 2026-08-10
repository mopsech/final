-- ========================================
-- ===== PLANET HUB (РАБОЧИЙ КАРКАС) =====
-- ========================================

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/refs/heads/main/source.luau"))()

-- ========================================
-- ===== СОЗДАНИЕ ОКНА =====
-- ========================================

local Window = NeverLose:CreateWindow({
    Name = "Planet Hub",
    Content = "v3.0",
    Size = UDim2.fromOffset(800, 600),
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
    Default = false,
    Callback = function(v) print("Murder ESP:", v) end
})
MurderESP:AddColorPicker({
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(c) print("Murder Color:", c) end
})

local SheriffESP = ESPSection:AddLabel("Sheriff ESP")
SheriffESP:AddToggle({
    Default = false,
    Callback = function(v) print("Sheriff ESP:", v) end
})
SheriffESP:AddColorPicker({
    Default = Color3.fromRGB(0, 0, 255),
    Callback = function(c) print("Sheriff Color:", c) end
})

local InnocentESP = ESPSection:AddLabel("Innocent ESP")
InnocentESP:AddToggle({
    Default = false,
    Callback = function(v) print("Innocent ESP:", v) end
})
InnocentESP:AddColorPicker({
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(c) print("Innocent Color:", c) end
})

ESPSection:AddLabel("Tracers"):AddToggle({
    Default = false,
    Callback = function(v) print("Tracers:", v) end
})
ESPSection:AddColorPicker({
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) print("Tracers Color:", c) end
})

-- Chams
local ChamsSection = VisualsTab:AddSection({Name = "Chams", Position = "Right"})
ChamsSection:AddLabel("Enable Chams"):AddToggle({
    Default = false,
    Callback = function(v) print("Chams:", v) end
})
ChamsSection:AddColorPicker({
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(c) print("Chams Color:", c) end
})
ChamsSection:AddLabel("RGB Humanoid"):AddToggle({
    Default = false,
    Callback = function(v) print("RGB Humanoid:", v) end
})

-- Effects
local EffectsSection = VisualsTab:AddSection({Name = "Effects", Position = "Left"})
EffectsSection:AddLabel("Jump Circles"):AddToggle({
    Default = false,
    Callback = function(v) print("Jump Circles:", v) end
})
EffectsSection:AddColorPicker({
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) print("Jump Circles Color:", c) end
})
EffectsSection:AddLabel("Trails"):AddToggle({
    Default = false,
    Callback = function(v) print("Trails:", v) end
})
EffectsSection:AddColorPicker({
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) print("Trails Color:", c) end
})
EffectsSection:AddLabel("XRay"):AddToggle({
    Default = false,
    Callback = function(v) print("XRay:", v) end
})
EffectsSection:AddLabel("Bloom"):AddToggle({
    Default = false,
    Callback = function(v) print("Bloom:", v) end
})
EffectsSection:AddLabel("Vignette"):AddToggle({
    Default = false,
    Callback = function(v) print("Vignette:", v) end
})

-- China Hat
local ChinaSection = VisualsTab:AddSection({Name = "China Hat", Position = "Right"})
ChinaSection:AddLabel("Enable"):AddToggle({
    Default = false,
    Callback = function(v) print("China Hat:", v) end
})
ChinaSection:AddColorPicker({
    Default = Color3.fromRGB(0, 255, 255),
    Callback = function(c) print("China Hat Color:", c) end
})
ChinaSection:AddLabel("Rainbow"):AddToggle({
    Default = false,
    Callback = function(v) print("China Hat Rainbow:", v) end
})

-- Aura
local AuraSection = VisualsTab:AddSection({Name = "Aura", Position = "Left"})
AuraSection:AddLabel("Enable"):AddToggle({
    Default = false,
    Callback = function(v) print("Aura:", v) end
})
AuraSection:AddColorPicker({
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) print("Aura Color:", c) end
})

-- World
local WorldSection = VisualsTab:AddSection({Name = "World", Position = "Right"})
WorldSection:AddLabel("Orbiz"):AddToggle({
    Default = false,
    Callback = function(v) print("Orbiz:", v) end
})
WorldSection:AddLabel("Texture Pack"):AddToggle({
    Default = false,
    Callback = function(v) print("Texture Pack:", v) end
})
WorldSection:AddLabel("Stretch"):AddToggle({
    Default = false,
    Callback = function(v) print("Stretch:", v) end
})
WorldSection:AddSlider({
    Default = 75,
    Min = 50,
    Max = 100,
    Callback = function(v) print("Stretch Factor:", v) end
})

-- ========================================
-- ===== COMBAT TAB =====
-- ========================================

local CombatTab = Window:AddTab({Name = "Combat", Icon = "crosshairs"})

local CombatSection = CombatTab:AddSection({Name = "Combat", Position = "Left"})
CombatSection:AddLabel("Shoot Button"):AddToggle({
    Default = false,
    Callback = function(v) print("Shoot Button:", v) end
})
CombatSection:AddLabel("Sheriff Auto Shoot"):AddToggle({
    Default = false,
    Callback = function(v) print("Sheriff Auto Shoot:", v) end
})
CombatSection:AddLabel("Kill All"):AddToggle({
    Default = false,
    Callback = function(v) print("Kill All:", v) end
})
CombatSection:AddLabel("Fling Murderer"):AddToggle({
    Default = false,
    Callback = function(v) print("Fling Murderer:", v) end
})
CombatSection:AddLabel("Fling Sheriff"):AddToggle({
    Default = false,
    Callback = function(v) print("Fling Sheriff:", v) end
})
CombatSection:AddLabel("Grab Gun"):AddToggle({
    Default = false,
    Callback = function(v) print("Grab Gun:", v) end
})

local AimbotSection = CombatTab:AddSection({Name = "Aimbot", Position = "Right"})
AimbotSection:AddLabel("FOV Aimbot"):AddToggle({
    Default = false,
    Callback = function(v) print("FOV Aimbot:", v) end
})
AimbotSection:AddSlider({
    Default = 120,
    Min = 10,
    Max = 600,
    Callback = function(v) print("FOV Radius:", v) end
})
AimbotSection:AddSlider({
    Default = 50,
    Min = 1,
    Max = 100,
    Callback = function(v) print("Smoothness:", v) end
})
AimbotSection:AddLabel("Predict"):AddToggle({
    Default = true,
    Callback = function(v) print("Predict:", v) end
})
AimbotSection:AddLabel("Wall Check"):AddToggle({
    Default = true,
    Callback = function(v) print("Wall Check:", v) end
})

-- ========================================
-- ===== MOVEMENT TAB =====
-- ========================================

local MovementTab = Window:AddTab({Name = "Movement", Icon = "wind"})

local MovementSection = MovementTab:AddSection({Name = "Movement", Position = "Left"})
MovementSection:AddLabel("Fly"):AddToggle({
    Default = false,
    Callback = function(v) print("Fly:", v) end
})
MovementSection:AddSlider({
    Default = 50,
    Min = 10,
    Max = 200,
    Callback = function(v) print("Fly Speed:", v) end
})
MovementSection:AddLabel("BHop"):AddToggle({
    Default = false,
    Callback = function(v) print("BHop:", v) end
})
MovementSection:AddSlider({
    Default = 30,
    Min = 10,
    Max = 80,
    Callback = function(v) print("BHop Speed:", v) end
})
MovementSection:AddLabel("Spin Bot"):AddToggle({
    Default = false,
    Callback = function(v) print("Spin Bot:", v) end
})
MovementSection:AddSlider({
    Default = 9999,
    Min = 100,
    Max = 20000,
    Callback = function(v) print("Spin Speed:", v) end
})
MovementSection:AddLabel("Noclip"):AddToggle({
    Default = false,
    Callback = function(v) print("Noclip:", v) end
})
MovementSection:AddLabel("Anti-Fling"):AddToggle({
    Default = false,
    Callback = function(v) print("Anti-Fling:", v) end
})
MovementSection:AddLabel("Wall Hop"):AddToggle({
    Default = false,
    Callback = function(v) print("Wall Hop:", v) end
})

-- ========================================
-- ===== FARM TAB =====
-- ========================================

local FarmTab = Window:AddTab({Name = "Farm", Icon = "tractor"})

local FarmSection = FarmTab:AddSection({Name = "Auto Farm", Position = "Left"})
FarmSection:AddLabel("Enable"):AddToggle({
    Default = false,
    Callback = function(v) print("Auto Farm:", v) end
})
FarmSection:AddLabel("Auto Respawn"):AddToggle({
    Default = true,
    Callback = function(v) print("Auto Respawn:", v) end
})
FarmSection:AddSlider({
    Default = 20,
    Min = 5,
    Max = 50,
    Callback = function(v) print("Farm Speed:", v) end
})
FarmSection:AddSlider({
    Default = 40,
    Min = 10,
    Max = 100,
    Callback = function(v) print("Coin Limit:", v) end
})

-- ========================================
-- ===== ANIMATIONS TAB =====
-- ========================================

local AnimationsTab = Window:AddTab({Name = "Animations", Icon = "music"})

local AnimSection = AnimationsTab:AddSection({Name = "Animations", Position = "Left"})
AnimSection:AddLabel("Enable"):AddToggle({
    Default = false,
    Callback = function(v) print("Animations:", v) end
})

local AnimGridSection = AnimationsTab:AddSection({Name = "Select Pack", Position = "Right"})
for _, packName in ipairs(ANIM_PACK_NAMES) do
    AnimGridSection:AddButton({
        Name = packName,
        Callback = function() print("Selected:", packName) end
    })
end

-- ========================================
-- ===== FUN TAB =====
-- ========================================

local FunTab = Window:AddTab({Name = "Fun", Icon = "smile"})

local FunSection = FunTab:AddSection({Name = "Fun", Position = "Left"})
FunSection:AddLabel("Jerk"):AddToggle({
    Default = false,
    Callback = function(v) print("Jerk:", v) end
})
FunSection:AddLabel("Anti-AFK"):AddToggle({
    Default = false,
    Callback = function(v) print("Anti-AFK:", v) end
})
FunSection:AddButton({
    Name = "Rejoin",
    Callback = function() print("Rejoin") end
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

Window:ToggleInterface()
print("✅ PLANET HUB LOADED!")
