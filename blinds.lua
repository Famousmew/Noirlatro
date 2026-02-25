-- Noirlatro Was made by FamousmewYT-JP. Please do not use any of my code without asking me first! If you see some code you would like to use, please feel free to let me know by DM'ing me on Discord "@famousmewyt_jp". Thanks!

local TAN = {0.82, 0.72, 0.55, 1}
local DARK_GREY = {0.25, 0.25, 0.25, 1}
SMODS.Blind{
key = "one_one_highcard",
unlocked = true, -- This should make it start out automatically unlocked I think (I always forgor to add those damn commas...)
boss = {min = 1, max = 39},
atlas = "one_one_highcard",
pos = { x = 0, y = 0 },
dollars = 10,
mult = 0.5,
colour = TAN,
color = TAN,
boss_colour = TAN,
boss_color = TAN,
loc_txt = {
name = "1-1",
text = {
"High Card or Die."
}
},
set_blind = function(self)
G.noir_triggered_video = false
end,
in_pool = function(self)
if G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante then
if G.GAME.round_resets.ante % 8 == 0 then -- This should make it not appear on Antes 8, 16, 24, 32 and 38.
return false
end
end
return true
end,
calculate = function(self, blind, context)
if context.cardarea == G.play and context.scoring_name then
if context.scoring_name ~= "High Card" and not G.noir_triggered_video then
G.FUNCS.noir_lose_logic = function(e)
G.GAME.chips = 0
G.GAME.current_round.hands_left = 0
G.GAME.current_round.discards_left = 0
G.FUNCS.exit_overlay_menu()
G.STATE = G.STATES.GAME_OVER
G.STATE_COMPLETE = false
end
G.noir_triggered_video = true
local vid_name = "lose_1-1.ogv"
local file_path = SMODS.Mods["noirlatro"].path.."/assets/video/"..vid_name
local file = NFS.read(file_path)
love.filesystem.write("temp.ogv", file)
local video_file = love.graphics.newVideo('temp.ogv')
local vid_sprite = Sprite(0, 0, 11*16/9, 11, G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
video_file:getSource():setVolume(G.SETTINGS.SOUND.volume * G.SETTINGS.SOUND.game_sounds_volume / (100 * 10))
vid_sprite.video = video_file
video_file:play()
local video_ui = create_UIBox_generic_options({
back_delay = 2,
back_func = 'noir_lose_logic',
back_label = "LMAO",
colour = G.C.BLACK,
padding = 0,
contents = {{n = G.UIT.O, config = {object = vid_sprite}}}
})
G.FUNCS.overlay_menu{
definition = video_ui
}
return {
message = "Fuck You.",
colour = G.C.RED
}
end
end
end
}

-- DO NOT CHANGE ANYTHING FOR 1-1 IT FINALLY FUCKING WORKS THIS IS DONE!!

SMODS.Blind{
key = 'laggy_stream',
unlocked = true,
atlas = "laggy_stream",
pos = { x = 0, y = 0 },
loc_txt = {
name = 'Laggy Ass Stream',
text = { 'Game Speed set to X0.25' }
},
boss = { showup = true, viewable = true },
config = { mult = 2 },
colour = DARK_GREY,
color = DARK_GREY,
boss_colour = DARK_GREY,
boss_color = DARK_GREY,
vars = function(self, info_queue, card)
return { vars = {} }
end,
in_pool = function(self, args)
if not args then return true end
if args.ante > 39 then return false end
if args.ante % 8 == 0 then return false end
return true
end,
set_blind = function(self)
self.prev_speed = G.SETTINGS.GAMESPEED or 1
G.SETTINGS.GAMESPEED = 0.25
end,
disable = function(self)
G.SETTINGS.GAMESPEED = self.prev_speed or 1
end,
defeat = function(self)
G.SETTINGS.GAMESPEED = self.prev_speed or 1
end,
withdraw = function(self)
G.SETTINGS.GAMESPEED = self.prev_speed or 1
end
}
