-- Noirlatro Was made by FamousmewYT-JP. Please do not use any of my code without asking me first! If you see some code you would like to use, please feel free to let me know by DM'ing me on Discord "@famousmewyt_jp". Thanks!

assert(SMODS.load_file("video_overlay.lua"))() -- Always First
assert(SMODS.load_file("atlases.lua"))() -- Always Before jokers.lua and blinds.lua. ALWAYS.
assert(SMODS.load_file("jokers.lua"))()
assert(SMODS.load_file("hands.lua"))()
assert(SMODS.load_file("consumable.lua"))()
assert(SMODS.load_file("blinds.lua"))()

local noirlatro_conf = SMODS.current_mod
function noirlatro_conf.post_executable()
if G.P_CENTERS then
for k, v in pairs(G.P_CENTERS) do
if v.mod and (v.mod.id == 'noirlatro' or v.mod.id == 'noir') then
v.unlocked = true
v.discovered = true
v.alerted = true
unlock_card(v)
discover_card(v)
end
end
end
end