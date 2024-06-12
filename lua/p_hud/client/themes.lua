local LPlayer = nil
local defaultOffset = 50
local iDrawing = 0

local icons = {
    ["health"] = Material("prisel/hud/icons/heart.png", "noclamp smooth"),
    ["armor"] = Material("prisel/hud/icons/shield.png", "noclamp smooth"),
    ["food"] = Material("prisel/hud/icons/hamb.png", "noclamp smooth"),
    ["prisel"] = Material("prisel/hud/icons/prisel_rounded_logo.png", "noclamp smooth")
}

local iHealthLerp = 0
local iArmorLerp = 0
local iFoodLerp = 0


-- TODO: Old theme
Prisel.HUD:RegisterTheme("old", function()

    if not IsValid(LPlayer) then
        LPlayer = LocalPlayer()
    end

    if not IsValid(LPlayer) then return end
    if not LPlayer:Alive() then return end

    -- Food
    if (LPlayer:getDarkRPVar("Energy") ~= nil and LPlayer:getDarkRPVar("Energy") > 0) then
        local iFood = math.Remap(LPlayer:getDarkRPVar("Energy"), 0, 100, 0, 200)
        iFoodLerp = math.Clamp((iFoodLerp and Lerp(math.ease.OutQuad(0.02), iFoodLerp, iFood) or 0), 0, 200)
        
        draw.RoundedBox(8, RX(20), RY(1017), RX(30), RY(30), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020), RX(200), RY(25), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020), RX(iFoodLerp), RY(25), PLib.Constants.Colors["orange"])
        draw.SimpleText(LPlayer:getDarkRPVar("Energy"), PLib:Font("SemiBold", 20), RX(170), RY(1020 + (25/2) ), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(icons["food"])
        surface.DrawTexturedRect(RX(25), RY(1021), RX(22), RY(22))
        
        iDrawing = iDrawing + 1
    end

    -- Armor
    if (LPlayer:Armor() ~= nil and LPlayer:Armor() > 0) then
        local iArmor = math.Remap(LPlayer:Armor(), 0, 100, 0, 200)
        iArmorLerp = math.Clamp((iArmorLerp and Lerp(math.ease.OutQuad(0.02), iArmorLerp, iArmor) or 0), 0, 200)

        draw.RoundedBox(8, RX(20), RY(1020 - (50*iDrawing)), RX(30), RY(30), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)), RX(200), RY(25), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)) , RX(iArmorLerp), RY(25), PLib.Constants.Colors["blue"])
        draw.SimpleText(LPlayer:Armor(), PLib:Font("SemiBold", 20), RX(170), RY(1031 - (50*iDrawing)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(icons["armor"])
        surface.DrawTexturedRect(RX(25), RY(1021 - (47*iDrawing)), RX(22), RY(22))

        iDrawing = iDrawing + 1
    end

    -- Health
    if (LPlayer:Health() ~= nil and LPlayer:Health() > 0) then
        local iHealth = math.Remap(LPlayer:Health(), 0, 100, 0, 200)
        iHealthLerp = math.Clamp((iHealthLerp and Lerp(math.ease.OutQuad(0.02), iHealthLerp, iHealth) or 0), 0, 200)

        draw.RoundedBox(8, RX(20), RY(1020 - (50*iDrawing)), RX(30), RY(30), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)), RX(200), RY(25), PLib.Constants.Colors["background"])
        draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)), RX(iHealthLerp), RY(25), PLib.Constants.Colors["red"])
        draw.SimpleText(LPlayer:Health(), PLib:Font("SemiBold", 20), RX(170), RY(1031 - (50*iDrawing)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(icons["health"])
        surface.DrawTexturedRect(RX(25), RY(1021 - (48*iDrawing)), RX(22), RY(22))

        
        iDrawing = iDrawing + 1
    end

    iDrawing = 0

    -- Name
    draw.RoundedBox(8, RX(1650), RY(920), RX(250), RY(30), PLib.Constants.Colors["background"])


end)

Prisel.HUD:RegisterTheme("default", function()

    if not IsValid(LPlayer) then
        LPlayer = LocalPlayer()
    end

    if not IsValid(LPlayer) then return end
    if not LPlayer:Alive() then return end

    local iHealth = math.Remap(LPlayer:Health(), 0, 100, 0, 360)
    iHealthLerp = (iHealthLerp and Lerp(math.ease.OutQuad(0.02), iHealthLerp, iHealth) or 0)

    local iArmor = math.Remap(LPlayer:Armor(), 0, 100, 0, 360)
    iArmorLerp = (iArmorLerp and Lerp(math.ease.OutQuad(0.02), iArmorLerp, iArmor) or 0)

    local iFood = math.Remap(LPlayer:getDarkRPVar("Energy"), 0, 100, 0, 360)
    iFoodLerp = (iFoodLerp and Lerp(math.ease.OutQuad(0.02), iFoodLerp, iFood) or 0)

    local iOffset = defaultOffset

    -- Health
    PLib:DrawCircle(RX(68), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
    PLib:DrawCircle(RX(68), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
    PLib:DrawArc(RX(68), RY(1006), 0, iHealthLerp, RX(34), PLib.Constants.Colors["red"], 90)

    PLib:DrawCircle(RX(68), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

    draw.SimpleText(LPlayer:Health(), PLib:Font("SemiBold", 18), RX(68), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    -- Armor
    PLib:DrawCircle(RX(172), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
    PLib:DrawCircle(RX(172), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
    PLib:DrawArc(RX(172), RY(1006), 0, iArmorLerp, RX(34), PLib.Constants.Colors["blue"], 90)

    PLib:DrawCircle(RX(172), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

    draw.SimpleText(LPlayer:Armor(), PLib:Font("SemiBold", 18), RX(172), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    -- Food
    PLib:DrawCircle(RX(276), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
    PLib:DrawCircle(RX(276), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
    PLib:DrawArc(RX(276), RY(1006), 0, iFoodLerp, RX(34), PLib.Constants.Colors["orange"], 90)

    PLib:DrawCircle(RX(276), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

    draw.SimpleText(LPlayer:getDarkRPVar("Energy"), PLib:Font("SemiBold", 18), RX(276), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    

    -- Prisel
    PLib:DrawCircle(RX(1852), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)

    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["prisel"])
    surface.DrawTexturedRect(RX(1852 - 64/2), RY(966 + 64/8), RX(64), RY(64))
end)