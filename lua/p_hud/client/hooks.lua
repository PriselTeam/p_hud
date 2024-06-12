hook.Add("HUDShouldDraw", "Prisel:HUD:Hook:HUDShouldDraw", function(name)
    return not Prisel.HUD.Constants.HidedElements[name]
end)

hook.Add("HUDPaint", "Prisel:HUD:Hook:HUDPaint", function()
    Prisel.HUD.DrawCurrentTheme()
end)

concommand.Add("prisel_hud_set_theme", function(ply, cmd, args)
    Prisel.HUD:SetTheme(args[1])
end)