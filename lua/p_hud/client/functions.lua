function Prisel.HUD:ShouldBeHidden(name)
    return not Prisel.HUD.Constants.HidedElements[name]
end