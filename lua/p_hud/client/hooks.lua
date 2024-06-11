hook.Add("HUDShouldDraw", "Prisel:HUD:Hook:HUDShouldDraw", function(name)
    return not Prisel.HUD.Constants.HidedElements[name]
end)

hook.Add("HUDPaint", "Prisel:HUD:Hook:HUDPaint", function()
    Prisel.HUD.DrawTheme("old")
end)