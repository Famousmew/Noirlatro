-- Noirlatro Was made by FamousmewYT-JP. Please do not use any of my code without asking me first! If you see some code you would like to use, please feel free to let me know by DM'ing me on Discord "@famousmewyt_jp". Thanks!
-- Anyone who decides to look at my fuck ass code I'm so so sorry. It's kinda bad. But look, not having the indentation makes it REALLY easy for me to do debugging.

SMODS.Joker{
key = "plus_four_mult",
name = "Sanity Check Joker",
unlocked = true,
config = {},
loc_txt = {
name = "Sanity Check Joker",
text = {
"{C:mult}+10{} Mult"
}
},
rarity = 1,
cost = 0,

calculate = function(self, card, context)
if context.joker_main then
return {
mult = 10
}
end
end
}

SMODS.Joker{
key = "kms",
unlocked = true,
atlas = "kms_joker",
pos = { x = 0, y = 0 },

loc_txt = {
name = "Is it better just to KMS?",
text = {
"Prevents death if Chips are at least {C:attention}#1#%{}",
"of the Blind requirement."
}
},

rarity = 3,
cost = 7,

config = {extra = { threshold = 0.75 } },

loc_vars = function(self, info_queue, card)
local t = (card and card.ability and card.ability.extra and card.ability.extra.threshold) or 0.75
return { vars = { math.floor(t * 100 + 0.5) } } -- Ok yeah 75%
end,

calculate = function(self, card, context)
if context.game_over and G.GAME and G.GAME.blind then
local required = G.GAME.blind.chips
local scored = G.GAME.chips
local t = card.ability.extra.threshold

-- Haha loser
if required and scored and scored < required and scored >= required * t then
-- I think this is how it works?
G.GAME.chips = required

return {
message = "Is it better just to kms?", -- Trust me it's a neiche meme you wouldn't understand
colour = G.C.Money, 
saved = true,
}
end
end
end
}

SMODS.Joker{
key = "noir",
unlocked = true,
-- atlas = "noir_joker",         -- No image so set like this so it doesn't give a stack traceback every time you open the game
-- pos = { x = 0, y = 0 },
rarity = 4,
cost = 15,
config = { extra = { x_mult = 1.5, scaling = 0.5, current_x_mult = 1.5 } },
loc_vars = function(self, info_queue, card)
return { vars = { card.ability.extra.x_mult, card.ability.extra.scaling, card.ability.extra.current_x_mult }}
end,
loc_txt = {
name = "Noir Heart",
text = {
"Each played {C:attention}Red Seal{}, {C:attention}Steel{},",
"{C:attention}King{}, or {C:hearts}Heart{} card scored",
"or held in hand gives {X:mult,C:white}x#3#{} XMult.",
"{C:inactive}(Increases by {X:mult,C:white}x#2#{} per trigger){}",
"{C:inactive}(Resets after Boss Blind){}"
}
},
calculate = function(self, card, context)   -- Card Type Detection thingy
if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
local target = context.other_card
if target.seal == 'Red' or target.config.center == G.P_CENTERS.m_steel or target:get_id() == 13 or target:is_suit('Hearts') then
local usage_mult = card.ability.extra.current_x_mult
card.ability.extra.current_x_mult = card.ability.extra.current_x_mult + card.ability.extra.scaling
return {
x_mult = usage_mult,
card = card
}
end
end
if context.end_of_round and G.GAME.blind.boss and not context.blueprint then -- This. Shit. Took. FOREVER. I had to scratch an ENTIRE JOKER JUST TO GET THIS SHIT TO WORK
card.ability.extra.current_x_mult = card.ability.extra.x_mult
attention_text({
text = 'Reset',
colour = G.C.FILTER,
scale = 0.45, 
hold = 0.8,
major = card
})
end
end
}

SMODS.Joker{  -- Atlas is ready, Awaitng Debugging.
key = "nub",
unlocked = true,
atlas = "nub_joker",
pos = { x = 0, y = 0 },
rarity = 3,
cost = 7,
config = { extra = { x_mult = 1 } },
loc_vars = function(self, info_queue, card)
local current_speed = G.SETTINGS.GAMESPEED or 1
local display_mult = 1
if current_speed <= 0.25 then 
display_mult = 5
elseif current_speed <= 0.5 then 
display_mult = 4
elseif current_speed <= 1 then 
display_mult = 3
elseif current_speed <= 2 then 
display_mult = 2
else 
display_mult = 1
end
return { vars = { display_mult, current_speed } }
end,
loc_txt = {
name = "Butternub",
text = {
"Gives {X:mult,C:white}x#1#{} Mult based",
"on current {C:attention}Game Speed{}",
"{C:inactive}(Currently {X:mult,C:white}x#1#{} at speed #2#){}",
"{C:inactive}Lower speed = Higher Mult{}"
}
},
calculate = function(self, card, context)
if context.joker_main then
local current_speed = G.SETTINGS.GAMESPEED or 1
local final_x_mult = 1

if current_speed <= 0.25 then
final_x_mult = 5
elseif current_speed <= 0.5 then
final_x_mult = 4
elseif current_speed <= 1 then
final_x_mult = 3
elseif current_speed <= 2 then
final_x_mult = 2
else
final_x_mult = 1
end

if final_x_mult > 1 then
return {
message = 'x' .. final_x_mult,
x_mult = final_x_mult
}
end
end
end
}

SMODS.Joker{
key = "kumo",
unlocked = true,
atlas = "kumo_joker",
pos = { x = 0, y = 0 },
rarity = 4,
cost = 10,
config = { extra = { x_mult = 1.5, scaling = 0.5, current_x_mult = 1.5 } },
loc_vars = function(self, info_queue, card)
return { vars = { card.ability.extra.x_mult, card.ability.extra.scaling, card.ability.extra.current_x_mult }}
end,
loc_txt = {
name = "Kumo",
text = {
"Each played {C:attention}Red Seal{}, {C:attention}Steel{},",
"{C:attention}Queen{}, or {C:hearts}Heart{} card scored",
"or held in hand gives {X:mult,C:white}x#3#{} XMult.",
"{C:inactive}(Increases by {X:mult,C:white}x#2#{} per trigger){}",
"{C:inactive}(Resets after Boss Blind){}"
}
},
calculate = function(self, card, context)
if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
local target = context.other_card
if target.seal == 'Red' or target.config.center == G.P_CENTERS.m_steel or target:get_id() == 12 or target:is_suit('Hearts') then
local usage_mult = card.ability.extra.current_x_mult
card.ability.extra.current_x_mult = card.ability.extra.current_x_mult + card.ability.extra.scaling
return {
x_mult = usage_mult,
card = card
}
end
end
if context.end_of_round and G.GAME.blind.boss and not context.blueprint then
card.ability.extra.current_x_mult = card.ability.extra.x_mult
attention_text({
text = 'Reset',
colour = G.C.FILTER,
scale = 0.45, 
hold = 0.8,
major = card
})
end
end
}