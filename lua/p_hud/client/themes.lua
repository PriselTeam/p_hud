local LPlayer = nil
local defaultOffset = 50
local iDrawing = 0

local icons = {
    ["health"] = Material("prisel/hud/icons/heart.png", "noclamp smooth"),
    ["armor"] = Material("prisel/hud/icons/shield.png", "noclamp smooth"),
    ["food"] = Material("prisel/hud/icons/hamb.png", "noclamp smooth"),
    ["prisel"] = Material("prisel/hud/icons/prisel_rounded_logo.png", "noclamp smooth"),
    ["prisel_rect"] = Material("prisel/hud/icons/prisel_rect_logo.png", "noclamp smooth"),
    ["money"] = Material("prisel/hud/icons/money.png", "noclamp smooth")
}

local iHealthLerp = 0
local iArmorLerp = 0
local iFoodLerp = 0
local iMoneyLerp = 0

Prisel.HUD:RegisterTheme("old", function()

    if not IsValid(LPlayer) then
        LPlayer = LocalPlayer()
    end

    if not IsValid(LPlayer) then return end
    if not LPlayer:Alive() then return end

    -- Food
    local iFood = math.Remap(LPlayer:getDarkRPVar("Energy"), 0, 100, 0, 200)
    iFoodLerp = math.Clamp((iFoodLerp and Lerp(math.ease.OutQuad(0.02), iFoodLerp, iFood) or 0), 0, 200)
    
    draw.RoundedBox(8, RX(20), RY(1020), RX(30), RY(30), PLib.Constants.Colors["background"])
    draw.RoundedBox(8, RX(70), RY(1020), RX(200), RY(25), PLib.Constants.Colors["background"])
    draw.RoundedBox(8, RX(70), RY(1020), RX(iFoodLerp), RY(25), PLib.Constants.Colors["orange"])
    draw.SimpleText(LPlayer:getDarkRPVar("Energy"), PLib:Font("SemiBold", 20), RX(170), RY(1020 + (25/2) ), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["food"])
    surface.DrawTexturedRect(RX(25), RY(1025), RX(20), RY(20))

    iDrawing = iDrawing + 1

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
        surface.DrawTexturedRect(RX(25), RY(1025 - (50*iDrawing)), RX(20), RY(20))
        
        iDrawing = iDrawing + 1

    end

    -- Health
    local iHealth = math.Remap(LPlayer:Health(), 0, 100, 0, 200)
    iHealthLerp = math.Clamp((iHealthLerp and Lerp(math.ease.OutQuad(0.02), iHealthLerp, iHealth) or 0), 0, 200)

    draw.RoundedBox(8, RX(20), RY(1020 - (50*iDrawing)), RX(30), RY(30), PLib.Constants.Colors["background"])
    draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)), RX(200), RY(25), PLib.Constants.Colors["background"])
    draw.RoundedBox(8, RX(70), RY(1020 - (50*iDrawing)), RX(iHealthLerp), RY(25), PLib.Constants.Colors["red"])
    draw.SimpleText(LPlayer:Health(), PLib:Font("SemiBold", 20), RX(170), RY(1031 - (50*iDrawing)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["health"])
    surface.DrawTexturedRect(RX(25), RY(1025 - (50*iDrawing)), RX(20), RY(20))

    iDrawing = iDrawing + 1

    iDrawing = 0

    -- Prisel Logo
    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["prisel_rect"])
    surface.DrawTexturedRect(RX(1852), RY(1020), RX(30), RY(30))

    draw.RoundedBox(8, RX(1622), RY(1020), RX(200), RY(30), PLib.Constants.Colors["background"])
    draw.SimpleText("PRISEL.FR", PLib:Font("SemiBold", 24), RX(1722), RY(1020 + (30/2 - 1)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    -- Money
    draw.RoundedBox(8, RX(1852), RY(970), RX(30), RY(30), PLib.Constants.Colors["background"])

    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["money"])
    surface.DrawTexturedRect(RX(1857), RY(975), RX(20), RY(20))

    iMoneyLerp = Lerp(math.ease.OutQuad(0.02), iMoneyLerp, LPlayer:getDarkRPVar("money") or 0)

    draw.RoundedBox(8, RX(1622), RY(970), RX(200), RY(30), PLib.Constants.Colors["background"])
    draw.SimpleText(DarkRP.formatMoney(math.Round(iMoneyLerp)), PLib:Font("SemiBold", 22), RX(1722), RY(970 + (30/2 - 1)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    -- Name
    draw.RoundedBox(8, RX(1622), RY(920), RX(200), RY(30), PLib.Constants.Colors["background"])

    surface.SetFont(PLib:Font("SemiBold", 22))

    local iTextWidth, iTextHeight = surface.GetTextSize(LPlayer:Nick())

    if iTextWidth > RX(200) then
        draw.SimpleText(LPlayer:Nick(), PLib:Font("SemiBold", 18), RX(1722), RY(920 + (30/2 - 1)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(LPlayer:Nick(), PLib:Font("SemiBold", 22), RX(1722), RY(920 + (30/2 - 1)), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

local iHealthLerpPos = 68
local iArmorLerpPos = 68
local iFoodLerpPos = 68

Prisel.HUD:RegisterTheme("default", function()

    if not IsValid(LPlayer) then
        LPlayer = LocalPlayer()
    end

    if not IsValid(LPlayer) then return end
    if not LPlayer:Alive() then return end

    local iHealth = math.Remap(LPlayer:Health(), 0, LPlayer:GetMaxHealth(), 0, 360)
    iHealthLerp = math.Clamp((iHealthLerp and Lerp(math.ease.OutQuad(0.02), iHealthLerp, iHealth) or 0), 0, 360)

    local iArmor = math.Remap(LPlayer:Armor(), 0, 100, 0, 360)
    iArmorLerp = math.Clamp((iArmorLerp and Lerp(math.ease.OutQuad(0.02), iArmorLerp, iArmor) or 0), 0, 360)

    local iFood = math.Remap(LPlayer:getDarkRPVar("Energy"), 0, 100, 0, 360)
    iFoodLerp = math.Clamp((iFoodLerp and Lerp(math.ease.OutQuad(0.02), iFoodLerp, iFood) or 0), 0, 360)

    local iOffset = defaultOffset

    -- Health
    PLib:DrawCircle(RX(68), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
    PLib:DrawCircle(RX(68), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
    PLib:DrawArc(RX(68), RY(1006), 0, iHealthLerp, RX(34), PLib.Constants.Colors["red"], 90)

    PLib:DrawCircle(RX(68), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

    draw.SimpleText(LPlayer:Health(), PLib:Font("SemiBold", 18), RX(68), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    iDrawing = iDrawing + 1

    if (LPlayer:Armor() ~= nil and LPlayer:Armor() > 0) then

        iArmorLerpPos = Lerp(math.ease.OutQuad(0.02), iArmorLerpPos, (68 + (104 * iDrawing)))

        PLib:DrawCircle(RX(iArmorLerpPos), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
        PLib:DrawCircle(RX(iArmorLerpPos), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
        PLib:DrawArc(RX(iArmorLerpPos), RY(1006), 0, iArmorLerp, RX(34), PLib.Constants.Colors["blue"], 90)

        PLib:DrawCircle(RX(iArmorLerpPos), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

        draw.SimpleText(LPlayer:Armor(), PLib:Font("SemiBold", 18), RX(iArmorLerpPos), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
        iDrawing = iDrawing + 1
    else
        iArmorLerpPos = 68
    end

    -- Food

    iFoodLerpPos = Lerp(math.ease.OutQuad(0.02), iFoodLerpPos, (68 + (104 * iDrawing)))

    PLib:DrawCircle(RX(iFoodLerpPos), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)
    PLib:DrawCircle(RX(iFoodLerpPos), RY(1006), RX(34), PLib.Constants.Colors["hoverBlue"], 90)
    PLib:DrawArc(RX(iFoodLerpPos), RY(1006), 0, iFoodLerp, RX(34), PLib.Constants.Colors["orange"], 90)

    PLib:DrawCircle(RX(iFoodLerpPos), RY(1006), RX(24), PLib.Constants.Colors["background"], 90)

    draw.SimpleText(LPlayer:getDarkRPVar("Energy"), PLib:Font("SemiBold", 18), RX(iFoodLerpPos), RY(1006), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    iDrawing = 0

    -- Prisel
    PLib:DrawCircle(RX(1852), RY(1006), RX(44), PLib.Constants.Colors["background"], 90)

    surface.SetDrawColor(color_white)
    surface.SetMaterial(icons["prisel"])
    surface.DrawTexturedRect(RX(1852 - 64/2), RY(966 + 64/8), RX(64), RY(64))
end)