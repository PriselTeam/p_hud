Prisel = Prisel or {}
Prisel.HUD = Prisel.HUD or {}

local function I(sFile) return include("p_hud/"..sFile) end
local function A(sFile) return AddCSLuaFile("p_hud/"..sFile) end
local function IA(sFile) return I(sFile), A(sFile) end


if SERVER then
    A("client/functions.lua")
    A("client/hooks.lua")
else
    I("client/functions.lua")
    I("client/hooks.lua")
    I("client/constants.lua")
end