Prisel = Prisel or {}
Prisel.HUD = Prisel.HUD or {}

local function I(sFile) return include("p_hud/"..sFile) end
local function A(sFile) return AddCSLuaFile("p_hud/"..sFile) end
local function IA(sFile) return I(sFile), A(sFile) end


if SERVER then
    A("client/constants.lua")
    A("client/functions.lua")
    A("client/hooks.lua")
    A("client/themes.lua")
else
    I("client/constants.lua")
    I("client/functions.lua")
    I("client/hooks.lua")
    I("client/themes.lua")
end