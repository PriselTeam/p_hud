hook.Add("HUDShouldDraw", "Prisel:HUD:Hook:HUDShouldDraw", function(name)
    Prisel.HUD:ShouldBeHidden(name)
end)