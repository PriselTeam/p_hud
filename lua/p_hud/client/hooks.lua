hook.Add("HUDShouldDraw", "Prisel:HUD:Hook:HUDShouldDraw", function(name)
    if (Prisel.HUD.Constants.HidedElements[name]) then return false end
end)

hook.Add("HUDPaint", "Prisel:HUD:Hook:HUDPaint", function()
    Prisel.HUD.DrawCurrentTheme()
    Prisel.HUD.DrawNotification()
end)

concommand.Add("prisel_hud_set_theme", function(ply, cmd, args)
    Prisel.HUD:SetTheme(args[1])
end)

Prisel.HUD.Notification = {}


function notification.AddLegacy(sText, sType, iTime)
    if Prisel.HUD.Notification[sText] then return end

    local iCount = #Prisel.HUD.Notification

    c = {
        sText = sText,
        sType = sType,
        iTime = iTime,
        iStart = CurTime(),
        iEnd = CurTime() + iTime,
        iAlpha = 255,
        iXPos = 2300,
        iYPos = (iCount + 1) * 60,
        iPosition = iCount + 1
    }

    table.insert(Prisel.HUD.Notification, c)
end

local prisel_rect = Material("prisel/hud/icons/prisel_rect_logo.png", "noclamp smooth")

function Prisel.HUD.DrawNotification()
    for k, v in ipairs(Prisel.HUD.Notification) do
        if v.iEnd < CurTime() then
            v.iAlpha = Lerp(math.ease.OutQuad(0.01), v.iAlpha, 0)
            v.iXPos = Lerp(math.ease.OutQuad(0.01), v.iXPos, 2500)

            if v.iAlpha < 80 then
                table.remove(Prisel.HUD.Notification, k)
            end
        else
            v.iXPos = Lerp(math.ease.OutQuad(0.01), v.iXPos, 1800)
            v.iYPos = Lerp(math.ease.OutQuad(0.01), v.iYPos, k * 60)
        end

        surface.SetFont(PLib:Font("SemiBold", 18))
        local iTextWidth, iTextHeight = surface.GetTextSize(v.sText)


        draw.RoundedBox(8, RX(v.iXPos - iTextWidth), RY(v.iYPos), RX((50 + iTextWidth + 20)), RY(50), ColorAlpha(PLib.Constants.Colors["background"], v.iAlpha))
        draw.RoundedBox(8, RX(v.iXPos - iTextWidth), RY(v.iYPos), RX(50), RY(50), ColorAlpha(PLib.Constants.Colors["blue"], v.iAlpha))
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(prisel_rect)
        surface.DrawTexturedRect(RX(v.iXPos - iTextWidth), RY(v.iYPos + 50/2 - 25), RX(50), RY(50))

        draw.SimpleText(v.sText, PLib:Font("SemiBold", 18), RX(v.iXPos + 50 + 10), RX(v.iYPos + 50/2 - 1), ColorAlpha(color_white, v.iAlpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end
end