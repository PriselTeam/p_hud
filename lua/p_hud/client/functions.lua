local themes = {}
local currentTheme = {}

function Prisel.HUD.SaveCurrentTheme()
    if not currentTheme then return end

    if not file.Exists("prisel/hud/", "DATA") then
        file.CreateDir("prisel/hud/")
    end

    file.Write("prisel/hud/theme.txt", currentTheme.Name)

    return currentTheme
end

function Prisel.HUD.LoadTheme()
    if not file.Exists("prisel/hud/theme.txt", "DATA") then return end

    local theme = file.Read("prisel/hud/theme.txt", "DATA")

    if not themes[theme] then return end

    currentTheme = theme.name

    return theme
end

function Prisel.HUD.AddTheme(cname, drawing)
    themes[cname] = {}
    themes[cname].name = cname
    themes[cname].Draw = drawing
end

function Prisel.HUD.GetThemes()
    return themes
end

function Prisel.HUD.SetTheme(name)
    currentTheme = themes[name]
end

function Prisel.HUD.GetCurrentTheme(fallback)

    if not currentTheme then
        if fallback then
            Prisel.HUD.SetTheme(fallback)
            return themes[fallback]
        end
    return end

    return currentTheme

end

function Prisel.HUD.DrawTheme(name)
    if not themes[name] then return end

    themes[name].Draw()
end