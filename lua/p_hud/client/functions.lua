local themes = themes or {}
local currentTheme = "default"

function Prisel.HUD:RegisterTheme(name, fcDraw)
    themes[name] = fcDraw
end

function Prisel.HUD:SetTheme(theme)
    if not themes[theme] then
        error("Theme " .. theme .. " does not exist")
    end

    currentTheme = theme
end

function Prisel.HUD:GetCurrentTheme()
    return currentTheme
end

function Prisel.HUD:GetThemeByName(name)
    return themes[name]
end

function Prisel.HUD.DrawCurrentTheme()

    if not themes[currentTheme] then
        error("Theme " .. currentTheme .. " does not exist")
        Prisel.HUD:SetTheme("default")
    end

    themes[currentTheme]()
end