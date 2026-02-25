function OneOneVideoModal:stop()
if self.vid then
self.vid:pause()
self.vid = nil
end
self.vid_sprite = nil
self.active = false
self.finished = false
self.started_this_loss = false
end

SMODS.Consumable{
key = 'debut_planet_card',
set = 'Planet',
atlas = 'debut_planet',
pos = { x = 0, y = 0 },
config = {hand_type = 'noir_debut', soft_stats = {chips = 30, mult = 3}},
loc_txt = {
name = 'Noirian Kingdom',
text = { "Level Up {C:attention}#3#", "{C:chips}+#1#{} Chips and", "{C:mult}+#2#{} Mult" }
},
loc_vars = function(self, info, card)
local hand_name = "Debut"
if G.localization.misc.poker_hands[self.config.hand_type] then
hand_name = G.localization.misc.poker_hands[self.config.hand_type][1]
end
return {vars = {self.config.soft_stats.chips, self.config.soft_stats.mult, hand_name}}
end,
can_use = function(self, card)
return true
end,
use = function(self, card, area, copier)
-- Safety Check: If hand doesn't exist in current run, add it
if not G.GAME.hands[self.config.hand_type] then
local hand_obj = SMODS.PokerHands[self.config.hand_type]
G.GAME.hands[self.config.hand_type] = {
level = 1,
order = hand_obj.order,
mult = hand_obj.mult,
chips = hand_obj.chips,
l_mult = hand_obj.l_mult,
l_chips = hand_obj.l_chips,
active = true,
visible = true
}
end
level_up_hand(card, self.config.hand_type, false, 1)
G.E_MANAGER:add_event(Event({
trigger = 'after',
delay = 0.4,
func = function()
play_sound('tarot1')
card:juice_up(0.3, 0.5)
return true
end
}))
end
}

SMODS.Consumable{
key = 'flush_debut_planet_card',
set = 'Planet',
atlas = 'flush_debut_planet',
pos = { x = 0, y = 0 },
config = {hand_type = 'noir_flush_debut', soft_stats = {chips = 50, mult = 5}},
loc_txt = {
name = 'Noirian Throne',
text = { "Level Up {C:attention}#3#", "{C:chips}+#1#{} Chips and", "{C:mult}+#2#{} Mult" }
},
loc_vars = function(self, info, card)
local hand_name = "Flush Debut"
if G.localization.misc.poker_hands[self.config.hand_type] then
hand_name = G.localization.misc.poker_hands[self.config.hand_type][1]
end
return {vars = {self.config.soft_stats.chips, self.config.soft_stats.mult, hand_name}}
end,
can_use = function(self, card)
return true
end,
use = function(self, card, area, copier)
-- Safety Check: If hand doesn't exist in current run, add it
if not G.GAME.hands[self.config.hand_type] then
local hand_obj = SMODS.PokerHands[self.config.hand_type]
G.GAME.hands[self.config.hand_type] = {
level = 1,
order = hand_obj.order,
mult = hand_obj.mult,
chips = hand_obj.chips,
l_mult = hand_obj.l_mult,
l_chips = hand_obj.l_chips,
active = true,
visible = true
}
end
level_up_hand(card, self.config.hand_type, false, 1)
G.E_MANAGER:add_event(Event({
trigger = 'after',
delay = 0.4,
func = function()
play_sound('tarot1')
card:juice_up(0.3, 0.5)
return true
end
}))
end
}

SMODS.Tarot{
key = "egg_tarot_card",
unlocked = true,
atlas = "egg_tarot",
pos = { x = 0, y = 0 },
config = {},
loc_txt = {
name = "Egg",
text = {
"Egg.",
}
},
can_use = function(self, card)
return true
end,
use = function(self, card, area, copier)
if OneOneVideoModal then
OneOneVideoModal:start("egg.ogv")
end
for i = 1, 3 do
G.E_MANAGER:add_event(Event({
func = function()
local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_egg', 'egg_flipnote')
card:set_edition({negative = true}, true)
card:add_to_deck()
G.jokers:emplace(card)
return true
end
}))
end
end
}

local game_update_ref = Game.update
function Game:update(dt)
game_update_ref(self, dt)
if OneOneVideoModal then
OneOneVideoModal:update()
end
end
